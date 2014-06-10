function building(){
	alert(RES.BUILDING);
}
//遮罩层显示部分
function LoadShow(){
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			$("body","html").css({height: "100%", width: "100%"});
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
		$("body").append("<div id='TB_load'><img src='images/loading.gif' /></div>");//add loader to the page
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
//遮罩层显示部分结束
var changeLange = function(locales){
	$("#langlocale").val(locales);
	$("#langform").submit();
}

//浏览器信息
function getOs(){  
   if(navigator.userAgent.indexOf("MSIE")>0){  
	   return "Microsoft Internet Explorer";  
   }  
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
	   return "Firefox";  
   }  
   if(isChrome=navigator.userAgent.indexOf("Chrome")>0) {  
	   return "Chrome";  
   }  
   if(isSafari=navigator.userAgent.indexOf("Safari")>0) {  
	   return "Safari";  
   }
} 

//操作系统信息
function detectOS() {  
    var sUserAgent = navigator.userAgent;  
    var isWin = (navigator.platform == "Win32") || (navigator.platform == "Windows");  
    var isMac = (navigator.platform == "Mac68K") || (navigator.platform == "MacPPC") || (navigator.platform == "Macintosh") || (navigator.platform == "MacIntel");  
    if (isMac) return "Mac";  
    var isUnix = (navigator.platform == "X11") && !isWin && !isMac;  
    if (isUnix) return "Unix";  
    var isLinux = (String(navigator.platform).indexOf("Linux") > -1);  
    if (isLinux) return "Linux";  
    if (isWin) {  
        var isWin2K = sUserAgent.indexOf("Windows NT 5.0") > -1 || sUserAgent.indexOf("Windows 2000") > -1;  
        if (isWin2K) return "Win2000";  
        var isWinXP = sUserAgent.indexOf("Windows NT 5.1") > -1 || sUserAgent.indexOf("Windows XP") > -1;  
        if (isWinXP) return "WinXP";  
        var isWin2003 = sUserAgent.indexOf("Windows NT 5.2") > -1 || sUserAgent.indexOf("Windows 2003") > -1;  
        if (isWin2003) return "Win2003";  
        var isWinVista= sUserAgent.indexOf("Windows NT 6.0") > -1 || sUserAgent.indexOf("Windows Vista") > -1;  
        if (isWinVista) return "WinVista";  
        var isWin7 = sUserAgent.indexOf("Windows NT 6.1") > -1 || sUserAgent.indexOf("Windows 7") > -1;  
        if (isWin7) return "Win7";  
    }  
    return "other";  
} 

var login = function(){
	var email=$("#account").val();
	var password = $("#password").val();
	var vercode=$("#vercode").val();
	var emailPat=/^(.+)@(.+)$/;
	//浏览器信息
	//var ieinfo = navigator.appName;
	var ieinfo = navigator.userAgent.substring(0, 255);
	//var ieinfo = getOs();
	
	if(navigator.appName=="Opera")
		ieinfo = "Opera";
	//操作系统信息
	var sysinfo = detectOS();
	
	//获取当前日期时间
	var datetime = new Date().toLocaleDateString()+" "+new Date().toLocaleTimeString();
	
	if (!emailPat.test(email)){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.EMAILWRONG,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		return;
	}
	
	if(password==''){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.PASSWORDNOTNULL,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		return;
	}
	if(vercode==''){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.RES_FIND_PWD_INOUT_CHECKCODE,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
		return;
	}
	
	var datajson = {"email":email, "password":password, "vercode":vercode, "sysinfo":sysinfo, "ieinfo":ieinfo, "datetime":datetime};
	var url = 'ajaxlogin.action';
	//LoadShow();
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: responseLogin,
        error: function () {
            //alert(RES.REQUESTWRONG);
        }
    });
}

var responseLogin = function(data, textStatus, jqXHR){
	//LoadHidden();
	if(data.status=="ok"){
		if($("#remain").attr("checked")==true){
			Cookie.setCookie("email2",$("#account").val());
			Cookie.setCookie("password2",$("#password").val());
		}
		else{
			Cookie.clearCookie("email2");	
			Cookie.clearCookie("password2");	
		}
		window.location.href="main.action";
	}
	else if(data.errorcode == 1){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.LOGINFALSE1,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
	}
	else if(data.errorcode == 2){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.LOGINFALSE2,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
	}
	else if(data.errorcode == 3){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.LOGINFALSE3,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
	}
	else if(data.errorcode == 4){
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.LOGINFALSE4,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
	}
	verImg.src = "verCode?"+Math.random();
}

var example = function(){
	window.location.href="powerlist.action";
	       
}

var responseExampleLogin = function(data, textStatus, jqXHR){
	if(data.status=="ok"){
		window.location.href="powerlist.action";
	}else{
		art.dialog({
			width:300,
			height:50,
			title:"Solarcloud Message",
			content:RES.LOGINFALSE,
			ok:function(){},
			okValue:RES.CONF_ART_OK
		});
	}
}
var changeTab = function(obj){
	var id = $(obj).attr('id');
	if(id=="yesterday_dc_tab"){
		$("#yesterday_dc").css("display","");
		$("#total_dc").css("display","none");
		var ydivList = $("#yesterday_dc_tab").children('div');
		$(ydivList[0]).attr("class","tabl");
		$(ydivList[1]).attr("class","tabc");
		$(ydivList[2]).attr("class","tabr");
		var tdivList = $("#total_dc_tab").children('div');
		$(tdivList[0]).attr("class","tabl_off");
		$(tdivList[1]).attr("class","tabc_off");
		$(tdivList[2]).attr("class","tabr_off");
	}else if(id=="total_dc_tab"){
		$("#yesterday_dc").css("display","none");
		$("#total_dc").css("display","");
		var ydivList = $("#yesterday_dc_tab").children('div');
		$(ydivList[0]).attr("class","tabl_off");
		$(ydivList[1]).attr("class","tabc_off");
		$(ydivList[2]).attr("class","tabr_off");
		var tdivList = $("#total_dc_tab").children('div');
		$(tdivList[0]).attr("class","tabl");
		$(tdivList[1]).attr("class","tabc");
		$(tdivList[2]).attr("class","tabr");
	}
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
	function doClick(langs){
	   changeLange(langs);
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
function wapTip(){
	
	var infos="<table width='400' border='0' cellspacing='0' cellpadding='0'>";
	 infos= infos+"  <tr>";
	 infos= infos+"    <td width='100%'  background='images/listbg29_1.gif' class='black2'>"+RES.RES_WAP_LIKE_ALERT+":</td>";
	 infos= infos+"  </tr>";
	 infos= infos+"  <tr>";
	 infos= infos+"    <td  height='29'  background='images/listbg29.gif' class='black2'><div ><strong> http://wap.zeversolar.com</strong></div></td>";
	 infos= infos+"  </tr>";
	 
	 infos= infos+"</table>";
	art.dialog({		
	    title: "WAP",
		width: 450,
		height: 100,
	    content: infos
	});
	
}
function wapTip2(){
	alert(RES.RES_WAP_LIKE_ALERT+"\nhttp://wap.zeversolar.com");
}