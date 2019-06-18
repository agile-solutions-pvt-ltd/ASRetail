const invoiceLanding = (() => {
    //********* Private Variables **************//



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
                else
                    history.pushState({}, null, window.location.origin + "/SalesInvoice/Landing?Mode=")+ GetUrlParameters("mode");
                
        }, 3000);

        $('#memberTable').hide();
    };
    let SearchMember = (info) => {       
        let members = _.filter(customerList, (x) => {
            let checkMemberId = x.Membership_Number === info;
            let checkMemberName = x.Name.toLowerCase().indexOf(info) > -1;
            let checkPhone = x.Mobile1.toLowerCase().indexOf(info) > -1;
            return checkMemberId || checkMemberName || checkPhone;
        });
        DisplayMember(members);
    };
    let DisplayMember = (list) => {
        $('#memberTable tbody').html('');
        if (list.length > 0)
            $('#memberTable').show();
        else
            $('#memberTable').hide();
        _.each(list, function (v, k) {
            //add row
            var selected = k === 0 ? "class='selected'" : "";
            var html = '<tr ' + selected + '>' +
                '<td>' + (k + 1).toString() + '</td>' +
                '<td class="membership-id">' + v.Membership_Number + '</td>' +
                '<td>' + v.Name + '</td>' +
                '<td>' + v.Mobile1 + '</td>' +
                '<td><input type="button" class="btn btn-success btn-sm" onclick="invoiceLanding.SelectMember(' + v.Membership_Number + ');" value="Select" /></td>' +
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
        } else {
            let searchInfo = $(".search-input").val();
            if (searchInfo !== "" && searchInfo.length >= 3)
                SearchMember(searchInfo);
            else {
                $('#memberTable tbody').html('');
                $('#memberTable').hide();
            }
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
        var membership = {
            Name: $("#Customer_Name").val(),
            Mobile1: $("#Customer_Mobile").val(),
            Address: $("#Customer_Address").val(),
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
                    }

                }
            });
        }
        else {
            $("#message").text("Name and Mobile No. are compulsary !!");
            $("#message").show();
        }
    };
    let SkipPage = () => {
        bootbox.confirm({
            message: "Are you sure our customer doesn't want membership ?",
            buttons: {
                cancel: {
                    label: 'Sure',
                    className: 'btn-warning'
                },
                confirm: {
                    label: 'Go Back',
                    className: 'btn-success'
                }
            },
            callback: function (result) {
                
                if (!result) {
                    var url = window.location.origin;
                    if (GetUrlParameters("mode") === undefined)
                        url += "/SalesInvoice";
                    else
                        url += "/SalesInvoice?Mode=" + GetUrlParameters("mode");
                    window.location.href = url;
                }
               
            }
        });




       
    };
    let AssignKeyEvent = () => {
        Mousetrap.bindGlobal('enter', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var membershipId = $('#memberTable tbody tr.selected').find(".membership-id").text();
                SelectMember(membershipId);
            }
        });
        Mousetrap.bindGlobal('up', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var selectedRow = $('#memberTable tbody tr.selected');
                if ($('#memberTable tbody tr:first.selected')[0] === undefined) {
                    selectedRow.removeClass("selected");
                    selectedRow.prev().addClass("selected");
                }
                return false;

            }
        });
        Mousetrap.bindGlobal('down', function () {
            if ($('#memberTable tbody tr').length > 0) {
                var selectedRow = $('#memberTable tbody tr.selected');
                if ($('#memberTable tbody tr:last.selected')[0] === undefined) {
                    selectedRow.removeClass("selected");
                    selectedRow.next().addClass("selected");
                }
                return false;
            }
        });
        Mousetrap.bindGlobal('esc', SkipPage);
        Mousetrap.bindGlobal('f2', AddMember);

        Mousetrap.bindGlobal('shift+enter', function (e) {
            e.preventDefault(); e.stopPropagation();
            $(".bootbox-cancel").trigger("click");
        });

    };


    //********* Events ************************//
    $(".search").on("click, keyup", SearchChangeEvent);
    $("#addNewMemberButton").on("click", AddMember);
    $("#memberSaveButton").on("click", SaveMember);
    $("#skipPage").on("click", SkipPage);

    //********* Public Output ****************//
    return {
        init,
        SelectMember
    };

})();
invoiceLanding.init();