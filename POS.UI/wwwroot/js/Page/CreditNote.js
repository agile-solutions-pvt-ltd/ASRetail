const creditNote = (function () {
    //*********Private Variables **************//
    let salesItems = [];
    var isFirstTimeLoadItem = true;
    var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
    let $form = $('form#Credit_Note_Form');


    let init = () => {

        //focus on ref number
        $("#Reference_Number").focus();

        //set todays date
        $("#trans_date_ad").val(FormatForDisplay(new Date()));
        $("#trans_date_ad").trigger('change');

        //hide bill to customer info
        $(".bill_to_info_div").hide();
    };
    let loadInvoice = (invoiceNumber) => {
        if (validateInvoiceNumber(invoiceNumber)) {
            getInvoice(invoiceNumber, function (data) {
                if (validateInvoiceData(data)) {
                    salesItems = data.salesInvoiceItems;
                    loadPausedTransactionData(data);
                }
            });
        }
    };
    let getInvoice = (invoiceNumber, callback) => {
        $.ajax({
            url: "https://localhost:44355/SalesInvoice/GetInvoice?invoiceNumber=" + invoiceNumber,
            type: "GET",
            complete: function (data) {
                if (data.status !== 200) {
                    $("#itemNotFoundLabel").show();
                    setTimeout(function () { $("#itemNotFoundLabel").hide(); }, 9000);

                } else
                    callback(data.responseJSON);
            },
        });
    };
    let validateInvoiceNumber = (invoiceNumber) => {
        //do validation here
        return true;
    };
    let validateInvoiceData = (data) => {
        let transDate = new Date(data.trans_Date_Ad);
        let compareDate = new Date();
        compareDate.setDate(compareDate.getDate() - 7);
        compareDate = new Date(compareDate);

        if (data.remarks === "Return") {
            displayError("Error: Already Return !! \n You can only return one time of this purchase !!");
            return false;
        }

        if (transDate < compareDate) {
            displayError("Expired: You can only return within 7 days of purchase !!");
            return false;
        }

       
        return true;
    };
    let validateCreditNoteItems = () => {
        //check if quantity is max then sales quantity

        //but skip for firsttime load
        let isValid = true;
        if (!isFirstTimeLoadItem)
            $.each(table.rows, function (i, v) {
                if (parseFloat($(this).find(".Quantity").val()) >= parseFloat($(this).find(".Quantity").attr("max"))) {
                    displayError("Return quantity cannot be greater than sales quantity !!");
                    $(this).find(".Quantity").val($(this).find(".Quantity").attr("max"));
                    isValid = false;
                    return false;
                }
            });
        isFirstTimeLoadItem = false;
        //check when new quantity is added
        let itemCode = $("#item_code").val();
        if (!_.isEmpty(itemCode)) {
            let checkData = _.filter(salesItems, function (x) { return x.bar_Code === itemCode; })[0];
            if (_.isEmpty(checkData)) {
                displayError("Item not available in this sales !!");
                isValid = false;
                return false;
            }
        }
        //check others

        return isValid;
    };
    let calcAll = () => {
        calculateSN();
        calcTotal();
       // updateFlatDiscount();
        validateCreditNoteItems();
    };
    let displayError = (message) => {
        $("#errorMessage").text(message);
        $("#errorMessage").show();
        setTimeout(function () { $("#errorMessage").hide(); }, 9000);
    };
    let GetItems = (code, callback) => {
        $.ajax({
            url: "https://localhost:44355/item/GetItems/?code=" + code,
            type: "GET",
            success: function (data) {
                if (data.length === 0) {
                    displayError("Item Not Found !! Try different Bar Code !!!!");
                } else
                    callback(data[0]);
            },
            error: function (x) {
                alert(x);
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

        //validate creditnote items first
        //validateCreditNoteItems();


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
                    tax = parseFloat(tax);
                    var netAmount = grossAmount - discount + tax;

                    totalQuantity += quantity;
                    totalDiscount += discount;
                    totalTax += tax;
                    totalGrossAmount += grossAmount;
                    totalNetAmount += netAmount;

                    //assign
                    $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
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
            $("#totalGrossAmount").text("0");
            $("#totalDiscount").text("0");
            $("#totalTax").text("0");
            $("#totalNetAmount").text("0");
        }
    };
    let updateFlatDiscount = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var type = $("input[name='flatDiscount']:checked").val();
        var value = $("#flat_discount").val();
        var percent = 0;
        if (_.isEmpty(type) || _.isEmpty(value))
            return false;
        if (type === "percent") {
            percent = parseFloat(value);
        } else {
            discountAmount = parseFloat(value);
            totalGrossAmount = parseFloat($("#totalGrossAmount").text());
            percent = discountAmount * 100 / totalGrossAmount;
        }
        $.each(table.rows, function (i, v) {
            var grossAmount = parseFloat($(this).find(".GrossAmount").val());
            var discount = grossAmount * percent / 100;
            $(this).find(".Discount").val((discount).toFixed(2));
        });
        calcTotal();
    };
    let calculateSN = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((i + 1).toString());
        });
    };
    let quantityChangeEvent = (that) => {

        if (parseInt($(that).val()) > parseInt($(that).attr("max")))
            $(that).val($(that).attr("max"));
    };
    let addRowGetUpdateData = (code) => {
        //validate

        if (!validateCreditNoteItems())
            return false;

        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var t1 = (table.rows.length);

        //first check there alreay item in pos  
        var checkAlreadyExistItem = false;
        $.each(table.rows, function (i, v) {
            var barcode = $(this).find(".barcode").text();
            var quantity = $(this).find(".Quantity").val();
            if (barcode === code) {
                $(this).find(".Quantity").val((parseInt(quantity) + 1).toString());
                calcTotal();
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
        var t1 = table.rows.length;

        var row = table.insertRow(t1);
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
        debugger;

        var barCode = result.bar_Code || result.Bar_Code;
        var itemName = result.name || result.Name;
        var unit = result.unit || result.Unit;
        var rate = result.rate || result.Rate;
        var quantity = (result.quantity || result.Quantity) === undefined ? 1 : (result.quantity || result.Quantity);

        var grossAmount = rate * quantity;
        var discount = (result.discount || result.Discount) === undefined ? 0 : (result.discount || result.Discount);
        var tax = (result.tax || result.Tax) === undefined ? 0 : (result.tax || result.Tax);
        var netAmount = grossAmount - discount;

        //invoiceItems[0].sn

        $('<i class="sn font-weight-bold">' + (table.rows.length) + '</i>').appendTo(cell1);
        $("<span class='barcode'>" + barCode + "</span>").appendTo(cell2);
        $("<span>" + itemName + "</span>").appendTo(cell3);
        $("<span>" + unit + "</span>").appendTo(cell4);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Rate" type="number" onkeyup="creditNote.calcTotal()" name="Rate" min="0" value=' + rate.toFixed(2) + '>').appendTo(cell5);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Quantity" type="number" onkeyup="creditNote.quantityChangeEvent(this);creditNote.calcTotal();" name="Quantity" min="1" max=' + quantity.toString() + ' value=' + quantity.toString() + '>').appendTo(cell6);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right GrossAmount" type="number" onkeyup="creditNote.calcTotal()" name="GrossAmount" disabled value=' + grossAmount.toFixed(2) + '>').appendTo(cell7);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Discount" type="number" onkeyup="creditNote.calcTotal()" name="Discount" min="0" value=' + discount.toFixed(2) + '>').appendTo(cell8);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Tax" type="number" onkeyup="creditNote.calcTotal()" name="Tax" disabled value=' + tax.toFixed(2) + '>').appendTo(cell9);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right NetAmount" type="number" onkeyup="creditNote.calcTotal()" name="NetAmount" disabled value=' + netAmount.toFixed(2) + '>').appendTo(cell10);

        $('<botton onclick="creditNote.delete_row(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell11);

        calcAll();
    };
    let resetForm = () => {
        window.location.href = window.location.origin + "/CreditNote";
    };
    let SaveCreditNote = () => {
        //save field data first
        $("#Total_Quantity").val(CurrencyUnFormat($("#totalQuantity").text()));
        $("#Total_Gross_Amount").val(CurrencyUnFormat($("#totalGrossAmount").text()));
        $("#Total_Discount").val(CurrencyUnFormat($("#totalDiscount").text()));
        $("#Total_Tax").val(CurrencyUnFormat($("#totalTax").text()));
        $("#Total_Net_Amount").val(CurrencyUnFormat($("#totalNetAmount").text()));

        //validate
        if (!$('form#Credit_Note_Form').valid()) {
            return false;
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
                Is_Vatable: $(this).find('td input.Tax').data("isVatable"),
                Net_Amount: $(this).find('td input.NetAmount').val()
            });
        });



        var data = $('form#Credit_Note_Form').serializeObject();
        data.CreditNoteItems = invoiceItems;
        $.ajax({
            method: "POST",
            url: "/CreditNote/Index",
            //dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data),
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
        if (data.salesInvoiceItems !== null) {
            //customer info
            $("#Customer_Id").val(data.customer_Id);
            //flat discount
            if (data.flat_Discount_Amount !== null) {
                $("#amountRadio").prop("checked", true);
                $("#flat_discount").val(data.flat_Discount_Amount);
            } else {
                $("#percentRadio").prop("checked", true);
                $("#flat_discount").val(data.flat_Discount_Percent);
            }

            //insert items
            if (data.salesInvoiceItems.length > 0) {
                _.each(data.salesInvoiceItems, function (x) {
                    addRowWithData(x);
                });
            }
        }
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



    //events


    $("#SaveButton").on('click', SaveCreditNote);
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
            return x.Id === selectedValue;
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

    $("#Reference_Number").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            loadInvoice($(this).val());
        }
    });


    $("#ResetButton").on('click', function () {
        resetForm();
    });


    return {
        init: init,
        delete_row: delete_row,
        deleteInvoice: deleteInvoice,
        calcTotal: calcTotal,
        holdTransaction: holdTransaction,
        showPausedTransaction: showPausedTransaction,
        quantityChangeEvent
    };


})();
creditNote.init();
