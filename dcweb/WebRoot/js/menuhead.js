$(document).ready(function(){
	
	var lis=$("ul>a");
	lis.mouseover(
			  function () {
				  var lia=$(this).nextAll("li");
				  lia.toggle("show");
				  lia.mouseout(function (){
					  lia.toggle("hide");
				  });
				  }
				);
	
});