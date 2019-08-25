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
function FormatForDisplayTime(timespan) {
    let arr = timespan.split(":");
    let hour = arr[0];
    let ampm = "AM";
    let minute = arr[1];
    if (hour > 12) {
        hour = hour - 12;
        ampm = "PM";
    }
    let formatted_date = hour + ":" + minute + " " + ampm;
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
Number.prototype.toFixed = function (decimalPlaces) {
    //first roundoff
    var firstResult = math.round(parseFloat(this), decimalPlaces + 9);
    //second roundoff
    var secondResult = math.round(firstResult, decimalPlaces);
    return secondResult.toString();
};
Number.prototype.toFixedDecimal = function (decimalPlaces) {
    //first roundoff
    var firstResult = math.round(parseFloat(this), decimalPlaces + 9);
    //second roundoff
    var secondResult = math.round(firstResult, decimalPlaces);
    return secondResult;
};
//Number.prototype.toFixed = function (decimalPlaces) {
//    //first roundoff
//    var factor = Math.pow(10, decimalPlaces + 9 || 0);
//    var v = (Math.round(this * factor) / factor).toString();
//    var firstResult = 0;
//    if (v.indexOf('.') >= 0) {
//        firstResult = v + factor.toString().substr(v.length - v.indexOf('.'));
//    } else
//        firstResult = v + '.' + factor.toString().substr(1);

//    //second roundoff
//    var factor = Math.pow(10, decimalPlaces || 0);
//    var v = (Math.round(firstResult * factor) / factor).toString();
//    var secondResult = 0
//    if (v.indexOf('.') >= 0) {
//        secondResult = v + factor.toString().substr(v.length - v.indexOf('.'));
//    } else
//        secondResult = v + '.' + factor.toString().substr(1);

//    return secondResult;
//};


function CurrencyFormat(amount) {
    let amountFloat = parseFloat(amount);
    let isNegative = false;
    if (isNaN(amountFloat))
        amountFloat = 0;
    if (amountFloat < 0) {
        amountFloat = Math.abs(amountFloat);
        isNegative = true;
    }
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
    }
    else
        formattedAmout = amount + afterDotValue;

    if (isNegative)
        return "-" + formattedAmout;
    else
        return formattedAmout;
}

function CurrencyUnFormat(amount) {
    amount = amount.replace(/,/g, '');
    if ($.isNumeric(amount))
        return parseFloat(amount);
    else
        return NaN;
}

function NumberFormat(num) {
    let numInt = parseInt(num);
    if (isNaN(numInt))
        num = 0;
    else
        num = numInt.toString();
    let formattedNum = 0;
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


function GetClientLocalIP(callback) {

    window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;//compatibility for Firefox and chrome
    var pc = new RTCPeerConnection({ iceServers: [] }), noop = function () { };
    pc.createDataChannel('');//create a bogus data channel
    //pc.createOffer(pc.setLocalDescription.bind(pc), noop);// create offer and set local description

    pc.createOffer().then(function (offer) {
        return pc.setLocalDescription(offer);
    });

    pc.onicecandidate = function (ice) {

        if (ice && ice.candidate && ice.candidate.candidate) {
            var myIP = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/.exec(ice.candidate.candidate)[1];
            callback(myIP);
            pc.onicecandidate = noop;
        }
    };
}


function StatusNotify(type, message) {
    new PNotify({
        title: type,
        text: message,
        nonblock: {
            nonblock: true
        },
        type: type,
        addclass: type === 'success' ? 'bg-success' : 'bg-danger',
        closer: true,
        closer_hover: true,
        sticker: true,
        sticker_hover: true
    });
}


function toCamel(o) {
    var newO, origKey, newKey, value
    if (o instanceof Array) {
        return o.map(function (value) {
            if (typeof value === "object") {
                value = toCamel(value)
            }
            return value
        })
    } else {
        newO = {}
        for (origKey in o) {
            if (o.hasOwnProperty(origKey)) {
                newKey = (origKey.charAt(0).toLowerCase() + origKey.slice(1) || origKey).toString()
                value = o[origKey]
                if (value instanceof Array || (value !== null && value.constructor === Object)) {
                    value = toCamel(value)
                }
                newO[newKey] = value
            }
        }
    }
    return newO
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
                    $("." + val.menu.name.replace(/ /g, "_")).css("display", "block !important");
                    $("." + val.menu.name.replace(/ /g, "_")).show();
                });
            }
        }
    });
})();



//function resizeGrid() {
//    var gridElement = $("#grid"),
//        dataArea = $(".k-grid-content"),
//        gridHeight = gridElement.innerHeight(),
//        documentHeight = $(window).height(),
//        otherElements = $(document).children().not(".k-grid-content"),
//        otherElementsHeight = 0;
//    otherElements.each(function () {
//        otherElementsHeight += $(this).outerHeight();
//    });
//   // gridElement.height = gridHeight - otherElementsHeight;
//    $(".k-grid").attr("style", "height:auto");
//    
//    var gridH = documentHeight - otherElementsHeight - 300;
//    dataArea.attr("style", "height: " + (documentHeight - 50).toString() + "px");  
//}
function CalcGridHeight() {
    var viewportHeight = $(window).height();
    return viewportHeight - 212;
}
function PageSlimScroll() {
    var viewportHeight = $(window).height();
    //$('body').slimScroll({
    //    height: viewportHeight + 'px',
    //    color: '#455A64',
    //    distance: '0',
    //    allowPageScroll: true,
    //    alwaysVisible: false
    //});
    $("body").mCustomScrollbar({
        axis: "y",
        autoHideScrollbar: false,
        scrollInertia: 100,
        theme: "minimal",
    });

}
$(window).resize(function () {
    PageSlimScroll();
    //reset height according to screen

    // resizeGrid();

    $(".k-grid-content").height(CalcGridHeight() - 15);
    $(".k-grid").height("auto");
});

// toggle full screen
function toggleFullScreen() {
    var a = $(window).height() - 10;

    if (!document.fullscreenElement && // alternative standard method
        !document.mozFullScreenElement && !document.webkitFullscreenElement) { // current working methods
        if (document.documentElement.requestFullscreen) {
            document.documentElement.requestFullscreen();
        } else if (document.documentElement.mozRequestFullScreen) {
            document.documentElement.mozRequestFullScreen();
        } else if (document.documentElement.webkitRequestFullscreen) {
            document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
        }
    } else {
        if (document.cancelFullScreen) {
            document.cancelFullScreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        }
    }
}

//light box
$(document).on('click', '[data-toggle="lightbox"]', function (event) {
    event.preventDefault();
    $(this).ekkoLightbox();
});

$(document).ready(function () {
    var $window = $(window);
    //add id to main menu for mobile menu start
    var getBody = $("body");
    var bodyClass = getBody[0].className;
    $(".main-menu").attr('id', bodyClass);
    //add id to main menu for mobile menu end

    // card js start
    var emailbody = $(window).height();
    $('.user-body').css('min-height', emailbody);
    $(".card-header-right .icofont-close-circled").on('click', function () {
        var $this = $(this);
        $this.parents('.card').animate({
            'opacity': '0',
            '-webkit-transform': 'scale3d(.3, .3, .3)',
            'transform': 'scale3d(.3, .3, .3)'
        });

        setTimeout(function () {
            $this.parents('.card').remove();
        }, 800);
    });
    //$("#styleSelector .style-cont").slimScroll({
    //    height: '100%',
    //    allowPageScroll: false,
    //    wheelStep: 5,
    //    color: '#999',
    //    animate: true
    //});
    $(".card-header-right .icofont-rounded-down").on('click', function () {
        var $this = $(this);
        var port = $($this.parents('.card'));
        var card = $(port).children('.card-block').slideToggle();
        $(this).toggleClass("icon-up").fadeIn('slow');
    });
    $(".icofont-refresh").on('mouseenter mouseleave', function () {
        $(this).toggleClass("rotate-refresh").fadeIn('slow');
    });
    $("#more-details").on('click', function () {
        $(".more-details").slideToggle(500);
    });
    $(".mobile-options").on('click', function () {
        $(".navbar-container .nav-right").slideToggle('slow');
    });
    // card js end

    //Menu layout end

    /*chatbar js start*/
    /*chat box scroll*/
    //var a = $(window).height() - 50;
    //$(".main-friend-list").slimScroll({
    //    height: a,
    //    allowPageScroll: false,
    //    wheelStep: 5,
    //    color: '#1b8bf9'
    //});


    // /*chatbar js end*/

    //Language chage dropdown start

    //Language chage dropdown end
    //loader start
    $('.theme-loader').fadeOut(300);
    //loader end







    //////browser closed event
    //var validNavigation = false;
    //function wireUpWindowUnloadEvents() {

    //    // Attach the event keypress to exclude the F5 refresh
    //    $(document).on('keypress', function (e) {
    //        if (e.keyCode === 116) {
    //            validNavigation = true;
    //        }
    //    });

    //    // Attach the event click for all links in the page
    //    $(document).on("click", "a", function () {
    //        validNavigation = true;
    //    });

    //    // Attach the event submit for all forms in the page
    //    $(document).on("submit", "form", function () {
    //        validNavigation = true;
    //    });

    //    // Attach the event click for all inputs in the page
    //    $(document).bind("click", "input[type=submit]", function () {
    //        validNavigation = true;
    //    });
    //    $(document).bind("click", "input[type=button]", function () {
    //        validNavigation = true;
    //    });

    //    $(document).bind("click", "button[type=submit]", function () {
    //        validNavigation = true;
    //    });

    //}



    //function windowCloseEvent() {
    //    window.onbeforeunload = function () {
    //        if (!validNavigation) {
    //            callServerForBrowserCloseEvent();
    //        }
    //    };
    //}
    //wireUpWindowUnloadEvents();
    //windowCloseEvent();

    //// Broad cast that your're opening a page.
    //localStorage.openpages = Date.now();
    //var onLocalStorageEvent = function (e) {
    //    if (e.key == "openpages") {
    //        // Listen if anybody else opening the same page!
    //        localStorage.page_available = Date.now();
    //    }
    //    if (e.key == "page_available") {
    //        alert("One more page already open");
    //    }
    //};
    //window.addEventListener('storage', onLocalStorageEvent, false);

    function callServerForBrowserCloseEvent() {
        $.ajax({
            method: "POST",
            url: "/Account/BrowserClose",
            dataType: "json",
            contentType: "application/json; charset=utf-8"
        });
    }
});
