
function OpenNewWin(url) {
	var popup = window.open(url,"_blank");
}

function showFlashElement(swfname,flashvars) {
	var version = swfobject.getFlashPlayerVersion();
	//alert(version.major+" "+navigator.userAgent.indexOf("MSIE"));
	if (parseInt(version.major) >= 10 ) {
		var attributes = {};
		var params = {};
		params.menu = "false";
		params.quality = "high";
		params.allowfullscreen = "true";
		params.allowscriptaccess = "always";
		params.allownetworking = "all";
		params.wmode ="transparent";
		swfobject.embedSWF(swfname+"?seed=001", "flashCont", "100%", "100%", "10.1.0", "http://get.adobe.com/cn/flashplayer/", flashvars, params, attributes);
	} else {
		var html="<div class=\"noflash\"><div class=\"nfTip\">";
		html+="<p class=\"txtRed\"><a href='http://get.adobe.com/flashplayer/' target='_blank'>Install missing plugins...</a></p></div>";
		//html+="<a href=\"javascript:;\" class=\"nfreflash\" onclick=\"refresh();\"></a></div></div>";
		document.getElementById("flashCont").innerHTML = html;
	}
}

function refresh() {
	window.location.reload();
}


