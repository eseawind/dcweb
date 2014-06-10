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


var confPmu = function(){
	var flag=false;
	function init(){
		$('#searchImg').bind('click',submitForm);
		$('#firstP').bind('click',firstPage);
		$('#preP').bind('click',prePage);
		$('#lastP').bind('click',lastPage);
		$('#nextP').bind('click',nextPage);
	}
	
	function submitForm(){
		$('#page').val('1');
		var Val1 = $("#Val1").val();
		var val2 = $("#val2").val();
		var reg = /^\d+$/;
		//判断输入是否为数字
		if((Val1.match(reg) || Val1=="") && (val2.match(reg) || val2=="")){
			$("#searchForm").submit();
		}else{
			alert(RES.CONF_INPUT_LEGAL);
		}
	}
	
	function firstPage(){
		$('#page').val('1');
		$("#searchForm").submit();		
	}
	
	function lastPage(){
		$('#page').val($('#allPage').val());
		$("#searchForm").submit();		
	}
	
	function prePage(){
		var nowPage=parseInt($('#page').val());
        if (nowPage !=1){
    		nowPage=nowPage-1;
    		$('#page').val(nowPage+'');
    		$("#searchForm").submit();
        }
	}
	
	function nextPage(){
		var nowPage=parseInt($('#page').val());
		var allpage=parseInt($('#allPage').val());
        if (nowPage !=allpage){
    		nowPage=nowPage+1;
    		$('#page').val(nowPage+'');
    		$("#searchForm").submit();	
    	}
	}
	
	return {
		init:function(){init();}
	}
}();

function addDict(){
	var subtagObj=parent.document.getElementById("subtag");
	var langObj=parent.document.getElementById("lan");
	var infos="<table height='100%' width='540' border='0' cellspacing='0' cellpadding='0'>";
	infos= infos+"  <tr>";
	infos= infos+"    <td width='20%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>参数段:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	 infos= infos+"    <td width='30%'  background='images/listbg29.gif' class='black2'>" +
	"<input class='test_input8' id='subtag2'/>"+
	"</td>";
	 infos= infos+"    <td width='20%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>语言:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	 infos= infos+"    <td width='30%'  background='images/listbg29.gif' class='black2'>" +
	"<input class='test_input8' id='lan2'/>"+
	"</td>";
	 infos= infos+"  </tr>";
	 infos= infos+"  <tr>";
	 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>val1:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	 infos= infos+"    <td '  background='images/listbg29.gif' class='black2'><input class='test_input8' id='val12'/></td>";
	 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>val2:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	 infos= infos+"    <td   background='images/listbg29.gif' class='black2'><input class='test_input8' id='val22'/></td>";
	 infos= infos+"  </tr>";
	 infos= infos+"  <tr>";
	 infos= infos+"    <td  height='118'   class='black2' background='images/listbg29_2.gif'><div align='right'><strong>文本:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
	 infos= infos+"    <td   background='images/listbg29_2.gif' class='black2'  colspan='3' ><textarea id='context2' cols='52' rows='5'> </textarea></td>";
	 infos= infos+"  </tr>";
	 infos= infos+"  <tr>";
	 infos= infos+"    <td  height='38'  background='images/listbg29_2.gif' colspan='4' align='center'><input type='button' class='button1' value='确 定'   style='cursor:pointer' onclick='addDict2()'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button1' value='取 消'   style='cursor:pointer' onclick='closeDiv()'/></td>";
	 infos= infos+"  </tr>";
	 infos= infos+"</table>";
	art.dialog({
	    title: "添加参数",
		width:550,
		height: 100,
	    content: infos
	});
}

function closeDiv(){
	var ds = document.getElementsByTagName("div");
	for(var i = 0 ; i < ds.length ;i++){
		if(ds[i].style.position=="absolute")
			ds[i].style.display="none";
  	 	break;
   }
}

function addDict2(){
	var url = "createDict.action";
	var subtag2v=$('#subtag2').val();
	var lang2v=$('#lan2').val();
	var val12v=$('#val12').val();
	var val22v=$('#val22').val();
	var context2v=$('#context2').val();
	if (subtag2v==""){
		alert("请选择参数段！");
		return false;
	}
	if (lang2v==""){
		alert("请选择语种！");
		return false;
	}
	if (val12v==""){
		alert("请输入val1！");
		return false;
	}
	if (val22v==""){
		alert("请输入val2！");
		return false;
	}
	if (context2v==""){
		alert("请输入文本！");
		return false;
	}
	var datajson = {"subtag":subtag2v,"lan":lang2v,"Val1":val12v,"val2":val22v,"content":context2v};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: addDiectInfo,
        error: function () {
            alert(RES.REQUESTWRONG);
        }
    });
}

function addDiectInfo(data, textStatus, jqXHR){
	if(data.status == 'ok'){
		alert('添加成功');
		closeDiv();
	}else{
		if(data.errorcode == "1"){
			alert('该参数已经存在！');
		}
		if(data.errorcode == "2"){
			alert('错误的语种！');
		}
	}
}


function removeDict(subtags,lang,val1s,val2s){
	if (confirm("是否确认删除该参数?")) {
	var url = "removeDict.action";
	var datajson = {"subtag":subtags,"lan":lang,"Val1":val1s,"val2":val2s};
	$.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: datajson,
        success: removeDiectInfo,
        error: function () {
            alert(RES.REQUESTWRONG);
        }
    });
	}
}
function removeDiectInfo(data, textStatus, jqXHR){
	location.reload();
}

function updateDict(subtags,lang,val1s,val2s,contexts){
	var subtagObj=parent.document.getElementById("subtag");
	var langObj=parent.document.getElementById("lan");
	var infos="<table height='100%' width='540' border='0' cellspacing='0' cellpadding='0'>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td width='20%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>参数段:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='30%'  background='images/listbg29.gif' class='black2'>" +
		 		"<input type='hidden' id='subtag2' name='subtag2' value='"+subtags+"'>"+subtags+"</td>";
		 infos= infos+"    <td width='20%' height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>语言:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td width='30%'  background='images/listbg29.gif' class='black2'>" +
		 		"<input type='hidden' id='lan2' name='lan2' value='"+lang+"'>"+lang+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>val1:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td '  background='images/listbg29.gif' class='black2'><input type='hidden' id='val12' value='"+val1s+"' />"+val1s+"</td>";
	
		 infos= infos+"    <td  height='38'  background='images/listbg29.gif' class='black2'><div align='right'><strong>val2:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29.gif' class='black2'><input type='hidden' id='val22' value='"+val2s+"' />"+val2s+"</td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='118'   class='black2' background='images/listbg29_2.gif'><div align='right'><strong>文本:&nbsp;&nbsp;&nbsp;&nbsp;</strong></div></td>";
		 infos= infos+"    <td   background='images/listbg29_2.gif' class='black2'  colspan='3' ><textarea id='context2' cols='52' rows='5'>"+contexts+" </textarea></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"  <tr>";
		 infos= infos+"    <td  height='38'  background='images/listbg29_2.gif' colspan='4' align='center'><input type='button' class='button1' value='确 定'   style='cursor:pointer' onclick='updateDict2()'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' class='button1' value='取 消'   style='cursor:pointer' onclick='closeDiv()'/></td>";
		 infos= infos+"  </tr>";
		 infos= infos+"</table>";
		art.dialog({
		    title: "编辑参数",
			width:550,
			height: 100,
		    content: infos
		});
}


function updateDict2(){
	var url = "updateDict.action";
	var subtag2v=$('#subtag2').val();
	var lang2v=$('#lan2').val();
	var val12v=$('#val12').val();
	var val22v=$('#val22').val();
	var context2v=$('#context2').val();
	if (subtag2v==""){
		
		alert("请选择参数段！");
		return false;
	}
	if (lang2v==""){
		
		alert("请选择语种！");
		return false;
	}
	if (val12v==""){
		
		alert("请输入val1！");
		return false;
	}
	if (val22v==""){
		
		alert("请输入val2！");
		return false;
	}
	if (context2v==""){
		
		alert("请输入文本！");
		return false;
	}
	var datajson = {"subtag":subtag2v,"lan":lang2v,"Val1":val12v,"val2":val22v,"content":context2v};
	$.ajax({
            type: "POST",
            url: url,
            dataType: "json",
            data: datajson,
            success: updateDiectInfo,
            error: function () {
                alert(RES.REQUESTWRONG);
            }
    });
	
}
function updateDiectInfo(data, textStatus, jqXHR){
	location.reload();
}