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


var confFindEvent = function(){
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
		var err = $("#errcode").val();
		var reg = /^\d+$/;

		if(err.match(reg) || err==""){
			$("#searchForm").submit();
		}else{
			alert("错误代码只能为数字 ! ");
		}
	}
	
	function firstPage(){
		$('#page').val('1');
		var err = $("#errcode").val();
		var reg = /^\d+$/;

		if(err.match(reg) || err==""){
			$("#searchForm").submit();
		}else{
			alert("错误代码只能为数字 ! ");
		}
		//$("#searchForm").submit();		
	}
	function lastPage(){
		$('#page').val($('#totalPage').val());
		var err = $("#errcode").val();
		var reg = /^\d+$/;

		if(err.match(reg) || err==""){
			$("#searchForm").submit();
		}else{
			alert("错误代码只能为数字 ! ");
		}
		//$("#searchForm").submit();		
	}
	function prePage(){
		var nowPage=parseInt($('#page').val());
        if (nowPage !=1)
        	{
        		nowPage=nowPage-1;
        		$('#page').val(nowPage+'');
        		var err = $("#errcode").val();
        		var reg = /^\d+$/;

        		if(err.match(reg) || err==""){
        			$("#searchForm").submit();
        		}else{
        			alert("错误代码只能为数字 ! ");
        		}
        		//$("#searchForm").submit();
        	}
				
	}
	function nextPage(){
		var nowPage=parseInt($('#page').val());
		var allpage=parseInt($('#totalPage').val());
		
        if (parseInt(nowPage)<parseInt(allpage))
        	{
        		nowPage=nowPage+1;
        		$('#page').val(nowPage+'');
        		var err = $("#errcode").val();
        		var reg = /^\d+$/;

        		if(err.match(reg) || err==""){
        			$("#searchForm").submit();
        		}else{
        			alert("错误代码只能为数字 ! ");
        		}
        		//$("#searchForm").submit();	
        	}
			
	}
	return {
		init:function(){init();}
	}
}();
function viewPmu(psno){
	var url = "pmuInfoView.action";
	var datajson = {"listno":psno};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: listPmuInfo,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function listPmuInfo(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		var res=data.res;
		var ress=res.split(";");
		var infos="<table width='500' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_USEDSPACE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[0]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif'><div align='right' class='black2'><strong>"+RES.PMU_TOTALSPACE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[1]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td height='38'  background='images/listbg29.gif'><div align='right' class='black2'><strong>"+RES.PMU_STATE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[2]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_SOFTVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[3]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_HARDWVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[4]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";			
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_LLIP+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[5]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_LLDT+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[6]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"</table>";
		art.dialog({
		    title: '属性',
			width: 500,
			height: 150,
		    content: infos
		});

	}else{
		if(data.errorcode == "0"){
			alert('bb');
		}

		
	}
}
function viewInv(psno){
	var url = "invInfoView.action";
	var datajson = {"listno":psno};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: listInvInfo,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function listInvInfo(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		var res=data.res;
		var ress=res.split(";");
		var infos="<table width='500' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.CREATEDT+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[0]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[1]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.FACTORYNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[2]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PENPAI+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[3]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.SOFTVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[4]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";			
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.HARDVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[5]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.E_TOTAL+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[6]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.H_TOTAL+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[7]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVTYPENAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[8]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"</table>";
		art.dialog({
		    title: '属性',
			width: 500,
			height: 150,
		    content: infos
		});

	}else{
		if(data.errorcode == "0"){
			alert('bb');
		}

		
	}
}
