const bill = (function () {
    //*********Private Variables **************//
    let table = document.getElementById("billing-table").getElementsByTagName('tbody')[0];
    let trans_mode = {
        Cash: "Cash", DebitCard: "Card", Credit: "Credit", CreditNote: "Credit Note"
    };
    let loyaltyDiscountPercent = 2;

    //*********Private Methods **************//
    let init = () => {

        AssignKeyEvent();
        //update page respect to permission
        updatePageWithRespectToPermission();

        calcAll("cash");
        //update total net amount format
        calcVat();

        //var getCustomerBaseUrl = window.location.origin + "/Customer/";
        //var getCustomerUrl = getCustomerBaseUrl + "GetCustomer?MembershipNumber=" + membershipNumber;
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

        //        $("#membershipId").trigger("change");
        //    }

        //});



        $.ajax({
            method: "POST",
            url: window.location.origin + "/Customer/GetCustomerByNumber?MembershipNumber=" + GetUrlParameters("M"),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {               
                if (result.status === 200) {
                    if (result.responseJSON.length > 0) {
                        customerList = result.responseJSON;
                       // $("#customer").val(result.responseJSON[0].name);
                    }
                }
                $("#customer").attr("readonly", true);
            }
        });




        //select cash textbox bydefault
        $("#cashAmount").focus();

    };
    let roundUpTotalAmount = (mode) => {
        //roundup concept
        // $("#totalNetAmountSpan").text(parseFloat($("#totalNetAmountSpan").text()).toFixed(0));

        let amount = 0;
        if (mode !== undefined && mode === "cash")
            amount = parseFloat(CurrencyUnFormat($("#totalPayableAmount").text())).toFixed(0);
        else
            amount = parseFloat(CurrencyUnFormat($("#totalPayableAmount").text())).toFixed(2);
        $("#totalPayableAmount").text(CurrencyFormat(amount));

    };
    let calcDiscount = () => {

        var totalGrossAmount = parseFloat(CurrencyUnFormat($("#totalNetAmountSpan").text()));
        var promoDiscount = parseFloat(CurrencyUnFormat($("#promoDiscountSpan").text()));
        var loyaltyDiscount = parseFloat(CurrencyUnFormat($("#loyaltyDiscountSpan").text()));
        var vat = 0;
        if (promoDiscount === 0) {
            $("#promoDiscount").hide();
        } else {
            $("#promoDiscount").show();
        }

        if (loyaltyDiscount === 0) {
            $("#loyaltyDiscount").hide();
        } else {
            $("#loyaltyDiscount").show();
        }

        //if (promoDiscount === 0) {
        //    loyaltyDiscount = totalGrossAmount * loyaltyDiscountPercent / 100;

        //    $("#promoDiscount").hide();
        //    $("#loyaltyDiscount").show();
        //} else {
        //    $("#promoDiscount").show();
        //    $("#loyaltyDiscount").hide();
        //}
        vat = parseFloat(CurrencyUnFormat($("#vatSpan").text()));
        if ($("#Trans_Mode").val() !== "Tax")
            vat = 0;
        
        //var totalPayableAmount = totalGrossAmount - promoDiscount - loyaltyDiscount + vat;
        var totalPayableAmount = parseFloat($("#TotalNetAmount").val());


        //assign
        $("#totalNetAmountSpan").text(CurrencyFormat(totalGrossAmount));
        $("#promoDiscountSpan").text(CurrencyFormat(promoDiscount));
        $("#loyaltyDiscountSpan").text(CurrencyFormat(loyaltyDiscount));
        $("#totalPayableAmount").text(CurrencyFormat(totalPayableAmount.toFixed(2)));

    };
    let calcTotal = () => {
        let totalNetAmount = parseFloat(CurrencyUnFormat($("#totalPayableAmount").text()));
        let remainingAmount = 0;
        let changeAmount = 0;


        // let remainingAmount = totalNetAmount
        let totalTableAmount = 0;
        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {
                totalTableAmount += parseFloat(CurrencyUnFormat($(this).find(".table-amount").text()));
                changeAmount = totalTableAmount - totalNetAmount;
                $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                $("#tenderAmount").text(CurrencyFormat(totalTableAmount));
                $("#changeAmount").text(CurrencyFormat(changeAmount.toFixed(2)));
                //if (totalTableAmount > totalNetAmount) {
                //    changeAmount = totalTableAmount - totalNetAmount;
                //    $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                //    $("#totalRemainingAmountTextBox").val(0);
                //    $("#totalChangeAmountTextBox").val(changeAmount.toFixed(2));
                //} else {
                //    remainingAmount = totalNetAmount - totalTableAmount;
                //    $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                //    $("#totalRemainingAmountTextBox").val(remainingAmount.toFixed(2));
                //    $("#totalChangeAmountTextBox").val(0);
                //}

            });
        }
        else {
            $("#totalTableAmount").text("0");
            $("#totalRemainingAmountTextBox").val(totalNetAmount.toString());
            $("#totalChangeAmountTextBox").val(0);

            $("#tenderAmount").text("0.00");
            $("#changeAmount").text(CurrencyFormat(-totalNetAmount.toFixed(2)));
        }

    };
    let calcSN = () => {
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((i + 1).toString());
        });
    };
    let calcVat = () => {
        if ($("#Trans_Mode").val() === "Tax") {
            $("#vatSpan").text(CurrencyFormat($("#vatSpan").text()));
            $("#Vat13").show();
        }
    };
    let calcAll = (mode) => {
        calcDiscount();
        roundUpTotalAmount(mode);
        calcTotal();
    };
    let showErrorMessage = (messgae) => {
        $("#error-message").show();
        $("#error-message > span").text(messgae);
        setTimeout(function () { $("#error-message").hide(); }, 5000);
    };
    let addRow = (type, account, amount) => {

        //check if tendar amount is greater then bill amount
        if (type === trans_mode.DebitCard || type === trans_mode.Credit) {
            let changeAmount = parseFloat(CurrencyUnFormat($("#changeAmount").text()));


            if (changeAmount >= 0 || parseFloat(amount) > Math.abs(changeAmount)) {
                showErrorMessage("Tender amount cannot be greater then bill amount !!");
                return false;
            }
        }


        //check there alreay item in pos  
        var checkAlreadyExistItem = false;
        $.each(table.rows, function (i, v) {
            var mode = $(this).find(".trans_mode").text();
            if (type === mode) {
                var oldAmount = CurrencyUnFormat($(this).find(".table-amount").text());
                $(this).find(".table-amount").text(CurrencyFormat((parseFloat(oldAmount) + parseFloat(amount))));
                calcTotal();
                checkAlreadyExistItem = true;
                return false;
            }
        });

        if (!checkAlreadyExistItem) {
            var t1 = table.rows.length;
            var row = table.insertRow(t1);
            var cell1 = row.insertCell(0); //SN
            var cell2 = row.insertCell(1); //trans_type
            var cell3 = row.insertCell(2); //Account
            var cell4 = row.insertCell(3); //Amount
            var cell5 = row.insertCell(4); //delete  
            var accountToSave = account;
            if (type === trans_mode.Credit)
                accountToSave = $('#customer').find(":selected").val();
            if (type === trans_mode.CreditNote)
                accountToSave = $("#creditNoteNumber").val();

            $('<i class="sn font-weight-bold">' + (table.rows.length) + '</i>').appendTo(cell1);
            $("<span class='trans_mode'>" + type + "</span>").appendTo(cell2);
            $("<span class='account' data-account='" + accountToSave + "'>" + account + "</span>").appendTo(cell3);
            $("<span class='table-amount text-right'>" + CurrencyFormat(amount) + "</span>").appendTo(cell4);

            $('<botton onclick="bill.deleteRow(this);" class="btn btn-sm btn-danger"><i class="fa fa-times fa-sm"></i></botton>').appendTo(cell5);
        }
        calcTotal();
    };
    let deleteRow = (evt) => {
        evt.parentElement.parentElement.remove();
        calcSN();
        calcTotal();
    };
    let clear = () => {
        $("#cashAmount").val('');
        $("#cardType").val('');
        $("#cardAmount").val('');
        $("#customer").val('');
        $("#creditAmount").val('');

    };
    let handleBackButtonEvent = () => {
        if (!_.isEmpty(getUrlParameters())) {           
            var id = getUrlParameters();
            var mode = GetUrlParameters("mode");
            var member = GetUrlParameters("M");
            if (mode === "tax") {
                location.assign(window.location.origin + "/SalesInvoice/Index/" + id + "?Mode=tax&M=" + member);
                setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Index/" + id + "?Mode=tax&M=" + member); }, 100);                
            }
            else {
                location.assign(window.location.origin + "/SalesInvoice/Index/" + id + "?M=" + member);
                setTimeout(() => { location.assign(window.location.origin + "/SalesInvoice/Index/" + id + "?M=" + member); }, 100);                
            }
            return false;
        }
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
    let customerChangeEvent = () => {
        //var customerDropdown = $("#customer").data("kendoComboBox");
        //var selectedItem = customerDropdown.dataItem();

        //var selectedValue = $('#customer').find(":selected").val();
        //var selectedItem = _.filter(customerList, function (x) {
        //    return x.Code === selectedValue;
        //})[0];
        var selectedItem = customerList[0];
        
        if (selectedItem && (selectedItem.type == "1" || selectedItem.Type == "1")) {
            $("#customerPan").text(selectedItem.vat || selectedItem.Vat);
            $("#customerAddress").text(selectedItem.address || selectedItem.Address);
        } else {
            $("#customerPan").text("");
            $("#customerAddress").text("");
            $()
        }
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
    let updatePageWithRespectToPermission = () => {
        getPermissions((data) => {
            if (data.roleWiseUserPermission.credit_Note_Bill_Pay) {
                $("#creditNote").show();
            }
            else {
                $("#creditNote").remove();
            }
            if (data.roleWiseUserPermission.credit_Bill_Pay) {
                $("#credit").show();
            }
            else {
                $("#credit").remove();
            }

            paymentMethodForWholesaleCustomer();

        });
    };

    let paymentMethodForWholesaleCustomer = () => {
        
        if (customerList[0].CustomerPriceGroup === "WSP" || customerList[0].customerPriceGroup === "WSP" || customerList[0].Type === "1" || customerList[0].type === "1") {
            $("#cash").remove();
            $("#card").remove();
            $("#creditNote").remove();

            //trigger credit
            $(".payment-mode-panel").hide();
            $("#credit-panel").show();
            $(".payment-mode[data-shortcut='f3']").trigger("click");
            
            $("#customer").val(customerList[0].name || customerList[0].Name);
            customerChangeEvent();

            //select default customer           
            //make readonly
            //var customerMultiselect = $("#customer").data("kendoComboBox");
            //customerMultiselect.value(customerList[0].Membership_Number);
            // customerMultiselect.input.attr("readonly", true);
            // $(".k-icon.k-clear-value.k-i-close").remove();
        }
    };
    let PaymentMethodClickEvent = (evt) => {
        evt.preventDefault();
        $this = $(evt.currentTarget);
        let selectedMode = $this.data("mode");

        calcAll(selectedMode);

        $(".payment-mode-panel").hide();
        $("#" + selectedMode + "-panel").show();

        $(".payment-mode > span").removeClass("text-success");
        $this.find("span").addClass("text-success");
        $("#" + selectedMode + "-panel").find(".amount").trigger("click");
    };
    let getCreditNoteInfo = (creditNote, Callback) => {
        $.ajax({
            url: window.location.origin + "/CreditNote/GetCreditNote?CN=" + creditNote,
            type: "GET",
            complete: function (result) {
                Callback(result);
            }
        });
    };
    let creditNoteNumberChangeEvent = () => {
        let cn = $("#creditNoteNumber").val();
        if (!_.isEmpty(cn)) {
            getCreditNoteInfo(cn, (data) => {
                $(".onetimewarning").hide();
                $("#creditNoteAmount").val("");
                if (data.status === 400) {
                    showErrorMessage(data.responseJSON.message);
                }
                else if (data.status === 200) {
                    
                    $(".onetimewarning").show();
                    $("#creditNoteAmount").val(data.responseJSON.total_Net_Amount);
                    $("#creditNoteAmount").focus();
                } else
                    showErrorMessage("Credit Note Note Available !!");

            });
        }
    };
    let convertICtoNepaliCurrency = () => {
        let amount = $("#cashAmount");
        if (amount.val() !== "") {
            amount.val((parseFloat(amount.val()) * 1.6).toFixed(2));
        }
    };
    let AssignKeyEvent = () => {
        Mousetrap.bindGlobal('esc', function () {
            handleBackButtonEvent();
        });
        Mousetrap.bindGlobal('f1', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".payment-mode[data-shortcut='f1']").trigger("click");
        });
        Mousetrap.bindGlobal('f2', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".payment-mode[data-shortcut='f2']").trigger("click");
        });
        Mousetrap.bindGlobal('f3', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".payment-mode[data-shortcut='f3']").trigger("click");
        });
        Mousetrap.bindGlobal('f4', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".payment-mode[data-shortcut='f4']").trigger("click");
            $("#creditNoteNumber").focus();
        });
        Mousetrap.bindGlobal('f12', function (e) {
            e.preventDefault(); e.stopPropagation();
            convertICtoNepaliCurrency();
            $("#cashAmount").focus();
        });

        Mousetrap.bindGlobal(['ctrl+end', 'end'], function (e) {
            e.preventDefault(); e.stopPropagation();
            SaveBill();
        });

        Mousetrap.bindGlobal('enter', function (e) {
            $(".bootbox-cancel").trigger("click");

        });

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });


    };
    let SaveBill = () => {
        //some validation
        $("#SaveButton").attr("disabled", true);
        

        if (parseFloat(CurrencyUnFormat($("#changeAmount").text())) < 0) {
            bootbox.alert("Tender amount is less then bill amount !!");
            $("#SaveButton").attr("disabled", false);
            return false;
        }
        if (table.rows.length === 0) {
            bootbox.alert("Tender amount is less then bill amount !!");
            $("#SaveButton").attr("disabled", false);
            return false;
        }


        let invoiceId = $("#Invoice_Id").val();

        let data = [];
        $.each(table.rows, function (i, v) {
            let mode = $(this).find(".trans_mode").text();
            let account = $(this).find(".account").data("account");
            let amount = CurrencyUnFormat($(this).find(".table-amount").text());
            //let amount = $("#TotalNetAmount").val();

            data.push({
                Invoice_Id: invoiceId,
                Trans_Mode: mode,
                account: account,
                Amount: amount
            });

        });


        let finalData = {
            salesInvoiceId: invoiceId,
            billDiscount: CurrencyUnFormat($("#loyaltyDiscountSpan").text()),
            totalNetAmountRoundUp: CurrencyUnFormat($("#totalNetAmountSpan").text()),
            totalPayable: CurrencyUnFormat($("#totalPayableAmount").text()),
            tenderAmount: CurrencyUnFormat($("#tenderAmount").text()),
            changeAmount: CurrencyUnFormat($("#changeAmount").text()),
            bill: data
        };
        $.ajax({
            method: "POST",
            url: "/SalesInvoice/Billing",
            data: JSON.stringify(finalData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200) {
                    
                    if (result.responseJSON.billData !== null && result.responseJSON.billData[0].trans_Mode === "Credit") {
                        result.responseJSON.copy = {
                            printCount: 0
                        };
                        printer.PrintInvoice(result.responseJSON, function () {
                            window.location.href = "/SalesInvoice/CrLanding?mode=tax&type=credit&StatusMessage=" + result.responseJSON.statusMessage;
                        });
                    } else {
                        printer.PrintInvoice(result.responseJSON, function () {
                            window.location.href = "/SalesInvoice/Landing?StatusMessage=" + result.responseJSON.statusMessage;
                        });
                    }

                }
                else {
                    StatusNotify("error", "Error occur, try again later !!");
                    $("#SaveButton").attr("disabled", false);

                }
            }
        });
    };


    //********* Events **************//
    $("#customer").on('change', customerChangeEvent);
    $("#AddCashButton").on('click', function () {       
        if (parseFloat($("#cashAmount").val()) <= 0)
            $("#cashAmount").val("");
        else if ($("#cashAmount").val() !== "") {
            addRow("Cash", "", $("#cashAmount").val());
            clear();
        }
       
    });
    $("#AddDebitCardButton").on('click', function () {
        if (parseFloat($("#cardAmount").val()) <= 0)
            $("#cardAmount").val("");
       else if ($("#cardAmount").val() !== "") {
            addRow("Card", "Card", $("#cardAmount").val());
            clear();
        }
    });
    $("#AddCreditButton").on('click', function () {
        if ($("#customer").val() === "") {
            showErrorMessage("Please select credit account first !!");
            return false;
        }
        if (parseFloat($("#creditAmount").val()) <= 0)
            $("#creditAmount").val("");
        else
        if ($("#creditAmount").val() !== "") {
            addRow("Credit", $("#customer").text(), $("#creditAmount").val());
            clear();
        }
    });
    $("#AddCreditNoteNumbertButton").on('click', function () {
        if ($("#creditNoteAmount").val() !== "") {
            let crAmount = parseFloat($("#creditNoteAmount").val());
            let totalNetAmount = parseFloat($("#TotalNetAmount").val());
            if (crAmount > totalNetAmount) {
                //waring message
                bootbox.confirm({
                    message: "Your Credit Amount is greater than this Transaction Amount, Do you really want to proceed ?",
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
                            addRow("Credit Note", "Credit Note", $("#creditNoteAmount").val());
                            $("#creditNoteAmount").val("0.00");
                            $("#creditNoteAmount").focus();
                        }
                        else {
                            $("#creditNoteAmount").focus();
                        }

                    }
                });
            } else {
                addRow("Credit Note", "Credit Note", $("#creditNoteAmount").val());
                $("#creditNoteAmount").val("0.00");
                $("#creditNoteAmount").focus();
            }
            clear();
        }
    });
    $("#cashAmount,#cardAmount,#creditAmount").on('click', function () {
        let value = parseFloat(CurrencyUnFormat($("#changeAmount").text()));
        $this = $(this);
        if (value < 0)
            $this.val(Math.abs(value));
        else
            $this.val('');

        //highlight the selected code
        $this.focus();
        $this.select();
        $this.mouseup(function () {
            // Prevent further mouseup intervention
            $this.unbind("mouseup");
            return false;
        });
    });
    $("#cashAmount").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            $("#AddCashButton").trigger('click');
            return false; // prevent the button click from happening
        }
    });
    $("#cardAmount").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            $("#AddDebitCardButton").trigger('click');
            return false; // prevent the button click from happening
        }
    });
    $("#creditAmount").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            $("#AddCreditButton").trigger('click');
            return false; // prevent the button click from happening
        }
    });
    $("#creditNoteAmount").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            $("#AddCreditNoteNumbertButton").trigger('click');
            return false; // prevent the button click from happening
        }
    });
    $(".payment-mode").on("click", PaymentMethodClickEvent);
    $("#creditNoteNumber").on("keypress", function (e) {
        if (e.keyCode === 13 && $(this).val() !== "") {
            creditNoteNumberChangeEvent();
            e.preventDefault();
            return false;
        }
    });
    $("#SaveButton").on('click', SaveBill);

    //*********Public Output **************//
    return {
        init: init,
        deleteRow: deleteRow
    };
})();

bill.init();