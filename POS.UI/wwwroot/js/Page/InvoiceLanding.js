const invoiceLanding = (() => {
    //********* Private Variables **************//
    let defaultMembershipId = "POS";
    let searchLocal = false;
    var grid;

    //********* Private Methos *****************//
    let init = () => {
        AssignKeyEvent();

        //focus to textbox
        $(".search-input").focus();


        //remove success messge if any after certtain time
        setTimeout(() => {
            $(".alert").hide();
            //update url too
            
            if (GetUrlParameters("StatusMessage") !== undefined)
                if (GetUrlParameters("mode") === undefined)
                    history.pushState({}, null, window.location.origin + "/SalesInvoice/Landing");
                else if (GetUrlParameters("type") == "credit")
                    history.pushState({}, null, window.location.origin + "/SalesInvoice/CrLanding?Mode=" + GetUrlParameters("mode"));
                else
                    history.pushState({}, null, window.location.origin + "/SalesInvoice/Landing?Mode=" + GetUrlParameters("mode"));

        }, 3000);

        $('#memberTable').hide();
        $('.k-grid.k-widget.k-editable').addClass("display-none");

        //initialize table to kendo grid
        grid = $("#memberTable").kendoGrid({
            height: CalcGridHeight() - 100,
            editable: true,
            sortable: false,
            scrollable: true


        });
        $('.k-grid.k-widget.k-editable').addClass("display-none");
        //new logic
        // 

        //var customerListString = JSON.stringify(customerList);
        //var customerListChunkArry = customerListString.match(/(.{1,500000})/g);
        //localStorage.setItem("customerListCount", customerListChunkArry.length);
        //_.each(customerListChunkArry, function (v, k) {

        //    localStorage.setItem("customerList_" + (k + 1), v);
        //});


        ////now get item
        //var customerFinalDataString = "";
        //for (i = 0; i <= localStorage.getItem("customerListCount"); i++) {
        //    customerFinalDataString += localStorage.getItem("customerList_" + i);
        //}
        ////localStorage.getItem("customerList", JSON.stringify(customerList));
        //var cus = JSON.parse(customerFinalDataString);
    };
    let SearchMember = (info) => {
        info = info.toLowerCase();
        if (searchLocal === false) {
            SearchMemberServer(info);
        }
        else {
            let members = _.filter(customerList, (x) => {
                let checkMemberId = !_.isEmpty(x.Membership_Number) && x.Membership_Number.toLowerCase() === info;
                let checkMemberName = !_.isEmpty(x.Name) && x.Name.toLowerCase().indexOf(info) > -1;
                let checkPhone = !_.isEmpty(x.Mobile1) && x.Mobile1.toLowerCase().indexOf(info) > -1;
                let checkOldMemberId = !_.isEmpty(x.Membership_Number_Old) && x.Membership_Number_Old.toLowerCase() === info;
                let checkBarCode = !_.isEmpty() && x.Barcode.toLowerCase() === info;
                return checkMemberId || checkMemberName || checkPhone || checkOldMemberId || checkBarCode;
            });
            DisplayMember(members);
        }
    };
    let SearchMemberServer = (info) => {

        var page = GetUrlParameters();
        var url = window.location.origin + "/Customer/SearchMembership?text=" + info;
        if (page.indexOf("CrLanding") > -1)
            url += "&customer=Credit";
        $.ajax({
            method: "POST",
            url: url,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            complete: function (result) {
                if (result.status === 200) {
                    DisplayMember(result.responseJSON);
                }
            }
        });
    };
    let DisplayMember = (list) => {
        
        $('#memberTable tbody').html('');
        if (list.length > 0) {
            $('#memberTable').show();
            $('.k-grid.k-widget.k-editable').removeClass("display-none");
        }
        else {
            $('#memberTable').hide();
            $('.k-grid.k-widget.k-editable').addClass("display-none");
        }
        _.each(list, function (v, k) {
            //add row
            var selected = k === 0 ? "class='selected'" : "";
            var html = '<tr ' + selected + '>' +
                '<td style="width:7%;">' + (k + 1).toString() + '</td>' +
                '<td class="membership-id" style="width:20%;">' + v.membership_Number + '</td>' +
                '<td style="width:40%;">' + v.name + '</td>' +
                '<td style="width:30%">' + v.mobile1 + '</td>' +
                '<td style="width:15%;"><input type="button" class="btn btn-success btn-sm" onclick="invoiceLanding.SelectMember(\'' + v.membership_Number + '\');" value="Select" /></td>' +
                '</tr>';
            $('#memberTable').append(html);
        });

    };
    let SelectMember = (membershipId) => {
        var url = window.location.origin;
        if (GetUrlParameters("mode") === undefined)
            url += "/SalesInvoice?M=" + membershipId;
        else
            url += "/SalesInvoice?M=" + membershipId + "&Mode=" + GetUrlParameters("mode");
        window.location.href = url;
    };
    let SearchChangeEvent = (evt) => {

        if (evt.keyCode === 13 || evt.keyCode === 38 || evt.keyCode === 40) {
            //continue
            if (evt.keyCode === 13) {
                let searchInfo = $(".search-input").val();
                if (searchInfo !== "" && searchInfo.length >= 0)
                    SearchMember(searchInfo);
                else {
                    $('#memberTable tbody').html('');
                    $('#memberTable').hide();
                    $('.k-grid.k-widget.k-editable').addClass("display-none");
                }
            }

        } else {
            $('#memberTable tbody').html('');
            $('#memberTable').hide();
            $('.k-grid.k-widget.k-editable').addClass("display-none");
        }
    };
    let AddMember = () => {
        $("#membership-panel").toggle();
        if ($("#membership-panel").is(":visible"))
            $("#Customer_Name").focus();
        else
            $(".search-input").focus();
    };
    let SaveMember = () => {
        $("#memberSaveButton").attr("disabled", true);
        var membership = {
            Name: $("#Customer_Name").val(),
            Mobile1: $("#Customer_Mobile").val(),
            Address: $("#Customer_Address").val(),
            Vat: $("#Customer_Vat").val(),
            Is_Member: true
        };
        if (!_.isEmpty(membership.Name) && !_.isEmpty(membership.Mobile1) && membership.Mobile1.length > 9) {
            $.ajax({
                method: "POST",
                url: "/Customer/CreateMembership",
                data: JSON.stringify(membership),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                complete: function (result) {
                    if (result.status === 200) {

                        SelectMember(result.responseJSON.membership.membership_Number);
                    }
                    else if (result.status === 409) {
                        $("#message").text(result.responseJSON.statusMessage);
                        $("#message").show();
                        $("#memberSaveButton").attr("disabled", false);
                    }
                    else {
                        $("#message").text("Member creation failed!! try again later !!");
                        $("#message").show();
                        $("#memberSaveButton").attr("disabled", false);
                    }
                }
            });
        }
        else {
            $("#message").text("Name and Mobile No. are compulsary !!");
            $("#message").show();
            $("#memberSaveButton").attr("disabled", false);
        }
    };
    let SkipPage = () => {
        
        if ($(".bootbox.modal").is(":visible")) {
            $(".bootbox.modal").modal('hide')
        }
        else {
            bootbox.confirm({
                message: "Are you sure our customer doesn't want membership ?",
                buttons: {
                    cancel: {
                        label: 'Go Back',
                        className: 'btn-warning'
                    },
                    confirm: {
                        label: 'Sure',
                        className: 'btn-success'
                    }
                },
                callback: function (result) {
                    if (result) {
                        var url = window.location.origin;
                        if (GetUrlParameters("mode") === undefined)
                            url += "/SalesInvoice?M=" + defaultMembershipId;
                        else
                            url += "/SalesInvoice?M=" + defaultMembershipId + "&Mode=" + GetUrlParameters("mode");
                        window.location.href = url;
                    }
                    else {
                        $(".search").focus();
                    }

                }
            });
        }
    };
    let AssignKeyEvent = () => {
        Mousetrap.bindGlobal('enter', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var membershipId = $('#memberTable tbody tr.selected').find(".membership-id").text();
                SelectMember(membershipId);
            }
            $(".bootbox-cancel").trigger("click");
            if ($(".memberinput").val() !== "")
                $(this).next().focus();
            else
                $(".search").focus();
        });
        Mousetrap.bindGlobal('up', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var selectedRow = $('#memberTable tbody tr.selected');
                if ($('#memberTable tbody tr:first.selected')[0] === undefined) {
                    selectedRow.removeClass("selected");
                    selectedRow.removeClass("active");
                    selectedRow.prev().addClass("selected");
                    selectedRow.prev().addClass("active");

                    let gridUp = $("#memberTable").data("kendoGrid");
                    // gridUp.select(selectedRow.prev());
                    gridUp.content.scrollTop(selectedRow.prev().position().top);
                }
                return false;

            }
        });
        Mousetrap.bindGlobal('down', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var selectedRow = $('#memberTable tbody tr.selected');
                if ($('#memberTable tbody tr:last.selected')[0] === undefined) {
                    selectedRow.removeClass("selected");
                    selectedRow.removeClass("active");
                    selectedRow.next().addClass("selected");
                    selectedRow.next().addClass("active");
                    selectedRow.next().find(".membership-id").select();

                    let gridDown = $("#memberTable").data("kendoGrid");
                    //gridDown.select(selectedRow.next());
                    gridDown.content.scrollTop(selectedRow.next().position().top - 200);
                }
                return false;
            }
        });
        Mousetrap.bindGlobal('esc', SkipPage);
        Mousetrap.bindGlobal('f2', AddMember);

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-accept").trigger("click");
        });

    };


    //********* Events ************************//
    $(".search").on("click, keyup", SearchChangeEvent);
    $("#addNewMemberButton").on("click", AddMember);
    $("#memberSaveButton").on("click", SaveMember);
    $("#memberSaveButton").on("keydown", function (e) {
        if (e.keyCode === 13)
            SaveMember();
    });
    $("#skipPage").on("click", SkipPage);

    $("#Customer_Name").keypress(function (evt) {
        if (evt.keyCode === 13)
            $("#Customer_Mobile").focus();
    });
    $("#Customer_Mobile").keypress(function (evt) {
        if (evt.keyCode === 13)
            $("#Customer_Address").focus();
    });
    $("#Customer_Address").keypress(function (evt) {
        if (evt.keyCode === 13)
            $("#memberSaveButton").focus();
    });
    $("#Customer_Vat").keypress(function (evt) {
        if (evt.keyCode === 13)
            $("#memberSaveButton").focus();
    });

    //********* Public Output ****************//
    return {
        init,
        SelectMember
    };

})();
invoiceLanding.init();