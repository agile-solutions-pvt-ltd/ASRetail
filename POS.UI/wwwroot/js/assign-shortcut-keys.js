//update new keyboard
Mousetrap.addKeycodes({
    19: 'pause'
});



//open new sales invoice from any page
Mousetrap.bindGlobal('ctrl+alt+i', function (e) {  
    e.preventDefault(); e.stopPropagation();
    window.location = window.location.origin + "/SalesInvoice/Landing";
});

//open new Tax invoice from any page
Mousetrap.bindGlobal('ctrl+alt+t', function (e) {
    e.preventDefault(); e.stopPropagation();
    window.location = window.location.origin + "/SalesInvoice/Landing?mode=tax";
});
//open new Credit Note from any page
Mousetrap.bindGlobal('ctrl+alt+c', function (e) {
    e.preventDefault(); e.stopPropagation();
    window.location = window.location.origin + "/CreditNote";
});

//open new Credit Note from any page
Mousetrap.bindGlobal('ctrl+f1', function (e) {
    e.preventDefault(); e.stopPropagation();
    window.location = window.location.origin + "/Settings/Shortcuts";
});



//*************START SALES INVOICE ***********************************//

////for barcode textbox focus
//Mousetrap.bindGlobal('ctrl+b', function () {   
//    let barcodeTextBox = $("#item_code");
//    if (!_.isEmpty(barcodeTextBox)) {
//        barcodeTextBox.focus();
//    }
//});

////for barcode textbox focus
//Mousetrap.bindGlobal('ctrl+q', function () {
//    let quantityTextBox = $(".Quantity:first");
//    if (!_.isEmpty(quantityTextBox)) {
//        quantityTextBox.focus();
//    }
//});

////for save sales invoice
//Mousetrap.bindGlobal('ctrl+end', function () {
//    let saveButton = $("#NextButton");
//    if (!_.isEmpty(saveButton)) {
//        saveButton.trigger('click');
//    }
//});

////for hold transaction 
//Mousetrap.bindGlobal('ctrl+alt+p', function () {       
//    if (!_.isEmpty(invoice)) {
//        invoice.holdTransaction();
//    }
//});


////for display hold transactions
//Mousetrap.bindGlobal('f2', function () {    
//    if (!_.isEmpty(invoice)) {
//        invoice.showPausedTransaction();
//    }
//});

//*************END SALES INVOICE ***********************************//


//*************START SALES INVOICE BILLING *************************//
//Mousetrap.bindGlobal('esc', function () {
//    if (typeof bill !== 'undefined') {
//        bill.handleBackButtonEvent();
//    }
//});
//*************END SALES INVOICE BILLING *************************//
