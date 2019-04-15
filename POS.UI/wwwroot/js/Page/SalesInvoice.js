const invoice = (function () {
    //*********Private Variables **************//

    let taxPercent = 13;
    let salesTransactionLimit = 5000;

    let transType = $("#Trans_Type"),
        totalNetAmount = $("#Total_Net_Amount");


    //*********Private Methos **************//
    let init = () => {

        //focus on barcode
        $("#item_code").focus();

        //set todays date
        $("#trans_date_ad").val(FormatForDisplay(new Date()));
        $("#trans_date_ad").trigger('change');

        //hide bill to customer info
        $(".bill_to_info_div").hide();

        updateSalesTax();
        loadPausedTransactionData();
    };

    let updateSalesTax = () => {
        if (window.location.search.indexOf("tax") > -1 || window.location.search.indexOf("Tax") > -1) {
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
    let calcTotal = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var totalGrossAmount = 0;
        var totalNetAmount = 0;
        var totalQuantity = 0;
        var totalDiscount = 0;
        var totalTax = 0;

        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {
                //calculations

                var quantity = $(this).find(".Quantity").val();
                var rate = $(this).find(".Rate").val();
                var discount = $(this).find(".Discount").val() || 0;
                var tax = $(this).find(".Tax").val() || 0;

                if (quantity !== undefined && rate !== undefined) {
                    quantity = parseInt(quantity);
                    var grossAmount = quantity * parseFloat(rate);
                    discount = parseFloat(discount);
                    if ($("#Trans_Type").val() === "Tax" && $(this).find(".Tax").data("isvatable") === true)
                        tax = (grossAmount - discount) * taxPercent / 100;
                    else if ($("#Trans_Type").val() === "Tax")
                        tax = parseFloat(tax);
                    else
                        tax = 0;

                    var netAmount = grossAmount - discount + tax;

                    totalQuantity += quantity;
                    totalDiscount += discount;
                    totalTax += tax;
                    totalGrossAmount += grossAmount;
                    totalNetAmount += netAmount;

                    //assign
                    $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
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
    let updateFlatDiscount = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
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
            if ($(this).find(".Discount").data("isdiscountable")){
                var discount = grossAmount * percent / 100;
                $(this).find(".Discount").val((discount).toFixed(2));
            }
            //if flat_discount percent is zero then enable individual discount  
            $(this).find(".Discount").attr("readonly", percent !== 0);

        });
        calcTotal();
    };
    let calculateSN = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((table.rows.length - i).toString());
        });
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
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var t1 = (table.rows.length);

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
    let makeRowAtTopAndHightlight = (row) => {
        if (row.className === undefined) {
            row.addClass("active");
            setTimeout(() => { row.removeClass("active"); }, 300);
            //make it at first
            var firstRow = row.parent().children("tr:first");
            row.insertBefore(firstRow);
        } else {
            row.className = "active";
            setTimeout(() => { row.className = ""; }, 300);
        }

        debugger;
        //test logic
        // Change the selector if needed
        var $table = $('#item_table'),
            $bodyCells = $table.find('tbody tr:first').children(),
            colWidth;

        // Get the tbody columns width array
        colWidth = $bodyCells.map(function () {
            return $(this).width();
        }).get();

        //now make table scrollable
        // $table.find('tbody').css({"display":"block","overflow-y":"scroll"});

        // Set the width of thead columns
        $table.find('thead tr').children().each(function (i, v) {
            $(v).width(colWidth[i]);
        });

    };
    let delete_row = (evt) => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
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
    let addRowWithData = (result) => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];


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


        var barCode = result.bar_Code || result.Bar_Code;
        var itemName = result.name || result.Name;
        var unit = result.unit || result.Unit;
        var rate = result.rate || result.Rate;
        var quantity = result.Quantity === undefined ? 1 : result.Quantity;
        debugger;
        var grossAmount = rate * quantity;
        var discount = result.Discount || result.discount === undefined ? 0 : result.Discount || result.discount;
        var isDiscountable = result.is_Discountable || result.Is_Discountable || false;
        var tax = result.Tax === undefined ? 0 : result.Tax;
        var isVatable = result.is_Vatable || result.Is_Vatable;
        if ($("#Trans_Type").val() === "Tax" && isVatable !== undefined && isVatable && tax === 0) {
            tax = (grossAmount - discount) * taxPercent / 100;
        }
        var netAmount = grossAmount - discount + tax;

        //invoiceItems[0].sn
        //highlight row
        makeRowAtTopAndHightlight(row);

        $('<i class="sn font-weight-bold">' + (table.rows.length) + '</i>').appendTo(cell1);
        $("<span class='barcode'>" + barCode + "</span>").appendTo(cell2);
        $("<span>" + itemName + "</span>").appendTo(cell3);
        $("<span>" + unit + "</span>").appendTo(cell4);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Rate" type="number" min="0" onkeyup="invoice.calcTotal()" name="Rate" value=' + rate.toFixed(2) + '>').appendTo(cell5);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Quantity" type="number" min="1" onkeyup="invoice.calcTotal()" name="Quantity" value=' + quantity.toString() + '>').appendTo(cell6);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right GrossAmount" type="number" onkeyup="invoice.calcTotal()" name="GrossAmount" disabled value=' + grossAmount.toFixed(2) + '>').appendTo(cell7);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Discount" type="number" data-isDiscountable="' + isDiscountable+'" min="0" onkeyup="invoice.calcTotal()" name="Discount" value=' + discount.toFixed(2) + '>').appendTo(cell8);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Tax" data-isVatable="' + isVatable + '" type="number" onkeyup="invoice.calcTotal()" name="Tax" disabled value=' + tax.toFixed(2) + '>').appendTo(cell9);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right NetAmount" type="number" onkeyup="invoice.calcTotal()" name="NetAmount" disabled value=' + netAmount.toFixed(2) + '>').appendTo(cell10);

        $('<botton onclick="invoice.delete_row(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell11);

        calcAll();
    };
    let SaveSalesInvoice = () => {
        //save field data first
        $("#Total_Quantity").val(CurrencyUnFormat($("#totalQuantity").text()));
        $("#Total_Gross_Amount").val(CurrencyUnFormat($("#totalGrossAmount").text()));
        $("#Total_Discount").val(CurrencyUnFormat($("#totalDiscount").text()));
        $("#Total_Tax").val(CurrencyUnFormat($("#totalTax").text()));
        $("#Total_Net_Amount").val(CurrencyUnFormat($("#totalNetAmount").text()));

        //validate
        if (!$('form#Sales_Invoice_Form').valid())
            return false;

        //check sales limit
        if (transType.val() === "Sales" && totalNetAmount.val() >= salesTransactionLimit) {
            if (confirm('Your Transaction Amount Is Greater Than Sale Limit. \n Do You Want To Convert To Tax Invoice?')) {
                convertSalesTax();
                return false;
            }
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

        $.ajax({
            method: "POST",
            url: "/SalesInvoice/Index",
            data: JSON.stringify(data),
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
            $("#Customer_Id").val(salesInvoiceTmpData.Customer_Id);
            //flat discount
            if (salesInvoiceTmpData.Flat_Discount_Amount !== null) {
                $("#amountRadio").prop("checked", true);
                $("#flat_discount").val(salesInvoiceTmpData.Flat_Discount_Amount);
            } else {
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
        if (getUrlParameters() !== undefined && getUrlParameters().indexOf("?") > -1)
            window.location.href = window.location.origin + "/SalesInvoice?tax";
        else
            window.location.href = window.location.origin + "/SalesInvoice";
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

            // Work around Chrome's little problem
            $this.mouseup(function () {
                // Prevent further mouseup intervention
                $this.unbind("mouseup");
                return false;
            });
            return false; // prevent the button click from happening
        }
    };
    let getPermissions = (Callback) => {
        $.ajax({
            url: window.location.origin + "/Settings/UserPermissions",
            type: "GET",
            complete: function (result) {
                if (result.status === 200) {
                    Callback(result.responseJSON);
                } 
            },           
        });
    };
    let updatePageWithRespectToPermission = () => {

    };


    //events
    $("#NextButton").on('click', SaveSalesInvoice);
    $('#item_code').on("keypress", barCodeKeyPressEvent);
    $("#trans_date_ad").datepicker();
    $('#trans_date_bs').nepaliDatePicker({
        onChange: function () {
            $('#trans_date_ad').val(FormatForDisplay(BS2AD($('#trans_date_bs').val())));

        }
    });
    $('#trans_date_ad').change(function () {
        $('#trans_date_bs').val(AD2BS(FormatForInput($('#trans_date_ad').val())));
    });
    $("#customer_icon_toggle").on('click', function () {
        $(".bill_to_info_div").slideToggle("slow", function () {
            $("fieldset").toggleClass("bill_to_background_color");
            $("#customer_icon_toggle").toggleClass("fa-chevron-down");
        });

    });
    $("#Customer_Id").on('change', function () {
        var selectedValue = $('#Customer_Id').find(":selected").val();
        var selectedItem = _.filter(customerList, function (x) {
            return x.Id == selectedValue; //donot update to === //its a type convertion
        })[0];
        $("#Customer_Name").val(selectedItem.Name);
        $("#Customer_Address").val(selectedItem.Address);
        $("#Customer_Vat").val(selectedItem.Vat);
        $("#Customer_Mobile").val(selectedItem.Mobile);
    });
    $("input[name='flatDiscount'],#flat_discount").on('change', updateFlatDiscount);
    $("#convert-sales-tax").on('click', function (e) {
        e.preventDefault();
        convertSalesTax();
    });
    $('#pausedTransactionListTable >tbody > tr').on('dblclick', function () {
        loadPausedTransaction($(this));
        $("#PausedTransactionListModal").modal('hide');
    });
    $("#ResetButton").on('click', function () {
        resetForm();
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
