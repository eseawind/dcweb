
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


var createStation = function(){
	var flag=false;
	function init(){

		$('#submitImg').bind('click',submitForm);
		$('#stationname').bind('focusin',restaname);
		$('#stationname').bind('focusout',checkStationName);

		
		$('#psno').bind('focusout',checkPsno);
		$('#registno').bind('focusout',checkPsno);
		$('#installcap').bind('focusin',reInstallcap);
		$('#installcap').bind('focusout',checkInstallcap);
		
		$('#startdt').bind('focusin',restartDt);
		$('#startdt').bind('focusout',checkStartDt);
		$('#country').bind('change',checkCountry);
		$('#state').bind('change',checkState);
		
		$('#city').bind('focusin',recity);
		$('#city').bind('focusout',checkCity);
		
		$('#timezone').bind('change',checkTimezone);
		$("#stationname_tip").css("color","#000");
		$('#stationname_tip').html(RES.SNAMEINPUT);
		$("#country_tip").css("color","#000");
		$("#country_tip").html(RES.COUNTRYSELECT);
		$("#state_tip").css("color","#000");
		$("#state_tip").html(RES.STATESELECT);

		
		$('#height').bind('focusout',checkHasl);
		$('#insangle').bind('focusout',checkInsangle);
		
		$('#co2rate').bind('focusin',reCo2Rate);
		$('#co2rate').bind('focusout',checkCo2Rate);
		$('#currency').bind('focusin',reCurrency);
		$('#currency').bind('focusout',checkCurrency);
		$('#incomerate').bind('focusin',reIncomerate);
		$('#incomerate').bind('focusout',checkIncomerate);
		
		$('#flashCont')[0].style.display='none';
		$("#jd1").bind('focusout',checkJD);
		$("#jd1").bind('focusin',rejd);
		$("#jd2").bind('focusout',checkJD);
		$("#jd2").bind('focusin',rejd);
		$("#jd3").bind('focusout',checkJD);
		$("#jd3").bind('focusin',rejd);

		$("#wd1").bind('focusout',checkWD);
		$("#wd1").bind('focusin',rewd);
		$("#wd2").bind('focusout',checkWD);
		$("#wd2").bind('focusin',rewd);
		$("#wd3").bind('focusout',checkWD);
		$("#wd3").bind('focusin',rewd);

		$('#country').bind('change',changeCountry);
		$('#state').bind('change',changeState);
		
	}
	function repsno(){
		flag= false;
		$("#psno_tip").css("color","#000");
		$("#psno_tip").html(RES.INPUTISNO);
	}
	function restartDt(){
		flag = false;
		$("#startdt_tip").css("color","#000");
		$("#startdt_tip").html(RES.STARTDTSTYLE);
	}
	function rejd(){
		flag= false;
		$("#jd_tip").css("color","#000");
		$("#jd_tip").html(RES.RES_PLANT_JD_TI);
	}
	function rewd(){
		flag= false;
		$("#wd_tip").css("color","#000");
		$("#wd_tip").html(RES.RES_PLANT_WD_TI);
	}
	 function checkStartDt(){
		var dt=$("#startdt").val();
		dt = jQuery.trim(dt);
		if(dt !=""){
		var ereg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})/ ;
		
		var r = dt.match(ereg);
		if (!isDateString(dt)) {
			$("#startdt_tip").css("color","red");
			$("#startdt_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STARTDTSTYLEERR);
			flag = false;
			return false;
		}else{
			$("#startdt_tip").css("color","green");
			$("#startdt_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			flag = true;
		}
		
		}
		return true;
		
	}
	 function reInstallcap(){
			flag= false;
			$("#installcap_tip").css("color","#000");
			$("#installcap_tip").html("");
		}
	 function checkInstallcap(){
		 flag=false;
		 var inst=$("#installcap").val();
		 inst = jQuery.trim(inst);
			if(inst !=""){
				if(!checkNum(inst)){
					$("#installcap_tip").css("color","red");
					$("#installcap_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.INSTALLCAPERR);
					flag = false;
					return false;
				}else{
					$("#installcap_tip").css("color","green");
					$("#installcap_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
					flag = true;
				}
			}
		 return true;
	 }
	 var haveCheck=false;
	function checkPsno(){
		flag=false;
		
		var url = "checkPsno.action";
		var psno = $("#psno").val();
		var regno=$("#registno").val();
		
		if(psno.length==0){
			$("#psno_tip").css("color","red");
			$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PSNOCANNOTNULL);
			flag = false;
			return false;
		}
		if (regno==""){
			
			$("#psno_tip").css("color","red");
			$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REGNOINPUT);
			flag = false;
			return false;
		}
		
		
		var datajson = {"psno":psno,"registno":regno};
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
	function checkPsno2(){
		flag=false;
		
		var url = "checkPsno.action";
		var psno = $("#psno").val();
		var regno=$("#registno").val();
		
		if(psno.length==0){
			$("#psno_tip").css("color","red");
			$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.PSNOCANNOTNULL);
			flag = false;
			return false;
		}
		if (regno==""){
			
			$("#psno_tip").css("color","red");
			$("#psno_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.REGNOINPUT);
			flag = false;
			return false;
		}
		
		return true;
	
	}
	function  responseCheckIsno(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			$("#psno_tip").css("color","green");
			$("#psno_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;"+RES.PSNORIGHT);
			$("#psnoflag").val("true");
			return true;
		}else{
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

			$("#psnoflag").val("false");
			return false;
		}
	}
	function restaname(){
		flag = false;
		$("#stationname_tip").css("color","#000");
		$("#stationname_tip").html(RES.STANAMETIP);
	}
	function checkStationName(){
		var stationname = $("#stationname").val();
		
		stationname = jQuery.trim(stationname);
		if(stationname==""){
			$("#stationname_tip").css("color","red");
			$("#stationname_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STATIONNAMENOTNULL);
			flag = false;
			return false;
		}else{
			$("#stationname_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function reCo2Rate(){
		flag = false;
		$("#co2rate_tip").css("color","#000");
		$("#co2rate_tip").html(RES.CO2RATETIP);
	}
	function checkCo2Rate(){
		var co2rate = $("#co2rate").val();
		
		co2rate = jQuery.trim(co2rate);
		if(co2rate!="" && !checkNum(co2rate)){
			$("#co2rate_tip").css("color","red");
			$("#co2rate_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CO2RATETIP);
			flag = false;
			return false;
		}
		else if(co2rate==""){
			$("#co2rate_tip").css("color","red");
			$("#co2rate_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CO2RATETIP);
			flag = false;
			return false;
		}
		else {
			$("#co2rate_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}

		return true;
	}
	function reCurrency(){
		flag = false;
		$("#currency_tip").css("color","#000");
		$("#currency_tip").html(RES.CURRENCYTIP);
	}
	function checkCurrency(){
		var currency = $("#currency").val();
		
		currency = jQuery.trim(currency);
		if(currency==""){
			$("#currency_tip").css("color","red");
			$("#currency_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CURRENCYTIP);
			flag = false;
			return false;
		}else{
			$("#currency_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function reIncomerate(){
		flag = false;
		$("#incomerate_tip").css("color","#000");
		$("#incomerate_tip").html(RES.INCOMERATETIPTIP);
	}
	function checkIncomerate(){
		var incomerate = $("#incomerate").val();
		
		incomerate = jQuery.trim(incomerate);
		if(incomerate!="" && !checkNum(incomerate)){
			$("#incomerate_tip").css("color","red");
			$("#incomerate_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.INCOMERATETIPTIP);
			flag = false;
			return false;
		}
		else  if (incomerate==""){
			$("#incomerate_tip").css("color","red");
			$("#incomerate_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.INCOMERATETIPTIP);
			flag = false;
			return false;
		}else{
			$("#incomerate_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
		return true;
	}
	function recity(){
		flag = false;
		$("#city_tip").css("color","#000");
		$("#city_tip").html(RES.CITYINPUT);
	}
	function checkCity(){
		var city = $("#city").val();
		
		city = jQuery.trim(city);
		if(city==""){
			$("#city_tip").css("color","red");
			$("#city_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CITYINPUT);
			flag = false;
			return false;
		}else{
			$("#city_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function checkMoney(){
		var money = $("#money>option:selected").val();
		if(money==0){
			$("#money_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CHOOSEMONEY);
			flag = false;
			return false;
		}else{
			$("#money_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function checkCountry(){
		var country = $("#country>option:selected").val();
		if(country==0){
			$("#country_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.COUNTRYSELECT);
			return false;
		}else{
			$("#country_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function checkState(){
		var state = $("#state>option:selected").val();
		if(state==0){
			$("#state_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.STATESELECT);
			flag = false;
			return false;
		}else{
			$("#state_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}

	function checkTimezone(){
		var timezone =  $("#timezone>option:selected").val();
		if(timezone=="0"){
		$("#timezone_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.CHOOSETIMEZONE);
			flag = false;
			return false;
		}else{
			
			$("#timezone_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");

			flag = true;
			return true;
		}
	}
	function checkJD(){
		var jd1 = $("#jd1").val();
		var jd2 =  $("#jd2").val();
		var jd3 =  $("#jd3").val();
		var jd_total = parseInt(jd1)+parseInt(jd2)/60+parseInt(jd3)/3600;
		if((jd1!="" && !checkNum(jd1)) || (jd2!="" && !checkNum(jd2)) || (jd3!="" && !checkNum(jd3)) ){
			$("#jd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.XMUSTNUM);
			flag = false;
			return false;
		}
		else if (jd1!="" &&   parseInt(jd1)>180){
			$("#jd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_JD_ERR1);
			flag = false;
				return false;
		}
		else if (jd2!="" && parseInt(jd2)>60){
			$("#jd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_JD_ERR2);
			flag = false;
				return false;
		}
		else if (jd3!="" &&  parseInt(jd3)>60){
			$("#jd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_JD_ERR3);
			flag = false;
			return false;
		}
		else if (jd_total>180){
			$("#jd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_JD_TOTAL);
			flag = false;
			return false;
		}
		else{
			if(!(jd1=="" && jd2=="" && jd3==""))
			$("#jd_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			flag = true;
			return true;
		}
	}
	function checkWD(){
		var wd1 = $("#wd1").val();
		var wd2 =  $("#wd2").val();
		var wd3 =  $("#wd3").val();
		var wd_total = parseInt(wd1)+parseInt(wd2)/60+parseInt(wd3)/3600;
		if((wd1!="" && isNaN(wd1)) || (wd2!="" && isNaN(wd2)) || (wd3!="" && isNaN(wd3)) ){
			$("#wd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.YMUSTNUM);
			flag = false;
			return false;
		}else if (wd1!="" &&   parseInt(wd1)>180){
			$("#wd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_WD_ERR1);
			flag = false;
			return false;
		}
		else if (wd2!="" && parseInt(wd2)>60){
			$("#wd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_WD_ERR2);
			flag = false;
			return false;
		}
		else if (wd3!="" &&  parseInt(wd3)>60){
			$("#wd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_WD_ERR3);
			flag = false;
			return false;
		}
		else if (wd_total>180){
			$("#wd_tip").html("<img src='images/icon/delete.png' />&nbsp;&nbsp;"+RES.RES_PLANT_WD_TOTAL);
			flag = false;
			return false;
		}
		else{
			if(!(wd1=="" && wd2=="" && wd3==""))
			$("#wd_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
			flag = true;
			return true;
		}
	}
	function editForm(){
		if(checkStationName()&&checkMoney()&&checkTimezone()&&checkCo2xs()&&checkgainxs()){
			$.post("updateStation.action", 
				$("#editStation").serialize(),
				function(data){
					if(data.status=='ok'){
						drawmenu.getBody('powerlist.action');
					}				   
				 }, 
				"json");
		}
		
	}
	
	function responseEPS(data, textStatus, jqXHR){
			if(data.status=="ok"){
				drawmenu.getBody('detailStation.action?stid='+data.stid)
			}
	}
	
	function submitForm(){
		$("#submitImg").unbind("click",submitForm);
		if(checkPsno2() && checkStationName() &&  checkInstallcap() && checkStartDt() && checkCountry() && checkState() && checkCity() && checkJD() && checkWD() && checkHasl() && checkInsangle() && checkCo2Rate() && checkCurrency() && checkIncomerate() && checkTimezone() ){
			
			var opdate =new Date().format('yyyy-MM-dd hh:mm:ss');
			$("#opdate").val(opdate);
			if ($("#psnoflag").val()=="true"){	
				$("#createStationForm").submit();
			}else
				$("#submitImg").bind("click",submitForm);
		}else{
			$("#submitImg").bind("click",submitForm);
		}
	}
	
	function checkSname(){
		var stationname = $("#stationname").val();
		if(""==jQuery.trim(stationname)){
			$("#stationname_tip").css("color","red");
			$("#stationname_tip").val(RES.SNAMENOTNULL)
			flag = false;
			return false;
		}
		$("#stationname_tip").css("color","#000");

		flag = true;
		return true;
	}
	function checkCo2xs(){
		var co2xs = $("#co2xs").val();
		if(""==jQuery.trim(co2xs)){
			$("#co2xs_tip").css("color","red");
			$("#co2xs_tip").val(RES.CO2XSNOTNULL)
			flag = false;
			return false;
		}
		$("#co2xs_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
		$("#co2xs_tip").css("color","#000");

		flag = true;
		return true;
	}
	function checkgainxs(){
		var gainxs = $("#gainxs").val();
		if(""==jQuery.trim(gainxs)){
			
			$("#gainxs_tip").css("color","red");
			$("#gainxs_tip").val(RES.GAINXSNOTNULL)
			flag = false;
			return false;
		}
		$("#gainxs_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
		$("#gainxs_tip").css("color","#000");

		flag = true;
		return true;
	}
	//验证海拔
	function checkHasl(){
		var re =  /^(\-|\+)?\d+(\.\d+)?$/;
		var l_height = $("#height").val();
	     if (l_height!="")
	    	 {
	    	 if (!re.test(l_height)){
		        $("#height_tip").css("color","red");
				$("#height_tip").html(RES.HMUSTNUM);
				flag = false;
		        return false;
	    	 }
	     else{
	    	 
	    	  $("#height_tip").css("color","#000");
	 	     $("#height_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
	     }
			}else{
		    	 $("#height_tip").html("");
		     }
	   

			flag = true;
	     return true;
	}
	function checkInsangle(){
		var re = /^(\d+)(\.?)(\d{0,10})$/; 
		var insangle = $("#insangle").val();
	     if (insangle!=""){
	    	if(!re.test(insangle)){
		        $("#insangle_tip").css("color","red");
				$("#insangle_tip").html(RES.AOIMUSTNUM);
				flag = false;
		        return false;
		     }else if(insangle>360){
		    	 $("#insangle_tip").css("color","red");
		    	 $("#insangle_tip").html(RES.AOIMUSTNUM_INSANGLE);
		     }else{
		    	 $("#height_tip").css("color","#000");
		    	 $("#insangle_tip").html("<img src='images/icon/right.png' />&nbsp;&nbsp;");
		     }
	     }else{
	    	 $("#insangle_tip").html("");
	     }
		flag = true;
	     return true;
	}
	function checkNum(val){
		var re = /^(\d+)(\.?)(\d{0,10})$/; 
	     if (!re.test(val)){
	 		
	        return false;
	     }
	     
	    
	     return true;
	}
	function isDateString(sDate) 
	{  
	   var mp=/\d{4}-\d{2}-\d{2}/; 

	   var matchArray = sDate.match(mp); 
	   if (matchArray==null) return false; 
	   var iaMonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]; 
	   var iaDate = new Array(3); 
	   var year, month, day;  
	    
	    iaDate = sDate.split("-");     
	    if (isNaN(iaDate[0]) || isNaN(iaDate[1]) || isNaN(iaDate[2]) ) return false; 
	    year = parseFloat(iaDate[0]) 
	    month = parseFloat(iaDate[1]) 
	    day=parseFloat(iaDate[2]) 
	    if (year < 1900 || year > 2100) return false; 
	    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1]=29; 
	    if (month < 1 || month > 12) return false; 
	    if (day < 1 || day > iaMonthDays[month - 1]) return false; 
	    return true; 
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
	return {
		init:function(){init();}
	}
}();
function changFac(){
	$('#flashCont')[0].style.display='';
	$('#frame1')[0].style.display='';
}
function setFace (imgurl){
	$("#stface").attr("src",imgurl);
	$('#flashCont')[0].style.display='none';
	$('#frame1')[0].style.display='none';
	$('#picurl').val(imgurl);
	
}
function cancelSetFace (){
	$('#flashCont')[0].style.display='none';
	$('#frame1')[0].style.display='none';
}

function changeTimezone(){
	var isdst=$("#timezone").find("option:selected").attr("data"); 
	//alert(isdst);
	if(isdst=="0"){
		//$("#customerflag").attr("checked","");
		$("#dst").hide();
		$("#customerflag").val("0");
	}else{
		//$("#customerflag").attr("checked","checked");
		$("#dst").show();
		$("#customerflag").val("1");
		$("#customerflag").attr("checked","checked");
	}	
}

function changeCustomerflag(){
	//alert($("#customerflag").attr("checked"));
	if(true == $("#customerflag").attr("checked")){
		$("#customerflag").val("1");
	}else{
		$("#customerflag").val("0");
	}
}