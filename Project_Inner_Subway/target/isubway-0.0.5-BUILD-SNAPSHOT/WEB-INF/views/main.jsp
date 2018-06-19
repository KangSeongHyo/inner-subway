<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/jquery.subwayMap-0.5.0.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/mainstyle.css"  type="text/css">
<style type="text/css">
@font-face{
  font-family: 'BU';
  src: url('font/BMJUA_ttf.ttf');
}
@font-face{
  font-family: 'Cactus';
  src: url('font/Cactus Tequila.ttf');
}
</style>
<script type="text/javascript">

$(document).ready(function() {
 $(".subway-map").subwayMap({ debug: true });
 
 $("button").on("click",function(){
		$.ajax({
			type:'get',
			url:'<%=request.getContextPath()%>/station/'+$(this).val(),
			success:function(serverResult){			
				$("#showStation").css("display","block");
				var str="";
				var result=JSON.parse(JSON.stringify(serverResult));
				for(var i=0;i<result.length;i++){
			      str+="<a href=<%=request.getContextPath()%>/board/external?scode="
			    		  +result[i].scode+"&sname="+result[i].sname+"&page=1>"+result[i].sname+"</a>";      
				}
				$("#showStation").html(str);
			},
		  error :function(request,status, error){
	          alert("code = "+ request.status+ " message = "+ request.responseText+ " error = "+ error); // 실패 시 처리
		  }
			
		 });
		
		});
 
      $("#menuBall1").on("click",function(){
    	 
    	  $(".subway-map").show(1000);
    	  
      });
 

});
</script>
</head>
<body>
		<div id="ballMenuContainer">
			<div id="menuBall1" class="menuBall">
				<a href="#" class="ball blueball">
					<div class="menuText">1호선</div>
				</a>
			</div>

			<div id="menuBall2" class="menuBall">
				<a href="#" class="ball redball">
					<div class="menuText">2호선</div>
				</a>
			</div>

			<div id="menuBall3" class="menuBall">
				<a href="#" class="ball greenball">
					<div class="menuText">7호선</div>
				</a>
			</div>
		

			<div id="menuBall4" class="menuBall">
				<a href="#" class="ball yellowball">
					<div class="menuText">신분당선</div>
				</a>
			</div>
			
		<div class="subway-map" data-columns="40" data-rows="20" data-cellSize="40" data-legendId="legend" data-textClass="text"
			data-gridNumbers="true" data-grid="false" data-lineWidth="28">
			<ul data-color="#0D47A1" data-label="jQuery Widgets">	
		       	<li data-coords="3,3" ><a href="#">병점</a></li>
				<li data-coords="9,3" ><a href="#">수원</a></li>
				<li data-coords="15,3" ><a href="#">금정</a></li>
				<li data-coords="21,3" ><a href="#">안양</a></li>
				<li data-coords="27,3" ><a href="<%=request.getContextPath()%>/board/external?scode=SN0101&sname=금천구청&page=1">금천구청</a></li>
				<li data-coords="33,3" ><a href="#">가산\n디지털단지</a></li> 
				<li data-coords="34,4" data-dir="E" ></li>
				<li data-coords="34,8"  ></li>
				<li data-coords="33,7" data-dir="S"  ></li>
				<li data-coords="33,8"  ><a href="#">구로</a></li>
				<li data-coords="27,8"  ><a href="#">신도림</a></li>
				<li data-coords="21,8"  ><a href="#">영등포</a></li>
				<li data-coords="15,8" ><a href="#">신길</a></li>
				<li data-coords="9,8"  ><a href="#">노량진</a></li>
				<li data-coords="3,8"  ><a href="#">용산</a></li>
				<li data-coords="2,9" data-dir="W"></li>
				<li data-coords="2,12"></li>
				<li data-coords="3,13" data-dir="S"><a href="#">서울역</a></li>
				<li data-coords="9,13" ><a href="#">시청</a></li>
				<li data-coords="15,13" ><a href="#">종로3가</a></li>
				<li data-coords="21,13" ><a href="#">동대문</a></li>
				<li data-coords="27,13" ><a href="#">청량리</a></li>
				<li data-coords="33,13" ><a href="#">회기</a></li>
				<li data-coords="39,13" ><a href="#">도봉산</a></li>
					 
			</ul>
		 </div> 
		</div>
	
    
    <div class="container">
         <h1>Inner Subway</h1>
   </div>



</body>
</html>
