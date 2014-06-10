var powerlist = function(){
	function delStation(stationid){
		if(confirm(RES.SUREDELSTATION)){
			var url = "delStation.action";
			var datajson = {"stid":stationid};
			$.ajax({
	            type: "POST",
	            url: url,
	            dataType: "json",
	            data: datajson,
	            success: responseDelStation,
	            error: function () {
	                alert(RES.REQUESTWRONG);
	            }
	    	});
		}else{
			return false;
		}
		
	}
	function responseDelStation(data, textStatus, jqXHR){
		if(data.status == 'ok'){
			drawmenu.getBody('powerlist.action');
		}else{
			
		}
	}
	return {
		delStation:function(stationid){delStation(stationid);}
	}
}();