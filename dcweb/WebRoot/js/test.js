var Test = function(){
  function doinit(){
  	alert('Test.js加载中');
  }
  return{
  	init:function(){doinit();}
  }
}();