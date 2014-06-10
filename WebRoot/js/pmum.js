var pmum = function(){
	var flag =false;
	
	function init(){
	
	}
	function enterPmuno(){
		flag = false;
		$("#psno_tip").val("");
	}
	
	//遮罩层显示部分
	function LoadShow(width,title){
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
			
			$("body").append("<div id='TB_load'>"+
							 "<table border='0' cellpadding='0' cellspacing='0' style='width:"+width+"px;border: 2px solid #ccc;background:#fff;margin:0 auto;'>"+
							 "<tr id='TB_title' height='30px' style='background: url(images/bg_tab.jpg) 0px -197px repeat-x;cursor:move;'>"+
							 "<td align='left' style='width:30px;'>&nbsp;&nbsp;<img src='images/icon/edit.png' /></td>"+
							 "<td align='left' style='width:200px;'><span class='spantitle'>"+title+"</span></td>"+
							 "<td align='right'  style='width:"+(width-230)+"px;padding-right:5px;'><span class='spantitle' style='cursor:pointer;' onclick='pmum.LoadHidden()'><image src='images/icon/close.png' /></span></td>"+
							 "</tr>"+
							 "<tr  height='30px'><td colspan='3' id='confSelIvn'><img src='images/loading.gif' /></td></tr></table></div>");//add loader to the page
			$('#TB_overlay').show();
			$('#TB_load').css('top',300);
			$('#TB_load').css('top',($(document).width)-700/2);
			$('#TB_load').show();
			var x = 0;
	       var y = 0;
	       var check = false;
	       
	       $(function(){$('#TB_load').mousedown(function(evt){
	           check = true;
	           x = evt.pageX-parseInt($('#TB_load').css('left'),10);
	           y = evt.pageY-parseInt($('#TB_load').css('top'),10);  
	           });
	       });
	        
	       $(function(){$(document).mousemove(function(evte){
	           if(!check)  return false;   
	           $('#TB_load').css('top',evte.pageY-y);
	           $('#TB_load').css('left',evte.pageX-x);      
	           });
	       });
	        
	       $(function(){$(document).mouseup(function(){    
	          check = false; 
	      	 });
	       });
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
	
	function outPmuno(){
		$("#psno_tip").val("loading...");
		var psno = $("#psno").val();
		var url = "checkPsno.action";
		var datajson = {"psno":psno};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseCheckPsno1,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	function responseCheckPsno1(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			flag=true;
			$("#psno_tip").css("color","green");
			$("#psno_tip").html(RES.VSPASS);
			
		}else{
			if(data.errorcode==1){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html(RES.PMUHASBINDED);
			}else  if(data.errorcode==0){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html(RES.PMUNOTEXIST);
			}
			return false;
		}
	}
	function bindPmu(){
		var width = 450;
		LoadShow(width,RES.ADDPMU);
		var bindDiv = "<div style='line-height:24px;' id='psno_tip'></div><div style='height:40px;line-height:40px;'>PMU "+RES.PSNO+"：<input id='pop_psno' class='input_txt' type='text' name='pmuno'></div>";
		$("#confSelIvn").html(bindDiv);
		var btnStr = "<div id='cc' style='height:40px;line-height:40px;'><input class='input_btn' id='pop_bindPmu'  type='button' value='"+RES.PZINVOK+"' /><input onclick='pmum.LoadHidden()' class='input_btn' style='margin-left:10px;'  type='button' value='"+RES.PZINVCANNEL+"' /></div>";
		$("#confSelIvn").append(btnStr);
		$('#pop_bindPmu').bind({
		  'click': dobindPmu
		});
	}
	function showPmuInfo(psno,ip,mac,softver,hardver,usedspace,totalspace,lldt){
		var width = 450;
		LoadShow(width,psno+' '+RES.ATTR);
		var bindDiv = "<table  border='0' cellpadding='0' cellspacing='0' width='80%' style='line-height:30px;border:1px solid #666;margin:10px auto;'>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>IP:</td><td align='left' width='70%'>"+ip+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td align='right' width='30%'>MAC:</td><td align='left' width='70%'>"+mac+"</td>"
						+"</tr>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.SOFTVRE+":</td><td align='left' width='70%'>"+softver+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td align='right' width='30%'>"+RES.HARDVRE+":</td><td align='left' width='70%'>"+hardver+"</td>"
						+"</tr>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.USEDSPACE+":</td><td align='left' width='70%'>"+usedspace+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td align='right' width='30%'>"+RES.TOTALSPACE+":</td><td align='left' width='70%'>"+totalspace+"</td>"
						+"</tr>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.LTIME+":</td><td align='left' width='70%'>"+lldt+"</td>"
						+"</tr>"
					  +"</table>";
		$("#confSelIvn").html(bindDiv);
		var btnStr = "<div id='cc' style='height:40px;line-height:40px;'><input onclick='pmum.LoadHidden()' class='input_btn' style='margin-left:10px;'  type='button' value='"+RES.PZINVOK+"' /></div>";
		$("#confSelIvn").append(btnStr);
		
	}
	function showInvInfo(isno,byName,factory,softver,hardver,ludt){
		var width = 450;
		LoadShow(width,byName+' '+RES.ATTR);
		var bindDiv = "<table  border='0' cellpadding='0' cellspacing='0' width='80%' style='line-height:30px;border:1px solid #666;margin:10px auto;'>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.PSNO+":</td><td align='left' width='70%'>"+isno+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td align='right' width='30%'>"+RES.FACTORY+":</td><td align='left' width='70%'>"+factory+"</td>"
						+"</tr>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.SOFTVRE+":</td><td align='left' width='70%'>"+softver+"</td>"
						+"</tr>"
						+"<tr>"
							+"<td align='right' width='30%'>"+RES.HARDVRE+":</td><td align='left' width='70%'>"+hardver+"</td>"
						+"</tr>"
						+"<tr style='background:#ccc;'>"
							+"<td align='right' width='30%'>"+RES.LTIME+":</td><td align='left' width='70%'>"+ludt+"</td>"
						+"</tr>"
					  +"</table>";
		$("#confSelIvn").html(bindDiv);
		var btnStr = "<div id='cc' style='height:40px;line-height:40px;'><input onclick='pmum.LoadHidden()' class='input_btn' style='margin-left:10px;'  type='button' value='"+RES.PZINVOK+"' /></div>";
		$("#confSelIvn").append(btnStr);
		
	}
	function dobindPmu(){
		$('#pop_bindPmu').unbind('click');
	   	var psno = $("#pop_psno").val();
	   	var datajson = {"psno":psno};
		var url = "bindPmu.action";
		$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: responsebindPmu,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    	});
	}
	function responsebindPmu(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			alert("binded Pmu success");
			drawmenu.getBody('showStationPmu.action');
			LoadHidden();
		}else{
			$('#pop_bindPmu').bind({
			  click: dobindPmu
			});
			if(data.stauts="error"&&data.errorcode=="1"){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html(RES.PMUHASBINDED);
			}else if(data.stauts="error"&&data.errorcode=="2"){
				$("#psno_tip").css("color","red");
				$("#psno_tip").html(RES.PMUNOTEXIST);
			}
			return false;
		}
	}
	function unbindPmu(psno){
		var url = "unbindPmu.action";
		var datajson = {"psno":psno};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseUnbindPmu,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	function responseUnbindPmu(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			alert("unbind Pmu success");
			drawmenu.getBody('showStationPmu.action');
		}else{
			return false;
		}
	}
	function update(){
		var param="";
		var invName = $("#invName").val();
		if(invName!=""){
			param="&invName="+encodeURI(invName);
		}
		var number = $("#number").val();
		var pino = $("#eqsel>option:selected").val();
		if(pino!=-1){
			number=pino;
		}
		if(number!=""){
			param=param+"&pino="+number;
		}
		var state = $("#statesel>option:selected").val();
		if(state!=-1){
			param=param+"&state="+state;
		}
		drawmenu.getBody("showStationPmu.action?a=a"+param);
	}
	function showlog(isno){
		drawmenu.getBody("event.action?isno="+isno);
	}
	function updateInvName(isno){
		if(typeof($("#txt_name_"+isno).val())=='undefined'){
			$("#inv_name_"+isno).html("<input id='txt_name_"+isno+"' type='text' value='"+$("#inv_name_"+isno).html()+"' />");
		}
		$("#txt_name_"+isno).bind('focusin',function(){
			
		});
		$("#txt_name_"+isno).bind('focusout',function(){
			changeInvName(isno);
		});
	}
	function changeInvName(isno){
		var byName = $("#txt_name_"+isno).val();
		$("#inv_name_"+isno).html(byName);
		var url = "reNamePmu.action";
		var datajson={"isno":isno,"byName":byName};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function(){},
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    });
	}
	return{
		init:function(){init();},
		unbindPmu:function(psno){unbindPmu(psno);},
		enterPmuno:function(psno){enterPmuno();},
		outPmuno:function(psno){outPmuno();},
		bindPmu:function(){bindPmu();},
		LoadHidden:function(){LoadHidden();},
		showPmuInfo:function(psno,ip,mac,softver,hardver,usedspace,totalspace,lldt){showPmuInfo(psno,ip,mac,softver,hardver,usedspace,totalspace,lldt);},
		showInvInfo:function(isno,byName,factory,softver,hardver,ludt){showInvInfo(isno,byName,factory,softver,hardver,ludt);},
		showlog:function(isno){showlog(isno);},
		updateInvName:function(isno){updateInvName(isno);},
		update:function(){update();}
	}
}();
function pageselectCallback1(page_id, jq){
	var startid = page_id*pageSize;
	var endid = page_id*pageSize+pageSize-1;
	$("#Searchresult tr").css("display","none");
	$($("#Searchresult tr")[0]).css("display","");
	for(var i=startid;i<=endid;i++){
		$("#page_"+i).css("display","");
	}
 }