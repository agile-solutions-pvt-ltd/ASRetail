const denomination = (() => {
    //variable
    let R1000 = $("#R1000"), R1000Total = $("#R1000Total"),
        R500 = $("#R500"), R500Total = $("#R500Total"),
        R250 = $("#R250"), R250Total = $("#R250Total"),
        R100 = $("#R100"), R100Total = $("#R100Total"),
        R50 = $("#R50"), R50Total = $("#R50Total"),
        R25 = $("#R25"), R25Total = $("#R25Total"),
        R20 = $("#R20"), R20Total = $("#R20Total"),
        R10 = $("#R10"), R10Total = $("#R10Total"),
        R5 = $("#R5"), R5Total = $("#R5Total"),
        R2 = $("#R2"), R2Total = $("#R2Total"),
        R1 = $("#R1"), R1Total = $("#R1Total"),
        R05 = $("#R05"), R05Total = $("#R05Total"),
        Ric = $("#Ric"), RicTotal = $("#RicTotal"),
        Rcheque = $("#Cheque"),
        RdebitCard = $("#Debit_Card"),
        Rother = $("#Other"),
        Total = $("#Total");

    let icRate = 1.6;

   

    //methods
    let init = () => {

        //set todays date
       
        
        if (verifydate != null) {
            var verifydate = document.getElementById("startingdate").value;
        }
        else {
            $("#Date").val(FormatForDisplay(new Date()));
            $("#Date").trigger('change');
        }
       
        
        calcAmount();
      

        //make edit denomination uneditable
        
        $('#detail-form :input').attr('readonly', 'readonly');
        $("#print").removeAttr('readonly');
        $(".total").attr("readonly", "readonly");
    };

    

    let calcAmount = () => {

        
        let totalAmount = 0;
        if (!_.isEmpty(R1000.val())) {
            let R1000Value = parseFloat(R1000.val()) * 1000;
            R1000Total.val(R1000Value.toFixed(2));
            totalAmount += R1000Value;
        }
        if (!_.isEmpty(R500.val())) {
            let R500Value = parseFloat(R500.val()) * 500;
            R500Total.val(R500Value.toFixed(2));
            totalAmount += R500Value;
        }
        if (!_.isEmpty(R250.val())) {
            let R250Value = parseFloat(R250.val()) * 250;
            R250Total.val(R250Value.toFixed(2));
            totalAmount += R250Value;
        }
        if (!_.isEmpty(R100.val())) {
            let R100Value = parseFloat(R100.val()) * 100;
            R100Total.val(R100Value.toFixed(2));
            totalAmount += R100Value;
        }
        if (!_.isEmpty(R50.val())) {
            let R50Value = parseFloat(R50.val()) * 50;
            R50Total.val(R50Value.toFixed(2));
            totalAmount += R50Value;
        }
        if (!_.isEmpty(R25.val())) {
            let R25Value = parseFloat(R25.val()) * 25;
            R25Total.val(R25Value.toFixed(2));
            totalAmount += R25Value;
        }
        if (!_.isEmpty(R20.val())) {
            let R20Value = parseFloat(R20.val()) * 20;
            R20Total.val(R20Value.toFixed(2));
            totalAmount += R20Value;
        }
        if (!_.isEmpty(R10.val())) {
            let R10Value = parseFloat(R10.val()) * 10;
            R10Total.val(R10Value.toFixed(2));
            totalAmount += R10Value;
        }
        if (!_.isEmpty(R5.val())) {
            let R5Value = parseFloat(R5.val()) * 5;
            R5Total.val(R5Value.toFixed(2));
            totalAmount += R5Value;
        }
        if (!_.isEmpty(R2.val())) {
            let R2Value = parseFloat(R2.val()) * 2;
            R2Total.val(R2Value.toFixed(2));
            totalAmount += R2Value;
        }
        if (!_.isEmpty(R1.val())) {
            let R1Value = parseFloat(R1.val()) * 1;
            R1Total.val(R1Value.toFixed(2));
            totalAmount += R1Value;
        }
        if (!_.isEmpty(R05.val())) {
            let R05Value = parseFloat(R05.val()) * 0.5;
            R05Total.val(R05Value.toFixed(2));
            totalAmount += R05Value;
        }
        if (!_.isEmpty(Ric.val())) {
            let RicValue = parseFloat(Ric.val()) * icRate;
            RicTotal.val(RicValue.toFixed(2));
            totalAmount += RicValue;
        }
        if (!_.isEmpty(Rcheque.val())) {
            totalAmount += parseFloat(Rcheque.val());
        }
        if (!_.isEmpty(RdebitCard.val())) {
            totalAmount += parseFloat(RdebitCard.val());
        }
        if (!_.isEmpty(Rother.val())) {
            totalAmount += parseFloat(Rother.val());
        }

        //total Calculations
        Total.val(totalAmount.toFixed(2));

    };
    
    
    

   
    //events
    $("#R1000,#R500,#R250,#R100,#R50,#R25,#R20,#R10,#R5,#R2,#R1,#R05,#Ric,#Cheque,#Debit_Card,#Other").on("keyup", calcAmount);
  
    $()

    $("#Date").datepicker()
        .change(function () {
            $('#Date_BS').val(AD2BS(FormatForInput($('#Date').val())));
        });
    
    $('#Date_BS').nepaliDatePicker({
        onChange: function () {
            $('#Date').val(FormatForDisplay(BS2AD($('#Date_BS').val())));

        }
    });

    $("#submitbtn").on("click", function () {
        bootbox.alert("Hello world!", function () {
            console.log("Alert Callback");
        });
    });

    $("#print").on('click', function () {
        var data = {
            DenominationData: denominationData,
            Store: store
        };
        printer.PrintDenomination(data, function () {

        });
    });

    //output
    return {
        init: init
    };

})();
denomination.init();
