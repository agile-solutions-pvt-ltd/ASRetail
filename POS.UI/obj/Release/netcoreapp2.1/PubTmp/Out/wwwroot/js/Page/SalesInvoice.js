const invoice = (function () {
    //*********Private Variables **************//

    let table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
    let taxPercent = 13;
    let salesTransactionLimit = 5000;
    let permission = {
        salesDiscountItemwise: false,
        salesRateEditRight: false
    };

    let transType = $("#Trans_Type"),
        totalNetAmount = $("#Total_Net_Amount");


    //*********Private Methos **************//
    let init = () => {


        //focus on barcode
        $("#item_code").focus();

        //set todays date
        $("#trans_date_ad").val(FormatForDisplay(new Date()));
        $("#trans_date_ad").trigger('change');

        //remove success messge if any after certtain time
        setTimeout(() => {
            $(".alert").hide();
            //update url too
            if (getUrlParameters().indexOf("StatusMessage") > -1)
                history.pushState({}, null, window.location.origin + "/SalesInvoice");
        }, 3000);




        //hide bill to customer info
        $(".bill_to_info_div").hide();

        updateSalesTax();

        //update page respect to permission //loadPausedTransaction after permission data loaded
        updatePageWithRespectToPermission(loadPausedTransactionData);

        //if membership in url load membership
        if (GetUrlParameters("M") !== undefined) {
            var membershipId = GetUrlParameters("M");
            $("#membershipId").val(membershipId).trigger('change');
        }

    };
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
    let calcAll = () => {
        calculateSN();
        calcTotal();
        updateFlatDiscount();
        updateSalesTax();
        adjustTableWidth();
    };
    let GetItems = (code, callback) => {
        $.ajax({
            url: window.location.origin + "/item/GetItems/?code=" + code,
            type: "GET",
            success: function (data) {
                if (data.length === 0) {
                    $("#itemNotFoundLabel").show();
                    setTimeout(function () { $("#itemNotFoundLabel").hide(); }, 9000);

                } else
                    callback(data[0]);
            },
            error: function (x) {
                console.log(x);
            }
        });
    };
    let calcTotal = (from) => {

        var totalGrossAmount = 0;
        var totalNetAmount = 0;
        var totalQuantity = 0;
        var totalDiscount = 0;
        var totalTax = 0;

        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {
                //calculations

                var quantity = $(this).find(".Quantity").val();
                var rate = $(this).find(".Rate").data("original-rate");
                var discount = $(this).find(".Discount").data("original-value") || 0;
                if (from !== undefined && from.name === "Discount")
                    discount = $(this).find(".Discount").val();
                var tax = $(this).find(".Tax").val() || 0;

                if (quantity !== undefined && rate !== undefined) {
                    quantity = parseInt(quantity);
                    rate = parseFloat(rate);
                    discount = parseFloat(discount);
                    if (from !== undefined && from.name === "Discount") {
                        discount = discount / quantity;
                        $(this).find(".Discount").data("original-value", discount);
                    }

                    if ($("#Trans_Type").val() === "Tax" && $(this).find(".Tax").data("isvatable") === true)
                        tax = calculateTax(rate, taxPercent);
                    else if ($("#Trans_Type").val() === "Tax")
                        tax = parseFloat(tax);
                    else
                        tax = 0;


                    rate = rate - tax; //exclude tax from rate
                    var grossAmount = quantity * rate;
                    tax = tax * quantity; //gross tax
                    var netAmount = grossAmount - discount + tax;

                    //discount
                    //only calculate if not flat discount
                    if (!$(this).find(".Discount").data("isdiscountable")) {
                        discount = discount * quantity;
                    }
                    else if ($("input[name='flatDiscount']:checked").val() === undefined || parseFloat($("#flat_discount").val()) <= 0)
                        discount = discount * quantity;

                    totalQuantity += quantity;
                    totalDiscount += discount;
                    totalTax += tax;
                    totalGrossAmount += grossAmount;
                    totalNetAmount += netAmount;

                    //assign
                    $(this).find(".Rate").val(rate.toFixed(2));
                    $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
                    if (from !== undefined && from.name === "Discount") {
                        //$(this).find(".Discount").data("original-value", discount);
                    }
                    else {
                        $(this).find(".Discount").val(discount.toFixed(2));
                    }

                    $(this).find(".Tax").val(tax.toFixed(2));
                    $(this).find(".NetAmount").val(netAmount.toFixed(2));
                    //assign total
                    $("#totalQuantity").text(NumberFormat(totalQuantity));
                    $("#totalGrossAmount").text(CurrencyFormat(totalGrossAmount));
                    $("#totalDiscount").text(CurrencyFormat(totalDiscount));
                    $("#totalTax").text(CurrencyFormat(totalTax));
                    $("#totalNetAmount").text(CurrencyFormat(totalNetAmount));
                }

            });
        }
        else {
            //assign total
            $("#totalQuantity").text("0");
            $("#totalGrossAmount").text("0.00");
            $("#totalDiscount").text("0.00");
            $("#totalTax").text("0.00");
            $("#totalNetAmount").text("0.00");
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
    let updateFlatDiscount = () => {
        var type = $("input[name='flatDiscount']:checked").val();
        var value = $("#flat_discount").val() || 0;
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
                var lineDiscountAmount = parseFloat($(this).find(".Discount").val());
                if ($(this).find(".Discount").data("isdiscountable")) {
                    totalGrossAmountWithoutLineDiscountItem += grossAmount;
                }
            });
            percent = discountAmount * 100 / totalGrossAmountWithoutLineDiscountItem;
        }

        $.each(table.rows, function (i, v) {
            var grossAmount = parseFloat($(this).find(".GrossAmount").val());
            var lineDiscountAmount = parseFloat($(this).find(".Discount").val());
            if ($(this).find(".Discount").data("isdiscountable")) {
                var discount = grossAmount * percent / 100;
                $(this).find(".Discount").val(discount.toFixed(2));
                $(this).find(".Discount").data("original-value", discount.toFixed(2));
            }
            //if flat_discount percent is zero then enable individual discount  
            $(this).find(".Discount").attr("readonly", percent !== 0);

        });
        calcTotal();
    };
    let calculateSN = () => {
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((table.rows.length - i).toString());
        });
    };
    let calculateTax = (grossAmount, taxPercent) => {
        //tax deduction formula
        let tax = (taxPercent * grossAmount) / (taxPercent + 100);
        return tax;

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
            //remove tax columns
            $('thead > tr > th:nth-child(9),tbody > tr > td:nth-child(9), tfoot > tr > td:nth-child(5)').show();

        } else {
            $("#Invoice_Number").attr("placeholder", salesInvoiceNumber.replace("TI", "SI"));
            if (!_.isEmpty($("#Invoice_Number").val())) $("#Invoice_Number").val(salesInvoiceNumber.replace("TI", "SI"));
            $("#Chalan_Number").attr("readonly", true);
            $("#convert-sales-tax").attr("title", "Convert to Tax Invoice");
            $("#Trans_Type").val("Sales");
            $('thead > tr > th:nth-child(9),tbody > tr > td:nth-child(9), tfoot > tr > td:nth-child(5)').hide();
        }
        calcTotal();

    };
    let addRowGetUpdateData = (code) => {
        var t1 = table.rows.length;

        //first check there alreay item in pos  
        var checkAlreadyExistItem = false;
        $.each(table.rows, function (i, v) {
            var barcode = $(this).find(".barcode").text();
            var quantity = $(this).find(".Quantity").val();
            if (barcode === code) {
                $(this).find(".Quantity").val((parseInt(quantity) + 1).toString());
                //highlight row
                makeRowAtTopAndHightlight($(this));
                calcTotal();
                calculateSN();
                checkAlreadyExistItem = true;
                return false;
            }
        });

        if (!checkAlreadyExistItem) {

            GetItems(code, function (result) {
                addRowWithData(result);
            });
        }
    };
    let addRowWithData = (result) => {

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

        //assign class
        cell1.className = "sn-width-item";
        cell2.className = "barCode-width-item";
        cell3.className = "itemName-width-item";
        cell4.className = "unit-width-item";
        cell5.className = "rate-width-item";
        cell6.className = "quantity-width-item";
        cell7.className = "grossAmount-width-item";
        cell8.className = "discount-width-item";
        cell9.className = "tax-width-item";
        cell10.className = "netAmount-width-item";
        cell11.className = "action-width-item";

        var barCode = result.bar_Code || result.Bar_Code;
        var itemName = result.name || result.Name;
        var unit = result.unit || result.Unit;
        var rate = result.rate || result.Rate;
        var quantity = result.Quantity === undefined ? 1 : result.Quantity;
        var discount = (result.Discount || result.discount) === undefined ? 0 : (result.Discount || result.discount);
        var isDiscountable = result.is_Discountable || result.Is_Discountable || false;
        var tax = result.Tax === undefined ? 0 : result.Tax;
        var isVatable = result.is_Vatable || result.Is_Vatable;
        if ($("#Trans_Type").val() === "Tax" && isVatable !== undefined && isVatable && tax === 0) {
            tax = (grossAmount - discount) * taxPercent / 100;
        }
        grossAmount = 0;
        tax = 0;
        var netAmount = 0;

        //invoiceItems[0].sn
        //highlight row
        makeRowAtTopAndHightlight(row);

        //discount make disable with respect to permission
        var discountDisabled = permission.salesDiscountItemwise === false ? "disabled" : isDiscountable === false ? "disabled" : "";
        var rateDisabled = permission.salesRateEditRight === true ? "" : "disabled";
        var fromDiscount = "fromDiscount";

        $('<i class="sn font-weight-bold">' + table.rows.length + '</i>').appendTo(cell1);
        $("<span class='barcode'>" + barCode + "</span>").appendTo(cell2);
        $("<span>" + itemName + "</span>").appendTo(cell3);
        $("<span>" + unit + "</span>").appendTo(cell4);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Rate" type="number" min="0" onkeyup="invoice.calcTotal()" name="Rate" ' + rateDisabled + ' data-original-rate="' + rate.toFixed(2) + '" value=' + rate.toFixed(2) + '>').appendTo(cell5);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Quantity" type="number" min="1" onkeyup="invoice.calcTotal()" name="Quantity" value=' + quantity.toString() + '>').appendTo(cell6);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right GrossAmount" type="number" onkeyup="invoice.calcTotal()" name="GrossAmount" disabled value=' + grossAmount.toFixed(2) + '>').appendTo(cell7);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Discount" type="number" data-isDiscountable="' + isDiscountable + '" ' + discountDisabled + ' min="0" onkeyup="invoice.calcTotal(this)" name="Discount" data-original-value="' + discount.toFixed(2) + '" value=' + discount.toFixed(2) + '>').appendTo(cell8);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Tax" data-isVatable="' + isVatable + '" type="number" onkeyup="invoice.calcTotal()" name="Tax" disabled value=' + tax.toFixed(2) + '>').appendTo(cell9);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right NetAmount" type="number" onkeyup="invoice.calcTotal()" name="NetAmount" disabled value=' + netAmount.toFixed(2) + '>').appendTo(cell10);

        $('<botton onclick="invoice.delete_row(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell11);

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
    let delete_row = (evt) => {
        evt.parentElement.parentElement.remove();
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
    let holdTransaction = () => {
        $("#Remarks").val($("#Trans_Type").val());
        $("#Trans_Type").val("Hold");
        SaveSalesInvoice();
    };
    let showPausedTransaction = () => {
        $("#PausedTransactionListModal").modal('show');
    };
    let loadPausedTransaction = (row) => {
        var invoiceId = row.closest("tr").find('td.invoice-id').text();
        window.location.href = window.location.origin + "/SalesInvoice/Index/" + invoiceId.trim();
    };
    let loadPausedTransactionData = (data) => {
        if (getUrlParameters() !== 0 && salesInvoiceTmpData.SalesInvoiceItems !== null) {



            //customer info
            $("#Customer_Id").val();
            //update membership            
            var selectedItem = _.filter(customerList, function (x) {
                return x.Id === salesInvoiceTmpData.Customer_Id;
            })[0];
            if (selectedItem) {
                $("#membershipId").val(selectedItem.Member_Id);
            }
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
            convertSalesTax();

            //save transaction id
            $("#Id").val(getUrlParameters());

            //insert items
            if (salesInvoiceTmpData.SalesInvoiceItems.length > 0) {
                _.each(salesInvoiceTmpData.SalesInvoiceItems, function (x) {
                    addRowWithData(x);
                });
            }
        }
    };
    let resetForm = () => {
        var url = window.location.origin + "/SalesInvoice";
        if (GetUrlParameters("mode") !== undefined && GetUrlParameters("mode") === "tax")
            url = SetUrlParameters(url, ["Mode=tax"]);
        if (GetUrlParameters("m") !== undefined)
            url = SetUrlParameters(url, ["M=" + GetUrlParameters("M")]);

        window.location.href = url;
    };
    let getUrlParameters = () => {
        var sPageURL = window.location.href;
        var indexOfLastSlash = sPageURL.lastIndexOf("/");

        if (indexOfLastSlash > 0 && sPageURL.length - 1 !== indexOfLastSlash)
            return sPageURL.substring(indexOfLastSlash + 1);
        else
            return 0;
    };
    let barCodeKeyPressEvent = (e) => {

        var $this = $(e.currentTarget);
        if (e.keyCode === 13 && $this.val() !== "" && $this.val().length > 2) {
            addRowGetUpdateData($this.val());
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

        }
    };
    let customerPanelToggle = () => {
        $(".bill_to_info_div").slideToggle("slow", function () {
            $("fieldset").toggleClass("bill_to_background_color");
            $("#customer_icon_toggle").toggleClass("fa-chevron-down");
        });
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
    let updatePageWithRespectToPermission = (Callback) => {
        getPermissions((data) => {
            //for flat discount Right
            if (data.roleWiseUserPermission.sales_Discount_Flat_Item) {
                $(".flatDiscountHide").show();
            }
            else {
                $(".flatDiscountHide").remove();
            }
            permission.salesDiscountItemwise = data.roleWiseUserPermission.sales_Discount_Line_Item;
            permission.salesRateEditRight = data.roleWiseUserPermission.sales_Rate_Edit;

            if (Callback !== undefined)
                Callback();
        });
    };
    let membershipIdChangeEvent = (evt) => {
        evt.preventDefault();
        let $mId = $("#membershipId").val();
        if (_.isEmpty($mId) && $mId.length < 4)
            return false;

        //search through customer       
        let customer = _.filter(customerList, (x) => { return x.Member_Id === parseInt($mId); })[0]; //donot update double equal
        if (customer !== undefined) {
            $("#Customer_Id").val(customer.Code).trigger('change');
        }
        else
            $("#Customer_Id").val("").trigger('change');

    };
    let addNewMemberClickEvent = (evt) => {
        evt.preventDefault();
        customerPanelToggle();
        $("#Customer_Id").val("").trigger("change");
        $("#Customer_Id option[value='0']").remove();
        $("#memberSaveButton").attr("disabled", false);
        $("#memberSaveButtonSH").show();
    };
    let saveNewMemberClickEvent = (evt) => {
        evt.preventDefault();
        let $name = $("#Customer_Name").val();
        let $mobile = $("#Customer_Mobile").val();
        let $vat = $("#Customer_Vat").val();
        let $address = $("#Customer_Address").val();
        if (!_.isEmpty($name) && !_.isEmpty($mobile) && $mobile.length > 9) {
            $("#membershipId").attr("readonly", true);
            $("#Customer_Id").attr("readonly", true);
            $("#Customer_Id").append($('<option>', {
                value: "0",
                text: $name,
                "data-mobile": $mobile,
                "data-vat": $vat,
                "data-address": $address
            })).val("0");
            $("#isNewMember").val(true);
            $("#memberSaveButton").attr("disabled", true);
            customerPanelToggle();
        }
    };

    let SaveSalesInvoice = () => {

        //final calculation if someone update through browser
        // calcAll();

        //save field data first
        $("#Total_Quantity").val(CurrencyUnFormat($("#totalQuantity").text()));
        $("#Total_Gross_Amount").val(CurrencyUnFormat($("#totalGrossAmount").text()));
        $("#Total_Discount").val(CurrencyUnFormat($("#totalDiscount").text()));
        $("#Total_Vat").val(CurrencyUnFormat($("#totalTax").text()));
        $("#Total_Net_Amount").val(CurrencyUnFormat($("#totalNetAmount").text()));

        //validate
        if (!$('form#Sales_Invoice_Form').valid())
            return false;



        //check sales limit
        if (transType.val() === "Sales" && totalNetAmount.val() >= salesTransactionLimit) {
            //if (confirm('Your Transaction Amount Is Greater Than Sale Limit. \n Do You Want To Convert To Tax Invoice?')) {
            //    convertSalesTax();
            //    return false;
            //}
            convertSalesTax();
        }

        //get items
        var table = $("#item_table");
        var invoiceItems = [];
        table.find('tbody > tr').each(function (i, el) {
            var $tds = $(this).find('td');
            invoiceItems.push({
                Bar_Code: $tds.eq(1).text(),
                Name: $tds.eq(2).text(),
                Unit: $tds.eq(3).text(),
                Rate: $(this).find('td input.Rate').val(),
                Quantity: $(this).find('td input.Quantity').val(),
                Gross_Amount: $(this).find('td input.GrossAmount').val(),
                Discount: $(this).find('td input.Discount').val(),
                Tax: $(this).find('td input.Tax').val(),
                Is_Vatable: $(this).find('td input.Tax').attr("data-isVatable") === "true",
                Is_Discountable: $(this).find('td input.Discount').attr("data-isDiscountable") === "true",
                Net_Amount: $(this).find('td input.NetAmount').val()
            });
        });

        //call ajaxnow       
        var data = $('form#Sales_Invoice_Form').serializeObject();

        if ($("input[name='flatDiscount']:checked").val() === "percent")
            data.Flat_Discount_Percent = $("#flat_discount").val();
        else
            data.Flat_Discount_Amount = $("#flat_discount").val();

        data.SalesInvoiceItems = invoiceItems;
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
                    window.location.href = window.location.origin + result.responseJSON.redirectUrl;
                }
            }
        });


        // $('form#Sales_Invoice_Form').submit();


    };


    //events
    $("#NextButton").on('click', SaveSalesInvoice);
    $('#item_code').on("keypress", barCodeKeyPressEvent);
    // $("#trans_date_ad").datepicker();
    //$('#trans_date_bs').nepaliDatePicker({
    //    onChange: function () {
    //        $('#trans_date_ad').val(FormatForDisplay(BS2AD($('#trans_date_bs').val())));

    //    }
    //});
    $('#trans_date_ad').change(function () {
        $('#trans_date_bs').val(AD2BS(FormatForInput($('#trans_date_ad').val())));
    });
    $('#trans_date_bs').change(function () {
        $('#trans_date_ad').val(FormatForDisplay(BS2AD($('#trans_date_bs').val())));
    });
    $("#customer_icon_toggle").on('click', customerPanelToggle);
    $("#Customer_Id").on('change', function () {
        var selectedValue = $('#Customer_Id').find(":selected").val();
        var selectedItem = _.filter(customerList, function (x) {
            return x.Code === selectedValue;
        })[0];
        if (selectedItem) {
            $("#Customer_Name").val(selectedItem.Name);
            $("#Customer_Address").val(selectedItem.Address);
            $("#Customer_Vat").val(selectedItem.Vat);
            $("#Customer_Mobile").val(selectedItem.Mobile);
            $("#membershipId").val(selectedItem.Member_Id);
        } else {
            $("#Customer_Name").val("");
            $("#Customer_Address").val("");
            $("#Customer_Vat").val("");
            $("#Customer_Mobile").val("");
        }
        $("#memberSaveButtonSH").hide();

    });
    $("input[name='flatDiscount'],#flat_discount").on('change', updateFlatDiscount);
    $("#convert-sales-tax").on('click', function (e) {
        e.preventDefault();
        convertSalesTax();
        return false;
    });
    $('#pausedTransactionListTable >tbody > tr').on('dblclick', function () {
        loadPausedTransaction($(this));
        $("#PausedTransactionListModal").modal('hide');
    });
    $("#ResetButton").on('click', function () {
        resetForm();
    });
    $("#membershipId").on('change', membershipIdChangeEvent);
    $("#memberAddButton").on('click', addNewMemberClickEvent);
    $("#memberSaveButton").on("click", saveNewMemberClickEvent);
    $(window).resize(function () {
        adjustTableWidth();
    });
    //Public Output
    return {
        init: init,
        delete_row: delete_row,
        deleteInvoice: deleteInvoice,
        calcTotal: calcTotal,
        holdTransaction: holdTransaction,
        showPausedTransaction: showPausedTransaction
    };


})();
invoice.init();
