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


var confAdmin = function(){
	var flag=false;
	function init(){

	}
	
	
	return {
		init:function(){init();}
	}
}();


function lockAcc(account,pmut,invt,usert,devt,eventt,obj){
	var url = "updateAdminAccount.action";
	var datajson = {"account":account, "updatet":pmut, "plantt":invt, "usert":usert, "devt":devt, "state":"2", "eventt":eventt};
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
		alert('锁定成功');
		location.reload();
	}else{
		alert('锁定失败');
	}
}

function unlockAcc(account,pmut,invt,usert,devt,eventt,obj){
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":pmut,"plantt":invt,"usert":usert,"devt":devt,"state":"1","eventt":eventt};
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
		alert('解除锁定成功');
		location.reload();
	}else{
		alert('解除锁定失败');
	}
}


function updateAcc(account,obj,plantt,usert,devt,state,eventt){
	var updatet=1;
	if (obj.checked==true)
		updatet=1;
	else
		updatet=0;
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":updatet,"plantt":plantt,"usert":usert,"devt":devt,"state":state,"eventt":eventt};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function updateres(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		
		 location.reload();
	}else{
		
			alert('设置失败');
		

		
	}
}
function plantAcc(account,updatet,obj,usert,devt,state,eventt){
	var plantt=1;
	if (obj.checked==true)
		plantt=1;
	else
		plantt=0;
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":updatet,"plantt":plantt,"usert":usert,"devt":devt,"state":state,"eventt":eventt};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function userAcc(account,updatet,plantt,obj,devt,state,eventt){
	var usert=1;
	if (obj.checked==true)
		usert=1;
	else
		usert=0;
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":updatet,"plantt":plantt,"usert":usert,"devt":devt,"state":state,"eventt":eventt};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function devAcc(account,updatet,plantt,usert,obj,state,eventt){
	var devt=1;
	if (obj.checked==true)
		devt=1;
	else
		devt=0;
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":updatet,"plantt":plantt,"usert":usert,"devt":devt,"state":state,"eventt":eventt};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}

function eventAcc(account,updatet,plantt,devt,usert,obj,state){
	var event=1;
	if (obj.checked==true)
		event=1;
	else
		event=0;
	var url = "updateAdminAccount.action";
	var datajson = {"account":account,"updatet":updatet,"plantt":plantt,"usert":usert,"devt":devt,"eventt":event,"state":state};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateres,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function removeAcc(account){
	 if(window.confirm('确认删除该管理员账号!')){

	var url = "removeAdminAccount.action";
	var datajson = {"account":account};
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
		
			alert('删除失败');
		

		
	}
}
function addAccount(){
	    
		var infos="<table width='100%' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='20%' height='20'   class='black2'><div align='right'><strong>账号:&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='80%'   class='black2'><input type='text' size='20' id='newAccount' onfocus='renewAccount()'><span id='newtip1'></span></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td height='20' colspan='2' class='black2'><span id='newtip2'></span></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td height='20' colspan='2' class='black2'><div align='center'><input type='button' class='button2' value='"+RES.PZINVOK+"' onclick='addnewAcctount()'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button2' value='"+RES.PZINVCANNEL+"' onclick='closeDiv()'></div></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"</table>";
		art.dialog({
		    title: '系统管理员帐号添加',
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
		$("#newtip2").html("请输入管理员账号！");
		return false;
	}
	var url = "addAdminAccount.action";
	var datajson = {"account":acc,"updatet":"0","plantt":"0","usert":"0","devt":"0","eventt":"0","state":"1"};
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
		
		if(data.errorcode == '2'){
			$("#newtip2").css("color","red");
			$("#newtip2").html("未知的错误！");
		}else if(data.errorcode == '1'){
			$("#newtip2").css("color","red");
			$("#newtip2").html("账号不存在！");
		}else if(data.errorcode == '0'){
			$("#newtip2").css("color","red");
			$("#newtip2").html("该账号已是共享账号！");
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