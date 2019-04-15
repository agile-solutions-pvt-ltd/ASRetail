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
