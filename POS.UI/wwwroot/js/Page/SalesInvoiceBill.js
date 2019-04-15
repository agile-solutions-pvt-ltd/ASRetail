const bill = (function () {
    //*********Private Variables **************//
    let table = document.getElementById("billing-table").getElementsByTagName('tbody')[0];
    let trans_mode = {
        Cash: "Cash", DebitCard: "Debit Card", Credit: "Credit"
    };

    //*********Private Methods **************//
    let init = () => {
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
                    $("#totalChangeAmountTextBox").val(changeAmount.toString());
                } else {
                    remainingAmount = totalNetAmount - totalTableAmount;
                    $("#totalTableAmount").text(CurrencyFormat(totalTableAmount));
                    $("#totalRemainingAmountTextBox").val(remainingAmount.toString());
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
        setTimeout(function () { $("#error-message").hide();}, 5000);
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

            $('<i class="sn font-weight-bold">' + (table.rows.length) + '</i>').appendTo(cell1);
            $("<span class='trans_mode'>" + type + "</span>").appendTo(cell2);
            $("<span class='account'>" + account + "</span>").appendTo(cell3);
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
        if (!_.isEmpty(getUrlParameters())){
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
            let account = $(this).find(".account").text();
            let amount = CurrencyUnFormat($(this).find(".table-amount").text());

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
                    window.location.href = "/SalesInvoice";
            }
        });
    };

    //********* Events **************//
    $("#AddCashButton").on('click', function () {
        addRow("Cash", "", $("#cashAmount").val());
        clear();
    });
    $("#AddDebitCardButton").on('click', function () {
        addRow("Debit Card", $("#cardType :selected").text(), $("#cardAmount").val());
        clear();
    });
    $("#AddCreditButton").on('click', function () {
        addRow("Credit", $("#customer :selected").text(), $("#creditAmount").val());
        clear();
    });
    $("#cashAmount,#cardAmount,#creditAmount").on('click', function () {
        let value = parseFloat($("#totalRemainingAmountTextBox").val());
        if (value > 0)
            $(this).val(value);
        else
            $(this).val('');
        //$(this).focus(function () { $(this).select(); });
        //$(this).mouseup(function () {  return false; });
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
    $("#SaveButton").on('click', SaveBill);

    //*********Public Output **************//
    return {
        init: init,
        deleteRow: deleteRow,
        handleBackButtonEvent
    };
})();

bill.init();