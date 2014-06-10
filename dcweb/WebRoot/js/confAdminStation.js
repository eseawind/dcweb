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


var confAdminStation = function(){
	var flag=false;
	function init(){

		$('#searchImg').bind('click',submitForm);
		$('#firstP').bind('click',firstPage);
		$('#preP').bind('click',prePage);
		$('#lastP').bind('click',lastPage);
		$('#nextP').bind('click',nextPage);
		$('#countryId').bind('change',changeCountry);

	}
	
	function submitForm(){
		$('#pageNo').val('1');
		$("#searchForm").submit();
	}
	function firstPage(){
		$('#pageNo').val('1');
		$("#searchForm").submit();		
	}
	function lastPage(){
		$('#pageNo').val($('#totalPage').val());
		$("#searchForm").submit();		
	}
	function prePage(){
		var nowPage=parseInt($('#pageNo').val());
        if (nowPage !=1)
        	{
        		nowPage=nowPage-1;
        		$('#pageNo').val(nowPage+'');
        		$("#searchForm").submit();
        	}
				
	}
	function nextPage(){
		var nowPage=parseInt($('#pageNo').val());
		var allpage=parseInt($('#totalPage').val());
		
        if (nowPage !=allpage)
        	{
        		nowPage=nowPage+1;
        		$('#pageNo').val(nowPage+'');
        		$("#searchForm").submit();	
        	}
			
	}
	
	function viewPmu(psno){
		alert(psno);
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

	function changeCountry(){
		var country = $("#countryId>option:selected").val();
		var url = "stateListAjax.action";
		var datajson = {"countryId":country};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: frushState,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
		
	}
	function frushState(data, textStatus, jqXHR){
		var dat=data.data;
		var stateObj=document.getElementById("state");

		 for (var i = stateObj.options.length-1; i >=1; i--) {        
		                stateObj.options.remove(i);     
		 }  
		 var states=dat.split(";");
		 for (var i=0;i<states.length;i++){
			 var state=states[i].split(",");
			 var varItem = new Option(state[1], state[0]);      
		        stateObj.options.add(varItem);  
			 
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
			var infos="<table width='100%' border='0' cellspacing='0' cellpadding='0'>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>usedspace:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[0]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>totalspace:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[1]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>state:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[2]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>softver:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[3]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>hardwver:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[4]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";			
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>llip:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[5]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif'><div align='right'><strong>lldt:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='62%'  background='images/listbg29.gif'>"+ress[6]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"</table>";
			art.dialog({
			    title: '属性',
				width: 300,
				height: 150,
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



//关注电站
function Attention(stationId, obj){
	var url = "updateStationAttention.action";
	var datajson = {"stationId":stationId, "state":"1"};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: attentionres,
        error: function () {
            alert("");
        }
    });
}

function attentionres(data, textStatus, jqXHR){
	location.reload();
}

//取消关注电站
function unAttention(stationId, obj){
	var url = "updateStationAttention.action";
	var datajson = {"stationId":stationId, "state":"0"};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: unattentionres,
        error: function () {
            alert("");
        }
    });
}

function unattentionres(data, textStatus, jqXHR){
	location.reload();
}












