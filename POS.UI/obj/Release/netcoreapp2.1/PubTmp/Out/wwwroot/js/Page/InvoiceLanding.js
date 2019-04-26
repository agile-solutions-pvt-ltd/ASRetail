const invoiceLanding = (() => {
    //********* Private Variables **************//



    //********* Private Methos *****************//
    let init = () => {
        AssignKeyEvent();

        //focus to textbox
        $(".search-input").focus();

        $('#memberTable').hide();
    };
    let SearchMember = (info) => {
        let members = _.filter(customerList, (x) => {
            let checkMemberId = x.Member_Id === parseInt(info);
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
                '<td class="membership-id">' + v.Member_Id + '</td>' +
                '<td>' + v.Name + '</td>' +
                '<td>' + v.Mobile1 + '</td>' +
                '<td><input type="button" class="btn btn-success btn-sm" onclick="invoiceLanding.SelectMember(' + v.Member_Id + ');" value="Select" /></td>' +
                '</tr>';
            $('#memberTable').append(html);
        });

    };
    let SelectMember = (membershipId) => {
        var url = window.location.origin;
        if (GetUrlParameters("mode") === undefined)
            url +=  "/SalesInvoice?M=" + membershipId;
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
        Mousetrap.bindGlobal('esc', function () {
            var url = window.location.origin;
            if (GetUrlParameters("mode") === undefined)
                url += "/SalesInvoice";
            else
                url += "/SalesInvoice?Mode=" + GetUrlParameters("mode");
            window.location.href = url;
        });

    };


    //********* Events ************************//
    $(".search").on("click, keyup", SearchChangeEvent);




    //********* Public Output ****************//
    return {
        init,
        SelectMember
    };

})();
invoiceLanding.init();