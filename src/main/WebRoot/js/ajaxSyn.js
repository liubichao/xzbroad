function getAjaxText(rUrl,rData,datatype){
    var str = $.ajax({
        type : "post",
        url : rUrl,
        data : rData,
        dataType :datatype,
        async : false
    }).responseText;
    return str;
}