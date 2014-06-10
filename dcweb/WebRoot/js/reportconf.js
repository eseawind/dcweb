var reportconf = function(){
	function init(){
	}
	function changeReportType(){
		var reportType = $("#reportTypeSel>option:selected").val();
		drawmenu.getBody("reportConf.action?reportType="+reportType);
	}
	function editReportConf(){
		var reportType = $("#reportTypeSel>option:selected").val();
		drawmenu.getBody("editReportConf.action?reportType="+reportType);
	}
	
	return {
		init:function(){init();},
		changeReportType:function(){changeReportType();},
		editReportConf:function(){editReportConf();}
	}
}();