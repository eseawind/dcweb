
var DCPOWER = function(){
	var allInvMap;
	var tempShowInvMap;
	var alltype;
	var pageSize = 18;
	var paramtype='';
	var paramdate = '';
	function doinit(inallInvMap,intype,in2type,indate){
		//alert(inallInvMap);
		allInvMap = jQuery.parseJSON(inallInvMap) ;
		alltype = intype;
		paramtype= in2type;
		paramdate = indate;
	  	$(".p_rttab .tab").click(function(e){
	  		initTab();
			var divList = $(this).children('div');
			$(divList[0]).attr("class","tableft_on");
			$(divList[1]).attr("class","tabcenter_on");
			$(divList[2]).attr("class","tabright_on");
			drawmenu.getBody($(this).attr('linked'));
		});
	}
	function initTab(){
	  	var tabList = $(".p_rttab .tab");
	  	for(var i=0;i<tabList.length;i++){
	  		var divList = $(tabList[i]).children('div');
			$(divList[0]).attr("class","tableft_off");
			$(divList[1]).attr("class","tabcenter_off");
			$(divList[2]).attr("class","tabright_off");
	  	}
	}
	function refreshSwf(sdate){
		var date='';
		if(typeof(sdate) !='undefined'){
			date = sdate;
		}else{
			var date = $("#sdate").val();
		} 
		go(date);
	}
	function isShow(obj){
		var Channel = $(obj).attr("id");
		var flag = $(obj).attr("checked");
		document.getElementById('flashCont').SwitchItem(Channel,flag);  
	}
	function isShowChannel(obj){
		var Channel = $(obj).attr("id");
		var name = $(obj).attr("name");
		var count = $(obj).attr("count");
		var flag = $(obj).attr("checked");
		for(var i=1;i<=count;i++){
			//$("#"+Channel+"_"+i).attr("checked",flag);
			document.getElementById('flashCont').SwitchItem(name+"_"+i,flag);  
		}
	}
	function refreshUrl(url){
		var date = $("#sdate").val(); 
		drawmenu.getBody(url+"?sdate="+date);
	}
	//遮罩层显示部分
	function LoadShow(){
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
							 "<table border='0' cellpadding='0' cellspacing='0' style='width:680px;border: 2px solid #ccc;background:#fff;'>"+
							 "<tr id='TB_title' height='30px' style='background: url(images/bg_tab.jpg) 0px -197px repeat-x;cursor:move;'>"+
							 "<td align='left' width='30px'>&nbsp;&nbsp;<img src='images/icon/edit.png' /></td>"+
							 "<td align='left' width='200px'><span class='spantitle'>"+RES.PZINV+"</span></td>"+
							 "<td align='right' width='450px' style='padding-right:5px;'><span class='spantitle' style='cursor:pointer;' onclick='DCPOWER.LoadHidden()'><image src='images/icon/close.png' /></span></td>"+
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
	function confShowInv(){
		LoadShow();
		if(alltype=='acp'||alltype=='inve'||alltype=='acf'){
			responseCSI2();
		}else{
			responseCSI();
		}
	}
	var resultjson = new Array();
	function responseCSI(){
		tempShowInvMap = allInvMap;
		var z=0;
		if($("#TB_load")){
			var listr="";
			for(var i=0;i<allInvMap.length;i++){
				var channelArr = allInvMap[i].channels.split("\^");
				for(var j=1;j<=allInvMap[i].channelCount;j++){
					if(jQuery.inArray(j+"",channelArr)<0){
						if(z<pageSize){
							listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' id='"+allInvMap[i].isno+"_"+j+"' onclick='DCPOWER.cc(this)' /></td><td>"+allInvMap[i].byName+"_"+j+"</td></tr></table></li>";
							z++;
						}else{
							listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;display:none;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' id='"+allInvMap[i].isno+"_"+j+"' onclick='DCPOWER.cc(this)' /></td><td>"+allInvMap[i].byName+"_"+j+"</td></tr></table></li>";
							z++;
						}
					}else{
						if(z<pageSize){
							listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' checked='true'  id='"+allInvMap[i].isno+"_"+j+"' onclick='DCPOWER.cc(this)'  /></td><td>"+allInvMap[i].byName+"_"+j+"</td></tr></table></li>";
							z++;
						}else{
							listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;display:none;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' checked='true'  id='"+allInvMap[i].isno+"_"+j+"' onclick='DCPOWER.cc(this)' /></td><td>"+allInvMap[i].byName+"_"+j+"</td></tr></table></li>";
							z++;
						}
					}
				}
			}
			var fangan = "<table id='fangan' border='0' cellpadding='0' cellspacing='0' style='width:540px;border: 1px solid #ccc;background:#fff;display:none;margin:10px auto;'></table>";
			var ulStr = "<ul id='invpageul' style='float:left;width:510px;margin-left:55px;margin-top:10px;margin-bottom:10px;padding:0 25px;'>"+listr+"</ul>";
			var showResult = "<div id='showresult' style='float:left;width:510px;margin-left:55px;margin-top:10px;padding:0 25px;text-align:left;cursor:pointer;' onclick='DCPOWER.showfangan()'><span class='spantitle' >"+RES.CKINV+"</span></div>"
			$("#confSelIvn").html(showResult);
			$("#confSelIvn").append(ulStr);
			$("#confSelIvn").append("<div class='clear'></div><div id='fenye' style='width:510px;position:relative;margin-left:55px;padding:0 25px;height:30px;'><div id='invpage' class='pagination' style='height: 30px;position:absolute;right:0px;'></div></div>");
			$("#confSelIvn").append(fangan);
			var btnStr = "<div id='cc' style='float:left;width:510px;margin-left:55px;margin-top:10px;margin-bottom:10px;'><input class='input_btn' onclick='DCPOWER.saveChanel()'  type='button' value='"+RES.PZINVOK+"' /><input onclick='DCPOWER.LoadHidden()' class='input_btn' style='margin-left:10px;'  type='button' value='"+RES.PZINVCANNEL+"' /></div>";
			$("#confSelIvn").append(btnStr);
			$("#confSelIvn").append("<div class='clear'></div>");
		}
		if(z>pageSize){
			$("#invpage").pagination(z, {
					 		items_per_page:pageSize,
							num_edge_entries: 2,
							um_display_entries: 4,
							next_text:">",
							prev_text:"<",
					        callback: pageselectCallback
			 });
	    }
	}
	
	function responseCSI2(){
		tempShowInvMap = allInvMap;
		var z=0;
		if($("#TB_load")){
			var listr="";
			for(var i=0;i<allInvMap.length;i++){
				if(z<pageSize){
					if(allInvMap[i].channels!="0"){
						listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' id='"+allInvMap[i].isno+"' onclick='DCPOWER.cc2(this)' /></td><td>"+allInvMap[i].byName+"</td></tr></table></li>";
						z++;
					}else{
						listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' checked='true' id='"+allInvMap[i].isno+"' onclick='DCPOWER.cc2(this)' /></td><td>"+allInvMap[i].byName+"</td></tr></table></li>";
						z++;
					}
				}else{
					if(allInvMap[i].channels!="0"){
						listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;display:none;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' id='"+allInvMap[i].isno+"' onclick='DCPOWER.cc2(this)' /></td><td>"+allInvMap[i].byName+"</td></tr></table></li>";
						z++;
					}else{
						listr =listr+ "<li id='invpageli_"+z+"' style='float:left;width:170px;text-align:left;height:30px;display:none;'><table><tr><td align='left' width='24px'><input class='isnocheckbox' type='checkbox' checked='true' id='"+allInvMap[i].isno+"' onclick='DCPOWER.cc2(this)' /></td><td>"+allInvMap[i].byName+"</td></tr></table></li>";
						z++;
					}
				}
			}
			var fangan = "<table id='fangan' border='0' cellpadding='0' cellspacing='0' style='width:540px;border: 1px solid #ccc;background:#fff;display:none;margin:10px auto;'></table>";
			var ulStr = "<ul id='invpageul' style='float:left;width:510px;margin-left:55px;margin-top:10px;margin-bottom:10px;padding:0 25px;'>"+listr+"</ul>";
			var showResult = "<div id='showresult' style='float:left;width:510px;margin-left:55px;margin-top:10px;padding:0 25px;text-align:left;cursor:pointer;' onclick='DCPOWER.showfangan2()'><span class='spantitle' >查看当前方案</span></div>"
			$("#confSelIvn").html(showResult);
			$("#confSelIvn").append(ulStr);
			$("#confSelIvn").append("<div class='clear'></div><div id='fenye' style='width:510px;position:relative;margin-left:55px;padding:0 25px;height:30px;'><div id='invpage' class='pagination' style='height: 30px;position:absolute;right:0px;'></div></div>");
			$("#confSelIvn").append(fangan);
			var btnStr = "<div id='cc' style='float:left;width:510px;margin-left:55px;margin-top:10px;margin-bottom:10px;'><input class='input_btn' onclick='DCPOWER.saveChanel2()'  type='button' value='"+RES.PZINVOK+"' /><input onclick='DCPOWER.LoadHidden()' class='input_btn' style='margin-left:10px;'  type='button' value='"+RES.PZINVCANNEL+"' /></div>";
			$("#confSelIvn").append(btnStr);
			$("#confSelIvn").append("<div class='clear'></div>");
		}	
		if(z>pageSize){
			$("#invpage").pagination(z, {
					 		items_per_page:pageSize,
							num_edge_entries: 2,
							um_display_entries: 4,
							next_text:">",
							prev_text:"<",
					        callback: pageselectCallback
			 });
	    }
	}
	
	function pageselectCallback(page_id, jq){
				var startid = page_id*pageSize;
		    	var endid = page_id*pageSize+pageSize-1;
		    	$("#invpageul li").css("display","none");
		    	for(var i=startid;i<=endid;i++){
		    		$("#invpageli_"+i).css("display","");
		    	}
	}
	function LoadHidden(){
		$('#TB_overlay').remove();
		$("#TB_load").remove();
	}
	function saveChanel(){
		var t1 = "";
		var t2= "";
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].channels.length>0){
				t1 = t1+tempShowInvMap[i].isno+","
				t2 = t2+tempShowInvMap[i].channels+","
			}
		}
		var url = "changeShowInv.action";
		var datajson = {"type":alltype,"isnos":t1,"channels":t2};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function (data, textStatus, jqXHR) {
	                if(data.status=="ok"){
	                	go(paramdate);
	                	LoadHidden();
	                };
	            },
	            error: function () {
	                (RES.REQUESTWRONG);
	            }
	    	});
	}
	
	function saveChanel2(){
		var t1 = "";
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].channels=="0"){
				t1 = t1+tempShowInvMap[i].isno+","
			}
		}
		var url = "changeShowInv.action";
		var datajson = {"type":alltype,"isnos":t1,"channels":""};
		$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: function (data, textStatus, jqXHR) {
	                if(data.status=="ok"){
	                	go(paramdate);
	                	LoadHidden();
	                };
	            },
	            error: function () {
	                (RES.REQUESTWRONG);
	            }
	    	});
	}
	
	function go(tdate){
	
						if(alltype=="acc"){
	                		drawmenu.getBody("acc.action?type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="dcc"){
	                		drawmenu.getBody("dcc.action?type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="dcp"){
	                		drawmenu.getBody("dcp.action?type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="dcv"){
	                		drawmenu.getBody("dcv.action?type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="acp"){
	                		drawmenu.getBody("acp.action??type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="acv"){
	                		drawmenu.getBody("acv.action??type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="inve"){
	                		drawmenu.getBody("inve.action??type="+paramtype+"&sdate="+tdate);
	                	}else if(alltype=="acf"){
	                		drawmenu.getBody("acf.action??type="+paramtype+"&sdate="+tdate);
	                	}
	}
	//逆变器选择
	function cc(obj){
	//tempShowInvMap  allInvMap
		var id = $(obj).attr('id');
		var checked = $(obj).attr("checked");
		var isno = id.split("_")[0];
		var channel = id.split("_")[1];
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].isno== isno){
				if(tempShowInvMap[i].channels==""){
					if(checked){
						tempShowInvMap[i].channels=channel;
					}
				}else{
					var temp_channelArr = tempShowInvMap[i].channels.split("\^");
					var index = jQuery.inArray( channel, temp_channelArr );
					if(index>=0){
						if(!checked){temp_channelArr.removeAt(index);}
						var channels = "";
						for(var j=0;j<temp_channelArr.length;j++){
							if(j==0){
								channels = channels+temp_channelArr[j];
							}else{
								channels= channels+"^"+temp_channelArr[j];
							}
						}
						tempShowInvMap[i].channels=channels;
					}else{
						tempShowInvMap[i].channels= tempShowInvMap[i].channels+"^"+channel;
					}
						
				}
			}	
		}
	}
	//逆变器选择
	function cc2(obj){
	//tempShowInvMap  allInvMap
		var isno = $(obj).attr('id');
		var checked = $(obj).attr('checked');
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].isno== isno){
				if(checked){
					tempShowInvMap[i].channels="0";
				}else{
					tempShowInvMap[i].channels="";
				}
			}	
		}
	}
	Array.prototype.removeAt=function(dx) 
	{ 
	    if(isNaN(dx)||dx>this.length){return false;} 
	    for(var i=0,n=0;i<this.length;i++) 
	    { 
	        if(this[i]!=this[dx]) 
	        { 
	            this[n++]=this[i] 
	        } 
	    } 
	    this.length-=1 
	} 
	function showfangan(){
		if($("#fangan").css("display")=="none"){
			var fanganli="";
			$("#showresult").html("<span class='spantitle' >"+RES.BACKINV+"</span>");
	 		for(var i=0;i<tempShowInvMap.length;i++){
	 			var byName = tempShowInvMap[i].byName;
	 			var channels = tempShowInvMap[i].channels;
	 		    var channelArr =channels.split("\^");
				var cstr = "";
				channelArr.sort();
				for(var k=0;k<channelArr.length;k++){
					cstr =cstr+"<li style='float:left;width:170px;overflow:hidden;height:30px;'>"+ byName+"_"+channelArr[k]+"&nbsp;&nbsp;</li>";
				}
				if(channels!=""){
					fanganli= fanganli+cstr;
		 		}
		 	}
		 	if(fanganli==""){
		 		fanganli= fanganli+ "<tr><td align='center' height='30px'>"+RES.BACKINVTIP+"</td></tr>";
		 	}else{
		 		fanganli="<tr style='line-height:24px;'><td align='left' style='padding-left:10px;padding-right:10px;'><ul>"+fanganli+"</ul></td></tr>";
		 	}
		 	$("#fangan").html(fanganli);
			
		 	$("#invpageul").css("display","none");
		 	$("#fenye").css("display","none");
		 	$("#channelul").css("display","none");
		 	$("#fangan").css("display","");
	 	}else{
	 		$("#showresult").html("<span class='spantitle' >"+RES.CKINV+"</span>");
		 	$("#invpageul").css("display","");
		 	$("#fenye").css("display","");
		 	$("#fangan").css("display","none");
	 	}
	}
	
	function showfangan2(){
		if($("#fangan").css("display")=="none"){
			var fanganli="";
			$("#showresult").html("<span class='spantitle' >"+RES.BACKINV+"</span>");
	 		for(var i=0;i<tempShowInvMap.length;i++){
	 			var byName = tempShowInvMap[i].byName;
	 			var channels = tempShowInvMap[i].channels;
				if(channels=="0"){
					fanganli =fanganli+"<li style='float:left;width:170px;overflow:hidden;height:30px;'>"+ byName+"&nbsp;&nbsp;</li>";
				}
		 	}
		 	if(fanganli==""){
		 		fanganli= fanganli+ "<tr><td align='center' height='30px'>"+RES.CKINV+"</td></tr>";
		 	}else{
		 		fanganli="<tr style='line-height:24px;'><td align='left' style='padding-left:10px;padding-right:10px;'><ul>"+fanganli+"</ul></td></tr>";
		 	}
		 	$("#fangan").html(fanganli);
			
		 	$("#invpageul").css("display","none");
		 	$("#fenye").css("display","none");
		 	$("#channelul").css("display","none");
		 	$("#fangan").css("display","");
	 	}else{
	 		$("#showresult").html("<span class='spantitle' >"+RES.CKINV+"</span>");
		 	$("#invpageul").css("display","");
		 	$("#fenye").css("display","");
		 	$("#fangan").css("display","none");
	 	}
	}
	
	function deleteChannel(isno,channel){
		tempShowInvMap = allInvMap;
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].isno== isno){
					var temp_channelArr = tempShowInvMap[i].channels.split("\^");
					var index = jQuery.inArray( channel, temp_channelArr );
					if(index>=0){
						temp_channelArr.removeAt(index);
						var channels = "";
						for(var j=0;j<temp_channelArr.length;j++){
							if(j==0){
								channels = channels+temp_channelArr[j];
							}else{
								channels= channels+"^"+temp_channelArr[j];
							}
						}
						tempShowInvMap[i].channels=channels;
					}
				}
			}
		saveChanel();	
	}
	function deleteChannel2(isno){
		tempShowInvMap = allInvMap;
		for(var i=0;i<tempShowInvMap.length;i++){
			if(tempShowInvMap[i].isno== isno){
					tempShowInvMap[i].channels="";
			}
		}
		saveChanel();	
	}
	return{
		init:function(allInvMap,type,in2type,insdate){doinit(allInvMap,type,in2type,insdate);},
		refreshSwf:function(sdate){refreshSwf(sdate);},
		isShow:function(obj){isShow(obj);},
		isShowChannel:function(obj){isShowChannel(obj);},
		confShowInv:function(){confShowInv();},
		LoadHidden:function(){LoadHidden();},
		saveChanel:function(){saveChanel();},
		saveChanel2:function(){saveChanel2();},
		cc:function(obj){cc(obj);},
		cc2:function(obj){cc2(obj);},
		showfangan:function(){showfangan();},
		showfangan2:function(){showfangan2();},
		chickPchannel:function(obj){chickPchannel(obj)},
		deleteChannel:function(isno,channel){deleteChannel(isno,channel);},
		deleteChannel2:function(isno){deleteChannel2(isno);},
		refreshUrl:function(url){refreshUrl(url);}
	}
}();
var download = function(){
	function cvsdownload(){
		var t =$("#t").val();
		var tabList = $(".p_rttab .tab");
		var sdate = "";
		var ct = $("#ct").val();
		if(ct=="day"){
			sdate = $("#d11").val();
		}else if (ct=="month"){
			sdate = $("#d12").val();
		}else if (ct=="year"){
			sdate = $("#d13").val();
		}
		var url = "csvdownload.action?t="+t+"&ct="+ct+"&sdate="+sdate;
		window.location.href= url;
	}
	function txtdownload(){
		var t =$("#t").val();
		var tabList = $(".p_rttab .tab");
		var sdate = "";
		var ct = $("#ct").val();
		if(ct=="day"){
			sdate = $("#d11").val();
		}else if (ct=="month"){
			sdate = $("#d12").val();
		}else if (ct=="year"){
			sdate = $("#d13").val();
		}
		var url = "txtdownload.action?t="+t+"&ct="+ct+"&sdate="+sdate;
		window.location.href= url;
	}
	function PrintCharts(){
		document.getElementById('flashCont').PrintChart();
	}
	return{
		cvsdownload:function(){cvsdownload();},
		txtdownload:function(){txtdownload();},
		printCharts:function(){PrintCharts();}
	}
}();

