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

var confPmu = function(){
	var flag=false;
	function init(){
		$('#searchImg').bind('click',submitForm);
		$('#firstP').bind('click',firstPage);
		$('#preP').bind('click',prePage);
		$('#lastP').bind('click',lastPage);
		$('#nextP').bind('click',nextPage);
	}
	function submitForm(){
		$('#page').val('1');
		$("#searchForm").submit();
	}
	function firstPage(){
		$('#page').val('1');
		$("#searchForm").submit();		
	}
	function lastPage(){
		$('#page').val($('#allPage').val());
		$("#searchForm").submit();		
	}
	function prePage(){
		var nowPage=parseInt($('#page').val());
        if (nowPage !=1){
    		nowPage=nowPage-1;
    		$('#page').val(nowPage+'');
    		$("#searchForm").submit();
    	}
	}
	function nextPage(){
		var nowPage=parseInt($('#page').val());
		var allpage=parseInt($('#allPage').val());
        if (nowPage != allpage){
    		nowPage=nowPage+1;
    		$('#page').val(nowPage+'');
    		$("#searchForm").submit();	
    	}
	}
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
			alert('aa');
		}else{
			if(data.errorcode == "0"){
				alert('bb');
			}
		}
	}
	return {
		init:function(){init();}
	}
}();

var confPmuView = function(){
	
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
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>电站名称:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[0]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>序列号:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[1]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>注册码:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[2]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>类型:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[3]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>型号:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[4]+"</td>";
			 infos= infos+"  </tr>";
			 
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>自动升级:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[5]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>需要升级:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[6]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_USEDSPACE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[7]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif'><div align='right' class='black2'><strong>"+RES.PMU_TOTALSPACE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[8]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td height='38'  background='images/listbg29.gif'><div align='right' class='black2'><strong>"+RES.PMU_STATE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[9]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_SOFTVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[10]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_HARDWVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[11]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";			
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_LLIP+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[12]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";			
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_CURGATE+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[13]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PMU_LLDT+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[14]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"</table>";
			art.dialog({
			    title: '属性',
				width: 500,
				height: 300,
			    content: infos
			});

		}else{
			if(data.errorcode == "0"){
				alert('bb');
			}

			
		}
	}
	return {
		init:function(aa){viewPmu(aa);}
	}
}();
function downPmuTxt(){
	downPmuForm.lsno.value=$('#listno').val();
	downPmuForm.type.value=$('#type').val();
	downPmuForm.model.value=$('#model').val();
	downPmuForm.searchOnline.value=$('#searchOnline').val();
	downPmuForm.hardver.value=$('#hardver').val();
	downPmuForm.softver.value=$('#softver').val();
	downPmuForm.autoupdate.value=$('#autoupdate').val();
	downPmuForm.needupdate.value=$('#needupdate').val();
	downPmuForm.tp.value="2";
	downPmuForm.submit();
	
}
function downPmuCsv(){
	downPmuForm.lsno.value=$('#listno').val();
	downPmuForm.type.value=$('#type').val();
	downPmuForm.model.value=$('#model').val();
	downPmuForm.searchOnline.value=$('#searchOnline').val();
	downPmuForm.hardver.value=$('#hardver').val();
	downPmuForm.softver.value=$('#softver').val();
	downPmuForm.autoupdate.value=$('#autoupdate').val();
	downPmuForm.needupdate.value=$('#needupdate').val();
	downPmuForm.tp.value="1";
	downPmuForm.submit();
	
}

function selectnos(obj){
	var nos=document.getElementsByName("selectno");
	for (var i=0;i<nos.length;i++){
		nos[i].checked=obj.checked;
	}
}

function openUpdate(){
	var nos=document.getElementsByName("selectno");
	var pons="";
	for (var i=0;i<nos.length;i++){
		if (nos[i].checked){
			if (pons==""){
				pons=nos[i].value;
			}else{
				pons=pons+","+nos[i].value;
			}			
		}		
	}
	if (pons==""){
		alert(RES.CONF_PUMLIST_SELECTPUM);
		return false;
	}
	var url = "setPmuUpdate.action";
	var datajson = {"psnos":pons,"status":1};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: openUpdateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function openUpdateres(data, textStatus, jqXHR){
	var nos=document.getElementsByName("selectno");
	for (var i=0;i<nos.length;i++){
		if (nos[i].checked){			
			var s="sp"+nos[i].value+".innerHTML='"+RES.CONF_PUMLIST_UPDATEST_AUTO+"';";
			eval(s);	
		}		
	}
}

function closeUpdate(){
	var nos=document.getElementsByName("selectno");
	var pons="";
	for (var i=0;i<nos.length;i++){
		if (nos[i].checked){
			if (pons==""){
				pons=nos[i].value;
			}else{
				pons=pons+","+nos[i].value;
			}			
		}		
	}
	if (pons==""){
		alert(RES.CONF_PUMLIST_SELECTPUM);
		return false;
	}
	var url = "setPmuUpdate.action";
	var datajson = {"psnos":pons,"status":0};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: closeUpdateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}
function closeUpdateres(data, textStatus, jqXHR){
	var nos=document.getElementsByName("selectno");
	for (var i=0;i<nos.length;i++){
		if (nos[i].checked){			
			var s="sp"+nos[i].value+".innerHTML='"+RES.CONF_PUMLIST_UPDATEST_CLOSE+"';";
			eval(s);	
		}		
	}
}
function nowUpdate(){
	var nos=document.getElementsByName("selectno");
	var pons="";
	for (var i=0;i<nos.length;i++){
		if (nos[i].checked){
			if (pons==""){
				pons=nos[i].value;
			}else{
				pons=pons+","+nos[i].value;
			}			
		}		
	}
	if (pons==""){
		alert(RES.CONF_PUMLIST_SELECTPUM);
		return false;
	}
	if (confirm(RES.CONF_PUMLIST_SETUPDATE_COM)) {
		var url = "setPmuUpdate.action";
		var datajson = {"psnos":pons,"status":9};
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: nowUpdateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    	});
	 }
}

function nowUpdateres(data, textStatus, jqXHR){
	alert(RES.CONF_PUMLIST_SETUPLOAD_OK);
	//location.reload();
}
