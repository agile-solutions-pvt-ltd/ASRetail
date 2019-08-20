const printer = (() => {
    //********* Private Variables **************//

    let maximumCharAllowInItemName = 9;
    //greycode printing initiliger
    class Ws {
        get newClientPromise() {
            return new Promise((resolve, reject) => {
                GetClientLocalIP(function (ip) {
                    
                    var newIp = _.filter(serverIp, function (x, y) {
                        return y == ip;
                    });
                    if (newIp.length === 0)
                        newIp = ip;
                    else
                        newIp = newIp[0];
                    //var newIp = ip;
                    let wsClient;
                    if (location.protocol === 'https:')
                        wsClient = new WebSocket("wss://" + newIp + ":90");
                    else
                        wsClient = new WebSocket("ws://" + newIp + ":90");
                    console.log(wsClient)
                    wsClient.onopen = () => {
                        console.log("connected");
                        resolve(wsClient);
                    };
                    wsClient.addEventListener("error", e => {
                        reject("Error Occor");
                        return;
                        // readyState === 3 is CLOSED
                        //if (e.target.readyState === 3) {
                        //    this.connectionTries--;

                        //    if (this.connectionTries > 0) {
                        //        setTimeout(() => this.connect(url), 5000);
                        //    } else {
                        //alert("Maximum number of connection trials has been reached");
                        //      }

                        // }

                    });
                })
            });
        }
        get clientPromise() {
            if (!this.promise) {
                this.promise = this.newClientPromise
            }
            return this.promise;
        }
    }

    //********* Private Methos *****************//
    let init = () => {


    };


    let PrintInvoice = (data, callback) => {
        //if (data.invoiceData.trans_Type === "Sales")
        //    PrintSalesInvoice(data, callback);
        //else {

        //    if (data.copy !== undefined) {
        //        //print double
        //        PrintTaxInvoice(data, callback);
        //        // PrintTaxInvoiceBrowser(data, callback);
        //    }
        //    else {
        //        //print single
        //        PrintTaxInvoice(data, callback);
        //    }

        //}
       
        if (data.invoiceData.trans_Type === "Sales") {
            PrintSalesInvoice(data, callback);
        }
        else {
            if (!_.isEmpty(data.copy) && data.copy.printCount == 0) {
                //print double
                PrintTaxInvoice(data, function () {
                    debugger;
                    data.copy.printCount = 1;
                    PrintTaxInvoice(data, callback);
                });

            }
            else {
                //print single
                PrintTaxInvoice(data, callback);
            }
        }
    };

    let PrintTaxInvoice = (data, callback) => {
        var paymentMode = _.pluck(data.billData, "trans_Mode").join(", ");
        if (paymentMode === "") {
            paymentMode = data.paymentMode;
        }

        //Header Start here
        var header = "";
        header += "         " + (data.storeData.COMPANY_NAME || data.storeData.companY_NAME) + "\r\n";
        header += "         " + (data.storeData.ADDRESS || data.storeData.address) + "\r\n ";
        header += "           Vat No.: " + (data.storeData.VAT || data.storeData.vat) + "\r\n";
        header += "        " + (!_.isEmpty(data.copy) && (data.copy !== undefined && data.copy.printCount >= 1) ? "    INVOICE" : "    TAX INVOICE") + "\r\n";
        header += (!_.isEmpty(data.copy) && data.copy.printCount > 1) ? "  (COPY OF ORIGINAL) (" + (data.copy.printCount - 1).toString() + ")\r\n\r\n" : "\r\n\r\n";
        header += "Bill #   : " + data.invoiceData.invoice_Number + "\r\n";
        header += "Date     : " + FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)) + " (" + data.invoiceData.trans_Date_Bs + ") \r\n";
        if (data.invoiceData.memberId !== "POS") {
            header += "Bill To  : " + data.invoiceData.customer_Name + "  \r\n";
            if (!_.isEmpty(data.invoiceData.customer_Vat)) {
                header += "VAT      : " + data.invoiceData.customer_Vat + "\r\n";
            }
            if (!_.isEmpty(data.invoiceData.customer_Address)) {
                header += "Address  : " + data.invoiceData.customer_Address + " \r\n";
            }
            if (!_.isEmpty(data.invoiceData.customer_Mobile)) {
                header += "Mobile   : " + data.invoiceData.customer_Mobile + "\r\n";
            }
        }
        header += "Pay Mode : " + paymentMode + "\r\n";
        header += "--------------------------------------- \r\n";
        //Header end here


        //Item Header Start here
        var itemHeader = "Particulars  Qty  Rate  P.Dis   Amount  \r\n";
        itemHeader += "------------------------------------- \r\n";
        //Item Header End here

        //items start here
        let printItems = "";
        var space = ' ';
        var spaceMain = ' ';
        var itemName = '';
        var qty = '';
        var rate = '';
        var dis = '';
        var amt = '';
        var item = "";
        _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
            itemName = v.name.substring(0, maximumCharAllowInItemName);
            while (itemName.length < 12) {
                itemName = itemName + ' ';  //adds a space before the d
            }
            item += itemName;
            qty = parseFloat(v.quantity).toFixed(2);
            while (qty.length < 6) {
                qty = qty + ' ';  //adds a space before the d
            }
            item += qty;
            rate = parseFloat(v.rate).toFixed(2);
            while (rate.length < 9) {
                rate = rate + ' ';  //adds a space before the d
            }
            item += rate;
            dis = parseFloat(v.promoDiscount).toFixed(2);
            while (dis.length < 6) {
                dis = dis + ' ';  //adds a space before the d
            }
            item += dis;
            amt = parseFloat(v.gross_Amount).toFixed(2);
            while (amt.length < 9) {
                amt = amt + ' ';  //adds a space before the d
            }
            item += amt;
            item += "\r\n";

        });

        //Items end here

        //Adding Total Item
        item += "            " + parseFloat(data.invoiceData.total_Quantity).toFixed(2) + "\r\n";

        //Items Total Start here
        let grossAmount = parseFloat(data.invoiceData.total_Gross_Amount).toFixed(2);
        while (grossAmount.length < 7) {
            grossAmount = ' ' + grossAmount;  //adds a space before the d
        }
        let promoDiscount = parseFloat(data.invoiceData.promoDiscount).toFixed(2);
        while (promoDiscount.length < 7) {
            promoDiscount = ' ' + promoDiscount;  //adds a space before the d
        }
        let loyaltyDiscount = parseFloat(data.invoiceData.membershipDiscount).toFixed(2);
        while (loyaltyDiscount.length < 7) {
            loyaltyDiscount = ' ' + loyaltyDiscount;  //adds a space before the d
        }
        let taxable = parseFloat(data.invoiceData.taxableAmount).toFixed(2);
        while (taxable.length < 7) {
            taxable = ' ' + taxable;  //adds a space before the d
        }
        let nonTaxable = parseFloat(data.invoiceData.nonTaxableAmount).toFixed(2);
        while (nonTaxable.length < 7) {
            nonTaxable = ' ' + nonTaxable;  //adds a space before the d
        }
        let vat = parseFloat(data.invoiceData.total_Vat).toFixed(2);
        while (vat.length < 7) {
            vat = ' ' + vat;  //adds a space before the d
        }



        let netAmount = parseFloat(data.invoiceData.total_Payable_Amount).toFixed(2);
        while (grossAmount.length < 7) {
            netAmount = ' ' + netAmount;  //adds a space before the d
        }
        let tender = parseFloat(data.invoiceData.tender_Amount).toFixed(2);
        while (tender.length < 7) {
            tender = ' ' + tender;  //adds a space before the d
        }
        let change = parseFloat(data.invoiceData.change_Amount).toFixed(2);
        while (change.length < 7) {
            change = ' ' + change;  //adds a space before the d
        }
        var itemTotal = "";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "                Gross Amount  : " + grossAmount + "\r\n";
        itemTotal += "                Promo Disc.   : " + promoDiscount + "\r\n";
        itemTotal += "                Loyalty Disc. : " + loyaltyDiscount + "\r\n";
        itemTotal += "                Taxable       : " + taxable + "\r\n";
        itemTotal += "                Non Taxable   : " + nonTaxable + "\r\n";
        itemTotal += "                Vat (13%)     : " + vat + "\r\n";
        itemTotal += "                Net Amount    : " + netAmount + "\r\n";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "                Tender        : " + tender + "\r\n";
        itemTotal += "                Change        : " + change + "\r\n";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "Saving in this bill: Rs. " + parseFloat(data.invoiceData.total_Discount).toFixed(2) + "\r\n";
        //Items Total End Here


        //Footer start here
        var footer = "--------------------------------------- \r\n";
        //footer += "Welcome to great shopping experience. Goods exchange within 7 days with original bill. contact: 01-5550422,23 \r\n";
        footer += (data.storeData.PrintMessage || data.storeData.printMessage);
        footer += "--------------------------------------- \r\n";
        footer += "Counter : " + data.invoiceData.terminal + " (" + FormatForDisplayTime(data.invoiceData.trans_Time) + ") \r\n";
        footer += "Cashier : " + data.invoiceData.created_By;
        footer += "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n";
        //Footer end here



        //Final Data
        var finalBill = header + itemHeader + item + itemTotal + footer;
        debugger;
        printwsBill(finalBill, callback, data, PrintTaxInvoiceBrowser);

    };
    let PrintTaxInvoiceBrowser = (data, callback) => {
        
        var url = ""
        var companyInitital = data.storeData.initial || data.storeData.INITIAL;
        if (data.billData !== null && data.billData.length > 0 && data.billData[0].trans_Mode === "Credit" && companyInitital === "WHS") {
            url = window.location.origin + "/Print/NewTaxInvoice";
            maximumCharAllowInItemName = 40;
        }
        else
            url = window.location.origin + "/Print/TaxInvoice";
        $.ajax({
            url: url,
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {

                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables  

                    var paymentMode = _.pluck(data.billData, "trans_Mode").join(", ");
                    if (paymentMode === "") {
                        paymentMode = data.paymentMode;
                    }

                    printText = printText.replace(/{companyName}/g, data.storeData.companY_NAME || data.storeData.COMPANY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address || data.storeData.ADDRESS);
                    printText = printText.replace("{vatNumber}", data.storeData.vat || data.storeData.VAT);
                    printText = printText.replace("{invoiceType}", (!_.isEmpty(data.copy) && data.copy.printCount >= 1) ? "INVOICE" : "TAX INVOICE");
                    printText = printText.replace("{copyName}", (!_.isEmpty(data.copy) && data.copy.printCount > 1) ? "(COPY OF ORIGINAL) (" + (data.copy.printCount - 1).toString() + ")" : "");
                    printText = printText.replace("{billNumber}", data.invoiceData.invoice_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace(/{customerhide}/g, data.invoiceData.memberId === "POS" ? "display-none" : "");
                    printText = printText.replace(/{addresshide}/g, _.isEmpty(data.invoiceData.customer_Address) ? "display-none" : "");
                    printText = printText.replace(/{mobilehide}/g, _.isEmpty(data.invoiceData.customer_Mobile) ? "display-none" : "");
                    printText = printText.replace(/{billToVatHide}/g, _.isEmpty(data.invoiceData.customer_Vat) ? "display-none" : "");
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToVat}", data.invoiceData.customer_Vat);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", paymentMode);
                    printText = printText.replace("{totalGrossAmount}", parseFloat(data.invoiceData.total_Gross_Amount).toFixed(2));
                    printText = printText.replace("{promoDiscount}", parseFloat(data.invoiceData.promoDiscount).toFixed(2));
                    printText = printText.replace("{loyaltyDiscount}", parseFloat(data.invoiceData.membershipDiscount).toFixed(2));
                    printText = printText.replace("{totalSaving}", parseFloat(data.invoiceData.total_Discount).toFixed(2));
                    printText = printText.replace("{totalNetAmount}", parseFloat(data.invoiceData.total_Payable_Amount).toFixed(2));
                    printText = printText.replace("{tenderAmount}", parseFloat(data.invoiceData.tender_Amount).toFixed(2));
                    printText = printText.replace("{changeAmount}", parseFloat(data.invoiceData.change_Amount).toFixed(2));
                    printText = printText.replace("{totalQuantity}", parseFloat(data.invoiceData.total_Quantity).toFixed(2));
                    printText = printText.replace("{totalTaxableAmount}", parseFloat(data.invoiceData.taxableAmount).toFixed(2));
                    printText = printText.replace("{totalNonTaxableAmount}", parseFloat(data.invoiceData.nonTaxableAmount).toFixed(2));
                    printText = printText.replace("{totalVat}", parseFloat(data.invoiceData.total_Vat).toFixed(2));
                    printText = printText.replace("{terminalName}", data.invoiceData.terminal);
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", data.invoiceData.created_By);
                    printText = printText.replace("{printMessage}", data.storeData.PrintMessage || data.storeData.printMessage );

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";
                    _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", parseFloat(v.quantity).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", parseFloat(v.rate).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemPromoDiscount}", parseFloat(v.promoDiscount).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", parseFloat(v.gross_Amount).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemTax}", (v.is_Vatable == true ? "V" : "N"));
                        printItems += printItemTemplate;
                    });


                    FinalPrint(printText, printItems, callback);

                    //update print count
                    $.ajax({
                        url: window.location.origin + "/Print/UpdatePrintCount?invoiceNumber=" + data.invoiceData.invoice_Number,
                        type: 'POST',
                        complete: function (result) {
                        }
                    });
                }

                //if (callback !== undefined)
                //    callback();
            }
        });
    };

    let PrintSalesInvoice = (data, callback) => {
        
        var paymentMode = _.pluck(data.billData, "trans_Mode").join(", ");
        if (paymentMode === "") {
            paymentMode = data.paymentMode;
        }

        //Header Start here
        var header = "";
        header += "         " + (data.storeData.COMPANY_NAME || data.storeData.companY_NAME) + "\r\n";
        header += "         " + (data.storeData.ADDRESS || data.storeData.address) + "\r\n ";
        header += "           Vat No.: " + (data.storeData.VAT || data.storeData.vat) + "\r\n";
        header += "       ABBREVIATED TAX INVOICE \r\n";
        header += (_.isEmpty(data.copy) || data.copy.printCount === 0) ? "\r\n\r\n" : "    (COPY OF ORIGINAL) \r\n\r\n";
        header += "Bill #   : " + data.invoiceData.invoice_Number + "\r\n";
        header += "Date     : " + FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)) + " (" + data.invoiceData.trans_Date_Bs + ") \r\n";
        if (data.invoiceData.memberId !== "POS") {
            header += "Bill To  : " + data.invoiceData.customer_Name + "  \r\n";
            if (!_.isEmpty(data.invoiceData.customer_Address)) {
                header += "Address  : " + data.invoiceData.customer_Address + " \r\n";
            }
            if (!_.isEmpty(data.invoiceData.customer_Mobile)) {
                header += "Mobile   : " + data.invoiceData.customer_Mobile + "\r\n";
            }
        }
        header += "Pay Mode : " + paymentMode + "\r\n";
        header += "--------------------------------------- \r\n";
        //Header end here


        //Item Header Start here
        var itemHeader = "Particulars  Qty  Rate  P.Dis   Amount  \r\n";
        itemHeader += "------------------------------------- \r\n";
        //Item Header End here

        //items start here
        let printItems = "";
        var space = ' ';
        var spaceMain = ' ';
        var itemName = '';
        var qty = '';
        var rate = '';
        var dis = '';
        var amt = '';
        var item = "";
        _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
            itemName = v.name.substring(0, maximumCharAllowInItemName);
            while (itemName.length < 12) {
                itemName = itemName + ' ';  //adds a space before the d
            }
            item += itemName;
            qty = parseFloat(v.quantity).toFixed(2);
            while (qty.length < 6) {
                qty = qty + ' ';  //adds a space before the d
            }
            item += qty;
            rate = parseFloat(v.rate).toFixed(2);
            while (rate.length < 9) {
                rate = rate + ' ';  //adds a space before the d
            }
            item += rate;
            dis = parseFloat(v.promoDiscount).toFixed(2);
            while (dis.length < 6) {
                dis = dis + ' ';  //adds a space before the d
            }
            item += dis;
            amt = parseFloat(v.gross_Amount).toFixed(2);
            while (amt.length < 8) {
                amt = amt + ' ';  //adds a space before the d
            }
            item += amt;
            //item += "      ";
            item += "\r\n";

        });

        //Items end here

        //Adding Total Item
        item += "            " + parseFloat(data.invoiceData.total_Quantity).toFixed(2) + "\r\n";

        //Items Total Start here
        let grossAmount = parseFloat(data.invoiceData.total_Gross_Amount).toFixed(2);
        while (grossAmount.length < 7) {
            grossAmount = ' ' + grossAmount;  //adds a space before the d
        }
        let promoDiscount = parseFloat(data.invoiceData.promoDiscount).toFixed(2);
        while (promoDiscount.length < 7) {
            promoDiscount = ' ' + promoDiscount;  //adds a space before the d
        }
        let loyaltyDiscount = parseFloat(data.invoiceData.membershipDiscount).toFixed(2);
        while (loyaltyDiscount.length < 7) {
            loyaltyDiscount = ' ' + loyaltyDiscount;  //adds a space before the d
        }
        let netAmount = parseFloat(data.invoiceData.total_Payable_Amount).toFixed(2);
        while (grossAmount.length < 7) {
            netAmount = ' ' + netAmount;  //adds a space before the d
        }
        let tender = parseFloat(data.invoiceData.tender_Amount).toFixed(2);
        while (tender.length < 7) {
            tender = ' ' + tender;  //adds a space before the d
        }
        let change = parseFloat(data.invoiceData.change_Amount).toFixed(2);
        while (change.length < 7) {
            change = ' ' + change;  //adds a space before the d
        }
        var itemTotal = "";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "                Gross Amount  : " + grossAmount + "\r\n";
        itemTotal += "                Promo Disc.   : " + promoDiscount + "\r\n";
        itemTotal += "                Loyalty Disc. : " + loyaltyDiscount + "\r\n";
        itemTotal += "                Net Amount    : " + netAmount + "\r\n";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "                Tender        : " + tender + "\r\n";
        itemTotal += "                Change        : " + change + "\r\n";
        itemTotal += "                ------------------------\r\n";
        itemTotal += "Saving in this bill: Rs. " + parseFloat(data.invoiceData.total_Discount).toFixed(2) + "\r\n";
        //Items Total End Here


        //Footer start here
        var footer = "--------------------------------------- \r\n";
        //footer += "Welcome to great shopping experience. Goods exchange within 7 days with original bill. contact: 01-5550422,23 \r\n";
        footer += (data.storeData.PrintMessage || data.storeData.printMessage);
        footer += "--------------------------------------- \r\n";
        footer += "Counter : " + data.invoiceData.terminal + " (" + FormatForDisplayTime(data.invoiceData.trans_Time) + ") \r\n";
        footer += "Cashier : " + data.invoiceData.created_By;
        footer += "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n";
        //Footer end here



        //Final Data
        var finalBill = header + itemHeader + item + itemTotal + footer;

        printwsBill(finalBill, callback, data, PrintSalesInvoiceBrowser);

    };
    let PrintSalesInvoiceBrowser = (data, callback) => {

        $.ajax({
            url: window.location.origin + "/Print/SalesInvoice",
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {
                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables

                    debugger;
                    var paymentMode = _.pluck(data.billData, "trans_Mode").join(", ");
                    if (paymentMode === "") {
                        paymentMode = data.paymentMode;
                    }

                    printText = printText.replace("{companyName}", data.storeData.companY_NAME || data.storeData.COMPANY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address || data.storeData.ADDRESS);
                    printText = printText.replace("{vatNumber}", data.storeData.vat || data.storeData.VAT);
                    printText = printText.replace("{invoiceType}", "ABBREVIATED TAX INVOICE");
                    printText = printText.replace("{copyName}", (_.isEmpty(data.copy) || data.copy.printCount === 0) ? "" : "(COPY OF ORIGINAL)");
                    printText = printText.replace("{billNumber}", data.invoiceData.invoice_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace(/{customerhide}/g, data.invoiceData.memberId === "POS" ? "display-none" : "");
                    printText = printText.replace(/{addresshide}/g, _.isEmpty(data.invoiceData.customer_Address) ? "display-none" : "");
                    printText = printText.replace(/{mobilehide}/g, _.isEmpty(data.invoiceData.customer_Mobile) ? "display-none" : "");
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", paymentMode);

                    printText = printText.replace("{totalGrossAmount}", parseFloat(data.invoiceData.total_Gross_Amount).toFixed(2));
                    printText = printText.replace("{promoDiscount}", parseFloat(data.invoiceData.promoDiscount).toFixed(2));
                    printText = printText.replace("{loyaltyDiscount}", parseFloat(data.invoiceData.membershipDiscount).toFixed(2));
                    printText = printText.replace("{totalSaving}", parseFloat(data.invoiceData.total_Discount).toFixed(2));
                    printText = printText.replace("{totalNetAmount}", parseFloat(data.invoiceData.total_Payable_Amount).toFixed(2));
                    printText = printText.replace("{tenderAmount}", parseFloat(data.invoiceData.tender_Amount).toFixed(2));
                    printText = printText.replace("{changeAmount}", parseFloat(data.invoiceData.change_Amount).toFixed(2));
                    printText = printText.replace("{totalQuantity}", parseFloat(data.invoiceData.total_Quantity).toFixed(2));
                    printText = printText.replace("{terminalName}", data.invoiceData.terminal);
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", data.invoiceData.created_By);
                    printText = printText.replace("{printMessage}", data.storeData.PrintMessage || data.storeData.printMessage);

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";
                    _.each(data.invoiceData.salesInvoiceItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", parseFloat(v.quantity).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", parseFloat(v.rate).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemPromoDiscount}", parseFloat(v.promoDiscount).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", parseFloat(v.gross_Amount).toFixed(2));
                        printItems += printItemTemplate;
                    });


                    //            //printText = 
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");
                    //            //printText = printText.replace("", "");




                    FinalPrint(printText, printItems, callback);
                    // console.log(finalBill);
                    // printwsBill(finalBill, callback);
                    //update print count
                    $.ajax({
                        url: window.location.origin + "/Print/UpdatePrintCount?invoiceNumber=" + data.invoiceData.invoice_Number,
                        type: 'POST',
                        complete: function (result) {
                        }
                    });
                }

                //        //if (callback !== undefined)
                //        //    callback();
                //    }
                //});
            }
        });
    };

    let PrintCreditNoteInvoice = (data, callback) => {
        debugger;
        var url = ""
        var companyInitital = data.storeData.initial || data.storeData.INITIAL;
        if (companyInitital === "WHS") {
            url = window.location.origin + "/Print/WholeSaleCreditNote";
            maximumCharAllowInItemName = 40;
        }
        else
            url = window.location.origin + "/Print/CreditNote";

        $.ajax({
            url: url,
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {
                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables
                    var paymentMode = _.pluck(data.billData, "trans_Mode").join(", ");
                    if (paymentMode === "") {
                        paymentMode = data.paymentMode;
                    }

                    printText = printText.replace(/{companyName}/g, data.storeData.companY_NAME || data.storeData.COMPANY_NAME);
                    printText = printText.replace("{storeLocation}", data.storeData.address || data.storeData.ADDRESS);
                    printText = printText.replace("{vatNumber}", data.storeData.vat || data.storeData.VAT);
                    printText = printText.replace("{invoiceType}", "CREDIT NOTE");
                    printText = printText.replace("{copyName}", (data.copy === undefined || data.copy === false) ? "" : "(COPY OF ORIGINAL)");
                    printText = printText.replace("{billNumber}", data.invoiceData.credit_Note_Number);
                    printText = printText.replace("{billRefNumber}", data.invoiceData.reference_Number);
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.invoiceData.trans_Date_Ad)));
                    printText = printText.replace("{dateBS}", data.invoiceData.trans_Date_Bs);
                    printText = printText.replace(/{customerhide}/g, data.invoiceData.memberId === "POS" ? "display-none" : "");
                    printText = printText.replace(/{addresshide}/g, _.isEmpty(data.invoiceData.customer_Address) ? "display-none" : "");
                    printText = printText.replace(/{mobilehide}/g, _.isEmpty(data.invoiceData.customer_Mobile) ? "display-none" : "");
                    printText = printText.replace(/{billToVatHide}/g, _.isEmpty(data.invoiceData.customer_Vat) ? "display-none" : "");
                    printText = printText.replace("{billToVat}", data.invoiceData.customer_Vat);
                    printText = printText.replace("{billToName}", data.invoiceData.customer_Name);
                    printText = printText.replace("{billToAddress}", data.invoiceData.customer_Address);
                    printText = printText.replace("{billToMobile}", data.invoiceData.customer_Mobile);
                    printText = printText.replace("{paymentMode}", data.invoiceData.payment_Mode);
                    printText = printText.replace("{totalGrossAmount}", parseFloat(data.invoiceData.total_Gross_Amount).toFixed(2));
                    printText = printText.replace("{promoDiscount}", parseFloat(data.invoiceData.promoDiscount).toFixed(2));
                    printText = printText.replace("{loyaltyDiscount}", parseFloat(data.invoiceData.membershipDiscount).toFixed(2));
                    // printText = printText.replace("{totalSaving}", parseFloat(data.invoiceData.total_Discount).toFixed(2));
                    printText = printText.replace("{totalTaxableAmount}", parseFloat(data.invoiceData.taxableAmount).toFixed(2));
                    printText = printText.replace("{totalNonTaxableAmount}", parseFloat(data.invoiceData.nonTaxableAmount).toFixed(2));
                    printText = printText.replace("{totalVat}", parseFloat(data.invoiceData.total_Vat).toFixed(2));
                    printText = printText.replace("{Remarks}", data.invoiceData.credit_Note);
                    printText = printText.replace("{totalNetAmount}", parseFloat(data.invoiceData.total_Net_Amount).toFixed(2));
                    printText = printText.replace("{tenderAmount}", parseFloat(data.invoiceData.tender_Amount).toFixed(2));
                    printText = printText.replace("{changeAmount}", parseFloat(data.invoiceData.change_Amount).toFixed(2));
                    printText = printText.replace("{totalQuantity}", parseFloat(data.invoiceData.total_Quantity).toFixed(2));
                    printText = printText.replace("{terminalName}", data.invoiceData.terminal);
                    printText = printText.replace("{transTime}", FormatForDisplayTime(data.invoiceData.trans_Time));
                    printText = printText.replace("{cashierName}", data.invoiceData.created_By);
                    printText = printText.replace("{printMessage}", data.storeData.PrintMessage || data.storeData.printMessage);

                    //get items template
                    let printItemTemplateOld = $(result.responseText).find("#items").html();
                    let printItems = "";

                    _.each(data.invoiceData.creditNoteItems, function (v, k) {
                        var printItemTemplate = printItemTemplateOld;
                        printItemTemplate = printItemTemplate.replace("{ItemSN}", (k + 1).toString());
                        printItemTemplate = printItemTemplate.replace("{ItemName}", v.name.substring(0, maximumCharAllowInItemName));
                        printItemTemplate = printItemTemplate.replace("{ItemQuantity}", parseFloat(v.quantity).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemRate}", parseFloat(v.rate).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemPromoDiscount}", parseFloat(v.promoDiscount).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemTotal}", parseFloat(v.gross_Amount).toFixed(2));
                        printItemTemplate = printItemTemplate.replace("{ItemTax}", (v.is_Vatable == true ? "V" : "N"));
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

                    FinalPrint(printText, printItems, callback);


                    //update print count
                    $.ajax({
                        url: window.location.origin + "/Print/UpdatePrintCount?invoiceNumber=" + data.invoiceData.credit_Note_Number,
                        type: 'POST',
                        complete: function (result) {
                        }
                    });
                }

                //if (callback !== undefined)
                //    callback();
            }
        });
    };
    let PrintDenomination = (data, callback) => {
        //var bill = "";
        //bill += "       " + data.Store.COMPANY_NAME + "      ";
        //bill += "       " + data.Store.ADDRESS + "     ";
        //bill += "      " + data.Store.VAT + "   ";
        //bill += "      DENOMINATION SLIP              ";
        //bill += "   AD:" + new Date(data.DenominationData.Date + "  BS:" + data.DenominationData.Date_BS;
        //bill += "Terminal: " + data.DenominationData.Date_BS + "   ";
        //bill += "Cashier:" + data.DenominationData.User_Id + "   ";
        $.ajax({
            url: window.location.origin + "/Print/Denomination",
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {
                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables

                    printText = printText.replace("{companyName}", data.Store.COMPANY_NAME);
                    printText = printText.replace("{storeLocation}", data.Store.ADDRESS);
                    printText = printText.replace("{vatNumber}", data.Store.VAT);
                    printText = printText.replace("{invoiceType}", "DENOMINATION SLIP");
                    printText = printText.replace("{copyName}", "");
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.DenominationData.Date)));
                    printText = printText.replace("{dateBS}", data.DenominationData.Date_BS);
                    printText = printText.replace("{terminalName}", data.DenominationData.Terminal.Name);
                    printText = printText.replace("{cashierName}", data.DenominationData.User_Id);


                    printText = printText.replace("{cardHide}", data.DenominationData.Card !== null ? "" : "display-none");
                    printText = printText.replace("{card}", (parseFloat(data.DenominationData.Card).toFixed(2)));
                    printText = printText.replace("{creditHide}", data.DenominationData.Credit !== null ? "" : "display-none");
                    printText = printText.replace("{credit}", (parseFloat(data.DenominationData.Credit).toFixed(2)));
                    printText = printText.replace("{creditNoteHide}", data.DenominationData.CreditNote !== null ? "" : "display-none");
                    printText = printText.replace("{creditNote}", (parseFloat(data.DenominationData.CreditNote).toFixed(2)));

                    printText = printText.replace("{ICHide}", data.DenominationData.Ric !== null ? "" : "display-none");
                    printText = printText.replace("{IC}", data.DenominationData.Ric);
                    printText = printText.replace("{ICTotal}", (parseFloat(data.DenominationData.Ric) * 1.6).toFixed(2));

                    printText = printText.replace("{RS1000Hide}", data.DenominationData.R1000 !== null ? "" : "display-none");
                    printText = printText.replace("{RS1000}", data.DenominationData.R1000);
                    printText = printText.replace("{RS1000Total}", (parseFloat(data.DenominationData.R1000) * 1000).toFixed(2));

                    printText = printText.replace("{RS500Hide}", data.DenominationData.R500 !== null ? "" : "display-none");
                    printText = printText.replace("{RS500}", data.DenominationData.R500);
                    printText = printText.replace("{RS500Total}", (parseFloat(data.DenominationData.R500) * 500).toFixed(2));

                    printText = printText.replace("{RS250Hide}", data.DenominationData.R250 !== null ? "" : "display-none");
                    printText = printText.replace("{RS250}", data.DenominationData.R250);
                    printText = printText.replace("{RS250Total}", (parseFloat(data.DenominationData.R250) * 250).toFixed(2));

                    printText = printText.replace("{RS100Hide}", data.DenominationData.R100 !== null ? "" : "display-none");
                    printText = printText.replace("{RS100}", data.DenominationData.R100);
                    printText = printText.replace("{RS100Total}", (parseFloat(data.DenominationData.R100) * 100).toFixed(2));

                    printText = printText.replace("{RS50Hide}", data.DenominationData.R50 !== null ? "" : "display-none");
                    printText = printText.replace("{RS50}", data.DenominationData.R50);
                    printText = printText.replace("{RS50Total}", (parseFloat(data.DenominationData.R50) * 50).toFixed(2));

                    printText = printText.replace("{RS25Hide}", data.DenominationData.R25 !== null ? "" : "display-none");
                    printText = printText.replace("{RS25}", data.DenominationData.R25);
                    printText = printText.replace("{RS25Total}", (parseFloat(data.DenominationData.R25) * 25).toFixed(2));

                    printText = printText.replace("{RS20Hide}", data.DenominationData.R20 !== null ? "" : "display-none");
                    printText = printText.replace("{RS20}", data.DenominationData.R20);
                    printText = printText.replace("{RS20Total}", (parseFloat(data.DenominationData.R20) * 20).toFixed(2));

                    printText = printText.replace("{RS10Hide}", data.DenominationData.R10 !== null ? "" : "display-none");
                    printText = printText.replace("{RS10}", data.DenominationData.R10);
                    printText = printText.replace("{RS10Total}", (parseFloat(data.DenominationData.R10) * 10).toFixed(2));

                    printText = printText.replace("{RS5Hide}", data.DenominationData.R5 !== null ? "" : "display-none");
                    printText = printText.replace("{RS5}", data.DenominationData.R5);
                    printText = printText.replace("{RS5Total}", (parseFloat(data.DenominationData.R5) * 5).toFixed(2));

                    printText = printText.replace("{RS2Hide}", data.DenominationData.R2 !== null ? "" : "display-none");
                    printText = printText.replace("{RS2}", data.DenominationData.R2);
                    printText = printText.replace("{RS2Total}", (parseFloat(data.DenominationData.R2) * 2).toFixed(2));

                    printText = printText.replace("{RS1Hide}", data.DenominationData.R1 !== null ? "" : "display-none");
                    printText = printText.replace("{RS1}", data.DenominationData.R1);
                    printText = printText.replace("{RS1Total}", (parseFloat(data.DenominationData.R1) * 1).toFixed(2));

                    printText = printText.replace("{RS05Hide}", data.DenominationData.R05 !== null ? "" : "display-none");
                    printText = printText.replace("{RS05}", data.DenominationData.R05);
                    printText = printText.replace("{RS05Total}", (parseFloat(data.DenominationData.R05) * 0.5).toFixed(2));

                    var grandTotal = parseFloat(data.DenominationData.Total) + parseFloat(data.DenominationData.Card || 0) + parseFloat(data.DenominationData.Credit || 0) + parseFloat(data.DenominationData.CreditNote || 0);
                    printText = printText.replace("{GrandTotal}", grandTotal.toFixed(2));


                    FinalPrint(printText, undefined, callback);
                }

                //if (callback !== undefined)
                //    callback();
            }
        });
    };
    let PrintSettlement = (data, callback) => {
        $.ajax({
            url: window.location.origin + "/Print/Settlement",
            type: 'GET',
            complete: function (result) {
                if (result.status === 200) {
                    let printText = $(result.responseText).find("#printbody").html();
                    //replace all variables

                    printText = printText.replace("{companyName}", data.store.companY_NAME);
                    printText = printText.replace("{storeLocation}", data.store.address);
                    printText = printText.replace("{vatNumber}", data.store.vat);
                    printText = printText.replace("{invoiceType}", "CASH SETTLEMENT MEMO");
                    printText = printText.replace("{copyName}", "");
                    printText = printText.replace("{dateAD}", FormatForDisplay(new Date(data.settlementData[0].verifiedDate)));
                    printText = printText.replace("{dateBS}", AD2BS(FormatForInput(new Date(data.settlementData[0].verifiedDate))));
                    printText = printText.replace("{terminalName}", data.settlementData[0].terminalName);
                    printText = printText.replace("{cashierName}", data.settlementData[0].userId);
                    printText = printText.replace("{verifyBy}", data.settlementData[0].verifiedBy);


                    printText = printText.replace("{openingBalance}", "0.00");
                    //variable

                    var cash = _.sum(_.pluck(_.filter(data.settlementData, function (i, j) {
                        return i.paymentMode === "Cash";
                    }), "totalAmount"));


                    var card = _.sum(_.pluck(_.filter(data.settlementData, function (i, j) {
                        return i.paymentMode === "Card";
                    }), "totalAmount"));
                    var credit = _.sum(_.pluck(_.filter(data.settlementData, function (i, j) {
                        return i.paymentMode === "Credit";
                    }), "totalAmount"));
                    var creditNote = _.sum(_.pluck(_.filter(data.settlementData, function (i, j) {
                        return i.paymentMode === "CreditNote";
                    }), "totalAmount"));

                    printText = printText.replace("{cashHide}", cash !== undefined && parseFloat(cash) > 0 ? "" : "display-none");
                    printText = printText.replace("{cash}", CurrencyFormat(cash.toString()));
                    printText = printText.replace("{cardHide}", card !== undefined && parseFloat(card) > 0 ? "" : "display-none");
                    printText = printText.replace("{card}", CurrencyFormat(card.toString()));
                    printText = printText.replace("{creditHide}", credit !== undefined && parseFloat(credit) > 0 ? "" : "display-none");
                    printText = printText.replace("{credit}", CurrencyFormat(credit.toString()));
                    printText = printText.replace("{creditNoteHide}", creditNote !== undefined && parseFloat(creditNote) > 0 ? "" : "display-none");
                    printText = printText.replace("{creditNote}", CurrencyFormat(creditNote.toString()));

                    var settlementCash = _.filter(data.settlementData, function (v, k) {
                        return v.paymentMode === "Cash";
                    })[0];
                    var settlementCard = _.filter(data.settlementData, function (v, k) {
                        return v.paymentMode === "Card";
                    })[0];
                    var settlementCredit = _.filter(data.settlementData, function (v, k) {
                        return v.paymentMode === "Credit";
                    })[0];
                    var settlementCreditNote = _.filter(data.settlementData, function (v, k) {
                        return v.paymentMode === "CreditNote";
                    })[0];
                    printText = printText.replace("{cashAdjHide}", settlementCash !== undefined && parseFloat(settlementCash.adjustmentAmount) > 0 ? "" : "display-none");
                    if (settlementCash !== undefined)
                        printText = printText.replace("{cashAdj}", CurrencyFormat(settlementCash.adjustmentAmount.toString()));
                    printText = printText.replace("{cardAdjHide}", settlementCard !== undefined && parseFloat(settlementCard.adjustmentAmount) > 0 ? "" : "display-none");
                    if (settlementCard !== undefined)
                        printText = printText.replace("{cardAdj}", CurrencyFormat(settlementCard.adjustmentAmount.toString()));
                    printText = printText.replace("{creditAdjHide}", settlementCredit !== undefined && parseFloat(settlementCredit.adjustmentAmount) > 0 ? "" : "display-none");
                    if (settlementCredit !== undefined)
                        printText = printText.replace("{creditAdj}", CurrencyFormat(settlementCredit.adjustmentAmount.toString()));
                    printText = printText.replace("{creditNoteAdjHide}", settlementCreditNote !== undefined && parseFloat(settlementCreditNote.adjustmentAmount) > 0 ? "" : "display-none");
                    if (settlementCreditNote !== undefined)
                        printText = printText.replace("{creditNoteAdj}", CurrencyFormat(settlementCreditNote.adjustmentAmount.toString()));


                    printText = printText.replace("{cashSEHide}", settlementCash !== undefined && parseFloat(settlementCash.shortExcessAmount) !== 0 ? "" : "display-none");
                    if (settlementCash !== undefined)
                        printText = printText.replace("{cashShortExcess}", CurrencyFormat(settlementCash.shortExcessAmount.toString()));
                    printText = printText.replace("{cardSEHide}", settlementCard !== undefined && parseFloat(settlementCard.shortExcessAmount) !== 0 ? "" : "display-none");
                    if (settlementCard !== undefined)
                        printText = printText.replace("{cardShortExcess}", CurrencyFormat(settlementCard.shortExcessAmount.toString()));
                    printText = printText.replace("{creditSEHide}", settlementCredit !== undefined && parseFloat(settlementCredit.shortExcessAmount) !== 0 ? "" : "display-none");
                    if (settlementCredit !== undefined)
                        printText = printText.replace("{creditShortExcess}", CurrencyFormat(settlementCredit.shortExcessAmount.toString()));
                    printText = printText.replace("{creditNoteSEHide}", settlementCreditNote !== undefined && parseFloat(settlementCreditNote.shortExcessAmount) !== 0 ? "" : "display-none");
                    if (settlementCreditNote !== undefined)
                        printText = printText.replace("{creditNoteShortExcess}", CurrencyFormat(settlementCreditNote.shortExcessAmount.toString()));




                    FinalPrint(printText, undefined, callback);
                }


            }
        });
    };
    let FinalPrint = (printText, printItemText, callback) => {

        $(document.body).find(".main-body").append('<div id="tempprint" ></div>');
        $("#tempprint").html(printText);
        if (printItemText !== undefined)
            $("#tempprint").find("#items").html(printItemText);
        debugger;

        //

        //var ws;
        //ws = new WebSocket('ws://127.0.0.1:90');
        //var str = $("#tempprint").html();
        //var state;
        //ws.addEventListener('open', ws_open(str), false);
        //function ws_open(text) {
        //    // alert("Are you sure to print?");
        //    console.log("printcalled");
        //    ws.onopen = () => ws.send(text);
        //    // ws.send(text);
        //}

        //
        printJS({
            printable: 'tempprint',
            type: 'html',
            targetStyles: ['*'],
            onLoadingEnd: function () {               
                $("#tempprint").remove();

                if (callback !== undefined)
                    setTimeout(callback, 100);
                   


            }
        });
    };

    let printwsBill = (str, callback, data, errorcallback, ) => {
        //var ws;
        //ws = new WebSocket('ws://127.0.0.1:90');
        //var state;
        //ws.addEventListener('open', ws_open(str), false);
        //ws.addEventListener('close', ws_close(str), false);
        //function ws_open(text) {
        //    // alert("Are you sure to print?");
        //    console.log("printcalled");
        //    ws.onopen = () => ws.send(text);
        //    // ws.send(text);
        //    if (callback !== undefined)
        //        callback();
        //}
        //function ws_close(text) {
        //    if (errorcallback !== undefined)
        //        errorcallback(data, callback);
        //}
        try {
            window.wsSingleton = new Ws()
            window.wsSingleton.clientPromise
                .then(wsClient => {
                    wsClient.send(str);
                    //console.log('sended')

                    if (callback !== undefined)
                        callback();
                })
                .catch((error) => {
                    if (errorcallback !== undefined)
                        errorcallback(data, callback);
                });


        } catch{
            alert("error");
        }



        //var ws;
        //ws = new WebSocket('ws://127.0.0.1:90');
        //var state;       
        //ws.addEventListener('open', ws_open(str), false);

        //function ws_open(text) {
        //    // alert("Are you sure to print?");
        //    console.log("printcalled");
        //    ws.onopen = () => ws.send(text);
        //    // ws.send(text);
        //    if (callback !== undefined)
        //        callback();
        //}


    };




    //********* Events ************************//

    //********* Public Output ****************//
    return {
        init,
        PrintInvoice,
        PrintCreditNoteInvoice,
        PrintDenomination,
        PrintSettlement
    };

})();

printer.init();