var Power = function(){
  function doinit(){
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
  function daySubmit(){
  	var today = $dp.cal.getDateStr();
  	document.getElementById('flashCont').RefreshData(today);
  }
  function monthSubmit(){
  	var month = $dp.cal.getDateStr();
  	document.getElementById('flashCont').RefreshData(month);
  }
  function yearSubmit(){
  	var year = $dp.cal.getDateStr();
  	document.getElementById('flashCont').RefreshData(year);
  }
  return{
  	init:function(){doinit();},
  	daySubmit:function(){daySubmit();},
  	monthSubmit:function(){monthSubmit();},
  	yearSubmit:function(){yearSubmit();}
  }
}();
Power.init();
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
