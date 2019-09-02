
const invoice = (function () {
    // #region PRIVATE VARIABLES **************//

    let table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
    let taxPercent = 13;
    let isBarCodePressed = false;
    let salesTransactionLimit = 5000;
    let permission = {
        salesDiscountItemwise: false,
        salesDiscountItemLimit: 0,
        salesRateEditRight: false
    };
    var selectedItems = [];
    var customerList = [];

    let transType = $("#Trans_Type"),
        totalNetAmount = $("#Total_Net_Amount");

    // #endregion PRIVATE VARIABLES **************//


    // #region PRIVATE METHODS **************//

    let init = () => {

        //focus on barcode
        $("#item_code").focus();

        //set todays date
        $("#trans_date_ad").val(FormatForDisplay(new Date()));
        $("#trans_date_ad").trigger('change');

        //assign shortcut keys
        AssignKeyEvent();

        //remove success messge if any after certtain time
        setTimeout(() => {
            $(".alert").hide();
            //update url too
            if (getUrlParameters().indexOf("StatusMessage") > -1)
                history.pushState({}, null, window.location.origin + "/SalesInvoice");
        }, 3000);




        //hide bill to customer info
        $(".bill_to_info_div").hide();

        //initialize table to kendo grid
        grid = $("#item_table").kendoGrid({
            height: CalcGridHeight() - 160,
            editable: true,
            sortable: false,
            scrollable: true,
            columns: [
                {
                    title: "SN",
                    width: "3%"

                },
                {
                    title: "BarCode",
                    width: "14%"
                },
                {
                    title: "Item",
                    width: "28%"
                },
                {
                    title: "Unit",
                    width: "7%"
                },
                {
                    title: "Rate",
                    width: "8%",
                    footerAttributes: {
                        "class": "p-1 text-right"

                    },
                    footerTemplate: "Total"
                },
                {
                    title: "Qty",
                    width: "5%",
                    footerAttributes: {
                        "class": "p-1 text-right"
                    },
                    footerTemplate: "<span class='text-right' id='totalQuantity'>0</span>"
                }, {
                    title: "GA",
                    width: "9%",
                    footerAttributes: {
                        "class": "p-1 text-right"
                    },
                    footerTemplate: "<span class='text-right' id='totalGrossAmount'>0</span>"
                },

                {
                    title: "Dis",
                    width: "8%",
                    footerAttributes: {
                        "class": "p-1 text-right"
                    },
                    footerTemplate: "<span class='text-right' id='totalDiscount'>0</span>"
                },
                {
                    title: "Tax",
                    width: "8%",
                    footerAttributes: {
                        "class": "p-1 text-right tax-show-hide"
                    },
                    footerTemplate: "<span class='text-right' id='totalTax'>0</span>"
                }, {
                    title: "Net",
                    width: "10%",
                    footerAttributes: {
                        "class": "p-1 text-right"
                    },
                    footerTemplate: "<span class='text-right' id='totalNetAmount'>0</span>"
                }, {
                    title: "Action",
                    width: "3%",
                },


            ]
        });
        $("#membershipId").attr("readonly", true);




        updateSalesTax();

        //update page respect to permission //loadPausedTransaction after permission data loaded
        updatePageWithRespectToPermission(loadCustomer(loadPausedTransactionData));

        //if membership in url load membership
        if (GetUrlParameters("M") !== undefined) {
            var membershipId = GetUrlParameters("M");
            $("#membershipId").val(membershipId);//.trigger('change');
        }

    };

    // #region GetData
    let GetItems = (code, callback) => {
        var membershipNumber = $("#membershipId").val();
        let customer = _.filter(customerList, (x) => { return x.membership_Number === membershipNumber; })[0];
        $.ajax({
            url: window.location.origin + "/item/GetItems/?code=" + code,
            type: "GET",
            contentType: "application/json",
            // headers: { 'Accept-Encoding': 'deflate' },

            success: function (data) {
                if (data.length === 0) {
                    $("#itemNotFoundLabel").show();
                    bootbox.alert("Item Not Found !!", function () {


                        $("#item_code").focus();
                        $("#item_code").select();

                        //for barcode device
                        setTimeout(() => {
                            $("#item_code").focus();
                            $("#item_code").select();
                        }, 20);
                    }).one("shown.bs.modal", function () {
                        //temporary paused the shortcut events
                        Mousetrap.pause();

                    }).one("hide.bs.modal", function () {
                        // allow Mousetrap events to fire again
                        Mousetrap.unpause();
                        setTimeout(() => {
                            $("#item_code").focus();
                            $("#item_code").select();
                        }, 20);

                    });
                    setTimeout(function () { $("#itemNotFoundLabel").hide(); }, 2000);

                } else {

                    _.each(data, function (x) { selectedItems.push(x); });
                    callback(data);
                }
                //remove loading icon
                $("#barcodeloading").removeClass("fa-spinner fa-pulse").css("font-size", "40px");
                isBarCodePressed = false;
            },
            error: function (x) {
                //remove loading icon
                $("#barcodeloading").removeClass("fa-spinner fa-pulse").css("font-size", "40px");
                isBarCodePressed = false;
                console.log(x);
            }
        });
    };
    let getItemReferenceData = (callback) => {
        $.ajax({
            url: window.location.origin + "/SalesInvoice/GetItemReferenceData/?id=" + getUrlParameters(),
            type: "GET",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200 && result.responseJSON.length > 0) {
                    _.each(result.responseJSON, function (x) { selectedItems.push(x); });
                    callback();
                }
                else {
                    console("Error: cannot get item reference data");
                }
            }

        });
    };
    let getUrlParameters = () => {

        var sPageURL = window.location.href;
        var indexOfLastSlash = sPageURL.lastIndexOf("/");

        if (indexOfLastSlash > 0 && sPageURL.length - 1 !== indexOfLastSlash) {
            var totalUrl = sPageURL.substring(indexOfLastSlash + 1);
            var onlyId = totalUrl.substring(0, totalUrl.indexOf("?"));
            return onlyId;
        }
        else
            return 0;
    };
    let getPermissions = (Callback) => {
        $.ajax({
            url: window.location.origin + "/Account/RoleWiseUserPermission",
            type: "GET",
            complete: function (result) {
                if (result.status === 200) {
                    Callback(result.responseJSON);
                }
            }
        });
    };
    let getFOCItem = (itemCode, callback) => {
        $.ajax({
            url: window.location.origin + "/SalesInvoice/GetFOCItem",
            type: "GET",
            complete: function (result) {
                if (result.status === 200) {
                    Callback(result.responseJSON);
                }
            }
        });
    };
    // #endregion

    let updateSalesTax = () => {

        if (GetUrlParameters("mode") !== undefined && GetUrlParameters("mode") === "tax") {
            //convert to tax invoice
            $("#Trans_Type").val("Sales");
            convertSalesTax();
        }
        else {
            //convert to sales invoice
            $("#Trans_Type").val("Tax");
            convertSalesTax();
        }


    };
    let adjustTableWidth = () => {
        let tableClassArr = [".sn-width", ".barCode-width", ".itemName-width", ".unit-width", ".rate-width", ".quantity-width", ".grossAmount-width", ".discount-width", ".tax-width", ".netAmount-width", ".action-width"];
        //$.each(tableClassArr, function (k, item) {
        //    $(item + "-item").width("0px");
        //});
        $.each(tableClassArr, function (k, item) {
            $(item + "-item").width($(item).width() + k + 10 + "px");
        });



    };
    let updateFlatDiscount = (calcTotalFlag) => {
        var type = $("input[name='flatDiscount']:checked").val();
        var value = parseFloat($("#flat_discount").val() || 0).toFixed(2);
        var percent = 0;
        if (_.isEmpty(type))
            return false;
        if (type === "percent") {
            percent = parseFloat(value);
        } else {
            discountAmount = parseFloat(value);
            totalGrossAmountWithoutLineDiscountItem = 0.0;
            $.each(table.rows, function (i, v) {
                var grossAmount = parseFloat($(this).find(".GrossAmount").val());
                if (type === "amount")
                    grossAmount = parseFloat($(this).find(".Rate").val());
                var lineDiscountAmount = parseFloat($(this).find(".Discount").val());
                if ($(this).find(".Discount").data("isdiscountable")) {
                    totalGrossAmountWithoutLineDiscountItem += grossAmount;
                }
            });
            percent = totalGrossAmountWithoutLineDiscountItem === 0 ? 0 : (discountAmount * 100 / totalGrossAmountWithoutLineDiscountItem);
        }

        //check if exceed the max percent
        var maxPercent = parseFloat($("#flat_discount").data("data-max"));
        if (percent > maxPercent) {
            percent = maxPercent; //no need to show error message// just set max percentage that is allowed.
            $("#flat_discount").val(maxPercent);
        }

        $.each(table.rows, function (i, v) {
            var grossAmount = parseFloat($(this).find(".GrossAmount").val());
            if (type === "amount")
                grossAmount = parseFloat($(this).find(".Rate").val());
            var lineDiscountAmount = parseFloat($(this).find(".Discount").val());
            if ($(this).find(".Discount").data("isdiscountable")) {
                var discount = grossAmount * percent / 100;
                $(this).find(".Discount").val(discount.toFixed(2));
                $(this).find(".Discount").data("original-value", discount.toFixed(2));

                //if flat_discount percent is zero then enable individual discount  
                $(this).find(".Discount").attr("readonly", percent !== 0);
            }



        });
        calcNetTotalsOnly();
        return percent;
    };
    let convertSalesTax = () => {

        let salesInvoiceNumber = "";
        if (!_.isEmpty($("#Invoice_Number").val()))
            salesInvoiceNumber = $("#Invoice_Number").val();
        else
            salesInvoiceNumber = $("#Invoice_Number").attr("placeholder");
        if ($("#Trans_Type").val() === "Sales") {
            $("#Invoice_Number").attr("placeholder", salesInvoiceNumber.replace("SI", "TI"));
            if (!_.isEmpty($("#Invoice_Number").val())) $("#Invoice_Number").val(salesInvoiceNumber.replace("SI", "TI"));
            $("#Chalan_Number").attr("readonly", false);
            $("#convert-sales-tax").attr("title", "Convert to Sales Invoice");
            $("#Trans_Type").val("Tax");

            //$("#col-item-name").css({ "width":"32%"});
            let grid1 = $("#item_table").data("kendoGrid");
            if (grid1 !== undefined)
                grid1.showColumn(8);

            //display tax columns
            $('.tax-show-hide').show();

        } else {
            $("#Invoice_Number").attr("placeholder", salesInvoiceNumber.replace("TI", "SI"));
            if (!_.isEmpty($("#Invoice_Number").val())) $("#Invoice_Number").val(salesInvoiceNumber.replace("TI", "SI"));
            $("#Chalan_Number").attr("readonly", true);
            $("#convert-sales-tax").attr("title", "Convert to Tax Invoice");
            $("#Trans_Type").val("Sales");

            //$("#col-item-name").css({ "width": "40%" });
            let grid1 = $("#item_table").data("kendoGrid");
            if (grid1 !== undefined)
                grid1.hideColumn(8);
            $('.tax-show-hide').hide();
        }

        //for now update all row to take change effect
        $.each(table.rows, function (i, v) {
            $(this).data("isChanged", true);
        });
        calcTotal();

    };

    // #region itemTable
    let addRowGetUpdateData = (code, key) => {
        var t1 = table.rows.length;
        //first check there alreay item in pos  

        var checkAlreadyExistItem = false;
        $.each(table.rows, function (i, v) {
            var barcode = $(this).find(".barcode").text();
            var itemCode = $(this).find(".itemName").attr("data-item-code");
            var quantity = $(this).find(".Quantity").val();
            if (barcode === code || itemCode === code) {
                if (key === 13) //enter key event
                {

                    //increase quantity               
                    $(this).find(".Quantity").val((parseFloat(quantity) + 1).toString());
                    $(this).data("isChanged", true);
                }
                if (key === 10 && parseFloat(quantity) > 1) //ctrl + enter key event
                {
                    //increase quantity               
                    $(this).find(".Quantity").val((parseFloat(quantity) - 1).toString());
                    $(this).data("isChanged", true);
                }
                //highlight row
                makeRowAtTopAndHightlight($(this));
                calcTotal();
                calculateSN();
                checkAlreadyExistItem = true;
                return false;
            }
        });

        if (!checkAlreadyExistItem) {

            //check if item already loaded to client
            var itemFromClient = _.filter(selectedItems, function (x) { return x.code == code || x.bar_Code == code });
            if (itemFromClient.length > 0) {
                addRowWithData(itemFromClient);
                //remove loading icon
                $("#barcodeloading").removeClass("fa-spinner fa-pulse").css("font-size", "40px");
                isBarCodePressed = false;
            }
            else
                GetItems(code, function (result) {
                    addRowWithData(result);
                });
        }
        else {
            //remove loading icon
            $("#barcodeloading").removeClass("fa-spinner fa-pulse").css("font-size", "40px");
            isBarCodePressed = false;
        }
    };

    let addRowWithData = (result, isCalcTotal) => {
        var row = table.insertRow(0);
        var cell1 = row.insertCell(0); //SN
        var cell2 = row.insertCell(1); //Bar Code
        var cell3 = row.insertCell(2); //Item Name
        var cell4 = row.insertCell(3); //Unit
        var cell5 = row.insertCell(4); //Rate
        var cell6 = row.insertCell(5); //Quantity
        var cell7 = row.insertCell(6); //G Amount
        var cell8 = row.insertCell(7); //Discount
        var cell9 = row.insertCell(8); //Tax
        var cell10 = row.insertCell(9); //Net Amount
        var cell11 = row.insertCell(10); //delete button

        cell1.className = "sn-width-item p-1";
        cell2.className = "barCode-width-item p-1";
        cell3.className = "itemName-width-item p-1";
        cell4.className = "unit-width-item p-1";
        cell5.className = "rate-width-item p-1 pr-3";
        cell6.className = "quantity-width-item p-1 pr-3";
        cell7.className = "grossAmount-width-item p-1 pr-3";
        cell8.className = "discount-width-item p-1 pr-3";
        cell9.className = "tax-width-item p-1 pr-3 tax-show-hide";
        cell10.className = "netAmount-width-item p-1 pr-3";
        cell11.className = "action-width-item p-1";


        var barCode = result.Bar_Code || result[0].bar_Code;
        var itemCode = result.Remarks || result[0].code; //temporary update code to remarks field :)       
        var itemName = result.Name || result[0].name;
        var itemId = result.ItemId || result[0].itemId;
        var unit = result.Unit || result[0].unit;
        //var rate = result.rate || result.Rate;
        var quantity = result.Quantity === undefined ? 1 : result.Quantity;
        //var discount = (result.Discount || result.discount) === undefined ? 0 : (result.Discount || result.discount);
        var isDiscountable = result.Is_Discountable || (result[0] === undefined ? false : result[0].is_Discountable);
        //var tax = result.Tax === undefined ? 0 : result.Tax;

        var isVatable = result.Is_Vatable || (result[0] === undefined ? false : result[0].is_Vatable);
        //if ($("#Trans_Type").val() === "Tax" && isVatable !== undefined && isVatable && tax === 0) {
        //    tax = (grossAmount - discount) * taxPercent / 100;
        //}
        //later calculations

        var rate = result.rate || result.Rate || 0;
        var originalRate = rate == 0 ? "" : "data-original-rate=" + rate;
        var popupRate = (result.Invoice_Number != undefined && result.Invoice_Number.indexOf("TI-") > -1 && isVatable == true ? result.RateExcludeVatWithoutRoundoff * 1.13 : rate).toFixed(2);
        var discount = result.Discount || 0;

        var grossAmount = 0;
        var tax = 0;
        var netAmount = 0;

        //invoiceItems[0].sn
        //highlight row
        makeRowAtTopAndHightlight(row);

        //discount make disable with respect to permission
        var discountDisabled = permission.salesDiscountItemwise === false ? "disabled" : isDiscountable === false ? "disabled" : "";
        var discountLimit = permission.salesDiscountItemLimit === 0 ? "" : "data-max=" + permission.salesDiscountItemLimit;
        var rateDisabled = "disabled";//permission.salesRateEditRight === true ? "" : "disabled";
        var fromDiscount = "fromDiscount";

        row.title = "Item Code: " + itemCode;
        $(row).data("isChanged", true);
        $('<i class="sn font-weight-bold">' + table.rows.length + '</i>').appendTo(cell1);
        $("<span class='barcode'>" + barCode + "</span>").appendTo(cell2);
        $("<span class='itemName' data-item-id='" + itemId + "' data-item-code= '" + itemCode + "'>" + itemName + "</span>").appendTo(cell3);
        $("<span>" + unit + "</span>").appendTo(cell4);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Rate" type="number" min="0.01" onfocusout="invoice.calcTotal()" name="Rate"  data-popup-rate="' + popupRate + '" ' + rateDisabled + ' " value=' + rate.toFixed(2) + ' ' + originalRate + '>').appendTo(cell5);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Quantity" type="number" min="0.01" onfocusout="invoice.quantityChangeEvt(this)" name="Quantity" value=' + quantity.toString() + '>').appendTo(cell6);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right GrossAmount" type="number" name="GrossAmount" disabled value=' + grossAmount.toFixed(2) + '>').appendTo(cell7);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Discount" type="number" data-isDiscountable="' + isDiscountable + '" ' + discountDisabled + ' min="0" ' + discountLimit + ' onfocusout="invoice.discountChangeEvt(this)" name="Discount" data-original-percent="' + discount.toFixed(2) + '" data-original-value="' + discount.toFixed(2) + '" value=' + discount.toFixed(2) + '>').appendTo(cell8);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Tax" data-isVatable="' + isVatable + '" type="number" name="Tax" disabled value=' + tax.toFixed(2) + '>').appendTo(cell9);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right NetAmount" type="number" name="NetAmount" disabled value=' + netAmount.toFixed(2) + '>').appendTo(cell10);

        $('<botton onclick="invoice.delete_row(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell11);


        //check keyinweight
        if (result.keyInWeight || (result.length > 0 && result[0].keyInWeight)) {
            $(row).find(".Quantity").val("0");
            $(row).find(".Quantity").focus();
            $(row).find(".Quantity").select();
            $(row).find(".Quantity").attr("min", 0);
            $(row).find(".Quantity").attr("isKeyInWeight", true);


            //again select because barcode device used late selecttion
            setTimeout(function () {
                $(row).find(".Quantity").focus();
                $(row).find(".Quantity").select();
            }, 20);
        }
        //bind quantity enter event handler
        $(row).find(".Quantity").bind("keypress", function (e) {
            if (e.keyCode === 13 && $(this).val() !== "") {
                $('#item_code').val('');
                $('#item_code').focus();
                e.preventDefault();
            }

        });
        //bind discount enter event handler
        $(row).find(".Discount").bind("keypress", function (e) {
            if (e.keyCode === 13 && $(this).val() !== "") {
                $('#item_code').val('');
                $('#item_code').focus();
                e.preventDefault();
            }

        });



        if (isCalcTotal === undefined || isCalcTotal == true)
            calcAll();
    };
    let makeRowAtTopAndHightlight = (row) => {
        //remove all highlights        
        $(table).find("tr").removeClass("active");
        if (row.className === undefined) {
            row.addClass("active");
            //setTimeout(() => { row.removeClass("active"); }, 300);
            //make it at first
            var firstRow = row.parent().children("tr:first");
            row.insertBefore(firstRow);
        } else {
            row.className = "active";
            // setTimeout(() => { row.className = ""; }, 300);
        }


        //make this row at top and scroll to top
        $(".k-grid-content.k-auto-scrollable").scrollTop(0);






        ////test logic
        //// Change the selector if needed
        //var $table = $('#item_table'),
        //    $bodyCells = $table.find('tbody tr:first').children(),
        //    colWidth;

        //// Get the tbody columns width array
        //colWidth = $bodyCells.map(function () {
        //    return $(this).width();
        //}).get();

        ////now make table scrollable
        //// $table.find('tbody').css({"display":"block","overflow-y":"scroll"});

        //// Set the width of thead columns
        //$table.find('thead tr').children().each(function (i, v) {
        //    $(v).width(colWidth[i]);
        //});

    };
    //let addFOCItem = (itemCode) => {
    //    getFOCItem(itemCode, function (data) {
    //        //
    //        if (data.length > 0) {
    //            
    //            _.each(data, function (value) {
    //                addRowWithData(data);
    //            });


    //        }
    //    });
    //};
    let delete_row = (evt) => {
        evt.parentElement.parentElement.remove();
        calcAll();
    };
    let deleteCurrentItemEntry = () => {
        var activeRow = $("#item_table").find("tr.active");
        if (activeRow[0] === $("#item_table").find("tr:last")[0]) {
            activeRow.prev().addClass("active");
        }
        else {
            activeRow.next().addClass("active");
        }
        activeRow.remove();
        calcAll();
    };
    let deleteInvoice = (row, id) => {
        $.ajax({
            method: "POST",
            url: "/SalesInvoice/Delete/" + id,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200) {
                    $(row).parent().parent().remove();
                }
            }
        });
    };
    let changeSelectedRow = (selection) => {
        $.each(table.rows, function (i, v) {

            if (selection === "down") {
                if ($(this).hasClass("active") && $(this)[0] !== $(table).find("tr:last")[0]) {
                    $(this).removeClass("active");
                    $(this).next().addClass("active");
                    $(this).next().find(".Quantity").focus();
                    $(this).next().find(".Quantity").select();
                    return false;
                }
            }
            if (selection === "up") {
                if ($(this).hasClass("active") && $(this)[0] !== $(table).find("tr:first")[0]) {
                    $(this).removeClass("active");
                    $(this).prev().addClass("active");
                    $(this).prev().find(".Quantity").focus();
                    $(this).prev().find(".Quantity").select();
                    return false;
                }
            }

        });
    };
    // #endregion

    let holdTransaction = () => {
        $("#Remarks").val($("#Trans_Type").val());
        $("#Trans_Type").val("Hold");
        SaveSalesInvoice();
    };

    let saveTransaction = () => {
        $("#Remarks").val($("#Trans_Type").val());
        $("#Trans_Type").val("Save");
        SaveSalesInvoice();
    };
    let showPausedTransaction = () => {
        $("#PausedTransactionListModal").modal('show');

    };
    ///
    let showSavedTransaction = () => {
        $("#SavedTransactionListModal").modal('show');

    };
    let loadPausedTransaction = (row) => {

        var invoiceId = row.closest("tr").find('td.invoice-id').text();
        var membershipId = row.closest("tr").find('td.membership-id').text();
        var transType = row.closest("tr").find('td.trans-type-popup').text();
        if (transType.trim() == "Tax")
            window.location.href = window.location.origin + "/SalesInvoice/Index/" + invoiceId.trim() + "?Mode=tax&M=" + membershipId.trim();
        else
            window.location.href = window.location.origin + "/SalesInvoice/Index/" + invoiceId.trim() + "?M=" + membershipId.trim();

    };
    let loadPausedTransactionData = (data) => {

        if (getUrlParameters() !== 0 && salesInvoiceTmpData.SalesInvoiceItems !== null) {
            kendo.ui.progress($("#item_table"), true);
            getItemReferenceData(function () {

                //flat discount
                if (salesInvoiceTmpData.Flat_Discount_Amount !== null) {
                    $("#amountRadio").prop("checked", true);
                    $("#flat_discount").val(salesInvoiceTmpData.Flat_Discount_Amount);
                }
                if (salesInvoiceTmpData.Flat_Discount_Percent !== null) {
                    $("#percentRadio").prop("checked", true);
                    $("#flat_discount").val(salesInvoiceTmpData.Flat_Discount_Percent);
                }
                //date
                $("#trans_date_ad").val(FormatForDisplay(salesInvoiceTmpData.Trans_Date_Ad));
                $("#trans_date_ad").trigger("change");
                //trans type
                if (salesInvoiceTmpData.Remarks === "Sales")
                    $("#Trans_Type").val("Tax");
                if (salesInvoiceTmpData.Remarks === "Tax")
                    $("#Trans_Type").val("Sales");
                // convertSalesTax();

                //save transaction id
                $("#Id").val(getUrlParameters());

                //insert items
                if (salesInvoiceTmpData.SalesInvoiceItems.length > 0) {
                    _.each(salesInvoiceTmpData.SalesInvoiceItems, function (x) {
                        addRowWithData(x, false);
                    });
                    calcAll();
                }
                kendo.ui.progress($("#item_table"), false);
            });

        }
    };
    let resetForm = () => {
        bootbox.confirm({
            message: "Are you sure ?",
            buttons: {
                cancel: {
                    label: 'Go Back',
                    className: 'btn-warning'
                },
                confirm: {
                    label: 'Sure',
                    className: 'btn-success'
                }
            },
            callback: function (result) {
                if (result) {
                    var url = window.location.origin + "/SalesInvoice";
                    if (GetUrlParameters("mode") !== undefined && GetUrlParameters("mode") === "tax")
                        url = SetUrlParameters(url, ["Mode=tax"]);
                    if (GetUrlParameters("m") !== undefined)
                        url = SetUrlParameters(url, ["M=" + GetUrlParameters("M")]);

                    window.location.href = url;
                }

            }
        });


    };
    let barCodeKeyPressEvent = (e) => {

        var $this = $(e.currentTarget);
        if ((e.keyCode === 13 || e.keyCode === 10) && $this.val() !== "" && $this.val().length > 1 && !isBarCodePressed) {

            //disable for another barcode
            isBarCodePressed = true;
            $("#barcodeloading").addClass("fa-spinner fa-pulse").css("font-size", "20px");
            addRowGetUpdateData($this.val(), e.keyCode);
            //highlight the selected code
            $this.focus();
            $this.select();

            //for barcode device
            setTimeout(() => {
                $this.focus();
                $this.select();
            }, 20);


            // Work around Chrome's little problem
            $this.mouseup(function () {
                // Prevent further mouseup intervention
                $this.unbind("mouseup");
                return false;
            });
            e.preventDefault();
            return false; // prevent the button click from happening

        } else if (e.keyCode === 13) { //enter key event
            e.preventDefault();
        }
    };



    // #region CALCULATIONS
    let calcDiscount = (itemCode, quantity, customerGroupCode, from) => {
        //variables       
        var todayDate = new Date();
        var membershipNumber = $("#membershipId").val();


        //Get Selected Item First   
        var selectedItem = _.filter(selectedItems, function (x) {
            return x.code === itemCode;
        });

        ////check location
        //if location is MRP or WholeSale then set discount equal zero
        //if (selectedItem[0].locationwisePriceGroup === "WSP")
        //    return 0;

        ///if no discount tag is enable then return no discount
        if (selectedItem.length > 0 && selectedItem[0].no_Discount === true) {
            $.each(table.rows, function (i, v) {
                if ($(this).find(".itemName").attr("data-item-code") === itemCode) {
                    $(this).find(".Discount").data("isdiscountable", false);
                    $(this).find(".Discount").data("noDiscount", true);
                    $(this).find(".Discount").attr("readonly", true);
                }

            });


            return 0;
        }

        var discount = calcDiscountLine(selectedItem, quantity, itemCode);

        /////****** Check if membership discount is available 
        if (discount === 0) {
            discount = calcDiscountMembership(selectedItem, quantity, itemCode);
            if (discount > 0)
                isMembershipDiscount = true;
        }

        if (discount > 0) {
            //update isdiscountable
            $.each(table.rows, function (i, v) {
                if ($(this).find(".itemName").attr("data-item-code") === itemCode) {
                    $(this).find(".Discount").data("isdiscountable", false);
                    $(this).find(".Discount").attr("readonly", true);
                }
            });
        }
        else if (discount === 0) {
            //update isdiscountable
            $.each(table.rows, function (i, v) {
                if ($(this).find(".itemName").attr("data-item-code") === itemCode) {
                    $(this).find(".Discount").data("isdiscountable", true);
                    $(this).find(".Discount").attr("readonly", false);
                }

            });
            discount = calcFlatDiscount();

        }


        return discount;
    };
    let calcDiscountLine = (selectedItem, quantity, itemCode) => {


        //variables
        var todayDate = new Date();
        var membershipNumber = $("#membershipId").val();
        var discount = 0;
        let customer = _.filter(customerList, (x) => { return x.membership_Number === membershipNumber; })[0];

        ///*** if location is MRP then only check mrp discount
        var lineDiscountRows = [];

        if ((store.CustomerPriceGroup === "MRP" && customer.customerDiscGroup !== "WSP") || store.CustomerPriceGroup === "WSP") {
            lineDiscountRows = _.filter(selectedItem, function (x) {
                return x.discountType === "Customer Disc. Group" && x.discountSalesGroupCode === store.CustomerPriceGroup;
            });
        }
        else {
            ////***** exclude all membership rows
            lineDiscountRows = _.filter(selectedItem, function (x) {
                return x.discountType === "Customer Disc. Group" && x.discountSalesGroupCode === customer.customerDiscGroup;
            });
        }



        //1) filter by date
        var filterByDate = _.filter(lineDiscountRows, function (x) {
            var conditions = (moment(todayDate).format("YYYY-MM-DD") >= moment(x.discountStartDate).format("YYYY-MM-DD") && moment(todayDate).format("YYYY-MM-DD") <= moment(x.discountEndDate).format("YYYY-MM-DD")) ||
                (x.discountStartDate === null && moment(todayDate).format("YYYY-MM-DD") <= moment(x.discountEndDate).format("YYYY-MM-DD")) ||
                (moment(todayDate).format("YYYY-MM-DD") >= moment(x.discountStartDate).format("YYYY-MM-DD") && x.discountEndDate === null);
            return conditions;
        });



        //2) filter by time
        var filterByTime = _.filter(filterByDate, function (x) {
            var conditions = (moment(todayDate).format("HH:mm:ss") >= moment(x.discountStartTime)._i && moment(todayDate).format("HH:mm:ss") <= moment(x.discountEndTime)._i) ||
                (x.discountStartTime === null || x.discountEndTime === null);
            return conditions;
        });

        //3) By time is priority
        var filterByTimePriority = _.filter(filterByDate, function (x) {
            var conditions = moment(todayDate).format("HH:mm:ss") >= moment(x.discountStartTime)._i && moment(todayDate).format("HH:mm:ss") <= moment(x.discountEndTime)._i;
            return conditions;
        });
        if (filterByTimePriority.length > 0) {
            discount = _.filter(filterByTimePriority, function (x) {
                return x.discountMinimumQuantity === 0;
            })[0];
            discount = discount === undefined ? 0 : discount.discount;
            _.each(filterByTimePriority, function (x) {
                if (x.discountMinimumQuantity > 0 && quantity >= x.discountMinimumQuantity)
                    discount = x.discount;
            });
        }
        //3) By time is priority 
        if (discount <= 0) {
            //check if location is present
            var filterByLoc = _.filter(filterByTime, function (x) {

                return store.INITIAL === x.discountLocation;
            });
            var filterByItemCategory = [];
            if (filterByLoc.length > 0)
                filterByItemCategory = filterByLoc;
            else
                filterByItemCategory = filterByTime;


            //check item level discount           
            let filterByItem = _.filter(filterByItemCategory, function (x) {
                return x.discountItemType === "Item";
            });
            if (filterByItem.length > 0) {
                discount = _.filter(filterByItem, function (x) {
                    return x.discountMinimumQuantity === 0;
                })[0];
                discount = discount === undefined ? 0 : discount.discount;
                _.each(filterByTime, function (x) {
                    if (x.discountMinimumQuantity > 0 && quantity >= x.discountMinimumQuantity)
                        discount = x.discount;
                });
            }
            else {
                discount = _.filter(filterByItemCategory, function (x) {
                    return x.discountMinimumQuantity === 0;
                })[0];
                discount = discount === undefined ? 0 : discount.discount;
                _.each(filterByTime, function (x) {
                    if (x.discountMinimumQuantity > 0 && quantity >= x.discountMinimumQuantity)
                        discount = x.discount;
                });
            }
        }

        if (discount > 0) {
            //update type promodiscount
            $.each(table.rows, function (i, v) {
                if ($(this).find(".itemName").attr("data-item-code") === itemCode) {
                    $(this).find(".Discount").data("discountType", "PromoDiscount");
                }

            });
        }

        return discount;

    };
    let calcDiscountMembership = (selectedItem, quantity, itemCode) => {

        //variables
        var todayDate = new Date();
        var membershipNumber = $("#membershipId").val();
        let customer = _.filter(customerList, (x) => { return x.membership_Number === membershipNumber; })[0];

        ////***** Get all membership rows
        var lineDiscountRows = _.filter(selectedItem, function (x) {
            return x.discountType === "Member Disc. Group";
        });

        //1) filter by date
        var filterByDate = _.filter(lineDiscountRows, function (x) {
            var conditions = (moment(todayDate).format("YYYY-MM-DD") >= moment(x.discountStartDate).format("YYYY-MM-DD") && moment(todayDate).format("YYYY-MM-DD") <= moment(x.discountEndDate).format("YYYY-MM-DD")) ||
                (x.discountStartDate === null && moment(todayDate).format("YYYY-MM-DD") <= moment(x.discountEndDate).format("YYYY-MM-DD")) ||
                (moment(todayDate).format("YYYY-MM-DD") >= moment(x.discountStartDate).format("YYYY-MM-DD") && x.discountEndDate === null);
            return conditions;
        });
        //2) filter by time
        var filterByTime = _.filter(filterByDate, function (x) {
            var conditions = (moment(todayDate).format("HH:mm:ss") >= moment(x.discountStartTime)._i && moment(todayDate).format("HH:mm:ss") <= moment(x.discountEndTime)._i) ||
                (x.discountStartTime === null || x.discountEndTime === null);
            return conditions;
        });

        // check customer group filter
        var filterByCustomerGroup = filterByTime;
        ////**** get selected membership


        if (customer !== undefined && filterByTime.length !== 0) {
            filterByCustomerGroup = _.filter(filterByTime, function (x) {
                return x.discountSalesGroupCode === customer.membershipDiscGroup;
            });
        }

        var discount = _.filter(filterByCustomerGroup, function (x) {
            return x.discountMinimumQuantity === 0;
        })[0];
        discount = discount === undefined ? 0 : discount.discount;
        _.each(filterByCustomerGroup, function (x) {
            if (x.discountMinimumQuantity > 0 && quantity >= x.discountMinimumQuantity)
                discount = x.discount;
        });
        if (discount > 0) {
            //update discount type
            $.each(table.rows, function (i, v) {
                if ($(this).find(".itemName").attr("data-item-code") === itemCode) {
                    $(this).find(".Discount").data("discountType", "MembershipDiscount");
                }

            });
        }

        return discount;
    };

    let calcRate = (itemCode, quantity, row) => {


        //Get Selected Item First       
        var todayDate = new Date();
        todayDate = new Date(todayDate.toDateString()); //remove timespan
        var membershipNumber = $("#membershipId").val();


        var selectedItem = _.filter(selectedItems, function (x) {
            return x.code === itemCode;
        });

        var filterByDate = _.filter(selectedItem, function (x) {
            var conditions = (moment(todayDate).format("YYYY-MM-DD") >= moment(x.rateStartDate).format("YYYY-MM-DD") && moment(todayDate).format("YYYY-MM-DD") <= moment(x.rateEndDate).format("YYYY-MM-DD")) ||
                (x.rateStartDate === null && moment(todayDate).format("YYYY-MM-DD") <= moment(x.rateEndDate).format("YYYY-MM-DD")) ||
                (moment(todayDate).format("YYYY-MM-DD") >= moment(x.rateStartDate).format("YYYY-MM-DD") && x.rateEndDate === null);
            return conditions;
        });

        //3) check customer group filter
        var filterByCustomerGroup = [];


        ////**** get selected membership
        let customer = _.filter(customerList, (x) => { return x.membership_Number === membershipNumber; })[0];
        if (filterByDate.length !== 0) {
            //check if location has mrp value

            if (store.CustomerPriceGroup === "MRP")
                if (customer.customerPriceGroup !== "WSP") //if customer is not wholesale then convert into mrp customer
                    customer.customerPriceGroup = "MRP";

            if (filterByDate[0].salesType === "Customer Price Group" && filterByDate[0].salesCode !== undefined) {
                filterByCustomerGroup = _.filter(filterByDate, function (x) {
                    return x.salesCode === customer.customerPriceGroup;
                });
            }
        }

        var rate = _.filter(filterByCustomerGroup, function (x) {
            return x.rateMinimumQuantity === 0;
        });

        //check if multiple open rate
        var selectedRate = parseFloat($(row).find(".Rate").data("popup-rate"));
        if (!isNaN(selectedRate) && selectedRate > 0) {
            rate = selectedRate;
        } else {
            var distinctRate = _.uniq(_.pluck(rate, "rate"));

            if (distinctRate.length > 1 && $(".bootbox.modal").is(":visible") == false) {
                row.find(".Rate").data("rate-selected", true);
                var options = "<select id='rateDropdown' class='form-control'>";
                _.each(distinctRate, function (x) {
                    options += "<option>" + x + "</option>";
                });
                options += "</select>";
                var dialog = bootbox.dialog({
                    title: 'Please select correct price',
                    message: options,
                    size: 'small',
                    buttons: {
                        ok: {
                            label: "Select",
                            className: 'btn-info',
                            callback: function () {
                                rate = $("#rateDropdown :selected").val();
                                row.find(".Rate").data("popup-rate", rate);

                                //row.find(".Rate").data("rate-selected", true);
                                $(row).data("isChanged", true);

                                if ($(row).find(".Quantity").attr("isKeyInWeight") == "true") {
                                    $("tr.active td > .Quantity").focus();
                                    $("tr.active td > .Quantity").select();
                                    setTimeout(() => {
                                        $("tr.active td > .Quantity").focus();
                                        $("tr.active td > .Quantity").select();
                                    }, 30);

                                } else
                                    calcTotal();

                            }
                        }
                    }

                }).one("shown.bs.modal", function () {
                    //temporary paused the shortcut events
                    Mousetrap.pause();
                    $('#rateDropdown').focus();
                    $('#rateDropdown').on("keypress", function (e) {
                        //
                        if (e.keyCode === 13) {
                            e.preventDefault(); e.stopPropagation();
                            $(".bootbox-accept").trigger("click");
                        }
                    });
                    //Mousetrap.bindGlobal('enter', function (e) {
                    //    e.preventDefault(); e.stopPropagation();
                    //    $(".bootbox-accept").trigger("click");
                    //});

                }).one("hide.bs.modal", function () {
                    // allow Mousetrap events to fire again
                    Mousetrap.unpause();
                    Mousetrap.unbind('enter');
                    setTimeout(() => {
                        $("#item_code").focus();
                        $("#item_code").select();
                    }, 20);

                });


                var myDropDown = $("#rateDropdown");
                var length = $('#rateDropdown> option').length + 1;
                myDropDown.attr('size', length);
                $('#rateDropdown> option').first().attr("select", "select");


            }


            rate = rate[0];
            rate = rate === undefined ? 0 : rate.rate;
        }
        _.each(filterByCustomerGroup, function (x) {
            if (x.rateMinimumQuantity > 0 && quantity >= x.rateMinimumQuantity)
                rate = x.rate;
        });
        return rate;

    };
    let calcRateFromCommission = (rate) => {
        var commissionPercent = $("#commissionPercent").val() || "0";
        if (parseFloat(commissionPercent) > 0) {
            commissionPercent = parseFloat($("#commissionPercent").val());
            var commissionedRate = rate + rate * commissionPercent / 100;

            return commissionedRate;
        }
        else
            return rate;

    };
    let calcTotal = (from) => {

        var totalGrossAmount = 0, totalNetAmount = 0, totalQuantity = 0, totalDiscount = 0, totalTax = 0, totalTaxableAmount = 0, totalNonTaxableAmount = 0, totalDiscountExcVat = 0;

        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {


                //variables
                let transType = $("#Trans_Type").val();
                let itemCode = $(this).find(".itemName").attr("data-item-code").toString();
                let taxable = $(this).find(".Tax").data("isvatable");
                let discountable = $(this).find(".Discount").data("isdiscountable");
                let quantity = parseFloat(parseFloat($(this).find(".Quantity").val()).toFixed(2));
                let netAmount = 0,
                    rateIncludeTax = 0,
                    rateExcludeTax = 0,
                    rate = 0, tax = 0,
                    discount = 0,
                    discountPercent = 0,
                    discountExcVat = 0,
                    grossAmout = 0;


                if ($(this).data("isChanged") != undefined && $(this).data("isChanged") == true) {


                    // 2. calc tax include Rate
                    rateIncludeTax = calcRate(itemCode, quantity, $(this));
                    // 3. calc unit tax
                    tax = calculateReverseTax(rateIncludeTax, taxPercent, taxable);
                    // 4. calc tax exclude rate
                    rateExcludeTax = rateIncludeTax - tax;
                    // 5. calc rate
                    rate = transType === "Tax" ? rateExcludeTax : rateIncludeTax;
                    // 5. calc discount
                    discountPercent = calcDiscount(itemCode, quantity, from);
                    //if discount percent is zero check manual inline discount
                    ///*** Discount logic start
                    if (from !== undefined && from.name === "Discount") {
                        $(this).find(".Discount").data("discountType", "InlineManualDiscount");
                        discount = parseFloat($(this).find(".Discount").val());
                        discountPercent = discount / (rate * quantity) * 100;
                        $(this).find(".Discount").data("original-value", (rate * discountPercent / 100).toFixed(2));
                    }




                    discount = rate * discountPercent / 100;
                    discountExcVat = rateExcludeTax * discountPercent / 100;
                    // 6. calc gross amount;
                    grossAmount = quantity * rate;
                    // 7. calc gross tax
                    tax = calculateTax((rateExcludeTax - discountExcVat), taxPercent, taxable) * quantity;



                    let discountType = $(this).find(".Discount").data("discountType");
                    if (discountPercent > 0 && discountType !== "InlineManualDiscount") {
                        $(this).find(".Discount").data("isdiscountable", false);
                        $(this).find(".Discount").attr("readonly", true);
                    }

                    if ($(this).find(".Discount").data("isdiscountable") && discountType !== "InlineManualDiscount") {
                        // $(this).find(".Discount").data("original-value", discount.toFixed(2));

                        //if flat_discount percent is zero then enable individual discount  
                        $(this).find(".Discount").attr("readonly", discountPercent !== 0);
                    }
                    if (($("input[name='flatDiscount']:checked").val() === "percent" || $("input[name='flatDiscount']:checked").val() === "amount") && $("#flat_discount").val() != "") {
                        $(this).find(".Discount").attr("readonly", true);
                        discountType = "PromoDiscount";
                        //$(this).find(".Discount").data("discountType", discountType);
                    }

                    //if inline discount then calculate direct

                    if (discountType === "MembershipDiscount" || discountType === "PromoDiscount")
                        discount = parseFloat((grossAmount.toFixed(2) * discountPercent / 100).toFixed(2));
                    else if ($("input[name='flatDiscount']:checked").val() === "percent") {
                        discount = parseFloat((grossAmount.toFixed(2) * discountPercent / 100).toFixed(2));
                    }
                    else if ($("input[name='flatDiscount']:checked").val() === "amount") {
                        //if it flat discount with amount then donot update discount
                    }
                    else if (discountType === "InlineManualDiscount") {
                        discount = parseFloat((grossAmount.toFixed(2) * discountPercent / 100).toFixed(2));
                    }

                    //    discount = discount * quantity;
                    //var condition = ($("input[name='flatDiscount']:checked").val() === undefined || parseFloat($("#flat_discount").val()) <= 0);
                    //if (!condition && $("input[name='flatDiscount']:checked").val() === "percent") {
                    //    updateFlatDiscount(false);
                    //    discount = discount * quantity;
                    //}

                    //calc netAmount
                    if (transType === "Tax")
                        netAmount = (rate * quantity) - (isNaN(discount) ? 0 : discount) + tax;
                    else
                        netAmount = (rate * quantity) - (isNaN(discount) ? 0 : discount);


                    //assign value
                    $(this).find(".Quantity").val(quantity.toFixed(2));
                    $(this).find(".Rate").val(rate.toFixed(2));
                    $(this).find(".Rate").data("RateExcludedVat", rateExcludeTax.toFixed(2));
                    $(this).find(".Rate").data("RateExcludedVatWithoutRoundoff", rateExcludeTax);
                    $(this).find(".Discount").data("DiscountPercent", discountPercent);
                    $(this).find(".Discount").data("DiscountExcVat", discountExcVat);
                    $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
                    $(this).find(".Tax").val(tax.toFixed(2));
                    $(this).find(".NetAmount").val(netAmount.toFixed(2));


                    if (from === undefined || from.name !== "Discount") {
                        $(this).find(".Discount").val(discount.toFixed(2));
                    }

                    // remove chagne boolean
                    $(this).data("isChanged", false);


                }
                else {
                    rate = parseFloat($(this).find(".Rate").val());
                    discount = parseFloat($(this).find(".Discount").val());
                    tax = parseFloat($(this).find(".Tax").val());
                    grossAmount = parseFloat($(this).find(".GrossAmount").val());
                    netAmount = parseFloat($(this).find(".NetAmount").val());
                    rateExcludeTax = parseFloat($(this).find(".Rate").data("RateExcludedVatWithoutRoundoff"));
                    discountExcVat = parseFloat($(this).find(".Discount").data("DiscountExcVat"));
                    discountPercent = parseFloat($(this).find(".Discount").data("DiscountPercent"))

                }


                //calc total
                totalQuantity += quantity;
                totalDiscount += parseFloat(discount.toFixed(2));
                totalDiscountExcVat += discountExcVat;
                totalTax += tax;
                totalGrossAmount += grossAmount;
                totalNetAmount += netAmount;

                //calc taxable and non taxable
                var grossRateN = parseFloat((rateExcludeTax * quantity).toFixed(2));
                var grossDiscountN = parseFloat((grossRateN * discountPercent / 100).toFixed(2));
                if (taxable)
                    totalTaxableAmount += parseFloat(grossRateN - grossDiscountN);// parseFloat(((rateExcludeTax - discountExcVat) * quantity).toFixed(2));
                else
                    totalNonTaxableAmount += parseFloat(grossRateN - grossDiscountN);



            });
        }

        //calctotal tax
        totalTax = totalTaxableAmount * 13 / 100;
        totalNetAmount = totalTaxableAmount + totalNonTaxableAmount + parseFloat(totalTax.toFixed(2));
        //assign total
        $("#totalQuantity").text(CurrencyFormat(totalQuantity));
        $("#totalGrossAmount").text(CurrencyFormat(totalGrossAmount));
        $("#totalDiscount").text(CurrencyFormat(totalDiscount));
        $("#TOTAL_DISCOUNT_EXC_VAT").val(totalDiscountExcVat.toFixed(2));
        $("#totalTax").text(CurrencyFormat(totalTax));
        $("#totalNetAmount").text(CurrencyFormat(totalNetAmount));
        $("#NonTaxableAmount").val(totalNonTaxableAmount.toFixed(2));
        $("#TaxableAmount").val(CurrencyFormat(totalTaxableAmount.toFixed(2)));
    };
    let calcNetTotalsOnly = () => {
        let totalQuantity = 0, totalGrossAmount = 0, totalDiscount = 0, totalTax = 0, totalNetAmount = 0;
        $.each(table.rows, function (i, v) {
            let quantity = parseFloat($(this).find(".Quantity").val()),
                grossAmount = parseFloat($(this).find(".GrossAmount").val()),
                discount = parseFloat($(this).find(".Discount").val()),
                tax = parseFloat($(this).find(".Tax").val());
            let netAmount = grossAmount - discount + tax;

            totalQuantity += quantity;
            totalGrossAmount += grossAmount;
            totalDiscount += parseFloat(discount.toFixed(2));
            totalTax += tax;
            totalNetAmount += netAmount;

            ///update netamount first    

            $(this).find(".NetAmount").val(netAmount.toFixed(2));

        });
        //assign total
        $("#totalQuantity").text(CurrencyFormat(totalQuantity));
        $("#totalGrossAmount").text(CurrencyFormat(totalGrossAmount));
        $("#totalDiscount").text(CurrencyFormat(totalDiscount));
        $("#totalTax").text(CurrencyFormat(totalTax));
        $("#totalNetAmount").text(CurrencyFormat(totalNetAmount));



    };
    let calcNetTotalAfterCommission = () => {
        let totalQuantity = 0, totalGrossAmount = 0, totalDiscount = 0, totalTax = 0, totalNetAmount = 0, totalTaxableAmount = 0, totalNonTaxableAmount = 0;
        $.each(table.rows, function (i, v) {
            let rate = parseFloat($(this).find(".Rate").val()),
                quantity = parseFloat($(this).find(".Quantity").val()),
                grossAmount = rate * quantity,
                discount = parseFloat($(this).find(".Discount").val()),
                taxable = $(this).find(".Tax").data("isvatable"),
                tax = calculateTax(rate, taxPercent, taxable) * quantity;
            let netAmount = grossAmount - discount + tax;


            //calc taxable and non taxable
            //if (taxable)
            //    totalTaxableAmount += parseFloat(((rate - discount) * quantity).toFixed(2));
            //else {
            //    totalNonTaxableAmount += parseFloat((rate * quantity).toFixed(2));
            //}
            //new logic
            if (taxable)
                totalTaxableAmount += parseFloat(parseFloat((rate * quantity).toFixed(2)) - parseFloat((discount * quantity).toFixed(2)).toFixed(2))// parseFloat(((rateExcludeTax - discountExcVat) * quantity).toFixed(2));
            else {
                totalNonTaxableAmount += parseFloat((rate * quantity).toFixed(2));
            }

            totalQuantity += quantity;
            totalGrossAmount += grossAmount;
            totalDiscount += parseFloat(discount.toFixed(2));
            totalTax += tax;
            totalNetAmount += netAmount;

            ///update netamount first    
            $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
            $(this).find(".NetAmount").val(netAmount.toFixed(2));
            $(this).find(".Tax").val(tax.toFixed(2));

        });
        //assign total
        $("#totalQuantity").text(CurrencyFormat(totalQuantity));
        $("#totalGrossAmount").text(CurrencyFormat(totalGrossAmount));
        $("#totalDiscount").text(CurrencyFormat(totalDiscount));
        $("#totalTax").text(CurrencyFormat(totalTax));
        $("#totalNetAmount").text(CurrencyFormat(totalNetAmount));
        $("#NonTaxableAmount").val(totalNonTaxableAmount.toFixed(2));
        $("#TaxableAmount").val(totalTaxableAmount.toFixed(2));



    };
    let calculateSN = () => {
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((table.rows.length - i).toString());
        });
    };
    let calcFlatDiscount = () => {

        var type = $("input[name='flatDiscount']:checked").val();
        var value = parseFloat($("#flat_discount").val() || 0).toFixed(2);
        var percent = 0;
        if (_.isEmpty(type) || _.isEmpty($("#flat_discount").val())) {
            $("input[name='flatDiscount']").prop('checked', false);
            return 0;
        }
        if (type === "percent") {
            percent = parseFloat(value);
        } else {
            discountAmount = parseFloat(value);
            totalGrossAmountWithoutOtherDiscountItem = 0.0;
            $.each(table.rows, function (i, v) {
                var grossAmount = parseFloat($(this).find(".GrossAmount").val());
                let discountable = $(this).find(".Discount").data("isdiscountable");
                let noDiscount = $(this).find(".Discount").data("noDiscount") || false;;
                let discountType = $(this).find(".Discount").data("discountType");

                //if (type === "amount")
                //    grossAmount = parseFloat($(this).find(".Rate").val());

                if (noDiscount === false && discountType !== "MembershipDiscount" && discountType !== "PromoDiscount") {
                    totalGrossAmountWithoutOtherDiscountItem += grossAmount;
                }
            });

            percent = totalGrossAmountWithoutOtherDiscountItem === 0 ? 0 : (discountAmount * 100 / totalGrossAmountWithoutOtherDiscountItem);
        }

        //check if exceed the max percent
        var maxPercent = parseFloat($("#flat_discount").data("data-max"));
        if (percent > maxPercent) {
            percent = maxPercent; //no need to show error message// just set max percentage that is allowed.
            $("#flat_discount").val(maxPercent);
        }

        return percent;
    };
    let calculateReverseTax = (amount, taxPercent, taxable) => {
        let tax = 0;
        if (taxable) {
            //tax deduction formula
            tax = (taxPercent * amount) / (taxPercent + 100);
        }
        return tax;

    };
    let calculateTax = (amount, taxPercent, taxable) => {
        let tax = 0;
        if (taxable) {
            //tax calc formula
            tax = amount * taxPercent / 100;
        }
        return tax;
    };
    let validateInlineDiscount = (row) => {

        let maxDiscountPercent = $(row).data("max");
        let grossAmount = parseFloat($(row).parent().parent().find(".GrossAmount").val());
        let givenDiscountAmount = parseFloat($(row).val());
        let givenDiscountPercent = givenDiscountAmount / grossAmount * 100;

        if (givenDiscountPercent > maxDiscountPercent) {
            let finalDiscountAmount = grossAmount * maxDiscountPercent / 100;
            $(row).val(finalDiscountAmount.toFixed(2));
        }

    };
    let calcTotalMembershipDiscount = () => {

        var totalAmount = 0;
        $.each(table.rows, function (i, v) {
            if ($(this).find(".Discount").data("discountType") === "MembershipDiscount") {
                //totalAmount += parseFloat($(this).find(".Discount").data("membership-discount"));
                totalAmount += parseFloat($(this).find(".Discount").val());
            }
        });
        return totalAmount;
    };
    let calcTotalPromoDiscount = () => {

        var totalAmount = 0;
        $.each(table.rows, function (i, v) {
            var discountType = $(this).find(".Discount").data("discountType");
            if (discountType === undefined || discountType !== "MembershipDiscount") {
                //totalAmount += parseFloat($(this).find(".Discount").data("membership-discount"));
                totalAmount += parseFloat($(this).find(".Discount").val());
            }
        });
        return totalAmount;
    };
    let calcCommission = (e) => {
        var commissionPercent = $("#commissionPercent").val() || "0";
        if (parseFloat(commissionPercent) > 5)
            $("#commissionPercent").val(5);
        if (parseFloat(commissionPercent) < 0)
            $("#commissionPercent").val(0);
        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {
                //calculations 
                var rate = 0;
                commissionPercent = parseFloat($("#commissionPercent").val());
                if ($(this).find(".Rate").data("rate-before-commission") !== undefined)
                    rate = parseFloat($(this).find(".Rate").data("rate-before-commission"));
                else
                    rate = parseFloat($(this).find(".Rate").val());


                var commissionedRate = rate + rate * commissionPercent / 100;


                $(this).find(".Rate").val(commissionedRate.toFixed(2));
                $(this).find('td input.Rate').data("RateExcludedVat", commissionedRate.toFixed(2));
                $(this).find('td input.Rate').data("RateExcludedVatWithoutRoundoff", commissionedRate);
                $(this).find(".Rate").data("original-rate", commissionedRate.toFixed(2));
                $(this).find(".Rate").data("rate-before-commission", rate);


            });
            calcNetTotalAfterCommission();
        }
        e.preventDefault(); e.stopPropagation();
    };
    let calcAll = () => {

        calculateSN();
        //calcTotal();
        updateFlatDiscount();
        updateSalesTax();
        adjustTableWidth();
    };

    // #endregion
    let handleBackButtonEvent = () => {
        if (!_.isEmpty(getUrlParameters())) {
            var id = getUrlParameters();
            var mode = GetUrlParameters("mode");

            if (table.rows.length > 0) {
                bootbox.confirm({
                    message: "Do you want to cancel this transaction?",
                    buttons: {
                        confirm: {
                            label: 'Yes',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'No',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        debugger;
                        if (result) {
                            if (mode === "tax")
                                setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Landing?mode=tax") }, 100);
                            else
                                setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Landing") }, 100);
                        } else
                            return;
                    }
                }).one("shown.bs.modal", function () {
                    //temporary paused the shortcut events
                    Mousetrap.pause();
                }).one("hide.bs.modal", function () {
                    // allow Mousetrap events to fire again
                    Mousetrap.unpause();

                });
            }

            else {
                if (mode === "tax")
                    setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Landing?mode=tax") }, 100);
                else
                    setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Landing") }, 100);

                return false;
            }
        }


    };
    let quantityChangeEvt = (row) => {
        $(row).parent().parent().data("isChanged", true);
        calcAll();
    };
    let discountChangeEvt = (row) => {
        validateInlineDiscount(row);
        $(row).parent().parent().data("isChanged", true);
        calcTotal(row);
    };
    let customerPanelToggle = (evt) => {

        if (evt !== undefined) {
            evt.preventDefault(); evt.stopPropagation();
        }
        $(".bill_to_info_div").slideToggle("slow", function () {
            $("fieldset").toggleClass("bill_to_background_color");
            $("#customer_icon_toggle").toggleClass("fa-chevron-down");
        });
        if ($(".bill_to_info_div").is(":visible") == false) {
            $("#item_code").focus();
        } else {
            $("#Customer_Vat").focus();
        }

    };
    let loadCustomer = (callback) => {

        $.ajax({
            method: "POST",
            url: window.location.origin + "/Customer/GetCustomerByNumber?MembershipNumber=" + GetUrlParameters("M"),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {

                if (result.status === 200) {
                    if (result.responseJSON.length > 0) {
                        customerList = result.responseJSON;
                        $("#Customer_Id").val(result.responseJSON[0].name);
                        $("#Customer_Id").trigger("change");
                        if (callback !== undefined)
                            callback();
                    }
                }
                $("#Customer_Id").attr("readonly", true);
            }
        });




        //initialize customer dropdown
        // var customerList = localStorage.getItem("customerList");
        //$(".theme-loader").show();
        //$("#item_code").attr("disabled", true);
        //var membershipNumber = GetUrlParameters("M");
        //var getMembershipUrlBase = window.location.origin + "/Customer/";
        //var getMembershipUrl = getMembershipUrlBase + "GetMembershipByNumber?MembershipNumber=" + membershipNumber;
        //var loadedAll = false;
        //var dataSource = new kendo.data.DataSource({
        //    transport: {
        //        read: function (options) {


        //            if (options.data !== undefined && options.data.filter !== undefined && options.data.filter.filters.length > 0) {
        //                getMembershipUrl = getMembershipUrlBase + "GetMembership?text=" + options.data.filter.filters[0].value;
        //            }
        //            else if (loadedAll) {
        //                getMembershipUrl = getMembershipUrlBase + "GetMembership";
        //            }
        //            $.ajax({
        //                type: 'GET',
        //                url: getMembershipUrl + "",
        //                contentType: 'application/json; charset=utf-8',
        //                dataType: 'json',
        //                complete: function (data) {

        //                    if (data.status === 200) {
        //                        customerList = data.responseJSON;

        //                        options.success(data.responseJSON);

        //                        if (loadedAll === false) {
        //                            loadedAll = true;

        //                            getMembershipUrl = getMembershipUrlBase + "/GetMembership";
        //                            //dataSource.fetch();
        //                            var customerMultiselect = $("#Customer_Id").data("kendoComboBox");

        //                            customerMultiselect.input.attr("readonly", true);
        //                            //customerMultiselect.input.attr("disabled", "disabled");
        //                            $(".k-icon").remove();
        //                            customerMultiselect.setDataSource(dataSource);
        //                            customerMultiselect.dataSource.options.serverFiltering = true;
        //                            // customerMultiselect.dataSource.read();


        //                            callback();
        //                        }
        //                    }
        //                    else {
        //                        options.error(data.responseJSON);
        //                    }

        //                }
        //            });
        //        }
        //    },
        //    //serverFiltering:true
        //});
        //$("#Customer_Id").kendoComboBox({
        //    dataSource: dataSource,
        //    dataTextField: "name",
        //    dataValueField: "membership_Number",
        //    filter: "contains",
        //    suggest: true,
        //    index: 1,
        //    dataBound: function () {
        //        $(".theme-loader").hide();
        //        $("#item_code").attr("disabled", false);
        //        $("#membershipId").trigger("change");


        //    }
        //});
    };
    let updatePageWithRespectToPermission = (Callback) => {

        getPermissions((data) => {

            //for flat discount Right
            if (data.roleWiseUserPermission.sales_Discount_Flat_Item) {
                $("#flat_discount").data("data-max", data.roleWiseUserPermission.sales_Discount_Flat_Item_Limit);
                $(".flatDiscountHide").show();
            }
            else {
                $(".flatDiscountHide").remove();
            }

            //for commission Right
            if (data.roleWiseUserPermission.sales_Rate_Commission_Right) {
                $(".commissionPercentHide").show();
            }
            else {
                $(".commissionPercentHide").remove();
            }
            permission.salesDiscountItemwise = data.roleWiseUserPermission.sales_Discount_Line_Item;
            permission.salesDiscountItemLimit = data.roleWiseUserPermission.sales_Discount_Line_Item_Limit;
            permission.salesRateEditRight = data.roleWiseUserPermission.sales_Rate_Edit;

            if (Callback !== undefined)
                Callback();
        });
    };
    let membershipIdChangeEvent = (evt) => {
        //evt.preventDefault(); evt.stopPropagation();

        //let $mId = $("#membershipId").val();
        //if (_.isEmpty($mId) && $mId.length < 4)
        //    return false;
        ////search through customer       
        //let customer = _.filter(customerList, (x) => { return x.membership_Number === $mId; })[0]; //donot update double equal
        ////var customerDropdown = $("#Customer_Id").data("kendoComboBox");

        //if (customer !== undefined) {
        //   // customerDropdown.value(customer.membership_Number);
        //    $("#Customer_Id").val(customer.name).trigger('change');
        //}
        //else {
        //   // customerDropdown.value('');
        //    $("#Customer_Id").val("").trigger('change');
        //}
        ////focus on barcode
        //$("#item_code").focus();


    };
    let addNewMemberClickEvent = (evt) => {
        evt.preventDefault(); evt.stopPropagation();
        //customerPanelToggle();
        //$("#Customer_Id").val("").trigger("change");
        //$("#Customer_Id option[value='0']").remove();
        //$("#memberSaveButton").attr("disabled", false);
        //$("#memberSaveButtonSH").show();
    };
    let AssignKeyEvent = () => {
        //for barcode textbox focus
        Mousetrap.bindGlobal(['ctrl+b', 'home'], function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#item_code").focus();
            $("#item_code").select();
        });

        //for quantity textbox focus
        Mousetrap.bindGlobal('ctrl+q', function () {
            $("tr.active td > .Quantity").focus();
            $("tr.active td > .Quantity").select();
        });

        //for flatdiscount textbox focus
        Mousetrap.bindGlobal('ctrl+f', function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#flat_discount").focus();
        });

        //for flatdiscount percent select
        Mousetrap.bindGlobal('ctrl+f+p', function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#percentRadio").trigger("click");
        });
        //for flatdiscount amount select
        Mousetrap.bindGlobal('ctrl+f+a', function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#amountRadio").trigger("click");
        });
        //for membership textbox focus
        Mousetrap.bindGlobal('ctrl+m', function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#membershipId").focus();
        });
        //for membership expand
        Mousetrap.bindGlobal('f6', function (e) {
            e.preventDefault(); e.stopPropagation();
            $("#customer_icon_toggle").trigger("click");

        });


        //for save sales invoice
        Mousetrap.bindGlobal(['ctrl+end', 'end'], function () {
            let saveButton = $("#NextButton");
            saveButton.focus();
            saveButton.trigger('click');
        });

        //to reset
        Mousetrap.bindGlobal('ctrl+r', function (e) {
            e.preventDefault(); e.stopPropagation();
            resetForm();
        });

        //for hold transaction 
        Mousetrap.bindGlobal(['ctrl+alt+p', 'pause'], function () {
            holdTransaction();
        });


        //For Save transaction
        Mousetrap.bindGlobal('ctrl+alt+s', function () {
            saveTransaction();
        });

        //for display hold transactions
        Mousetrap.bindGlobal('f2', function () {
            showPausedTransaction();
        });


        //for display save transactions
        Mousetrap.bindGlobal('f4', function () {
            showSavedTransaction();
        });


        //to convert sales and tax
        Mousetrap.bindGlobal('alt+c', function () {
            convertSalesTax();
        });

        Mousetrap.bindGlobal('enter', function (e) {
            $(".bootbox-cancel").trigger("click");

        });

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });


        Mousetrap.bindGlobal('ctrl+f11', function (e) {
            e.preventDefault(); e.stopPropagation();
            deleteCurrentItemEntry();
        });

        Mousetrap.bindGlobal('down', function (e) {
            e.preventDefault(); e.stopPropagation();
            changeSelectedRow("down");
        });
        Mousetrap.bindGlobal('up', function (e) {
            e.preventDefault(); e.stopPropagation();
            changeSelectedRow("up");
        });
        Mousetrap.bindGlobal(['ctrl+esc', 'esc'], function () {

            handleBackButtonEvent();
        });


        $('#Invoice_Number,#trans_date_ad,#trans_date_bs,#membershipId,#flat_discount,#Customer_Name,#Customer_Vat,#Customer_Mobile,#Customer_Address').on("keypress", function (e) {
            /* ENTER PRESSED*/
            if (e.keyCode == 13) {
                /* FOCUS ELEMENT */
                if (this.name == "Customer_Address") {
                    customerPanelToggle();
                }
                else {
                    var inputs = $(this).parents("form").eq(0).find(":input:visible");
                    var idx = inputs.index(this);

                    if (idx == inputs.length - 1) {
                        inputs[0].select()
                    } else {
                        inputs[idx + 1].focus(); //  handles submit buttons
                        inputs[idx + 1].select();
                    }
                }
                return false;
            }
        });


    };
    let saveNewMemberClickEvent = (evt) => {
        //evt.preventDefault();
        //let $name = $("#Customer_Name").val();
        //let $mobile = $("#Customer_Mobile").val();
        //let $vat = $("#Customer_Vat").val();
        //let $address = $("#Customer_Address").val();
        //if (!_.isEmpty($name) && !_.isEmpty($mobile) && $mobile.length > 7) {

        //    //save to database async // if not save now also then it will save when save sales invoice
        //    //CreateMembership

        //    var member = {
        //        Name: $("#Customer_Name").val(),
        //        Address: $("#Customer_Address").val(),
        //        Vat: $("#Customer_Vat").val(),
        //        Mobile1: $("#Customer_Mobile").val(),
        //        Is_Member: true
        //    };

        //    $.ajax({
        //        method: "POST",
        //        url: "/Customer/CreateMembership",
        //        data: JSON.stringify(member),
        //        dataType: "json",
        //        contentType: "application/json; charset=utf-8",
        //        complete: function (result) {
        //            if (result.status === 200) {

        //                //update membership id
        //                $("#membershipId").val(result.responseJSON.membership.membership_Number);
        //                //update customer code 'new' to newly generated code
        //                $("#Customer_Id option[value='0'").val(result.responseJSON.membership.code);

        //            }
        //        }
        //    });
        //}
    };
    let SaveSalesInvoice = () => {
        $("#NextButton").val("Please wait ..");
        ////first calc total
        ////*** deu to slow computer donot process all calculation
        calcTotal();
        //check sales limit
        if (transType.val() === "Sales" && parseFloat(CurrencyUnFormat($("#totalNetAmount").text())) >= salesTransactionLimit) {
            //if (confirm('Your Transaction Amount Is Greater Than Sale Limit. \n Do You Want To Convert To Tax Invoice?')) {
            //    convertSalesTax();
            //    return false;
            //}
            convertSalesTax();
        }

        //variable
        let tableRows = document.getElementById("item_table").getElementsByTagName('tbody')[0];




        //save field data first
        $("#Total_Quantity").val(CurrencyUnFormat($("#totalQuantity").text()));
        $("#Total_Gross_Amount").val(CurrencyUnFormat($("#totalGrossAmount").text()));
        $("#Total_Discount").val(CurrencyUnFormat($("#totalDiscount").text()));
        $("#Total_Vat").val(CurrencyUnFormat($("#totalTax").text()));
        $("#Total_Net_Amount").val(CurrencyUnFormat($("#totalNetAmount").text()));
        //$("#NonTaxableAmount").val(totalTaxableAmount.toFixed(2));
        //$("#TaxableAmount").val(CurrencyFormat(totalNonTaxableAmount.toFixed(2)));


        //validate
        if (!$('form#Sales_Invoice_Form').valid()) {
            bootbox.alert("Something wrong, please check all values !!");
            $("#NextButton").val("Next");
            return false;
        }
        if (tableRows === undefined || tableRows.rows.length === 0) {
            bootbox.alert("No Item selected !!");
            $("#NextButton").val("Next");
            return false;
        }
        let checkQuantityAndRateZeroValue = false;
        $.each(tableRows.rows, function (i, v) {

            //variables           
            let rate = parseFloat($(this).find(".Rate").val());
            let quantity = parseFloat($(this).find(".Quantity").val());
            if (rate === 0 || quantity === 0) {
                checkQuantityAndRateZeroValue = true;
                $("#NextButton").val("Next");
                return false;
            }
        });
        if (checkQuantityAndRateZeroValue) {
            bootbox.alert("Item price or quantity must be greater than zero !!");
            $("#NextButton").val("Next");
            return false;
        }






        //get items
        var table = $("#item_table");
        var invoiceItems = [];
        table.find('tbody > tr').each(function (i, el) {
            var $tds = $(this).find('td');
            let discountType = $(this).find('td input.Discount').data("discountType");
            let promoDiscount = discountType === undefined || discountType !== "MembershipDiscount" ? $(this).find('td input.Discount').val() : 0;
            let membershipDiscount = discountType === "MembershipDiscount" ? $(this).find('td input.Discount').val() : 0;
            invoiceItems.push({
                Bar_Code: $tds.eq(1).text(),
                ItemCode: $(this).find('td .itemName').data("item-code"),
                ItemId: $(this).find('td .itemName').data("item-id"),
                Name: $tds.eq(2).text(),
                Unit: $tds.eq(3).text(),
                Rate: $(this).find('td input.Rate').val(),
                RateExcludeVat: $(this).find('td input.Rate').data("RateExcludedVat"),
                RateExcludeVatWithoutRoundoff: $(this).find('td input.Rate').data("RateExcludedVatWithoutRoundoff"),
                Quantity: $(this).find('td input.Quantity').val(),
                Gross_Amount: $(this).find('td input.GrossAmount').val(),
                Discount: $(this).find('td input.Discount').val(),
                DiscountPercent: $(this).find('td input.Discount').data("DiscountPercent"),
                PromoDiscount: promoDiscount,
                MembershipDiscount: membershipDiscount,
                Tax: $(this).find('td input.Tax').val(),
                Is_Vatable: $(this).find('td input.Tax').attr("data-isVatable") === "true",
                Is_Discountable: $(this).find('td input.Discount').attr("data-isDiscountable") === "true",
                Net_Amount: $(this).find('td input.NetAmount').val(),
                Remarks: $(this).find('td .itemName').data("item-code")
            });
        });



        //call ajaxnow       
        var data = $('form#Sales_Invoice_Form').serializeObject();

        //assign customer id
        data.Customer_Id = $("#membershipId").val();

        if ($("input[name='flatDiscount']:checked").val() === "percent")
            data.Flat_Discount_Percent = $("#flat_discount").val();
        else
            data.Flat_Discount_Amount = $("#flat_discount").val();



        //add membership discount
        data.MembershipDiscount = calcTotalMembershipDiscount();
        data.PromoDiscount = calcTotalPromoDiscount();



        data.SalesInvoiceItems = invoiceItems;
        data.MemberId = $("#membershipId").val();
        var membership = $("#Customer_Id option[value='0'");

        var final = {
            SalesInvoice: data,
            Customer: {
                Name: membership.text(),
                Address: membership.data("address"),
                Vat: membership.data("vat"),
                Mobile1: membership.data("mobile"),
                Is_Member: $("#isNewMember").val()
            }
        };


        $.ajax({
            method: "POST",
            url: "/SalesInvoice/Index",
            data: JSON.stringify(final),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200) {
                    //if ($("#Trans_Type").val() === "Hold") {
                    //    let m = GetUrlParameters("M") === undefined ? "" : "M=" + GetUrlParameters("M");
                    //    let mode = GetUrlParameters("Mode") === undefined ? "" : "Mode=" + GetUrlParameters("Mode");
                    //    let url = SetUrlParameters(window.location.origin + "/SalesInvoice", [m, mode]);
                    //    window.location.href = url;
                    //}

                    if (result.responseJSON.redirectUrl === "") {
                        StatusNotify("success", "Saved Successfully");
                    } else {

                        window.location.href = window.location.origin + result.responseJSON.redirectUrl;
                    }
                    // console.log("windows Url", window.location.href);


                }
                else {
                    StatusNotify("error", result.responseText);
                }
                $("#NextButton").val("Next");
            }
        });


        // $('form#Sales_Invoice_Form').submit();


    };


    // #endregion PRIVATE METHODS **************//

    // #region ALL EVENTS **************//
    $("#NextButton").on('click', SaveSalesInvoice);
    $('#item_code').on("keypress", barCodeKeyPressEvent);
    $('#trans_date_ad').change(function () {
        $('#trans_date_bs').val(AD2BS(FormatForInput($('#trans_date_ad').val())));
    });
    $('#trans_date_bs').change(function () {
        $('#trans_date_ad').val(FormatForDisplay(BS2AD($('#trans_date_bs').val())));
    });
    $("#customer_icon_toggle").on('click', customerPanelToggle);
    $("#Customer_Id").on('change', function (e) {

        //e.preventDefault(); e.stopPropagation();
        //var selectedValue = $("#Customer_Id").data("kendoComboBox").value();
        //var selectedItem = _.filter(customerList, function (x) {
        //    return x.membership_Number === selectedValue;
        //})[0];
        var selectedItem = customerList[0];
        if (selectedItem) {

            $("#Customer_Name").val(selectedItem.name);
            $("#Customer_Address").val(selectedItem.address);
            $("#Customer_Vat").val(selectedItem.vat);
            $("#Customer_Mobile").val(selectedItem.mobile1);
            $("#membershipId").val(selectedItem.membership_Number);
        } else {
            $("#Customer_Name").val("");
            $("#Customer_Address").val("");
            $("#Customer_Vat").val("");
            $("#Customer_Mobile").val("");
        }
        //$("#memberSaveButtonSH").hide();

    });
    $("input[name='flatDiscount'],#flat_discount").on('change', function () {

        //for now update all row to take change effect
        $.each(table.rows, function (i, v) {
            $(this).data("isChanged", true);
        });
        calcTotal();
    });
    $("input[name='flatDiscount'],#flat_discount").on('keypress', function (e) {
        var $this = $(e.currentTarget);
        if (e.keyCode === 13 && $this.val() !== "" && $this.val().length > 0) {
            $this.trigger("change");
            e.preventDefault();
        }
        else if (e.keyCode === 13 && $this.val() === "")
            e.preventDefault();

    });
    $("#commissionPercent").on('keypress', function (e) {
        var $this = $(e.currentTarget);
        if (e.keyCode === 13 && $this.val() !== "" && $this.val().length > 0) {
            $("#CalculateCommission").trigger("click");
            e.preventDefault();
        }
        else if (e.keyCode === 13 && $this.val() === "")
            e.preventDefault();
    });
    $("#CalculateCommission").on("click", calcCommission);
    $("#convert-sales-tax").on('click', function (e) {
        e.preventDefault();
        convertSalesTax();
        return false;
    });
    $('#pausedTransactionListTable >tbody > tr').on('dblclick', function () {
        loadPausedTransaction($(this));
        $("#PausedTransactionListModal").modal('hide');
    });
    $('#savedTransactionListTable >tbody > tr').on('dblclick', function () {
        loadPausedTransaction($(this));
        $("#SavedTransactionListModal").modal('hide');
    });
    $("#ResetButton").on('click', function () {
        resetForm();
    });
    $("#membershipId").on('change', membershipIdChangeEvent);
    $("#memberAddButton").on('click', addNewMemberClickEvent);

    //prevent click event
    $("#Invoice_Number,#trans_date_ad,#trans_date_bs").on('click', function (e) {
        e.preventDefault(); e.stopPropagation();
    });



    $("#memberSaveButton").on("click", saveNewMemberClickEvent);
    //$(window).resize(function () {
    //    adjustTableWidth();
    //});

    // #endregion ALL EVENTS **************//



    //********* PUBLIC OUTPUT **************//
    return {
        init: init,
        delete_row: delete_row,
        deleteInvoice: deleteInvoice,
        calcTotal: calcTotal,
        calcAll,
        quantityChangeEvt,
        discountChangeEvt,
        addRowGetUpdateData
    };


})();

invoice.init();
