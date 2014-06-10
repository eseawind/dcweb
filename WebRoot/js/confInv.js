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
        if (nowPage !=allpage){
    		nowPage=nowPage+1;
    		$('#page').val(nowPage+'');
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
	return {
		init:function(){init();}
	}
}();

var confPmuView = function(){
	
	function viewPmu(psno){
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
			 infos= infos+"    <td width='50%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PSNO+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td width='50%'  background='images/listbg29.gif' class='black2'>"+ress[0]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td   background='images/listbg29.gif' class='black2'>"+ress[1]+"</td>";
			 infos= infos+"  </tr>";
			 infos= infos+"  <tr>";
			 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVTYPENAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
			 infos= infos+"    <td  background='images/listbg29.gif' class='black2'>"+ress[8]+"</td>";
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
	return {
		init:function(aa){viewPmu(aa);}
	}
}();
var ssno="";
function downDevInfo(ssno2,nowDay){
	
	ssno=ssno2;
		var infos="<table height='100%' width='100%' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PSNO+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ssno+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.RES_DATA_LIST_D+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'><input id=\"startdate\" size=\"13\" class=\"Wdate\" type=\"text\" name=\"occdt1\" value='"+nowDay+"' onFocus=\"WdatePicker({maxDate:'',lang:'<%= lang %>'})\" />--<input id='enddate' size='13' class='Wdate' type='text' name='occdt2' value='"+nowDay+"' onfocus=\"WdatePicker({minDate:'',maxDate:'2050-01-01',lang:'<%= lang %>'})\"/></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' colspan='2' align='center'><input type='button' class='button1' value='"+RES.RES_DOWNLOAD_TYPE_TXT+"'   style='cursor:pointer' onclick='downTxt()'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button1' value='"+RES.RES_DOWNLOAD_TYPE_CSV+"'   style='cursor:pointer' onclick='downCsv()'/></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"</table>";
		art.dialog({
		    title: RES.CONF_DOWNDATA,
			width:500,
			height: 100,
		    content: infos
		});

	
}
function downTxt(){
	downForm.lsno.value=ssno;
	downForm.startdt.value=$('#startdate').val();
	downForm.enddt.value=$('#enddate').val();
	downForm.tp.value="2";
	downForm.submit();
	
}
function downCsv(){
	downForm.lsno.value=ssno;
	downForm.startdt.value=$('#startdate').val();
	downForm.enddt.value=$('#enddate').val();
	downForm.tp.value="1";
	downForm.submit();
	
}
function downInvTxt(){
	downInvForm.lsno.value=$('#listno').val();
	downInvForm.stationName.value=$('#stationName').val();
	downInvForm.model.value=$('#type').val();
	downInvForm.tp.value="2";
	downInvForm.submit();
	
}
function downInvCsv(){
	downInvForm.lsno.value=$('#listno').val();
	downInvForm.stationName.value=$('#stationName').val();
	downInvForm.model.value=$('#type').val();
	downInvForm.tp.value="1";
	downInvForm.submit();
	
}