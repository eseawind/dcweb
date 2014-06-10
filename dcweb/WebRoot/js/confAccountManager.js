var changeLange = function(locales){
	
			$("#langlocale").val(locales);
			$("#langform").submit();
		}
var langSel = function(){
	function doOpen(popid){
		var popdisplay = $("#"+popid).css("display");
		if(popdisplay=="none"){
			$("#"+popid).css("display","block");
		}else{
			$("#"+popid).css("display","none");
		}
		$("#"+popid).mouseleave(function(e){
				doClose(popid);
		});
		var selitems = $(".lang_tp");
		selitems.mouseenter(function(e){
			oversel($(this));
		});
		selitems.mouseleave(function(e){
			outsel($(this));
		});
	}
	function doClose(popid){
		$("#"+popid).css("display","none");
	}
	function doClick(obj){
	   var locallang = $(obj).attr("vtitle");
	   changeLange(locallang);
	}
	function oversel(obj){
		obj.css("background","#ddf8ff");
	}
	function outsel(obj){
		obj.css("background","#fff");
	}
	
	return{
		open : function(popid){doOpen(popid);},
		close: function(popid){doClose(popid);},
		click: function(obj){doClick(obj);},
		outsel: function(obj){alert($(event));  outsel(obj);},
		oversel: function(obj){oversel(obj);}
	}
}();


var confAccountManager = function(){
	var flag=false;
	function init(){

		$('#searchImg').bind('click',submitForm);
		$('#firstP').bind('click',firstPage);
		$('#preP').bind('click',prePage);
		$('#lastP').bind('click',lastPage);
		$('#nextP').bind('click',nextPage);
		

	}
	
	
	function submitForm(){
		$("#page").val("1");
					$("#searchForm").submit();
	}
	function firstPage(){
		$('#page').val('1');
		$("#searchForm").submit();		
	}
	function lastPage(){
		$('#page').val($('#totalPage').val());
		$("#searchForm").submit();		
	}
	function prePage(){
		var nowPage=parseInt($('#page').val());
        if (nowPage !=1)
        	{
        		nowPage=nowPage-1;
        		$('#page').val(nowPage+'');
        		$("#searchForm").submit();
        	}
				
	}
	function nextPage(){
		var nowPage=parseInt($('#page').val());
		var allpage=parseInt($('#totalPage').val());
		
        if (parseInt(nowPage)<parseInt(allpage))
        	{
        		nowPage=nowPage+1;
        		$('#page').val(nowPage+'');
        		$("#searchForm").submit();	
        	}
			
	}
	return {
		init:function(){init();}
	}
}();
function activeAccount(id){
	
	if(confirm("是否确认激活该账号？")){
	var url = "userActiveAdmin.action";
	
	
	var datajson = {"yourId":id};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: responseActiveAccount,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	}

}
function  responseActiveAccount(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		alert("账号激活成功！");
		location.reload();
	}else{
		alert("账号激活失败！");
		
	}
	
}
