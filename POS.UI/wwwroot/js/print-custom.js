const printer = (() => {
    //********* Private Variables **************//
    let maximumCharAllowInItemName = 13;


    //********* Private Methos *****************//
    let init = () => {

    };


    let PrintInvoice = (data, callback) => {
        if (data.invoiceData.trans_Type === "Sales")
            PrintSalesInvoice(data, callback);
        else
            PrintTaxInvoice(data, callback);
    };
    let PrintTaxInvoice = (data, callback) => {
        $.ajax({
            url: window.location.origin + "/Print/TaxInvoice",
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {

                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables
                    printText = printText.replace("{companyName}", data.storeData.companY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address);
                    printText = printText.replace("{vatNumber}", data.storeData.vat);
                    printText = printText.replace("{invoiceType}", "Invoice");
                    printText = printText.replace("{copyName}", "");
                    printText = printText.replace("{billNumber}", data.invoiceData.invoice_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", _.pluck(data.billData, "trans_Mode").join(", "));
                    printText = printText.replace("{totalGrossAmount}", data.invoiceData.total_Gross_Amount);
                    printText = printText.replace("{promoDiscount}", data.invoiceData.total_Discount);
                    printText = printText.replace("{loyaltyDiscount}", data.invoiceData.total_Bill_Discount);  
                    printText = printText.replace("{totalSaving}", (parseFloat(data.invoiceData.total_Discount) + parseFloat(data.invoiceData.total_Bill_Discount)).toString());
                    printText = printText.replace("{totalTaxableAmount}", data.invoiceData.taxableAmount);
                    printText = printText.replace("{totalNonTaxableAmount}", data.invoiceData.nonTaxableAmount);
                    printText = printText.replace("{totalVat}", data.invoiceData.total_Vat);
                    printText = printText.replace("{totalNetAmount}", data.invoiceData.total_Payable_Amount);
                    printText = printText.replace("{tenderAmount}", data.invoiceData.tender_Amount);
                    printText = printText.replace("{changeAmount}", data.invoiceData.change_Amount);
                    printText = printText.replace("{totalQuantity}", data.invoiceData.total_Quantity);
                    printText = printText.replace("{terminalName}", data.invoiceData.terminal);
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", data.invoiceData.created_By);

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";
                    _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", v.quantity);
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", v.rate);
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", v.gross_Amount);
                        printItems += printItemTemplate;
                    });
                   

                    FinalPrint(printText, printItems);
                }

                if (callback !== undefined)
                    callback();
            }
        });
    };
    let PrintSalesInvoice = (data, callback) => {
        $.ajax({
            url: window.location.origin + "/Print/SalesInvoice",
            type: 'GET',
            complete: function (result) {                
                if (result.status === 200) {
                   
                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables
                    printText = printText.replace("{companyName}", data.storeData.companY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address);
                    printText = printText.replace("{vatNumber}", data.storeData.vat);
                    printText = printText.replace("{invoiceType}", "ABBREVIATED TAX INVOICE");
                    printText = printText.replace("{copyName}", "");
                    printText = printText.replace("{billNumber}", data.invoiceData.invoice_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", _.pluck(data.billData, "trans_Mode").join(", "));
                    printText = printText.replace("{totalGrossAmount}", data.invoiceData.total_Gross_Amount);
                    printText = printText.replace("{promoDiscount}", data.invoiceData.total_Discount);
                    printText = printText.replace("{loyaltyDiscount}", data.invoiceData.total_Bill_Discount);                   
                    printText = printText.replace("{totalSaving}", (parseFloat(data.invoiceData.total_Discount) + parseFloat(data.invoiceData.total_Bill_Discount)).toString());
                    printText = printText.replace("{totalNetAmount}", data.invoiceData.total_Payable_Amount);
                    printText = printText.replace("{tenderAmount}", data.invoiceData.tender_Amount);
                    printText = printText.replace("{changeAmount}", data.invoiceData.change_Amount);
                    printText = printText.replace("{totalQuantity}", data.invoiceData.total_Quantity);
                    printText = printText.replace("{terminalName}", data.invoiceData.terminal);
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", data.invoiceData.created_By);

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";
                    
                    _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", v.quantity);
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", v.rate);
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", v.gross_Amount);
                        printItems += printItemTemplate;
                    });

                   
                    //printText = 
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");

                    FinalPrint(printText, printItems);
                }

                if (callback !== undefined)
                    callback();
            }
        });
    };
    let PrintCreditNote = (data, callback) => {
        $.ajax({
            url: window.location.origin + "/Print/CreditNote",
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {

                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables
                    printText = printText.replace("{companyName}", data.storeData.companY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address);
                    printText = printText.replace("{vatNumber}", data.storeData.vat);
                    printText = printText.replace("{invoiceType}", "ABBREVIATED TAX INVOICE");
                    printText = printText.replace("{copyName}", "");
                    printText = printText.replace("{billNumber}", data.invoiceData.invoice_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", _.pluck(data.billData, "trans_Mode").join(", "));
                    printText = printText.replace("{totalGrossAmount}", data.invoiceData.total_Gross_Amount);
                    printText = printText.replace("{totalDiscount}", data.invoiceData.total_Discount);
                    printText = printText.replace("{totalNetAmount}", data.invoiceData.total_Net_Amount);
                    printText = printText.replace("{tenderAmount}", data.invoiceData.tender_Amount);
                    printText = printText.replace("{changeAmount}", data.invoiceData.change_Amount);
                    printText = printText.replace("{totalQuantity}", data.invoiceData.total_Quantity);
                    printText = printText.replace("{terminalName}", "Terminal 1");
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", "Ashok");

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";
                    _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", v.quantity);
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", v.rate);
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", v.net_Amount);
                        printItems += printItemTemplate;
                    });


                    //printText = 
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");
                    //printText = printText.replace("", "");

                    FinalPrint(printText, printItems);
                }

                if (callback !== undefined)
                    callback();
            }
        });
    };
    let FinalPrint = (printText, printItemText) => {
        $(document.body).append('<div id="tempprint"></div>');
        $("#tempprint").html(printText);
        $("#tempprint").find("#items").html(printItemText);
        printJS({
            printable: 'tempprint',
            type: 'html',
            targetStyles: ['*'],
            onLoadingEnd: function () {
                $("#tempprint").remove();
            }
        });
    };




    //********* Events ************************//

    //********* Public Output ****************//
    return {
        init,
        PrintInvoice
    };

})();
printer.init();