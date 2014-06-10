var rolem = function(){
    var flag = false;
	function init(){
	}
	function cinit(){
		$('#email').bind('focusin',reEmail);
		$('#email').bind('focusout',checkFormatEmail);
	}
	function einit(){
		$("#editSysuserBtn").bind('click',submitEditForm);
	}
	function submitEditForm(){
		$("#editSysuserBtn").unbind('click',submitEditForm);
		if(checkPassword()&&reConrepassword()&&checkreqDepart()&&checkFirstName()&&checkSencondName()){
				$.post("doEditSysuser.action", 
				$("#editSysuserForm").serialize(),
				function(data){
					if(data.status=='ok'){
						drawmenu.getBody('rolemanager.action');
					}				   
				 }, 
				"json");
				
			}else{
				$('#editSysuserBtn').bind('click',submitEditForm);
		}
	}
	function reEmail(){
		flag = false;
		$('#emailTip').html("&nbsp;");
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
			$('#createSysuserBtn').bind('click',submitForm);
			$('#pwd').removeAttr("readonly");
			$("#emailTip").css("color","green");
			$("#emailTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			flag = true;
		}else{
			//$("#email").attr("class","reg_errinput");
			$("#emailTip").css("color","red");
			$("#emailTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.EMAILHASEXIST);
			return false;
		}
	}
	function checkPassword() {
		var password = $("#pwd").val();
		if (password.length <6) {
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
				$("#repwdTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REPWDWRONG);
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
	function checkreqDepart(){
		var reqdepartment = $('#reqdepartment').val();
		if(reqdepartment==''){
			$("#departTip").css("color","red");
			$("#departTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;");
			return false;
		}else{
			$("#departTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
	}
	function submitForm(){
		$('#createSysuserBtn').unbind('click');
		if(flag){
			if(checkPassword()&&reConrepassword()&&checkreqDepart()&&checkFirstName()&&checkSencondName()){
				$.post("doCreateSysuser.action", 
				$("#createSysuserForm").serialize(),
				function(data){
					if(data.status=='ok'){
						drawmenu.getBody('rolemanager.action');
					}				   
				 }, 
				"json");
				
			}else{
				$('#createSysuserBtn').bind('click',submitForm);
			}
		}
	
	}
	function deleteSysuser(userid){
		if(confirm(RES.DELETESYSUSER)){
			var url = "deleteSysUser.action";
			var datajson = {"userId":userid};
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function (data, textStatus, jqXHR) {
	                if(data.status=="ok"){
	                	drawmenu.getBody('rolemanager.action');
	                };
	            },
	            error: function () {
	                (RES.REQUESTWRONG);
	            }
	    	});
	    }else{
	    	return false;
	    }
	}
	function changeUserType(){
		var roleId= $("#selectRole>option:selected").val();
		drawmenu.getBody("editLimits.action?roleId="+roleId);
	}
	function subLimits(){
		var roleId = $("#roleId").val();
		var checkedLimits = $(".sellimit");
		var limitstr ="";
		for(var i=0;i<checkedLimits.size();i++){
			var tempStr =  $(checkedLimits[i]).val();
			if(i==(checkedLimits.size()-1)){
				if($(checkedLimits[i]).attr("checked")){
					limitstr =limitstr+ tempStr+"_1";
				}else{
					limitstr =limitstr+ tempStr+"_0";
				}
			}else{
				var tempStr =  $(checkedLimits[i]).val();
				if($(checkedLimits[i]).attr("checked")){
					limitstr =limitstr+ tempStr+"_1,";
				}else{
					limitstr =limitstr+ tempStr+"_0,";
				}
			}
		}
		var url="updateRoleLimits.action";
		var datajson = {"roleId":roleId,"limitsStr":limitstr};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function (data, textStatus, jqXHR) {
	                if(data.status=="ok"){
	                	alert("保存成功");
	                	drawmenu.getBody("editLimits.action?roleId="+roleId);
	                };
	            },
	            error: function () {
	                (RES.REQUESTWRONG);
	            }
	    	});
	}
	return {
		cinit:function(){cinit();},
		einit:function(){einit();},
		deleteSysuser:function(userid){deleteSysuser(userid);},
		changeUserType:function(){changeUserType();},
		subLimits:function(){subLimits();},
		init:function(){init();}
	}

}();