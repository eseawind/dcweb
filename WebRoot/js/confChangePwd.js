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

var confChangePwd = function(){
	function init(){
		$('#submitForm').bind('click',submitForm);
		$('#oldpwd').bind('focusin',relold);
		$('#oldpwd').bind('focusout',checkold);
		$('#newpwd').bind('focusin',relnew);
		$('#newpwd').bind('focusout',checknew);
		$('#renewpwd').bind('focusin',relrenew);
		$('#renewpwd').bind('focusout',checkrenew);
	}
	function relold(){
		$("#oldtip").css("color","#000");
		$("#oldtip").html(RES.RES_CHANGEPASSWD_INOLDPWD);
	}
	var p = /^[A-Za-z0-9]+$/;
	function checkold(){
		var oldpwd = $('#oldpwd').val();
		if(oldpwd==''){
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INOLDPWD);
			return false;
		}else if (oldpwd.length <6 || oldpwd.length >18) {
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDLENGTH);
			return false;
		}else if(!p.test(oldpwd)){
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDNOOK);
			return false;
		}
		else{
			$("#oldtip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function relnew(){
		//$("#newtip").css("color","#000");
		//$("#newtip").html(RES.RES_CHANGEPASSWD_INNEWPWD);
	}
	function checknew(){
		var newpwd = $('#newpwd').val();
		if(newpwd==''){
			$("#newtip").css("color","red");
			$("#newtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INNEWPWD);
			return false;
		}else if (newpwd.length <6 || newpwd.length >18) {
			$("#newtip").css("color","red");
			$("#newtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDLENGTH);
			return false;
		}else if(!p.test(newpwd)){
			$("#newtip").css("color","red");
			$("#newtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDNOOK);
			return false;
		}else{
			$("#newtip").html("<img style='padding-top: 4px; position: absolute' src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function relrenew(){
		//$("#retip").css("color","#000");
		//$("#retip").html(RES.RES_CHANGEPASSWD_INCOFMNEWPWD);
	}
	function checkrenew(){
		var renewpwd = $('#renewpwd').val();
		var newpwd = $('#newpwd').val();
		var oldpwd = $('#oldpwd').val();
		if(newpwd==''){
			$("#newtip").css("color","red");
			$("#newtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INNEWPWD);
			return false;
		}else{
			$("#newtip").html("<img style='padding-top: 4px; position: absolute' src='images/icon/right.png' />&nbsp;&nbsp;");
		}
		if(renewpwd==''){
			$("#retip").css("color","red");
			$("#retip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INCOFMNEWPWD);
			return false;
		}else{
			$("#retip").html("<img style='padding-top: 4px; position: absolute' src='images/icon/right.png' />&nbsp;&nbsp;");
		}
		if(renewpwd !=newpwd){
			$("#retip").css("color","red");
			//$("#retip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INCONFMPWDERR);
			$("#retip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REPWDTIP);
			return false;
		}
		else{
			$("#retip").html("<img style='padding-top: 4px; position: absolute' src='images/icon/right.png' />&nbsp;&nbsp;");
		}
		return true;
	}
	function submitForm(){
		var oldpwd = $('#oldpwd').val();
		if(oldpwd==''){
			$("#resinfotip").css("color","red");
			$("#resinfotip").html("<img style='padding-top: 4px; position: absolute' src='images/icon/delete.png' />&nbsp;&nbsp;&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_INOLDPWD);
			return false;
		}
		if(checknew()&&checkrenew()){
			var newpwd = $('#newpwd').val();
			var datajson = {"oldpwd":oldpwd,"pwd":newpwd};
			var url = "changeUserPws.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: editres,
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
	}
	function  editres(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			$("#resinfotip").css("color","green");
			$("#resinfotip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_OPT_SUCCESS);
			//alert(RES.RES_CHANGEPASSWD_OPT_SUCCESS);
			history.go(-1);
		}else if(data.errorcode == '1'){
			$("#resinfotip").css("color","red");
			$("#resinfotip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_OPT_FAILD1);
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;");
			//alert(RES.RES_CHANGEPASSWD_OPT_FAILD1);
		}else if(data.errorcode == '2'){
			$("#resinfotip").css("color","red");
			$("#resinfotip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_OPT_FAILD2);
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;");
			//alert(RES.RES_CHANGEPASSWD_OPT_FAILD2);
		}else{
			$("#resinfotip").css("color","red");
			$("#resinfotip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_CHANGEPASSWD_OPT_FAILD3);
			$("#oldtip").css("color","red");
			$("#oldtip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;");
			//alert(RES.RES_CHANGEPASSWD_OPT_FAILD3);
		}
	}
	return{
		init:function(){init()}
	}
}();
