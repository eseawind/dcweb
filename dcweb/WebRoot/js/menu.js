var drawmenu = function(){
	function doDefault(obj){
		var styleName=$(obj).attr('class');
		$(obj).attr('class',styleName.split("_")[0]+"_on");
		clearFocusLi();
		var url = $(obj).attr("linked");
		getBody(url);
	}
	function clearFocusLi(){
		var menuList = $(".menuul");
		for(var i=0;i<menuList.length;i++){
			$(menuList[i]).children().removeAttr("class");
		}
	}
	
	function getBody(url){
		LoadShow();
	    $.get(url, function(data) {
	    	  LoadHidden();
			  $('#showright').html(data);
			  
		});
		
	}
	
	
	function doClickMenu(obj){

	}
	function doClickli(obj){
		clearFocusLi();
		$(obj).parent("li").attr('class',"lion");
		var url = $(obj).attr("linked");
		getBody(url);
	}
	//遮罩层显示部分
	function LoadShow(){
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			$("body","html").css({height: "100%", width: "1001px"});
			$("html").css("overflow","hidden");
			if (document.getElementById("TB_HideSelect") === null) {//iframe to hide select elements in ie6
				$("body").append("<iframe id='TB_HideSelect'></iframe><div id='TB_overlay'></div><div id='TB_window'></div>");
				//$("#TB_overlay").click(tb_remove);
			}
		}else{//all others
			if(document.getElementById("TB_overlay") === null){
				$("body").append("<div id='TB_overlay'></div><div id='TB_window'></div>");
				//$("#TB_overlay").click(tb_remove);
			}
		}
		
		if(tb_detectMacXFF()){
			$("#TB_overlay").addClass("TB_overlayMacFFBGHack");//use png overlay so hide flash
		}else{
			$("#TB_overlay").addClass("TB_overlayBG");//use background and opacity
		}
		$("body").append("<div id='TB_load'><img src='images/loading.gif' style='margin-top:200px'/></div>");//add loader to the page
		$('#TB_overlay').show();
		$('#TB_load').show();
	}
	function tb_detectMacXFF() {
	  var userAgent = navigator.userAgent.toLowerCase();
	  if (userAgent.indexOf('mac') != -1 && userAgent.indexOf('firefox')!=-1) {
	    return true;
	  }
	}
	function LoadHidden(){
		$('#TB_overlay').remove();
		$("#TB_load").remove();
	}
	return{
		_default : function(obj){doDefault(obj);},
		clickMenu:function(obj){doClickMenu(obj);},
		clickli:function(obj){doClickli(obj);},
		getBody:function(url){getBody(url)}
	}
}();

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
	   changeLange(obj);
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
var changeLange = function(locales){
			$("#langlocale").val(locales);
			$("#langform").submit();
		}
/***导航栏配置*
var MENU = [{
				"text":RES.RES_OVERVIEW,
				"styleName":"taboverview",
				"link":"#",
				"child":[]
			},
			{
				"text":RES.RES_POWERPLANT,
				"styleName":"tabpowerplant",
				"link":"#",
				"child":[
					{
						"text":RES.RES_POWERLIST,
						"link":"#"
					},
					{
						"text":RES.RES_POWER,
						"link":"#"
					},
					{
						"text":RES.RES_EVENT,
						"link":"#"
					},
					{
						"text":RES.RES_POWERINFORMATION,
						"link":"#"
					}
					
				]
			},
			{
				"text":RES.RES_CHART,
				"styleName":"tabchart",
				"link":"#",
				"child":[
					{
						"text":RES.RES_DCPOWER,
						"link":"#"
					},
					{
						"text":RES.RES_DCCURRENT,
						"link":"#"
					},
					{
						"text":RES.RES_DCVOLATAGE,
						"link":"#"
					},
					{
						"text":RES.RES_ACPOWER,
						"link":"#"
					},
					{
						"text":RES.RES_ACCURRENT,
						"link":"#"
					},
					{
						"text":RES.RES_ACVOLATAGE,
						"link":"#"
					},
					{
						"text":RES.RES_IT,
						"link":"#"
					},
					{
						"text":RES.RES_INCOME,
						"link":"#"
					},
					{
						"text":RES.RES_CO2V,
						"link":"#"
					},
					{
						"text":RES.RES_CUSTOM,
						"link":"#"
					},
					{
						"text":RES.RES_EC,
						"link":"#"
					},
					{
						"text":RES.RES_CONSTRAST,
						"link":"#"
					}
				]	
			},
			{
				"text":RES.RES_CONFIGURATION,
				"styleName":"tabconf",
				"link":"#",
				"child":[
					{
						"text":RES.RES_BASESETTING,
						"link":"#"
					},
					{
						"text":RES.RES_PLANTPRO,
						"link":"#"
					},
					{
						"text":RES.RES_UCONF,
						"link":"#"
					},
					{
						"text":RES.RES_RCONF,
						"link":"#"
					}
				]
			}];
***/

/** delete plant **/
function removeStation(sid){
	art.dialog({
		width:300,
		height:50,
		title:"Solarcloud Message",
		content:RES.SUREDELSTATION,
		ok:function(){
			var url = "removeStation.action";
			var datajson = {"stationId":sid};
			$.ajax({
			    type: "POST",
			    url: url,
			    dataType: "json",
			    data: datajson,
			    success: removeRes,
			    error: function () {
					art.dialog({
						width:300,
						height:50,
						title:"Solarcloud Message",
						content:RES.REQUESTWRONG,
						ok:function(){},
						okValue:RES.CONF_ART_OK,
						cancel:function(){},
						cancelValue:RES.CONF_ART_CANCEL
					});    
			    }
			});
		},
		okValue:RES.CONF_ART_OK,
		cancel:function(){},
		cancelValue:RES.CONF_ART_CANCEL
	});    
}
function removeRes(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		location.reload();
	}else if(data.errorcode == '1'){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.DELSTATIONERR_HAVEPMU,
			ok:function(){},
			okValue:RES.CONF_ART_OK,
			cancel:function(){},
			cancelValue:RES.CONF_ART_CANCEL
		});
		return false;
	}else{
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.DELSTATIONERR,
			ok:function(){},
			okValue:RES.CONF_ART_OK,
			cancel:function(){},
			cancelValue:RES.CONF_ART_CANCEL
		});
		return false;
	}
}

function acceptShare(sid){
	if(confirm(RES.RES_ACCEPT_SHAREPLAT_CONFIRM)){
		var url = "shareAccountActive.action";
		var datajson = {"plantt":sid,"state":"1"};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: acceptShareRes,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
		}
	
}
var canA=true;
function acceptShareRes(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		alert(RES.RES_ACCEPT_SHAREPLAT_OK);
		location.reload();
	}else if(data.errorcode == '1'){
		alert(RES.RES_ACCEPT_SHAREPLAT_ERR1);
		return false;
	}else if(data.errorcode == '2'){
			alert(RES.RES_ACCEPT_SHAREPLAT_ERR2);
		return false;
	}
	canA=false;
	
}
/** cancel plant **/
function refuseShare(sid){
	art.dialog({
		width:300,
		height:50,
		title:"Solarcloud Message",
		content:RES.RES_REFUSE_SHAREPLAT_CONFIRM,
		ok:function(){
			var url = "removeStation.action";
			var datajson = {"stationId":sid};
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: refuseShareRes,
	            error: function () {
	                art.dialog({
						width:300,
						height:50,
						title:"Solarcloud Message",
						content:RES.REQUESTWRONG,
						ok:function(){},
						okValue:RES.CONF_ART_OK,
						cancel:function(){},
						cancelValue:RES.CONF_ART_CANCEL
					});  
	            }
		    });	
		},
		okValue:RES.CONF_ART_OK,
		cancel:function(){},
		cancelValue:RES.CONF_ART_CANCEL
	});    
}
function refuseShareRes(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_REFUSE_SHAREPLAT_OK,
		});
		location.reload();
	}else if(data.errorcode == '1'){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_REFUSE_SHAREPLAT_ERR1,
			ok:function(){},
			okValue:RES.CONF_ART_OK,
			cancel:function(){},
			cancelValue:RES.CONF_ART_CANCEL
		});
		return false;
	}else if(data.errorcode == '2'){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_REFUSE_SHAREPLAT_ERR2,
			ok:function(){},
			okValue:RES.CONF_ART_OK,
			cancel:function(){},
			cancelValue:RES.CONF_ART_CANCEL
		});
		return false;
	}
	
}