const settlement = (() => {
    //********* Private Variables **************//
    var paymentNode = $("#settlement-payment-node").parent().html();
    var htmlParent = "";
    var transAmount = {};
    var denominationAmount = {};


    //********* Private Methos *****************//
    let init = () => {

        getSettlementData((data) => {
            data = list = _.sortBy(data, "endTransaction");
            var sessionId = _.uniq(_.pluck(data, "sessionId"));
            _.each(sessionId, function (x) {
                var list = _.filter(data, function (y) {
                    return y.sessionId === x;
                });
                $("#settlement-row").append(generateHtml(list));
            });
            if (data.length === 0)
                $("#settlement-row").html('');
        });
        AssignKeyEvent();
    };
    let denominationView = (id) => {
        var url = window.location.origin + "/Denomination/Details/" + id;
        window.open(url, "_blank", "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=400,width=800,height=600");

    };
    let getMinDate = (dates) => {
        var timestamps = dates.map(function (date) {
            return new Date(date).getTime();
        });
        var date = new Date(_.min(timestamps));
        var month = date.getMonth() + 1; //js start with zero
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0' + minutes : minutes;

        return date.getFullYear() + "/" + month + "/" + date.getDate() + " " + hours + ':' + minutes + ' ' + ampm;
    };
    let getMaxDate = (dates) => {
        var timestamps = dates.map(function (date) {
            return new Date(date).getTime();
        });
        var date = new Date(_.max(timestamps));
        var month = date.getMonth() + 1; //js start with zero
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';

        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0' + minutes : minutes;
        return date.getFullYear() + "/" + month + "/" + date.getDate() + " " + hours + ':' + minutes + ' ' + ampm;
    };
    let calcShortExcessAmount = (e) => {



        //for first time
        if (e === undefined) {            
            let shortExcessAmount = {
                card: denominationAmount[0].card - parseFloat(CurrencyUnFormat(transAmount.cardAmount.toString())),
                credit: denominationAmount[0].credit - parseFloat(CurrencyUnFormat(transAmount.creditAmount.toString())),
                creditNote: denominationAmount[0].creditNote - parseFloat(CurrencyUnFormat(transAmount.creditNoteAmount.toString())),
                cash: denominationAmount[0].denominationCash - parseFloat(CurrencyUnFormat(transAmount.cashAmount.toString()))
            };
            return shortExcessAmount;
        }
        else {           
            var parentDiv = $($(e).parents()[3]);

            //variables
            let transCardAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".transCardAmount").text())),
                transCreditAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".transCreditAmount").text())),
                transCreditNoteAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".transCreditNoteAmount").text())),
                transCashAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".transCashAmount").text())),
                denoCardAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".denoCardAmount").text())),
                denoCreditAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".denoCreditAmount").text())),
                denoCreditNoteAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".denoCreditNoteAmount").text())),
                denoCashAmount = parseFloat(CurrencyUnFormat(parentDiv.find(".denoCashAmount").text())),
                adjustmentCardAmount = parseFloat(parentDiv.find(".adjustmentCardAmount").val() || 0),
                adjustmentCreditAmount = parseFloat(parentDiv.find(".adjustmentCreditAmount").val() || 0),
                adjustmentCreditNoteAmount = parseFloat(parentDiv.find(".adjustmentCreditNoteAmount").val() || 0),
                adjustmentCashAmount = parseFloat(parentDiv.find(".adjustmentCashAmount").val() || 0);

            //calc
            let shortExessAmount = {
                card: denoCardAmount - transCardAmount + adjustmentCardAmount,
                credit: denoCreditAmount - transCreditAmount + adjustmentCreditAmount,
                creditNote: denoCreditNoteAmount - transCreditNoteAmount + adjustmentCreditNoteAmount,
                cash: denoCashAmount - transCashAmount + adjustmentCashAmount
            };

            //assign
            parentDiv.find(".shortAccessCardAmount").text(CurrencyFormat(shortExessAmount.card));
            parentDiv.find(".shortAccessCreditAmount").text(CurrencyFormat(shortExessAmount.credit));
            parentDiv.find(".shortAccessCreditNoteAmount").text(CurrencyFormat(shortExessAmount.creditNote));
            parentDiv.find(".shortAccessCashAmount").text(CurrencyFormat(shortExessAmount.cash));

        }
    };
    let generateHtml = (data) => {
        //first get and set payment node        
        //$("#settlement-payment-row").html('');

        //_.each(data, function (x) {
        //    x.paymentMode = x.paymentMode === "Card" ? "Card" : x.paymentMode;
        //    x.paymentMode = x.paymentMode === "Credit Note" ? "Cr. Note" : x.paymentMode;
        //    paymentNodeHtml = paymentNode;
        //    paymentNodeHtml = paymentNodeHtml.replace("$paymentMode", x.paymentMode);
        //    paymentNodeHtml = paymentNodeHtml.replace("$amount", CurrencyFormat(x.totalAmount));
        //    if (x.paymentMode === "Cash")
        //        $("#settlement-payment-row").append(paymentNodeHtml);
        //    else
        //        $("#settlement-payment-row").prepend(paymentNodeHtml);

        //});
        transAmount = {
            cardAmount: 0,
            creditAmount: 0,
            creditNoteAmount: 0,
            cashAmount: 0
        };
        denominationAmount = data;

        _.each(data, function (x) {
            if (x.paymentMode === "Card") {
                x.paymentMode = "Card";
                transAmount.cardAmount = CurrencyFormat(x.totalAmount);
            }
            else if (x.paymentMode === "Credit") {
                transAmount.creditAmount = CurrencyFormat(x.totalAmount);
            }
            else if (x.paymentMode === "Credit Note") {
                x.paymentMode = "Cr. Note";
                transAmount.creditNoteAmount = CurrencyFormat(x.totalAmount);
            }
            else if (x.paymentMode === "Cash") {
                transAmount.cashAmount = CurrencyFormat(x.totalAmount);
            }

        });


        var shortExcessAmount = calcShortExcessAmount();


        if (htmlParent === "") {
            htmlParent = $(".settlement-node").parent().html();
            $("#settlement-row").html('');
        }        
        html = htmlParent;
        html = html.replace("settlement-node", "settlement-node-items");
        html = html.replace("$id", data[0].sessionId);
        html = html.replace("$Username", data[0].userId);
        html = html.replace("$terminalName", data[0].terminalName);
        html = html.replace("$startDate", getMinDate(_.pluck(data, "startTransaction")));
        html = html.replace("$endDate", getMaxDate(_.pluck(data, "endTransaction")));


        html = html.replace("$transCardAmount", transAmount.cardAmount);
        html = html.replace("$transCreditAmount", transAmount.creditAmount);
        html = html.replace("$transCreditNoteAmount", transAmount.creditNoteAmount);
        html = html.replace("$transCashAmount", transAmount.cashAmount);

        html = html.replace("$denoCardAmount", data[0].card);
        html = html.replace("$denoCreditAmount", data[0].credit);
        html = html.replace("$denoCreditNoteAmount", data[0].creditNote);
        html = html.replace("$denoCashAmount", data[0].denominationCash);
        html = html.replace("$denominationId", data[0].denominationId);

        html = html.replace("$shortAccessCardAmount", shortExcessAmount.card);
        html = html.replace("$shortAccessCreditAmount", shortExcessAmount.credit);
        html = html.replace("$shortAccessCreditNoteAmount", shortExcessAmount.creditNote);
        html = html.replace("$shortAccessCashAmount", shortExcessAmount.cash);


        return html;
    };
    let getSettlementData = (callback) => {
        $.ajax({
            url: window.location.origin + "/Settlement/GetSettlement",
            type: "GET",
            complete: function (result) {
                if (result.status === 200) {
                    callback(result.responseJSON);
                }
            }
        });
    };
    let verifySettlement = (evt) => {
        $this = $(this.event.target);
        $parent = $(this.event.target).parent().parent();
        bootbox.confirm({
            message: "Do you want to verify ?",
            buttons: {
                cancel: {
                    label: 'Proceed',
                    className: 'btn-warning'
                },
                confirm: {
                    label: 'Go Back',
                    className: 'btn-success'
                }
            },
            callback: function (result) {               
                if (!result) {
                    var final = {
                        Settlement: {
                            SessionId: $parent.find(".Id").val(),
                            AdjustmentAmount: $parent.find(".adjustmentAmount").val() || 0
                        },
                        AdjustmentCardAmount: parseFloat($parent.find(".adjustmentCardAmount").val() || 0),
                        AdjustmentCreditAmount: parseFloat($parent.find(".adjustmentCreditAmount").val() || 0),
                        AdjustmentCreditNoteAmount: parseFloat($parent.find(".adjustmentCreditNoteAmount").val() || 0),
                        AdjustmentCashAmount: parseFloat($parent.find(".adjustmentCashAmount").val() || 0),

                        ShortExcessCardAmount: CurrencyUnFormat($(".shortAccessCardAmount").text()),
                        ShortExcessCreditAmount: CurrencyUnFormat($(".shortAccessCreditAmount").text()),
                        ShortExcessCreditNoteAmount: CurrencyUnFormat($(".shortAccessCreditNoteAmount").text()),
                        ShortExcessCashAmount: CurrencyUnFormat($(".shortAccessCashAmount").text())
                    };
                    $.ajax({
                        method: "POST",
                        url: "/Settlement/VerifySettlement",
                        data: JSON.stringify(final),
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        complete: function (result) {
                            if (result.status === 200) {
                                $parent.parent().remove();
                                StatusNotify("success", "Verified");
                            } else {
                                StatusNotify("error", "Error occur, try again later");
                            }
                        }
                    });
                }
                else {
                   
                }

            }
        });
    };

    let AssignKeyEvent = () => {

        //Mousetrap.bindGlobal('ctrl+end', function (e) {
        //    e.preventDefault(); e.stopPropagation();
        //    SaveCreditNote();
        //});

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-cancel").trigger("click");
        });


    };


    //********* Events ************************//
    //$(".adjustment").on("key", function (e) {
    //    
    //    var $this = $(e.currentTarget);
    //    if ($this.val() !== "")
    //        calcShortExcessAmount();
    //});

    //********* Public Output ****************//
    return {
        init,
        denominationView,
        verifySettlement,
        calcShortExcessAmount
    };

})();
settlement.init();