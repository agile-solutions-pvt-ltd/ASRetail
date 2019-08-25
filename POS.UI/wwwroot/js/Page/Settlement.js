const settlement = (() => {
    //********* Private Variables **************//
    var paymentNode = $("#settlement-payment-node").parent().html();
    var htmlParent = "";
    var transAmount = {};
    var denominationAmount = {};
    var adjustmentAmount = {};
    var startdate = "";
    var enddate = "";
    var test = "";
    $("#filer").on('click', function () {


        let url = window.location.origin + "/Settlement/Index?startdate=" + $("#startdatepicker").val() + "&enddate=" + $("#enddatepicker").val();


        window.location.href = url;
        
       


    });
    $("#VerifyList").on('click', function () {


        let url = window.location.origin + "/Settlement/Index?startdate=" + $("#startdatepicker").val() + "&enddate=" + $("#enddatepicker").val()+"&status="+"verified";


        window.location.href = url;




    });
   
    //********* Private Methos *****************//
    let init = () => {
      
       
        var startdate = document.getElementById("startdatepicker").value;
        var enddate = document.getElementById("enddatepicker").value;
        var status = document.getElementById("VerifyList").value;
        startdate = formatDate(startdate);
        enddate = formatDate(enddate);


       // console.log("startdate", startdate)       
        $("#startdatepicker").datepicker({
                onSelect: function (date) {
                    startdate = date;
                    console.log(startdate);
                }


            }).on("change", function () {
                startdate = startdate;
            });
        $('#startdatepicker').datepicker('setDate', startdate);

            $("#enddatepicker").datepicker({
                onselect: function (date) {
                    enddate = date;
                    console.log(enddate);
                }
            }).on("change", function () {
                enddate = enddate;
            });
        $('#enddatepicker').datepicker('setDate', enddate);
        

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
        var url = window.location.origin + "/Denomination/Details/" + id ;

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
                card: CurrencyFormat(denominationAmount[0].card - parseFloat(CurrencyUnFormat(transAmount.cardAmount.toString())) + adjustmentAmount.cardAmount),
                credit: CurrencyFormat(denominationAmount[0].credit - parseFloat(CurrencyUnFormat(transAmount.creditAmount.toString())) + adjustmentAmount.creditAmount),
                creditNote: CurrencyFormat(denominationAmount[0].creditNote - parseFloat(CurrencyUnFormat(transAmount.creditNoteAmount.toString())) + adjustmentAmount.creditNoteAmount),
                cash: CurrencyFormat(denominationAmount[0].denominationCash - parseFloat(CurrencyUnFormat(transAmount.cashAmount.toString())) + adjustmentAmount.cashAmount)
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
                transAmount.cardAmount += parseFloat(x.totalAmount);
            }
            else if (x.paymentMode === "Credit") {
                transAmount.creditAmount += parseFloat(x.totalAmount);
            }
            else if (x.paymentMode === "Credit Note") {
                x.paymentMode = "Cr. Note";
                transAmount.creditNoteAmount += parseFloat(x.totalAmount);
            }
            else if (x.paymentMode === "Cash") {
                transAmount.cashAmount += parseFloat(x.totalAmount);
            }

        });
        transAmount.cashAmount = CurrencyFormat(transAmount.cashAmount);
        transAmount.creditAmount = CurrencyFormat(transAmount.creditAmount);
        transAmount.creditNoteAmount = CurrencyFormat(transAmount.creditNoteAmount);
        transAmount.cardAmount = CurrencyFormat(transAmount.cardAmount);




        //var shortExcessAmount = calcShortExcessAmount();


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

        html = html.replace("$denoCardAmount", CurrencyFormat(data[0].card));
        html = html.replace("$denoCreditAmount", CurrencyFormat(data[0].credit));
        html = html.replace("$denoCreditNoteAmount", CurrencyFormat(data[0].creditNote));
        html = html.replace("$denoCashAmount", CurrencyFormat(data[0].denominationCash));
        html = html.replace("$denominationId", CurrencyFormat(data[0].denominationId));

        //for adjustment amount
        adjustmentAmount = {
            cardAmount: 0,
            creditAmount: 0,
            creditNoteAmount: 0,
            cashAmount: 0
        };
        _.each(data, function (x) {
            if (x.paymentMode === "Card") {
                html = html.replace("$adjCardAmount", x.adjustmentAmount);
                adjustmentAmount.cardAmount = x.adjustmentAmount;
            }
            else if (x.paymentMode === "Credit") {
                html = html.replace("$adjCreditAmount", x.adjustmentAmount);
                adjustmentAmount.creditAmount = x.adjustmentAmount;
            }
            else if (x.paymentMode === "Credit Note") {
                html = html.replace("$adjCreditNoteAmount", x.adjustmentAmount);
                adjustmentAmount.creditNoteAmount = x.adjustmentAmount;
            }
            else if (x.paymentMode === "Cash") {
                html = html.replace("$adjCashAmount", x.adjustmentAmount);
                adjustmentAmount.cashAmount = x.adjustmentAmount;
            }

        });
        //if not found then assign zero
        html = html.replace("$adjCardAmount", 0);
        html = html.replace("$adjCreditAmount", 0);
        html = html.replace("$adjCreditNoteAmount", 0);
        html = html.replace("$adjCashAmount", 0);

        var shortExcessAmount = calcShortExcessAmount();
        html = html.replace("$shortAccessCardAmount", shortExcessAmount.card);
        html = html.replace("$shortAccessCreditAmount", shortExcessAmount.credit);
        html = html.replace("$shortAccessCreditNoteAmount", shortExcessAmount.creditNote);
        html = html.replace("$shortAccessCashAmount", shortExcessAmount.cash);
        //if (GetUrlParameters("status") == "verified") {
        //    //for shortexcess amount
        //    _.each(data, function (x) {
        //        if (x.paymentMode === "Card") {
        //            html = html.replace("$shortAccessCardAmount", x.shortExcessAmount);
        //        }
        //        else if (x.paymentMode === "Credit") {
        //            html = html.replace("$shortAccessCreditAmount", x.shortExcessAmount);
        //        }
        //        else if (x.paymentMode === "Credit Note") {
        //            html = html.replace("$shortAccessCreditNoteAmount", x.shortExcessAmount);
        //        }
        //        else if (x.paymentMode === "Cash") {
        //            html = html.replace("$shortAccessCashAmount", x.shortExcessAmount);
        //        }

        //    });
        //    //if not found then assign zero       
        //    html = html.replace("$shortAccessCardAmount", "0");
        //    html = html.replace("$shortAccessCreditAmount", "0");
        //    html = html.replace("$shortAccessCreditNoteAmount", "0");
        //    html = html.replace("$shortAccessCashAmount", "0");
        //}
        //else {
        //    var shortExcessAmount = calcShortExcessAmount();
        //    html = html.replace("$shortAccessCardAmount", shortExcessAmount.card);
        //    html = html.replace("$shortAccessCreditAmount", shortExcessAmount.credit);
        //    html = html.replace("$shortAccessCreditNoteAmount", shortExcessAmount.creditNote);
        //    html = html.replace("$shortAccessCashAmount", shortExcessAmount.cash);
        //}


        return html;
    };
    let getSettlementData = (callback) => {
        $(".theme-loader").css({ "background-color": "", "display": "block" });   
        var url = window.location.origin + "/Settlement/GetSettlement?startdate=" + $("#startdatepicker").val() + "&enddate=" + $("#enddatepicker").val() + "&status=" + $("#VerifyList").val();
            //$("#enddatepicker").val();
        if ($("#VerifyList").val()=="verified") {
            
            $(".VerifyButton").hide();

        }
        else {
            $(".PrintButton").hide(); 
        }
       
        $.ajax({
            url: url,
            type: "GET",
            complete: function (result) {
                           
                if (result.status === 200) {
                    callback(result.responseJSON);
                   
                }
               // $(".theme-loader").css({ "background-color": "#fff", "display": "none" });
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
                    var final = {
                        Settlement: {
                            SessionId: $parent.find(".Id").val(),
                            AdjustmentAmount: $parent.find(".adjustmentAmount").val() || 0
                        },
                        AdjustmentCardAmount: parseFloat($parent.find(".adjustmentCardAmount").val() || 0),
                        AdjustmentCreditAmount: parseFloat($parent.find(".adjustmentCreditAmount").val() || 0),
                        AdjustmentCreditNoteAmount: parseFloat($parent.find(".adjustmentCreditNoteAmount").val() || 0),
                        AdjustmentCashAmount: parseFloat($parent.find(".adjustmentCashAmount").val() || 0),

                        ShortExcessCardAmount: CurrencyUnFormat($parent.find(".shortAccessCardAmount").text()),
                        ShortExcessCreditAmount: CurrencyUnFormat($parent.find(".shortAccessCreditAmount").text()),
                        ShortExcessCreditNoteAmount: CurrencyUnFormat($parent.find(".shortAccessCreditNoteAmount").text()),
                        ShortExcessCashAmount: CurrencyUnFormat($parent.find(".shortAccessCashAmount").text())
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

                               
                                //print
                                printer.PrintSettlement(result.responseJSON);

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
    let formatDate = (dates) => {



        var date = new Date(dates);
        var month = date.getMonth() + 1; //js start with zero




        return month + "/" + date.getDate() + "/" + date.getFullYear();
    };
    let AssignKeyEvent = () => {

        //Mousetrap.bindGlobal('ctrl+end', function (e) {
        //    e.preventDefault(); e.stopPropagation();
        //    SaveCreditNote();
        //});
        Mousetrap.bindGlobal('enter', function (e) {
            $(".bootbox-cancel").trigger("click");
        });
        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });
        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });


    };

    let dateFilter = () => {
        init();
    };

    let printSettlement = (evt) => {
        $this = $(this.event.target);
        $parent = $(this.event.target).parent().parent();
        var session = $parent.find(".Id").val();
        $.ajax({
            method: "GET",
            url: "/Settlement/GetSettlementById?session=" + session,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200) {
                    //print
                    printer.PrintSettlement(result.responseJSON);
                }
            }           
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
        calcShortExcessAmount,
        printSettlement,
        dateFilter
       
    };

})();
settlement.init();