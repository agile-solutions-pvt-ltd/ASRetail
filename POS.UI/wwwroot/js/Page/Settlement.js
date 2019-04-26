const settlement = (() => {
    //********* Private Variables **************//
    var paymentNode = $("#settlement-payment-node").parent().html();
    var htmlParent = "";


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
    let generateHtml = (data) => {
        //first get and set payment node        
        $("#settlement-payment-row").html('');

        _.each(data, function (x) {
            x.paymentMode = x.paymentMode === "Debit Card" ? "Card" : x.paymentMode;
            paymentNodeHtml = paymentNode;
            paymentNodeHtml = paymentNodeHtml.replace("$paymentMode", x.paymentMode);
            paymentNodeHtml = paymentNodeHtml.replace("$amount", CurrencyFormat(x.totalAmount));
            if (x.paymentMode === "Cash")
                $("#settlement-payment-row").append(paymentNodeHtml);
            else
                $("#settlement-payment-row").prepend(paymentNodeHtml);

        });



        if (htmlParent === "") {
            htmlParent = $(".settlement-node").parent().html();
            $("#settlement-row").html('');
        }

        html = htmlParent;
        html = html.replace("settlement-node", "settlement-node-items");
        html = html.replace("$Username", data[0].userName);
        html = html.replace("$terminalName", data[0].terminalName);
        html = html.replace("$startDate", getMinDate(_.pluck(data, "startTransaction")));
        html = html.replace("$endDate", getMaxDate(_.pluck(data, "endTransaction")));
        html = html.replace("$denominationAmount", CurrencyFormat(data[0].denominationAmount));
        html = html.replace("$denominationId", data[0].denominationId);

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
    //********* Events ************************//

    //********* Public Output ****************//
    return {
        init,
        denominationView
    };

})();
settlement.init();