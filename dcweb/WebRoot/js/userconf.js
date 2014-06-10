var userconf = function(){
	var flag = false;
	function init(){
	
	}
	function showCNormalUser(){
		var count=$("#usercount").val();
		if(count>=5){
			alert(RES.ONLYCANC5USERS);
			return false;
		}
		var disp = $("#addUsertab").css("display");
		if(disp==""||disp=="block"){
			$("#addUsertab").css("display","none");
		}else{
			$("#addUsertab").css("display","block");
		}
	}
	function focusEmail(){
		 flag = false;
		 $("#email").css("border","1px solid #ccc");
		 $("#emailTip").html("");
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
			flag=true;
			$("#emailTip").html(RES.EMAILRIGHT);
			$('#submitForm').bind('click',submitForm);
		}else{
			flag=false;
			$("#email").css("border","1px solid red");
			$("#emailTip").html(RES.EMAILHASEXIST);
			return false;
		}
	}
	function checkFormatEmail() {
		var emailStr = $("#email").val();
		var emailPat = /^(.+)@(.+)$/;
		var matchArray = emailStr.match(emailPat);
		if (matchArray == null) {
			$("#email").css("border","1px solid red");
			$("#emailTip").html(RES.EMAILWRONG);
			//$('#checkEmailBtn').unbind('click',checkEmail);
			return false;
		} else {
			checkEmail();
			//$("#emailTip").html(RES.EMAILEXIST);
			//$('#checkEmailBtn').bind('click',checkEmail);
			return true;
		}
	}
	function checkPassword() {
		var password = $("#pwd").val();
		if (password.length <6) {
			alert(RES.PWDLENGTH);
			return false;
		} else {
			return true;
		}
	}
	function reConrepassword() {
			var password = $("#pwd").val();
			var repassword = $("#repwd").val();
			if (password == repassword) {
				return true;
			} else {
				alert(RES.REPWDWRONG);
				return false;
			}
	}
	function checkFirstName(){
		var firstName = $('#firstName').val();
		if(firstName==''){
			alert(RES.FIRSTNAMEWORNG);
			return false;
		}else{
			return true;
		}
	}
	function checkSencondName(){
		var secondName = $('#secondName').val();
		if(secondName==''){
			alert(RES.SNAMEWORNG);
			return false;
		}else{
			return true;
		}
		
	}
	function submitForm(){
		$('#submitForm').unbind('click',submitForm);
		if(flag&&checkPassword()&&reConrepassword()&&checkFirstName()&&checkSencondName()){
			$.post("createNormalUser.action", 
				$("#addUserForm").serialize(),
				function(data){
					if(data.status=='ok'){
						drawmenu.getBody("userconf.action");
					}				   
				 }, 
				"json");
		}else{
			$('#submitForm').bind('click',submitForm);
			return false;
		}
	}
	
	function delNormalUser(userId){
		if(confirm(RES.SUREDELNUSER)){
		var datajson = {"userId":userId};
		var url = "delNormalUser.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responsedelNormalUser,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	    }
	}
	function responsedelNormalUser(data, textStatus, jqXHR){
		if(data.status=="ok"){
			drawmenu.getBody("userconf.action");
		}else{
			return false;
		}
	}
	function editNormalUser(userid){
		drawmenu.getBody("editUser.action?userId="+userid);
	}
	function updateUser(){
		if(checkPassword()&&reConrepassword()&&checkFirstName()&&checkSencondName()){
			var userId = $("#text_userId").val();
			var password = $("#pwd").val();
			var firstName = $('#firstName').val();
			var secondName = $('#secondName').val();
			var datajson = {"userId":userId,"pwd":password,"firstName":firstName,"secondName":secondName};
			var url = "updateUser.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseUpdateUser,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    	});
		}else{
			return false;
		}
	}
	function responseUpdateUser(data, textStatus, jqXHR){
		if(data.status =="ok"){
			alert("update user info success");
		}else{
			return false;
		}
	}
	function updateUserLimits(){
		var userId = $("#text_userId").val();
		var editStationLimit = $("#editStationLimit").attr('checked')==true?1:0;
		var addPmuLimit = $("#addPmuLimit").attr('checked')==true?1:0;
		var delPmuLimit = $("#delPmuLimit").attr('checked')==true?1:0;
		var setReportLimit = $("#setReportLimit").attr('checked')==true?1:0;
		var datajson = {"userId":userId,"editStationLimit":editStationLimit,"addPmuLimit":addPmuLimit,
							"delPmuLimit":delPmuLimit,"setReportLimit":setReportLimit};
		var url = "editUserLimits.action";
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseUpdateUserLimits,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    	});
	}
	function responseUpdateUserLimits(data, textStatus, jqXHR){
		if(data.status =="ok"){
			alert("update user limits success");
		}else{
			return false;
		}
	}
	return {
		init:function(){init();},
		showCNormalUser:function(){showCNormalUser();},
		checkEmail:function(){checkFormatEmail();},
		delNormalUser:function(userid){delNormalUser(userid);},
		editNormalUser:function(userid){editNormalUser(userid);},
		updateUser:function(){updateUser();},
		updateUserLimits:function(){updateUserLimits();},
		focusEmail:function(){focusEmail();}
	}

}();