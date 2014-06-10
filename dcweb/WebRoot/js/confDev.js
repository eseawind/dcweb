
Date.prototype.format =function(format)
    {
        var o = {
        "M+" : this.getMonth()+1, //month
"d+" : this.getDate(),    //day
"h+" : this.getHours(),   //hour
"m+" : this.getMinutes(), //minute
"s+" : this.getSeconds(), //second
"q+" : Math.floor((this.getMonth()+3)/3),  //quarter
"S" : this.getMilliseconds() //millisecond
        }
        if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
        (this.getFullYear()+"").substr(4- RegExp.$1.length));
        for(var k in o)if(new RegExp("("+ k +")").test(format))
        format = format.replace(RegExp.$1,
        RegExp.$1.length==1? o[k] :
        ("00"+ o[k]).substr((""+ o[k]).length));
        return format;
    }

var changeLange = function(locales)
{
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

var confDev = function(){
	var flag=false;
	function init(){
		$('#addDev').bind('click',addDevOpt);
		$('#delDev').bind('click',delDevOpt);
	}
	
	//添加监控器
	function addDevOpt(){
		var stationId=jQuery.trim($('#stationId').val());
		var listno=jQuery.trim($('#listno').val());
		var serialno=jQuery.trim($('#serialno').val());
		if (listno==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_INPUT_PSNO,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		if (serialno==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_INPUT_SERIALNO,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var opdate =new Date().format('yyyy-MM-dd hh:mm:ss');
		var url = "bindPmu.action";
		var datajson = {"stationId":stationId,"listno":listno,"serialno":serialno,"opdate":opdate};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: addDevRes,
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
	function addDevRes(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_ADDPUM_SUCCESS,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			location.reload();
		}else{
			if(data.errorcode == "0"){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.CONF_ADDPUM_ERR_NODIFINE,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}else if(data.errorcode == "1"){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.CONF_ADDPUM_ERR_PSNOERR,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}else if(data.errorcode == "2"){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.CONF_ADDPUM_ERR_PSNUSED,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}else if(data.errorcode=="3"){
				art.dialog({
					width:300,
					height:50,
					title:"Solarcloud Message",
					content:RES.CONF_ADDPUM_ERR_NOSTATION,
					ok:function(){},
					okValue:RES.CONF_ART_OK
				});
			}
			return false;
		}
		
	}
	function delDevOpt(){
		var stationId=jQuery.trim($('#stationId').val());
		var listno=jQuery.trim($('#listno').val());
		if (listno==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_INPUT_PSNODEL,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		var serialno=jQuery.trim($('#serialno').val());
		if (serialno==""){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_INPUT_SERIALNO,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.SUREDELPMU,
			ok:function(){
				var url = "unbindPmu.action";
				var opdate =new Date().format('yyyy-MM-dd hh:mm:ss');
				var datajson = {"stationId":stationId,"listno":listno,"serialno":serialno,"opdate":opdate};
				$.ajax({
				    type: "POST",
				    url: url,
				    dataType: "json",
				    data: datajson,
				    success: delDevRes,
				    error: function () {
						art.dialog({
							width:300,
							height:50,
							title:"Solarcloud Message",
							content:RES.REQUESTWRONG,
							ok:function(){},
							okValue:RES.CONF_ART_OK,
						});    
				    }
				});
			},
			okValue:RES.CONF_ART_OK,
			cancel:function(){},
			cancelValue:RES.CONF_ART_CANCEL
		});  
	}
	function delDevRes(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_DELPUM_SUCCESS,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			location.reload();
		}else if (data.errorcode == '2'){
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_DELPUM_ERR_PSNOERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}else if (data.errorcode == '1'){			
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_DELPUM_ERR_PSNOERR,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}else{
			art.dialog({
				width:300,
				height:50,
				title:"Solarcloud Message",
				content:RES.CONF_DELPUM_ERR_NODIFINE,
				ok:function(){},
				okValue:RES.CONF_ART_OK
			});
			return false;
		}
	}
	return {
		init:function(){init();}
	}
}();


	
function viewDev(psno){
	var url = "devInfoView.action";
	var datajson = {"listno":psno};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: listDevInfo,
        error: function () {
            alert(RES.REQUESTWRONG);
        }
    });
	
}
	
function listDevInfo(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		var res=data.res;
		var ress=res.split(";");
		var infos="<table width='380' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PSNO+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[0]+"</td>";
		 infos= infos+"  </tr>";
		 var  typeName="";
		 if(parseInt(ress[1])==1)
			 typeName=RES.RES_CONFIG_DEV_MONITOR;
		 else
			 typeName=RES.RES_CONFIG_DEV_INVERTER;
		 
		 //2013-04-19  小向修改
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVMODELNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+typeName+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[2]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";			
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.DEVTYPENAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[5]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.FACTORYNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[7]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PENPAI+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[8]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.SOFTVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[3]+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.HARDVER+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[4]+"</td>";
		 infos= infos+"  </tr>";
/*		 
		 //2013-04-02修改，新增E_Total
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.E_TOTAL_EX+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ress[6]+"</td>";
		 infos= infos+"  </tr>";
*/		 
		 infos= infos+"</table>";
		 art.dialog({
		    title: RES.ATTR,
			width: 400,
			height: 150,
		    content: infos
		});

	}else{
		if(data.errorcode == "0"){
			alert('bb');
		}

		
	}
}
	
var ssno;
function setDevInfo(ssno2,byn){
	ssno=ssno2;
	var infos="<table width='380' border='0' cellspacing='0' cellpadding='0'>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PSNO+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ssno+"</td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.OLDBYNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+byn+"</td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.BYNAME+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='62%'  background='images/listbg29.gif'><input type='text' id='byname' size='20' maxlength='20'></td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' colspan='2' align='center'><input type='button' class='button1' value='"+RES.PZINVOK+"'  id='delDev' style='cursor:pointer' onclick='setDevName()'/></td>";
	infos= infos+"  </tr>";
	infos= infos+"</table>";
	art.dialog({
	    title: RES.CONF_SET,
		width: 400,
		height: 50,
	    content: infos
	});
}
	
function setDevName(){
	var byn=jQuery.trim($('#byname').val());
	//正则表达式匹配,不能输入半角全角的引号
	var reg = '^[^’`\'\']+$';
	if (byn==""){
		alert(RES.CONF_INPUT_BYNAME);
		return false;
	}
	if(!byn.match(reg)){
		alert(RES.CONF_INPUT_BYNAME_FORMAT);
		return false;
	}
	var url = "setDevByName.action";
	var datajson = {"listno":ssno,"byName":byn};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: closeDiv,
        error: function () {
            alert(RES.REQUESTWRONG);
        }
    });
}

function closeDiv(){
	var ds = document.getElementsByTagName("div");
    location.href=location.href;
}
	
var ssno="";
function downDevInfo(ssno2,byn,nowDay){
	ssno=ssno2;
	var infos="<table width='500' border='0' cellspacing='0' cellpadding='0'>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.PSNO+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'>"+ssno+"</td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>"+RES.RES_DATA_LIST_D+":&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='62%'  background='images/listbg29.gif' class='black2'><input id=\"startdate\" size=\"13\" class=\"Wdate\" type=\"text\" name=\"occdt1\" value='"+nowDay+"' onFocus=\"WdatePicker({maxDate:'',lang:'<%= lang %>'})\" />--<input id='enddate' size='13' class='Wdate' type='text' name='occdt2' value='"+nowDay+"' onfocus=\"WdatePicker({minDate:'',maxDate:'2050-01-01',lang:'<%= lang %>'})\"/></td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='38%' height='38'  background='images/listbg29_1.gif' colspan='2' align='center'><input type='button' class='button1' value='"+RES.RES_DOWNLOAD_TYPE_TXT+"'   style='cursor:pointer' onclick='downTxt()'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button1' value='"+RES.RES_DOWNLOAD_TYPE_CSV+"'   style='cursor:pointer' onclick='downCsv()'/></td>";
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
	if(downForm.startdt.value>downForm.enddt.value){
		alert(RES.CONF_INPUT_DATE);
		return false;
	}
	downForm.tp.value="2";
	downForm.submit();
}

function downCsv(){
	downForm.lsno.value=ssno;
	downForm.startdt.value=$('#startdate').val();
	downForm.enddt.value=$('#enddate').val();
	if(downForm.startdt.value>downForm.enddt.value){
		alert(RES.CONF_INPUT_DATE);
		return false;
	}
	downForm.tp.value="1";
	downForm.submit();
	
}
//删除
function deleteDev(isno){
	art.dialog({
		width:300,
		height:50,
		title:"Solarcloud Message",
		content:RES.CONF_DELETE_INV,
		ok:function(){
			var url = "remove_invbasepmu.action";
			var datajson = {"isno":isno};
			$.ajax({
			    type: "POST",
			    url: url,
			    dataType: "json",
			    data: datajson,
			    success: function(){
					location.reload();
				},
			    error: function () {
					art.dialog({
						width:300,
						height:50,
						title:"Solarcloud Message",
						content:RES.RES_DELSHAREACCOUNT_ERR,
						ok:function(){},
						okValue:RES.CONF_ART_OK,
					});    
			    }
			});
		},
		okValue:RES.CONF_ART_OK,
		cancel:function(){},
		cancelValue:RES.CONF_ART_CANCEL
	});    
}















