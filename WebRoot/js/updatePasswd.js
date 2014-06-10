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

var updatePasswd = function(){
	function init(){
		$('#submitForm').bind('click',submitForm);
		$('#email').bind('focusin',reEmail);
		$('#email').bind('focusout',checkFormatEmail);

		$('#verCode').bind('focusin',reVerCode);
		$('#verCode').bind('focusout',checkVerCode);
	}
	function reEmail(){

		
		$("#emailTip").css("color","#000");
		$('#emailTip').html("");
	}
	function checkFormatEmail() {
		var emailStr = $("#email").val();
		var emailPat = /^(.+)@(.+)$/;
		var matchArray = emailStr.match(emailPat);
		if (matchArray == null) {
			//$("#email").attr("class","reg_errinput");
			$("#emailTip").css("color","red");
			$("#emailTip").html("<img src='images/icon/delete.png'>&nbsp;&nbsp;"+RES.EMAILWRONG);
			//$('#checkEmailBtn').unbind('click',checkEmail);
			return false;
		} else {
			$("#emailTip").html("<img src='images/icon/right.png' />");
			
			return true;
		}
	}
	//验证码输入框获得焦点
	function reVerCode()
	{
		$("#codeTip").css("color","#000");
		$('#codeTip').html(RES.RES_FIND_PASSWD_IMGNUM);
	}
	//校验输入框
	function checkVerCode() 
	{
		var re = /^(\d+)(\.?)(\d{0,10})$/; 
		var verCode = $("#verCode").val();
		if(verCode == "") 
		{
			$("#codeTip").css("color","red");
			$("#codeTip").html("<img src='images/icon/delete.png'>&nbsp;&nbsp;"+RES.RES_FIND_PASSWD_INCODE);
			return false;
		} 
		if(verCode.length!=4 || !re.test(verCode))
		{
			$("#codeTip").css("color","red");
			$("#codeTip").html("<img src='images/icon/delete.png'>&nbsp;&nbsp;"+RES.RES_FIND_PASSWD_CODENUM);
		}
		else 
		{
			$("#codeTip").html("&nbsp;");
			return true;
		}
	}
	
	function submitForm()
	{
		if(checkFormatEmail())
		{
			var email=$('#email').val();	
			var verCode = $("#verCode").val();
			var datajson = {"email":email,"verCode":verCode};
			var url = "checkEmailAndVerCode.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: editres,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
			});
		}
	}
	
	function  editres(data, textStatus, jqXHR)
	{
		if(data.status == 'ok')
		{
			location.href="updatePasswdMail.action";
			//去掉找回密码页面
			//location.href="updatePasswdType.action";
		}
		else if(data.status=="errCode")
		{
			alert(RES.RES_FIND_PASSWD_ERRCODE);
		}
		else if(data.status=="noAcc")
		{
			alert(RES.RES_FIND_PASSWD_NOACC);
		}
		else
		{
			alert(RES.REQUESTWRONG);
		}
	}
	return{
		init:function(){init()}
	}
}();

var updatePasswd2 = function(){
	function init(){
		$('#submitForm').bind('click',submitForm);
		
	}
	function submitForm(){
		$('#submitForm').unbind('click',submitForm);
		location.href="updatePasswdMail.action";
	}
	return{
		init:function(){init()}
	}
}();

var updatePasswd3 = function(){
	function init(){
		$('#submitForm').bind('click',submitForm);
		$('#email').bind('focusin',reEmail);
		$('#email').bind('focusout',checkFormatEmail);
		$('#checkcode').bind('focusin',reCode);
		$('#checkcode').bind('focusout',checkCode);
		$('#password').bind('focusin',repwd);
		$('#password').bind('focusout',checkpwd);
		$('#repassword').bind('focusin',reRepwd);
		$('#repassword').bind('focusout',checkRepwd);
	}
	function reEmail(){

		$("#email").attr("class","test_input12");
		$("#email_tip").css("color","#000");
		$('#email_tip').html("");
	}
	function reCode(){

		$("#email").attr("class","test_input12");
		$("#checkcode_tip").css("color","#000");
		$('#checkcode_tip').html("");
	}
	function checkCode(){
		var code = $("#checkcode").val();
		
		code = jQuery.trim(code);
		if(code==""){
			$("#checkcode_tip").css("color","red");
			$("#checkcode_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_FIND_PWD_INOUT_CHECKCODE);
			return false;
		}else{
			$("#checkcode_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			return true;
		}
	}
	function repwd(){

		$("#password").attr("class","test_input12");
		$("#password_tip").css("color","#000");
		$('#password_tip').html("");
	}
	function checkpwd(){
		var password = $("#password").val();
		
		password = jQuery.trim(password);
		if(password==""){
			$("#password_tip").css("color","red");
			$("#password_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_FIND_PWD_INPUT_NEWPWD);
			return false;
		}if (password.length <6 || password.length >18) {
			$("#password_tip").css("color","red");
			$("#password_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDLENGTH);
			return false;
		}else{
			$("#password_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			return true;
		}
	}
	function reRepwd(){

		$("#repassword").attr("class","test_input12");
		$("#repassword_tip").css("color","#000");
		$('#repassword_tip').html("");
	}

	function checkRepwd(){
		var password = $("#password").val();
		var repassword = $("#repassword").val();
		password = jQuery.trim(password);
		repassword = jQuery.trim(repassword);
		if(repassword==""){
			$("#repassword_tip").css("color","red");
			$("#repassword_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_FIND_PWD_REPWD);
			return false;
		}else if (repassword!=password){
			$("#repassword_tip").css("color","red");
			$("#repassword_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_FIND_PWD_TWO_PWD);
			return false;
			
		}else{
			$("#repassword_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			return true;
		}
	}
	function checkFormatEmail() {
		var emailStr = $("#email").val();
		var emailPat = /^(.+)@(.+)$/;
		var matchArray = emailStr.match(emailPat);
		if (matchArray == null) {
			//$("#email").attr("class","reg_errinput");
			$("#email_tip").css("color","red");
			$("#email_tip").html("<img src='images/icon/delete.png'>&nbsp;&nbsp;"+RES.EMAILWRONG);
			//$('#checkEmailBtn').unbind('click',checkEmail);
			return false;
		} else {
			
			return true;
		}
	}
	function submitForm(){
		$('#submitForm').unbind('click',submitForm);
		if(checkFormatEmail() && checkCode() && checkpwd()&& checkRepwd()){
			var email=$('#email').val();
			var code = $("#checkcode").val();
			var password = $("#password").val();
			var datajson = {"email":email,"checkcode":code,"pwd":password};
			var url = "doUpdatePasswd.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: editres,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
				});
		}
		
	}
	function  editres(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			alert(RES.RES_FIND_PWD_UPDATE_OK);
				location.href="index.action";
			
		}
		else if (data.errorcode=="1"){
			
			alert(RES.RES_FIND_PWD_ERR_CHECKCODE);
		}
		else if (data.errorcode=="2"){

			alert(RES.RES_FIND_PWD_ERR_ACC_NOTFIND);
		}
	}
	
	
	return{
		init:function(){init()}
	}
}();