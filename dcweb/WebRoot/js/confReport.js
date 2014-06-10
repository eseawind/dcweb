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

var confReportDay = function(){
	var flag=false;
	function init(){
		$('#savereport').bind('click',saveReport);
		$('#sendreport').bind('click',sendReport);
	}
	function saveReport(){
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked){
			state="0";
			if(!recieverList.match(reg) && recieverList!=""){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
				return false;
			}
		}
		else if(ds[1].checked){
			state="1";
		}
		var repFormat="0";
		var sendTime = $('#sendTime').val();
		ds = document.getElementsByName("itemstr");
		var itemstr="1,1,1,1,1,1,1";
        var url = "reportDay.action";
		var datajson = {"reportId":reportId,"state":state,"recieverList":recieverList,"repFormat":repFormat,"sendTime":sendTime,"itemstr":itemstr};
		$.ajax({
			type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: putres,
            error: function(){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}
	    });
	}
	function putres(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_OK,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
		else{
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_ERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
	}
	function sendReport(){
		var stationName=$('#plantnametip').html();
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked){
			state="0";
		}
		else if(ds[1].checked)
			state="1";
		if(!recieverList.match(reg)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		if (recieverList==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAIL,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var repFormat="0";
		var sendTime=$('#sendTime').val();
		ds = document.getElementsByName("itemstr");
		var itemstr="1,1,1,1,1,1,1";
        var url = "sendReportDay.action";
		var datajson = {"stationName":stationName,"reportId":reportId,"state":state,"recieverList":recieverList,"repFormat":repFormat,"sendTime":sendTime,"itemstr":itemstr};
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_CONFIG_REPORT_SEND_OK,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: sendres,
            error: function () {
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}
	    });
	}
	function sendres(data, textStatus, jqXHR){
	}
	return {
		init:function(){init();}
	}
}();

function changeReportId(obj){
	document.changeForm.reportId.value=obj.value;
	document.changeForm.submit();
}

var confReportMon = function(){
	var flag=false;
	function init(){
		$('#savereport').bind('click',saveReport);
		$('#sendreport').bind('click',sendReport);
	}
	function saveReport(){
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked){
			state="0";
			if(!recieverList.match(reg) && recieverList!=""){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
				return false;
			}
		}
		else if(ds[1].checked){
			state="1";
		}	
		var repFormat="0";
		var itemstr="1,1,1,1,1,1,1";
        var url = "reportMon.action";
		var datajson = {"reportId":reportId,"state":state,"recieverList":recieverList,"repFormat":repFormat,"itemstr":itemstr};
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: putres,
            error: function () {
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}
	    });
	}
	function putres(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_OK,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
		else{
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_ERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
	}
	
	function sendReport(){
		var stationName=$('#plantnametip').html();
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked)
			state="0";
		else if(ds[1].checked)
			state="1";
		if(!recieverList.match(reg)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		if (recieverList==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAIL,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var repFormat="0";
		var sendTime=$('#sendTime').val();
		ds = document.getElementsByName("itemstr");
		var itemstr="1,1,1,1,1,1,1";
        var url = "sendReportMonth.action";
		var datajson = {"stationName":stationName,"reportId":reportId,"state":state,"recieverList":recieverList,"repFormat":repFormat,"sendTime":sendTime,"itemstr":itemstr};
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_CONFIG_REPORT_SEND_OK,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: sendres,
            error: function () {
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
            }
	    });
	}
	function sendres(data, textStatus, jqXHR){
	}
	return {
		init:function(){init();}
	}
}();


var confReportEvent = function(){
	var flag=false;
	function init(){
		$('#savereport').bind('click',saveReport);
		$('#sendreport').bind('click',sendReport);
	}
	function saveReport(){
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked)
			state="0";
			if(!recieverList.match(reg) && recieverList!=""){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
				return false;
			}
		else if(ds[1].checked)
			state="1";
		var recieverList=$('#recieverList').val();
		var repFormat="0";
		var nextdelay;
		var nextdelayval=$('#nextdelayval').val();
		nextdelay=nextdelayval;
		var maxeventlimit="999";
		var re = /^(\d+)(\.?)(\d{0,10})$/; 
		if (nextdelay=="" || !re.test(nextdelay)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_IN_TIMESPLIT,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		if (parseInt(maxeventlimit)<5 || parseInt(maxeventlimit)>1000 || !re.test(maxeventlimit)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_IN_MAXLIMIT_ERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var emptysend="1";
		ds = document.getElementsByName("itemstr");
		var itemstr="0,1";
        var url = "reportEvent.action";
		var datajson = {"reportId":reportId,"state":state,"nextdelay2":nextdelayval,"recieverList":recieverList,"repFormat":repFormat,"emptysend":emptysend,"maxeventlimit":maxeventlimit,"itemstr":itemstr};
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: putres,
            error: function () {
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
            }
	    });
	}
	function putres(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_OK,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
		else{
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SAVE_ERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
		}
	}

	function sendReport(){
		var stationName=$('#plantnametip').html();
		var reportId=$('#reportId').val();
		var state;
		var ds = document.getElementsByName("state");
		var recieverList=$('#recieverList').val();
		var reg = /^\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(\;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*(\;)*\s*$/;
		if(ds[0].checked)
			state="0";
		else if(ds[1].checked)
			state="1";
		var repFormat="0";
		if(!recieverList.match(reg)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAILEX,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		if (recieverList==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_SEND_MAIL,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var nextdelayval=$('#nextdelayval').val();
		var emptysend="1";
		var maxeventlimit="999";
		var re = /^(\d+)(\.?)(\d{0,10})$/; 
		if (nextdelayval=="" || !re.test(nextdelayval)){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_IN_TIMESPLIT,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
        var itemstr="1,"+maxeventlimit;
        itemstr=itemstr+",0";
        itemstr=itemstr+",1";
        /*
        ds = document.getElementsByName("itemstr");
        var selectitem=false;
        for(var i = 0 ; i < ds.length ;i++){
        	if(ds[i].checked){
        		itemstr=itemstr+",1";
       			selectitem=true;
            }
        	else{
        		itemstr=itemstr+",0";
        	}
        }
        if (!selectitem){
        	art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_CONFIG_REPORT_IN_NEEDTYPE_ERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
        	return false;
        }
        */
        var startdt=$('#startdate').val();
        var enddt=$('#enddate').val();
        itemstr=itemstr+","+startdt+" 00:00:00,"+enddt+" 23:59:59";
        var s1=startdt+" 00:00:00";
        var s2=enddt+" 23:59:59";
        s1 = s1.replace(/-/g, "/");
        s2 = s2.replace(/-/g, "/");
		s1 = new Date(s1);
		s2 = new Date(s2);
		var days= s2.getTime() - s1.getTime();
		if (days<0){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_REPORT_EVENT_DATE_ERR1,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		days = parseInt(days / (1000 * 60 * 60 * 24));
		if (days>7){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.RES_REPORT_EVENT_DATE_ERR2,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
        var url = "sendReportEvent.action";
		var datajson = {"stationName":stationName,"reportId":reportId,"state":state,"recieverList":recieverList,"repFormat":repFormat,"itemstr":itemstr,"startDt":startdt,"endDt":enddt,"emptysend":emptysend};
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_CONFIG_REPORT_SEND_OK,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: sendres,
            error: function () {
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.REQUESTWRONG,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
            }
	    });
	}
	function sendres(data, textStatus, jqXHR){
	}
	return {
		init:function(){init();}
	}
}();