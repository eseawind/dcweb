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

var confUser = function(){
	function init(){
		$('#submitForm').bind('click',submitForm);
		$('#firstName').bind('focusin',refname);
		$('#firstName').bind('focusout',checkFirstName);
		$('#secondName').bind('focusin',relname);
		$('#secondName').bind('focusout',checkSencondName);
		$('#country').bind('change',changeCountry);
		$('#state').bind('change',changeState);
	}
	function refname(){
		$("#fnameTip").css("color","#000");
		$("#fnameTip").html(RES.FNAMETIP);
	}

	function relname(){
		$("#lnameTip").css("color","#000");
		$("#lnameTip").html(RES.LNAMETIP);
	}
	function submitForm(){
		if(checkFirstName()&&checkSencondName() && checkCountry() && checkState()){
			var email=$('#email').val();
			var firstName=$('#firstName').val();
			var secondName=$('#secondName').val();
			var company=$('#company').val();
			var myurl=$('#myurl').val();
			var country=$('#country').val();
			var state=$('#state').val();
			var city=$('#city').val();
			var address=$('#address').val();
			var postcode=$('#postcode').val();
			var tel1=$('#tel1').val();
			var tel2=$('#tel2').val();
			var tel3=$('#tel3').val();
			var tel4=$('#tel4').val();
			var tel=tel1+"-"+tel2+"-"+tel3+"-"+tel4;
			var mobile1=$('#mobile1').val();
			var mobile=$('#mobile').val();

			var mobile=mobile1+"-"+mobile;
			var datajson = {"firstName":firstName,"secondName":secondName,"company":company,"myurl":myurl,"country":country,"state":state,"city":city,"address":address,"postcode":postcode,"tel1":tel,"mobile":mobile,"email":email};
			
			var url = "editUserRegInfo.action";
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
		}else{

			
		}
	}
	function  editres(data, textStatus, jqXHR){
		if(data.status == 'ok'){

			var firstName=$('#firstName').val();
			var secondName=$('#secondName').val();
			$('#usernameTip').html(firstName+secondName);
			alert(RES.RES_CONFIG_REPORT_SAVE_OK);
		}else{

			alert(RES.RES_CONFIG_REPORT_SAVE_ERR);
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
	function checkCountry(){
		var country = $('#country').val();
		if(country=='0'){
			$("#countryTip").css("color","red");
			$("#countryTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.COUNTRYSELECT);
			return false;
		}else{
			$("#countryTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
		}
		
	}
	function checkState(){
		var state = $('#state').val();
		if(state=='0'){
			$("#stateTip").css("color","red");
			$("#stateTip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STATESELECT);
			return false;
		}else{
			$("#stateTip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			return true;
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
	return{
		init:function(){init()}
	}
}();
