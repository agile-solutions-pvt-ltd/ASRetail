const bill = (function () {
    //*********Private Variables **************//
    let table = document.getElementById("billing-table").getElementsByTagName('tbody')[0];
    let trans_mode = {
        Cash: "Cash", DebitCard: "Debit Card", Credit: "Credit",CreditNote: "Credit Note"
    };

    //*********Private Methods **************//
    let init = () => {

        //update page respect to permission
        updatePageWithRespectToPermission();

        calcTotal();
        //update total net amount format
        $("#totalNetAmountSpan").text(CurrencyFormat($("#totalNetAmountSpan").text()));
    };
    let calcTotal = () => {
        let totalNetAmount = parseFloat($("#TotalNetAmount").val());
        let remainingAmount = 0;
        let changeAmount = 0;

        // let remainingAmount = totalNetAmount
        let totalTableAmount = 0;
        if (table.rows.length > 0) {
            $.each(table.rows, function (i, v) {
                totalTableAmount += parseFloat(CurrencyUnFormat($(this).find(".table-amount").text()));
                if (totalTableAmount > totalNetAmount) {
                    changeAmount = totalTableAmount - totalNetAmount;
                    $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                    $("#totalRemainingAmountTextBox").val(0);
                    $("#totalChangeAmountTextBox").val(changeAmount.toFixed(2));
                } else {
                    remainingAmount = totalNetAmount - totalTableAmount;
                    $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                    $("#totalRemainingAmountTextBox").val(remainingAmount.toFixed(2));
                    $("#totalChangeAmountTextBox").val(0);
                }

            });
        }
        else {
            $("#totalTableAmount").text("0");
            $("#totalRemainingAmountTextBox").val(totalNetAmount.toString());
            $("#totalChangeAmountTextBox").val(0);
        }

    };
    let calcSN = () => {
        $.each(table.rows, function (i, v) {
            $(this).find(".sn").text((i + 1).toString());
        });
    };
    let showErrorMessage = (messgae) => {
        $("#error-message").show();
        $("#error-message > span").text(messgae);
        setTimeout(function () { $("#error-message").hide(); }, 5000);
    };
    let addRow = (type, account, amount) => {

        //check if tendar amount is greater then bill amount
        if (type === trans_mode.DebitCard || type === trans_mode.Credit) {
            if (parseFloat(amount) > parseFloat($("#totalRemainingAmountTextBox").val())) {
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
            $("<span class='account' data-account='"+accountToSave+"'>" + account + "</span>").appendTo(cell3);
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
            window.location.href = window.location.origin + "/SalesInvoice/Index/" + id;
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
    let customerChangeEvent = () => {
        var selectedValue = $('#customer').find(":selected").val();
        var selectedItem = _.filter(customerList, function (x) {
            return x.Code === selectedValue; 
        })[0];
        if (selectedItem) {
            $("#customerPan").text(selectedItem.Vat);
            $("#customerAddress").text(selectedItem.Address);
        } else {
            $("#customerPan").text("");
            $("#customerAddress").text("");
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
        });
    };
    let PaymentMethodClickEvent = (evt) => {
        evt.preventDefault();
        $this = $(evt.currentTarget);
        let selectedMode = $this.data("mode");
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
                } else
                    showErrorMessage("Credit Note Note Available !!");

            });
        }
    };
    let SaveBill = () => {
        //some validation

        if (parseFloat($("#totalRemainingAmountTextBox").val()) > 0) {
            return false;
        }
        if (table.rows.length === 0) {
            return false;
        }


        let invoiceId = $("#Invoice_Id").val();
        let data = [];


        $.each(table.rows, function (i, v) {
            let mode = $(this).find(".trans_mode").text();
            let account = $(this).find(".account").data("account");            
           // let amount = CurrencyUnFormat($(this).find(".table-amount").text());
            let amount = $("#TotalNetAmount").val();

            data.push({
                Invoice_Id: invoiceId,
                Trans_Mode: mode,
                account: account,
                Amount: amount
            });

        });

        $.ajax({
            method: "POST",
            url: "/SalesInvoice/Billing?salesInvoiceId=" + invoiceId,
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200)
                    window.location.href = "/SalesInvoice?StatusMessage=" + result.responseText;
            }
        });
    };


    //********* Events **************//
    $("#customer").on('change', customerChangeEvent);
    $("#AddCashButton").on('click', function () {
        if ($("#cashAmount").val() !== "") {
            addRow("Cash", "", $("#cashAmount").val());
            clear();
        }
    });
    $("#AddDebitCardButton").on('click', function () {
        if ($("#cardAmount").val() !== "") {
            addRow("Debit Card", "ATM Card", $("#cardAmount").val());
            clear();
        }
    });
    $("#AddCreditButton").on('click', function () {
        if ($("#customer :selected").val() === "") {
            showErrorMessage("Please select credit account first !!");
            return false;
        }

        if ($("#creditAmount").val() !== "") {
            addRow("Credit", $("#customer :selected").text(), $("#creditAmount").val());
            clear();
        }
    });
    $("#AddCreditNoteNumbertButton").on('click', function () {
        if ($("#creditNoteAmount").val() !== "") {
            addRow("Credit Note", "Credit Note", $("#creditNoteAmount").val());
            clear();
        }
    });
    $("#cashAmount,#cardAmount,#creditAmount").on('click', function () {
        let value = parseFloat($("#totalRemainingAmountTextBox").val());
        $this = $(this);
        if (value > 0)
            $this.val(value);
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
        deleteRow: deleteRow,
        handleBackButtonEvent
    };
})();

bill.init();