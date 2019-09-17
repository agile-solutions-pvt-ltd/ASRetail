const creditNote = (function () {
    //*********Private Variables **************//
    let salesItems = [];
    var isFirstTimeLoadItem = true;
    var invoiceExpiredDays = 30;
    var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];   
    let $form = $('form#Credit_Note_Form');
    let taxPercent = 13;
   
    let init = () => {
        //console.log("isredeem", document.getElementById('isRedeemed').value)
        $('input[type="checkbox"]').click(function () {
            if ($(this).prop("checked") == true) {
                document.getElementById('isRedeemed').value = 'true';

                console.log("isredeem", document.getElementById('isRedeemed').value)
            }
            else if ($(this).prop("checked") == false) {
                document.getElementById('isRedeemed').value = 'false';
                console.log("isredeem", document.getElementById('isRedeemed').value)
            }
        });
        //focus on ref number
        $("#Reference_Number").focus();

        //set todays date
        $("#trans_date_ad").val(FormatForDisplay(new Date()));
        $("#trans_date_ad").trigger('change');

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
                    width: "15%"
                },
                {
                    title: "Item",
                    width: "24%"
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
                        "class": "p-1 text-right"
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


        //initialize customer dropdown
        //$("#Customer_Id").kendoComboBox({
        //    filter: "contains",
        //    suggest: true,
        //    index: 1
        //});
        //hide bill to customer info
        $(".bill_to_info_div").hide();
      
        AssignKeyEvent();
    };
    let loadInvoice = (invoiceNumber) => {
        kendo.ui.progress($("#item_table"), true);
        if (validateInvoiceNumber(invoiceNumber)) {
            getInvoice(invoiceNumber, function (data) {
                if (validateInvoiceData(data.invoiceData)) {                                      
                    salesItems = data.invoiceData.salesInvoiceItems;
                    resetTransactionData();
                    loadPausedTransactionData(data.invoiceData);
                    $("#Customer_Id").val(data.customerData.membership_Number);
                    $("#BillTo_Name").val(data.customerData.name);
                    $("#Reference_Number_Id").val(data.invoiceData.id);
                    $("#Payment_Mode").val(_.uniq(_.pluck(data.invoiceBillData, "trans_Mode")).join(', '));
                    // $("#TaxableAmount").val(data.invoiceData.taxableAmount);
                    //$("#NonTaxableAmount").val(data.invoiceData.nonTaxableAmount);
                    // $("#Total_Vat").val(data.invoiceData.total_Vat);
                    $("#Tender_Amount").val(data.invoiceData.tender_Amount);
                    $("#Change_Amount").val(data.invoiceData.change_Amount);
                    $("#Reference_Number").val(data.invoiceData.invoice_Number);
                    $("#Trans_Type").val(data.invoiceData.trans_Type);
                    $("#totalNetAmount").text(CurrencyFormat(data.invoiceData.total_Payable_Amount));
                    kendo.ui.progress($("#item_table"), false);
                }
            });
        }
    };
    let getInvoice = (invoiceNumber, callback) => {
        $.ajax({
            url: window.location.origin + "/SalesInvoice/GetInvoice?invoiceNumber=" + invoiceNumber,
            type: "GET",
            complete: function (data) {

                if (data.status !== 200) {
                    kendo.ui.progress($("#item_table"), false);
                    $("#itemNotFoundLabel").show();
                    setTimeout(function () { $("#itemNotFoundLabel").hide(); }, 9000);

                } else
                    callback(data.responseJSON);
            }
        });
    };
    let validateInvoiceNumber = (invoiceNumber) => {
        //do validation here
        return true;
    };
    let validateInvoiceData = (data) => {

        let transDate = new Date(data.trans_Date_Ad);
        let compareDate = new Date();
        compareDate.setDate(compareDate.getDate() - invoiceExpiredDays);
        compareDate = new Date(compareDate);

        if (data.remarks === "Return") {
            displayError("Error: Already Return !! \n You can only return one time of this purchase !!");
            kendo.ui.progress($("#item_table"), false);
            return false;
        }

        if (transDate < compareDate) {
            displayError("Expired: You can only return within " + invoiceExpiredDays + " days of purchase !!");
            kendo.ui.progress($("#item_table"), false);
            return false;
        }


        return true;
    };
    let validateCreditNoteItems = () => {
        //check if quantity is max then sales quantity

        //but skip for firsttime load
        let isValid = true;
        //if (!isFirstTimeLoadItem)

        //isFirstTimeLoadItem = false;
        $.each(table.rows, function (i, v) {
            if (parseFloat($(this).find(".Quantity").val()) >= parseFloat($(this).find(".Quantity").attr("max"))) {
               // displayError("Return quantity cannot be greater than sales quantity !!");
                $(this).find(".Quantity").val($(this).find(".Quantity").attr("max"));
                isValid = false;
                return false;
            }
        });
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
    let resetTransactionData = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        if (table.rows.length > 0) {
            $('#item_table').find('tbody').detach();
            $('#item_table').append($('<tbody>'));
        }
    };
    let convertSalesTax = (type) => {
        //if (type === "Sales") {
        //    //remove tax columns
        //    $('thead > tr > th:nth-child(9),tbody > tr > td:nth-child(9), tfoot > tr > td:nth-child(5)').hide();
        //} else {
        //    $('thead > tr > th:nth-child(9),tbody > tr > td:nth-child(9), tfoot > tr > td:nth-child(5)').show();
        //}
    };
    let displayError = (message) => {
        $("#errorMessage").text(message);
        $("#errorMessage").show();
        setTimeout(function () { $("#errorMessage").hide(); }, 9000);
    };
    let GetItems = (code, callback) => {
        $.ajax({
            url: window.location.origin + "/item/GetItems/?code=" + code,
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
        var taxable, totalTaxableAmount = 0, totalNonTaxableAmount = 0;

        //validate creditnote items first
        //validateCreditNoteItems();


        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {

                //calculations
                var quantity = $(this).find(".Quantity").val();
                var rate = $(this).find(".Rate").val();
                var rateExcludeVat = parseFloat($(this).find(".Rate").data('rateexcludedvatwithoutroundoff'));
                var discount = $(this).find(".Discount").data("original-discount") || 0;
                var promoDiscount = parseFloat($(this).find(".Discount").data("promodiscount") || 0);
                var loyaltyDiscount = parseFloat($(this).find(".Discount").data("loyaltydiscount") || 0);
                var discountPercent = parseFloat($(this).find(".Discount").data("discountpercent") || 0);
               

                var tax = $(this).find(".Tax").val() || 0;
                let taxable = $(this).find(".Tax").data("isvatable");

                if (quantity !== undefined && rate !== undefined) {
                    quantity = parseFloat(quantity);
                    var grossAmount = quantity * rateExcludeVat;
                    discount = grossAmount * discountPercent / 100;
                    if (taxable)
                        tax = (grossAmount - discount) * taxPercent / 100;
                    else
                        tax = 0;
                    var netAmount = grossAmount - discount + tax;

                    totalQuantity += quantity;
                    totalDiscount += parseFloat(discount.toFixed(2));
                    //totalTax += tax;
                    totalGrossAmount += grossAmount;
                    //totalNetAmount += netAmount;


                    //calc taxable and non taxable
                    //if (taxable)
                    //    totalTaxableAmount += (rate - discount) * quantity;
                    //else {
                    //    totalNonTaxableAmount += rate * quantity;
                    //}
                   

                    //new logic
                    //if (taxable)
                    //    totalTaxableAmount += parseFloat(parseFloat((rateExcludeVat * quantity).toFixed(2)) - parseFloat(discount.toFixed(2)).toFixed(2))// parseFloat(((rateExcludeTax - discountExcVat) * quantity).toFixed(2));
                    //else {
                    //    totalNonTaxableAmount += parseFloat((rateExcludeVat * quantity).toFixed(2));
                    //}

                    //new new logic
                    var grossRateN = parseFloat((rateExcludeVat * quantity).toFixed(2));
                    var grossDiscountN = parseFloat((grossRateN * discountPercent / 100).toFixed(2));
                    if (taxable)
                        totalTaxableAmount += parseFloat(grossRateN - grossDiscountN);// parseFloat(((rateExcludeTax - discountExcVat) * quantity).toFixed(2));
                    else
                        totalNonTaxableAmount += parseFloat(grossRateN - grossDiscountN);


                    //for promo or loyalty discount
                    if (promoDiscount > 0 && loyaltyDiscount == 0)
                        $(this).find(".Discount").data("promodiscount", discount.toFixed(2));
                    if (promoDiscount == 0 && loyaltyDiscount > 0)
                        $(this).find(".Discount").data("loyaltydiscount", discount.toFixed(2));

                    //assign
                    $(this).find(".GrossAmount").val(grossAmount.toFixed(2));
                    $(this).find(".NetAmount").val(netAmount.toFixed(2));
                    $(this).find(".Discount").val(discount.toFixed(2));
                    $(this).find(".Tax").val(tax.toFixed(2));
                   

                }

            });

            totalTax = totalTaxableAmount * 13 / 100;
            totalNetAmount = totalTaxableAmount + totalNonTaxableAmount + parseFloat(totalTax.toFixed(2));


            //assign total
            $("#totalQuantity").text(NumberFormat(totalQuantity));
            $("#totalGrossAmount").text(CurrencyFormat(totalGrossAmount));
            $("#totalDiscount").text(CurrencyFormat(totalDiscount));
            $("#totalTax").text(CurrencyFormat(totalTax));
            $("#totalNetAmount").text(CurrencyFormat(totalNetAmount));
        }
        else {
            //assign total
            $("#totalQuantity").text("0");
            $("#totalGrossAmount").text("0");
            $("#totalDiscount").text("0");
            $("#totalTax").text("0");
            $("#totalNetAmount").text("0");
        }
        
        $("#NonTaxableAmount").val(totalNonTaxableAmount.toFixed(2));
        $("#TaxableAmount").val(totalTaxableAmount.toFixed(2));
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
            $(this).find(".Discount").val(discount.toFixed(2));
        });
        calcTotal();
    };
    let calculateSN = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((i + 1).toString());
        });
    };
    let calcTotalPromoDiscount = () => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var total = 0;
        
        $.each(table.rows, function (i, v) {
            //calculations
            total += parseFloat($(this).find(".Discount").data("promodiscount") || 0);
        });
        return total;
    };
    let calcTotalMembershipDiscount = () => {
        
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var total = 0;
        $.each(table.rows, function (i, v) {
            //calculations
            total += parseFloat($(this).find(".Discount").data("membershipdiscount") || 0);
        });
        return total;
    };
    let calculateTax = (amount, taxPercent, taxable) => {
        let tax = 0;
        if (taxable) {
            //tax calc formula
            tax = amount * taxPercent / 100;
        }
        return tax;
    };

    let quantityChangeEvent = (that) => {

        if (parseFloat($(that).val()) > parseFloat($(that).attr("max")))
            $(that).val($(that).attr("max"));
    };
    let addRowGetUpdateData = (code) => {
        //validate

        if (!validateCreditNoteItems())
            return false;

        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var t1 = table.rows.length;

        //first check there alreay item in pos  
        var checkAlreadyExistItem = false;
        $.each(table.rows, function (i, v) {
            var barcode = $(this).find(".barcode").text();
            var quantity = $(this).find(".Quantity").val();
            if (barcode === code) {
                $(this).find(".Quantity").val((parseFloat(quantity) + 1).toString());
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
    let calcDiscount = (amount, quantity) => {
        if ($("#Trans_Type").val() === "Tax") {
            return parseFloat(amount) / parseFloat(quantity);
        } else {
            amount = parseFloat(amount) / parseFloat(quantity);
            return calcReverseTaxAmount(amount);
        }
    };
    let calcReverseTaxAmount = (amount) => {
        if (amount === 0)
            return 0;
        var value = amount - (taxPercent * amount) / (taxPercent + 100);
        return value;
    };
    let addRowWithData = (result) => {
        var table = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        var t1 = table.rows.length;


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

        
        var barCode = result.bar_Code || result.Bar_Code;
        var itemName = result.name || result.Name;
        var itemCode = result.itemCode || result.ItemCode; //temporary update code to remarks field :)               
        var itemId = result.ItemId || result.itemId;
        var unit = result.unit || result.Unit;
        var rate = result.rateExcludeVat || result.RateExcludeVat;
        var rateWithoutRoundOff = result.rateExcludeVatWithoutRoundoff || 0;
        var quantity = (result.quantity || result.Quantity) === undefined ? 1 : (result.quantity || result.Quantity);
        //calc discount
        var discount = result.discount;
        var discountPercent = result.discountPercent || 0;
        var isVatable = result.Is_Vatable || result.is_Vatable;

        var tax = (result.tax || result.Tax) === undefined ? 0 : (result.tax || result.Tax);
        var grossAmount = 0;
        var netAmount = 0;
        var promoDiscount = calcDiscount(result.promoDiscount || 0, quantity);

        var membershipDiscount = calcDiscount(result.membershipDiscount || 0, quantity);

        row.title = "Item Code: " + itemCode;
        $('<i class="sn font-weight-bold">' + table.rows.length + '</i>').appendTo(cell1);
        $("<span class='barcode'>" + barCode + "</span>").appendTo(cell2);
        $("<span class='itemName' data-item-id='" + itemId + "' data-item-code= '" + itemCode + "'>" + itemName + "</span>").appendTo(cell3);
        $("<span>" + unit + "</span>").appendTo(cell4);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Rate" type="number" onkeyup="creditNote.calcTotal()" disabled name="Rate" min="0" data-RateExcludedVat="'+rate+'" data-RateExcludedVatWithoutRoundoff=' + rateWithoutRoundOff+' value=' + rate.toFixed(2) + '>').appendTo(cell5);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Quantity" type="number" onkeyup="creditNote.quantityChangeEvent(this);creditNote.calcTotal();" name="Quantity" min="0.01" max=' + quantity.toString() + ' value=' + quantity.toString() + '>').appendTo(cell6);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right GrossAmount" type="number" name="GrossAmount" disabled value=' + grossAmount.toFixed(2) + '>').appendTo(cell7);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Discount" type="number" disabled onkeyup="creditNote.calcTotal()" name="Discount" min="0" data-DiscountPercent="'+discountPercent+'" data-original-discount ="' + discount.toFixed(2) + '" data-promoDiscount= ' + promoDiscount + ' data-membershipDiscount=' + membershipDiscount + ' value=' + discount.toFixed(2) + '>').appendTo(cell8);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right Tax" type="number" name="Tax" data-isVatable="' + isVatable + '" disabled value=' + tax.toFixed(2) + '>').appendTo(cell9);
        $('<input class="tabledit-input form-control form-control-sm input-sm text-right NetAmount" type="number" name="NetAmount" disabled value=' + netAmount.toFixed(2) + '>').appendTo(cell10);

        $('<botton onclick="creditNote.delete_row(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell11);

        calcTotal();
    };
    let AssignKeyEvent = () => {

        Mousetrap.bindGlobal(['ctrl+end','end'], function (e) {
            e.preventDefault(); e.stopPropagation();
            saveForm();
        });

        Mousetrap.bindGlobal('enter', function (e) {
            $(".bootbox-cancel").trigger("click");

        });

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });


    };
    let resetForm = () => {
        bootbox.confirm({
            message: "Are you Sure ?",
            buttons: {
                cancel: {
                    label: 'Go Back',
                    className: 'btn-warning'
                },
                confirm: {
                    label: 'Proceed',
                    className: 'btn-success'
                }
            },
            callback: function (result) {

                if (result) {
                    window.location.href = window.location.origin + "/CreditNote";
                }

            }
        });

    };


    let saveForm = () => {
        $("#SaveButton").attr("disabled", true);
        bootbox.confirm({
            message: "Are you Sure you want to save?",
            buttons: {
                cancel: {
                    label: 'No',
                    className: 'btn-warning'
                },
                confirm: {
                    label: 'Proceed',
                    className: 'btn-success'
                }
            },
            callback: function (result) {

                if (result) {
                    SaveCreditNote();
                }
                else {
                    $("#SaveButton").attr("disabled", false);
                }
               

            }
        });

    };
    let SaveCreditNote = () => {
        //save field data first
        $("#Total_Quantity").val(CurrencyUnFormat($("#totalQuantity").text()));
        $("#Total_Gross_Amount").val(CurrencyUnFormat($("#totalGrossAmount").text()));
        $("#Total_Discount").val(CurrencyUnFormat($("#totalDiscount").text()));
        $("#Total_Vat").val(CurrencyUnFormat($("#totalTax").text()));
        $("#Total_Net_Amount").val(CurrencyUnFormat($("#totalNetAmount").text()));

        //validate
        if (!$('form#Credit_Note_Form').valid()) {
            $("#SaveButton").attr("disabled", false);
            return false;
        }
        let tableRows = document.getElementById("item_table").getElementsByTagName('tbody')[0];
        if (tableRows === undefined || tableRows.rows.length === 0) {
            bootbox.alert("No Item selected !!");
            return false;
        }

        
        //console.log("isredeem", document.getElementById('isRedeemed').value)
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
                RateExcludeVat: $(this).find('td input.Rate').data("rateexcludedvat"),
                RateExcludeVatWithoutRoundoff: $(this).find('td input.Rate').data("rateexcludedvatwithoutroundoff"),
                Quantity: $(this).find('td input.Quantity').val(),
                Gross_Amount: $(this).find('td input.GrossAmount').val(),
                Discount: $(this).find('td input.Discount').val(),
                DiscountPercent: $(this).find('td input.Discount').data("discountpercent"),
                PromoDiscount: parseFloat($(this).find('td input.Discount').data("promodiscount") || 0),
                MembershipDiscount: parseFloat($(this).find('td input.Discount').data("membershipdiscount") || 0),
                Tax: $(this).find('td input.Tax').val(),
                Is_Vatable: $(this).find('td input.Tax').data("isvatable"),
                Net_Amount: $(this).find('td input.NetAmount').val(),
                
               
            });
        });


        var data = $('form#Credit_Note_Form').serializeObject();

        data.Customer_Id = $("#Customer_Id").val();
        data.isRedeem = document.getElementById('isRedeemed').value;
        //add membership discount

        data.MembershipDiscount = calcTotalMembershipDiscount();
        data.PromoDiscount = calcTotalPromoDiscount();

        data.CreditNoteItems = invoiceItems;

        $.ajax({
            method: "POST",
            url: "/CreditNote/Index",
            //dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data),
            complete: function (result) {
                if (result.status === 200) {
                    printer.PrintCreditNoteInvoice(result.responseJSON, function () {
                        StatusNotify("success", result.responseJSON.message);
                        setTimeout(function () {
                            window.location.href = window.location.origin + result.responseJSON.redirectUrl;
                        }, 3000);
                    });
                    // window.location.href = window.location.origin + result.responseJSON.redirectUrl;
                }
                else {
                    StatusNotify("error", "Error occur, try again later !!");
                    $("#SaveButton").attr("disabled", false);
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
            //
            //let customer = _.filter(customerList, (x) => { return x.Membership_Number === data.customer_Id; })[0]; //donot update double equal
            //var customerDropdown = $("#Customer_Id").data("kendoComboBox");
            //if (customer !== undefined) {
            //    customerDropdown.value(customer.Membership_Number);
            //    $("#Customer_Id").val(customer.Membership_Number).trigger('change');


            $("#MemberId").val(data.memberId);
            $("#Customer_Name").val(data.customer_Name);
            $("#Customer_Vat").val(data.customer_Vat);
            $("#Customer_Mobile").val(data.customer_Mobile);
            $("#Customer_Address").val(data.customer_Address);

            // $("#Customer_Id").val(data.customer_Id);
            ////flat discount
            //if (data.flat_Discount_Amount !== null) {
            //    $("#amountRadio").prop("checked", true);
            //    $("#flat_discount").val(data.flat_Discount_Amount);
            //} else {
            //    $("#percentRadio").prop("checked", true);
            //    $("#flat_discount").val(data.flat_Discount_Percent);
            //}

            //insert items
            if (data.salesInvoiceItems.length > 0) {
                _.each(data.salesInvoiceItems, function (x) {
                    addRowWithData(x);
                });
            }

            // convertSalesTax(data.trans_Type);
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


    //$("#SaveButton").on('click', SaveCreditNote);
    $("#SaveButton").on('click', saveForm);
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

    $("#customer_icon_toggle").on('click', function () {
        $(".bill_to_info_div").slideToggle("slow", function () {
            $("fieldset").toggleClass("bill_to_background_color");
            $("#customer_icon_toggle").toggleClass("fa-chevron-down");
        });

    });


    $("#Customer_Id").on('change', function () {
        //var selectedValue = $("#Customer_Id").data("kendoComboBox").value();
        //var selectedItem = _.filter(customerList, function (x) {
        //    return x.Membership_Number === selectedValue;
        //})[0];
        //$("#Customer_Name").val(selectedItem.Name);
        //$("#Customer_Address").val(selectedItem.Address);
        //$("#Customer_Vat").val(selectedItem.Vat);
        //$("#Customer_Mobile").val(selectedItem.Mobile1);
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