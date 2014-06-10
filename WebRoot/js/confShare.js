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

var confShare = function(){
	var flag=false;
	function init(){

	}
	return {
		init:function(){init();}
	}
}();

function lockAcc(account,pmut,invt,usert,obj){
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"pmut":"0","invt":"0","usert":"0","state":"2"};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: lockres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function lockres(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		alert(RES.RES_SHAREACCOUNT_LOCK_OK);
		location.reload();
	}else{
		alert(RES.RES_SHAREACCOUNT_LOCK_FAILD);
	}
}

function unlockAcc(account,pmut,invt,usert,obj){
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"pmut":pmut,"invt":invt,"usert":usert,"state":"1"};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: unlockres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function unlockres(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		alert(RES.RES_SHAREACCOUNT_UNLOCK_OK);
		location.reload();
	}else{
		alert(RES.RES_SHAREACCOUNT_UNLOCK_FAILD);
	}
}

//编辑电站信息
function editAcc(account,obj,invt,report){
	var pmut=1;
	if (obj.checked==true)
		pmut=1;
	else
		pmut=0;
	var url = "createStationShareAccountRight.action";
	var rig=pmut+","+invt+","+report;
	var datajson = {"accountId":account,"rightStr":rig};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: pmures,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function pmures(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		location.reload();
	}else if(data.errorcode == '2'){
		alert(RES.RES_ADDSHAREACCOUNT_ERR_NOACC);
	}else{
		alert(RES.SET_FAILD);
	}
}

//设备管理
function invAcc(account,pmut,obj,report){
	var invt=1;
	if (obj.checked==true)
		invt=1;
	else
		invt=0;
	var url = "createStationShareAccountRight.action";
	var rig=pmut+","+invt+","+report;
	var datajson = {"accountId":account,"rightStr":rig};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: pmures,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

//配置报告
function reportAcc(account,pmut,invt,obj){
	var usert=1;
	if (obj.checked==true)
		usert=1;
	else
		usert=0;
	var url = "createStationShareAccountRight.action";
	var rig=pmut+","+invt+","+usert;
	var datajson = {"accountId":account,"rightStr":rig};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: pmures,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function removeAcc(state,account){
	if(confirm(RES.RES_DELSHAREACCOUNT_CONFIRM)){
		var url = "removeAccFromStation.action";
		var datajson = {"accountId":account,"state":state};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: removeres,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
}

function removeres(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		location.reload();
	}else{
		alert(RES.RES_DELSHAREACCOUNT_ERR);
	}
}

function addAccount(){
	var infos="<table width='100%' border='0' cellspacing='0' cellpadding='0'>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='20%' height='20' class='black2' ><div align='right'><strong>"+RES.RES_ACCOUNT+":&nbsp;&nbsp;</strong></div></td>";
	infos= infos+"    <td width='80%'   class='black2'><input type='text' size='20' id='newAccount' onfocus='renewAccount()'><span id='newtip1'></span></td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td height='20' colspan='2' class='black2'>"+RES.RES_ACCOUNT_STYLE+":12mou@Zeversolar.com</td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td height='20' colspan='2' class='black2'><span id='newtip2'></span></td>";
	infos= infos+"  </tr>";
	infos= infos+"  <tr>";
	infos= infos+"    <td height='20' colspan='2'><div align='center'><input type='button' class='button2' value='"+RES.PZINVOK+"' onclick='addnewAcctount()'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button2' value='"+RES.PZINVCANNEL+"' onclick='closeDiv()'></div></td>";
	infos= infos+"  </tr>";
	infos= infos+"</table>";
	art.dialog({
	    title: RES.RES_ADDSHAREACCOUNT,
		width: 300,
		height: 50,
	    content: infos
	});
}

function renewAccount(){
	$("#newtip1").css("color","red");
	$("#newtip1").html("");
	$("#newtip2").css("color","red");
	$("#newtip2").html("");
}

function addnewAcctount(){
	var acc=$('#newAccount').val();
	acc = jQuery.trim(acc);
	if (acc==""){
		$("#newtip1").css("color","red");
		$("#newtip1").html("<img src='images/icon/delete.png' />");
		$("#newtip2").css("color","red");
		$("#newtip2").html(RES.RES_ADDSHAREACCOUNT_NEEDINPUT);
		return false;
	}
	var url = "createStationShareAccount.action";
	var datajson = {"account":acc,"rightStr":"0,0,0"};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: addres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
}

function addres(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		 location.reload();
	}else{
		$("#newtip1").css("color","red");
		$("#newtip1").html("<img src='images/icon/delete.png' />");
		
		if(data.errorcode == '0'){
			$("#newtip2").css("color","red");
			$("#newtip2").html(RES.RES_ADDSHAREACCOUNT_ERR_UNKOW);
		}else if(data.errorcode == '2'){
			$("#newtip2").css("color","red");
			$("#newtip2").html(RES.RES_ADDSHAREACCOUNT_ERR_NOACC);
		}else if(data.errorcode == '1'){
			$("#newtip2").css("color","red");
			$("#newtip2").html(RES.RES_ADDSHAREACCOUNT_ERR_HAVESHARE);
		}
	}
}

function closeDiv(){
	var ds = document.getElementsByTagName("div");
    for(var i = 0 ; i < ds.length ;i++){
    	 if(ds[i].style.position=="absolute")
           ds[i].style.display="none";
   	 	break;
    }
}