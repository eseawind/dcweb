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

var register = function(){
	function init(){
		$('#submitFormB').bind('click',submitForm);
		$('#email').bind('focusin',reEmail);
		$('#email').bind('focusout',checkFormatEmail);
		$('#pwd').bind('focusin',pwdfun);
		$('#pwd').bind('focusout',checkPassword);
		$('#repwd').bind('focusin',repwdfun);
		$('#repwd').bind('focusout',reConrepassword);
		$('#firstName').bind('focusin',refname);
		$('#firstName').bind('focusout',checkFirstName);
		$('#secondName').bind('focusin',relname);
		$('#secondName').bind('focusout',checkSencondName);
		$('#question').bind('focusin',questionf);
		$('#question').bind('focusout',checkQuestion);
		$('#answer').bind('focusin',answerf);
		$('#answer').bind('focusout',checkAnswer);

		$('#country').bind('change',changeCountry);
		$('#state').bind('change',changeState);
		$('#resend').bind('click',resendVerCode);
		
	}
	function refname(){
		$("#firstName").attr("class","reg_input");
		$("#fnameTip").css("color","#000");
		$("#fnameTip").html(RES.FNAMETIP);
	}
	function refsecname(){
		$("#secondName").attr("class","reg_input");
		$("#lnameTip").css("color","#000");
		$("#lnameTip").html(RES.FNAMETIP);
	}

	function questionf(){
		$("#question").attr("class","test_input17");
		$("#questionTip").css("color","#000");
		$("#questionTip").html(RES.RES_QUESTION);
	}
	function answerf(){
		$("#answer").attr("class","test_input17");
		$("#answerTip").css("color","#000");
		$("#answerTip").html(RES.RES_ANSWER);
	}
	function relname(){
		$("#secondName").attr("class","reg_input");
		$("#lnameTip").css("color","#000");
		$("#lnameTip").html(RES.LNAMETIP);
	}
	function pwdfun(){
		$("#pwd").attr("class","test_input17");
		$("#pwdTip").css("color","#000");
		$('#pwdTip').html(RES.PWDTIP);
	}
	function repwdfun(){
		$("#repwd").attr("class","test_input17");
		$("#repwdTip").css("color","#000");
		$('#repwdTip').html(RES.REPWDTIP);
	}
	var email2;
	function resendVerCode(){
		$('#resend').unbind('click',resendVerCode);
		var url = "reSendVerCode.action";
		email2 = $("#email").val();
		var verCode = $("#verCode").val();
		var firstName = $("#firstName").val();
		var secondName = $("#secondName").val();
		var yourId = $("#yourId").val();
		var datajson = {"email":email2,"verCode":verCode,"firstName":firstName,"secondName":secondName,"yourId":yourId};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseResendVerCode,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
		$('#resend').bind('click',resendVerCode);
	}
	function responseResendVerCode(data, textStatus, jqXHR){
		if(data.status == 'ok'){
		alert(RES.RES_REGIST_REMAIL+email2);
		}else{
			alert(RES.RES_REGIST_MAIL_ERR);
			return false;
		}
	
	}
	function checkEmail(){
		var url = "checkEmail.action";
		var email = $("#email").val();
		var datajson = {"email":email};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseCheckEmail,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	function responseCheckEmail(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			$("#emailTip").html(RES.EMAILRIGHT);
			$('#pwd').removeAttr("readonly");
			$("#emailTip").css("color","green");
			$("#emailTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
		}else{
			//$("#email").attr("class","reg_errinput");
			$("#emailTip").css("color","red");
			$("#emailTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.EMAILHASEXIST);
			return false;
		}
	
	}
	function submitForm(){
		
		if(checkPassword()&&reConrepassword()&& checkQuestion() && checkAnswer() &&checkFirstName()&&checkSencondName() && checkCountry() &&checkState()){
			
			$('#submitFormB').unbind('click',submitForm);
			document.dorigisterForm.submit();
		}else{
			$('#submitForm').bind('click',submitForm);
			
		}
	}
	function changeCountry(){
		$("#countryTip").css("color","#000");
		$("#countryTip").html("");
		var country = $("#country>option:selected").val();
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
	function changeState(){
		$("#stateTip").css("color","#000");
		$("#stateTip").html("");
	}
	function checkCountry(){
		var country = $("#country>option:selected").val();
		if(country==0){
			$("#countryTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.COUNTRYSELECT);
			return false;
		}else{
			$("#countryTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			return true;
		}
	}
	function checkState(){
		var state = $("#state>option:selected").val();
		if($("#state>option").length==0 ||  state==0){
			$("#stateTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STATESELECT);
			
			return false;
		}else{
			$("#stateTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			return true;
		}
	}
	function reEmail(){
		$("#email").attr("class","test_input17");
		$("#emailTip").css("color","#000");
		$('#emailTip').html(RES.EMAILTIP);
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
			checkEmail();
			return true;
		}
	}
	function checkPassword() {
		var password = $("#pwd").val();
		//var p = /[^x00-xff]/;
		var p = /^[A-Za-z0-9]+$/;
		if (!p.test(password)){
			$("#pwdlTip").css("color","red");
			$("#pwdlTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDNOOK);
			return false;
		}
		if (password.length <6 || password.length >18) {
			$("#pwdlTip").css("color","red");
			$("#pwdlTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PWDLENGTH);
			return false;
		} else {
			$("#pwdlTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function reConrepassword() {
			var password = $("#pwd").val();
			var repassword = $("#repwd").val();
			if (password == repassword&&repassword.length>=6) {
				$("#repwdTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
				return true;
			} else {
				$("#repwdTip").css("color","red");
				//$("#repwdTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REPWDWRONG);
				$("#repwdTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REPWDTIP);
				return false;
			}
	}
	
	function checkFirstName(){
		var firstName = $('#firstName').val();
		if(firstName==''){
			$("#fnameTip").css("color","red");
			$("#fnameTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.FIRSTNAMEWORNG);
			return false;
		}else{
			$("#fnameTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkQuestion(){
		var question = $('#question').val();
		if(question==''){
			$("#questionTip").css("color","red");
			$("#questionTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_QUESTION);
			return false;
		}else{
			$("#questionTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkAnswer(){
		var question = $('#answer').val();
		if(question==''){
			$("#answerTip").css("color","red");
			$("#answerTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_ANSWER);
			return false;
		}else{
			$("#answerTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkSencondName(){
		var secondName = $('#secondName').val();
		if(secondName==''){
			$("#lnameTip").css("color","red");
			$("#lnameTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.SNAMEWORNG);
			return false;
		}else{
			$("#lnameTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
		
	}
	return{
		init:function(){init()}
	}
}();

var bindStation = function(){
	var flag = false;
	function init(){
		$("#psno_tip").html(RES.INPUTISNO);
		$("#stationname_tip").html(RES.STANAMETIP);
		$("#co2xs_tip").html(RES.ONLYNUM);
		$("#gainxs_tip").html(RES.ONLYNUM);
		$("#money_tip").html(RES.CHOOSEMONEY);
		$("#timezone_tip").html(RES.CHOOSETIMEZONE);
		$('#psno').bind('focusin',repsno);
		$('#psno').bind('focusout',checkPsno);
		$('#registno').bind('focusin',reregistno);
		$('#registno').bind('focusout',checkPsno);
		$('#stationname').bind('focusin',restaname);
		$('#stationname').bind('focusout',checkStationName);
		$('#co2xs').bind('focusin',reco2xs);
		$('#co2xs').bind('focusout',checkCo2xs);
		$('#gainxs').bind('focusin',regainxs);
		$('#gainxs').bind('focusout',checkGainxs);
		$('#bindBtn').bind('click',submitForm);
	}
	function reco2xs(){
		$("#co2xs_tip").css("color","#000");
		$("#co2xs_tip").html(RES.ONLYNUM);
	}
	function regainxs(){
		$("#gainxs_tip").css("color","#000");
		$("#gainxs_tip").html(RES.ONLYNUM);
	}
	function repsno(){
		flag= false;
		$("#psno_tip").css("color","#000");
		$("#psno_tip").html(RES.INPUTISNO);
	}
	function reregistno(){
		flag= false;
		$("#psno_tip").css("color","#000");
		$("#psno_tip").html(RES.INPUTREGISTCODE);
	}
	function restaname(){
		$("#stationname_tip").css("color","#000");
		$("#stationname_tip").html(RES.STANAMETIP);
	}
	function checkPsno(){
		var url = "checkPsno.action";
		var psno = $("#psno").val();
		if(psno.length==0){
			$("#psno_tip").css("color","red");
			$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PSNOCANNOTNULL);
			return false;
		}
		var datajson = {"psno":psno};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseCheckIsno,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	function  responseCheckIsno(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			$("#psno_tip").css("color","green");
			$("#psno_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;"+RES.PSNORIGHT);
			flag = true;
		}else{
			flag = false;
			if(data.errorcode == "0"){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PMUNOTEXIST);
			}else if(data.errorcode=="1"){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PMUHASBINDED);
			}else if(data.errorcode=="2"){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PMUCHECKCODEERR);
			}
			return false;
		}
	}
	function checkStationName(){
		var stationname = $("#stationname").val();
		stationname = jQuery.trim(stationname);
		if(stationname==""){
			$("#stationname_tip").css("color","red");
			$("#stationname_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STATIONNAMENOTNULL);
			return false;
		}else{
			$("#stationname_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	
	function checkCo2xs(){
		var co2xs = $("#co2xs").val();
		if(co2xs==""){
			$("#co2xs_tip").css("color","red");
			$("#co2xs_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CO2XSCANNOTNULL);
			return false;
		}else{
			$("#co2xs_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkGainxs(){
		var co2xs = $("#gainxs").val();
		if(co2xs==""){
			$("#gainxs_tip").css("color","red");
			$("#gainxs_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.GAINXSCANNOTNULL);
			return false;
		}else{
			$("#gainxs_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkMoney(){
		var money = $("#money>option:selected").val();
		if(money==0){
			$("#money_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CHOOSEMONEY);
			return false;
		}else{
			$("#money_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function checkTimezone(){
		var timezone =  $("#timezone>option:selected").val();
		if(timezone==""){
		$("#timezone_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CHOOSETIMEZONE);
			return false;
		}else{
			$("#timezone_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function submitForm(){
		alert("aaa");
		if(flag){
			if(checkStationName()&&checkMoney()&&checkTimezone()&&checkCo2xs()&&checkGainxs()){
				$("#bindForm").submit();
			}else{
				return false;
			}
		}
	}
	return{
		init:function(){init();}
	}
}();