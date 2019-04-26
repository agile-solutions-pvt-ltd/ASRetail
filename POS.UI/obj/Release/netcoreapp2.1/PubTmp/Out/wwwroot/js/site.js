// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

//some common functions
function FormatForDisplay(date) {
    let current_datetime = new Date(date);
    let formatted_date = ("0" + (current_datetime.getMonth() + 1)).slice(-2) + "/" + ("0" + current_datetime.getDate()).slice(-2) + "/" + current_datetime.getFullYear();
    return formatted_date;
}
function FormatForInput(date) {
    let current_datetime = new Date(date);
    let formatted_date = current_datetime.getFullYear() + "-" + (current_datetime.getMonth() + 1) + "-" + current_datetime.getDate();
    return formatted_date;
}
function GetUrlParameters(sParam) {
    if (sParam === undefined) {
        var sPageURL = window.location.href;
        var indexOfLastSlash = sPageURL.lastIndexOf("/");

        if (indexOfLastSlash > 0 && sPageURL.length - 1 !== indexOfLastSlash)
            return sPageURL.substring(indexOfLastSlash + 1);
        else
            return 0;
    }
    else {
        sParam = sParam.toLowerCase();
        var sPageURL1 = window.location.search.substring(1),
            sURLVariables = sPageURL1.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0].toLowerCase() === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    }
}
function SetUrlParameters(url, sParamArr) {    
    if (_.isEmpty(url))
        return false;
    if (_.isEmpty(sParamArr))
        return url;


    var param = sParamArr.join("&");
    if (url.indexOf("?") > -1)
        return url + "&" + param;
    else
        return url + "?" + param;

}

$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

function CurrencyFormat(amount) {   
    let amountFloat = parseFloat(amount);
    if (isNaN(amountFloat))
        amountFloat = 0;
    amount = amountFloat.toFixed(2);
    let formattedAmout = 0;
    let afterDotValue = "";
    if (amount.indexOf('.') > -1) {
        afterDotValue = amount.substring(amount.indexOf('.'));
        amount = amount.substring(0, amount.indexOf('.'));
    }
    if (amount.length > 3) {
        //first split last 3 digit
        let lastdigit = amount.substring(amount.length - 3);
        let remainingDigit = amount.substring(0, amount.length - 3);
        //then split in every 2 digit
        formattedAmout = remainingDigit.replace(/(\d)(?=(\d{2})+(?!\d))/g, '$1,');
        formattedAmout += "," + lastdigit + afterDotValue;
        return formattedAmout;
    }
    else
        return amount + afterDotValue;    
}

function CurrencyUnFormat(amount) {
    return parseFloat(amount.replace(/,/g, ''));
}

function NumberFormat(num) {
    let numInt = parseInt(num);
    if (isNaN(numInt))
        num = 0;
    else
        num = numInt.toString();
    let formattedNum =0;
    if (num.length > 3) {
        //first split last 3 digit
        let lastdigit = num.substring(num.length - 3);
        let remainingDigit = num.substring(0, num.length - 3);
        //then split in every 2 digit
        formattedNum = remainingDigit.replace(/(\d)(?=(\d{2})+(?!\d))/g, '$1,');
        formattedNum += "," + lastdigit;
        return formattedNum;
    }
    else
        return num; 
    //return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
}




//menu permission restriction
(() => {
    $.ajax({
        method: "GET",
        url: "/Account/RoleWiseMenuPermission",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        complete: function (result) {           
            if (result.status === 200) {
                _.each(result.responseJSON, function (val) {
                    $("." + val.menu.name.replace(/ /g, "_")).show();
                });
            }
        }
    });
})();
