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
<link rel="stylesheet" href="resources/css/mainstyle.css"
	type="text/css">
<style type="text/css">
@font-face {
	font-family: 'BU';
	src: url('font/BMJUA_ttf.ttf');
}

@font-face {
	font-family: 'Cactus';
	src: url('font/Cactus Tequila.ttf');
}
</style>
<script type="text/javascript">

$(document).ready(function() {
	
	
 $(document).on("click",".menuText",function(){
	var data=$(this).data();
	var contextPath='<%=request.getContextPath()%>';
	
    	$.ajax({
			type:'GET',
			url:'<%=request.getContextPath()%>/station/'+data.line,
			success:function(serverResult){		
				
				$(".subway-map").css("display","none");
			    $(".subway-map").empty();
				$(".subway-map").subwayMap({ debug: false });
				
				var str="";
				var count=0;
				var color="";
				
			   localStorage.setItem("line", data.line);
				
				switch (data.line) {
				case 1:
					color="#0D47A1";
					break;
					
				case 2:
					color="#00C853";
					break;
					
				case 7:
					color="#827717";
					break;
				case 10:
					color="#B71C1C";
					break;

				default:
					break;
				}
				
				
				
				$(".subway-map").append("<ul data-color='"+color+"' data-label='jQuery Widgets'></ul>");

				
				  if(data.line==1||data.line==7){
					  
					 for(var key in serverResult){
						 
					 
					  $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
							+serverResult[key].scode+"&sname="+serverResult[key].sname
						 +"&page=1'>"+serverResult[key].sname+"</a></li>");
					
					      if(key==(serverResult.length-1)){
						    break;
					      } 
					
					    count++;
					
				       if(count==6){
					       
				    	   var x=serverResult[key].x;
					       var y=serverResult[key].y;
						
					       $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+1)+"' data-dir='E' ></li>");
					       $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+5)+"'></li>");
					       $(".subway-map > ul").append("<li data-coords='"+x+","+(y+5+1)+"' data-dir='S' ></li>");
					   												
					    }else if(count==12){
						 
					    	var x=serverResult[key].x;
						    var y=serverResult[key].y;
						
					        $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+1)+"' data-dir='W' ></li>");
					        $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+5)+"'></li>");
					        $(".subway-map > ul").append("<li data-coords='"+(x)+","+(y+5+1)+"' data-dir='S' ></li>");
						
					        count=0;
					     }
					   }
				 
			       }else if(data.line==2){
			    	 
			    	   
			    	   
			    	  for(var key in serverResult){
			    	   
			    	    if(count==6){
							   var x=serverResult[key].x;
							   var y=serverResult[key].y;
								
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y-4)+"' data-dir='E' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
										+serverResult[key].scode+"&sname="+serverResult[key].sname
									 +"&page=1'>"+serverResult[key].sname+"</a></li>");
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y+4)+"' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+5)+"' data-dir='S' ></li>");
	
							    count++;
							continue;
							
							
								
						}else if(count==13){
								var x=serverResult[key].x;
								var y=serverResult[key].y;
								
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y+4)+"' data-dir='W' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
										+serverResult[key].scode+"&sname="+serverResult[key].sname
									 +"&page=1'>"+serverResult[key].sname+"</a></li>");
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y-4)+"'></li>");
							    $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y-5)+"' data-dir='N' ></li>");
								
								
							     count=0;
							     continue; 
					     }
			    	    
			    	   $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
								+serverResult[key].scode+"&sname="+serverResult[key].sname
							 +"&page=1'>"+serverResult[key].sname+"</a></li>");
			    	   
			    	    if(key==(serverResult.length-1)){
							break;
						}
			    	    
			    	    count++;
			    	        	   
			          }
			    	  
			       }else if(data.line==10){
			    	   
			    	   for(var key in serverResult){
			    	     
			    		   var x=serverResult[key].x;
					       var y=serverResult[key].y;
					   
					       $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
								+serverResult[key].scode+"&sname="+serverResult[key].sname
							 +"&page=1'>"+serverResult[key].sname+"</a></li>");
			    	   
					    count++;
					   
					   if(count==2){
						   $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+1)+"' data-dir='S' ></li>");
					   }
					   
			          }
			       }
			  
    	          $(".subway-map").show(1000);
				  $(".subway-map").subwayMap({ debug: true });
			  },
			error: function(xhr,status){
				 if(xhr.status==0){
				      alert('네트워크를 체크해주세요.');
				 }else if(xhr.status==401){
				      alert('권한이 없습니다.');
				 }else if(xhr.status==404){
				      alert('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
				      alert('서버에러 발생하였습니다.');
				 }else if(xhr.status==503){
				      alert('데이터를 찾을 수 없습니다.');
				 }else if(status=='timeout'){
				      alert('시간을 초과하였습니다.');
				 }else {
				      alert('에러가 발생하였습니다');
				 }
			 }
			
		 }); 
   });

});
</script>
<style type="text/css">
</style>
</head>
<body>
	<div id="ballMenuContainer">
		<div id="menuBall1" class="menuBall">
			<a href="#" class="ball blueball">
				<div data-line=1 class="menuText">1호선</div>
			</a>
		</div>

		<div id="menuBall2" class="menuBall">
			<a href="#" class="ball redball">
				<div data-line=2 class="menuText">2호선</div>
			</a>
		</div>

		<div id="menuBall3" class="menuBall">
			<a href="#" class="ball greenball">
				<div data-line=7 class="menuText">7호선</div>
			</a>
		</div>


		<div id="menuBall4" class="menuBall">
			<a href="#" class="ball yellowball">
				<div data-line=10 class="menuText">신분당선</div>
			</a>
		</div>


		<div class="subway-map" data-columns="40" data-rows="20"
			data-cellSize="40" data-legendId="legend" data-textClass="text"
			data-gridNumbers="true" data-grid="false" data-lineWidth="28">
			
		</div>

	</div>


	<div class="contain">
		<h1>Inner Subway</h1>
	</div>
	
	            <!-- <li data-coords='8,3'><a href='#'>홍대입구</a></li>
				<li data-coords='14,3'><a href='#'>신촌</a></li>
				<li data-coords="20,3"><a href="#">충정로</a></li>
				<li data-coords="26,3"><a href="#">을지로4가</a></li>
				<li data-coords="32,3"><a href="#">왕십리</a></li>
				<li data-coords="38,3"><a href="#">성수</a></li>
				<li data-coords="39,4" data-dir="E"></li>
				<li data-coords="39,8"><a href="#">건대입구</a></li>
				<li data-coords="39,12"></li>
				<li data-coords="38,13" data-dir="S"></li>
				<li data-coords="38,13"><a href="#">잠실</a></li>
				<li data-coords="32,13"><a href="#">선릉</a></li>
				<li data-coords="26,13"><a href="#">강남</a></li>
				<li data-coords="20,13"><a href="#">사당</a></li>
				<li data-coords="14,13"><a href="#">신림</a></li>
				<li data-coords="8,13"><a href="#">구로디지털단지</a></li>
				<li data-coords="7,12" data-dir="W"></li>
				<li data-coords="7,8" data-dir="W"><a href="#">신도림</a></li>
				<li data-coords="7,4" data-dir="W"></li>
				<li data-coords="8,3" data-dir="N"></li>
	 -->
	
	
	
	<%--           <li data-coords='8,3' ><a href='#'>병점</a></li>
				 <li data-coords='14,3'><a href='#'>수원</a></li>
				<li data-coords="20,3" ><a href="#">금정</a></li>
				<li data-coords="26,3" ><a href="#">안양</a></li>
				<li data-coords="32,3" ><a href="<%=request.getContextPath()%>/board/external?scode=SN0101&sname=금천구청&page=1">금천구청</a></li>
				<li data-coords="38,3" ><a href="#">가산디지털단지</a></li> 
				
				<li data-coords="39,8"  ></li>
				<li data-coords="38,9" data-dir="S" ></li>  
				<li data-coords="38,9"  ><a href="#">구로</a></li>
				<li data-coords="32,9"  ><a href="#">신도림</a></li>
				<li data-coords="26,9"  ><a href="#">영등포</a></li>
				<li data-coords="20,9" ><a href="#">신길</a></li>
				<li data-coords="14,9"  ><a href="#">노량진</a></li>
				<li data-coords="8,9"  ><a href="#">용산</a></li>
				<li data-coords="7,10" data-dir="W"></li>
			    <li data-coords="7,14"></li>
				<li data-coords="8,15" data-dir="S"></li>
				<li data-coords="8,15"  ><a href="#">서울역</a></li>
				<li data-coords="14,15" ><a href="#">시청</a></li>
				<li data-coords="20,15" ><a href="#">종로3가</a></li>
				<li data-coords="26,15" ><a href="#">동대문</a></li>
				<li data-coords="32,15" ><a href="#">청량리</a></li>
				<li data-coords="38,15" ><a href="#">회기</a></li> --%>
				
				<!-- /*  $(".subway-map > ul").append("<li data-coords='15,3' ><a href='#' >강남</a></li>");
					    $(".subway-map > ul").append("<li data-coords='15,7' ><a href='#' >양재</a></li>");
					    
					    $(".subway-map > ul").append("<li data-coords='23,8' ><a href='#' >청계산입구</a></li>");
					    $(".subway-map > ul").append("<li data-coords='36,8' ><a href='#' >판교</a></li>");
					    $(".subway-map > ul").append("<li data-coords='36,12' ><a href='#' >정자</a></li>");
					    $(".subway-map > ul").append("<li data-coords='30,12' ><a href='#' >동천</a></li>");
					    $(".subway-map > ul").append("<li data-coords='24,12' ><a href='#' >수지구청</a></li>");
					    $(".subway-map > ul").append("<li data-coords='18,12' ><a href='#' >성복</a></li>");
					    $(".subway-map > ul").append("<li data-coords='12,12' ><a href='#' >광교중앙</a></li>");
					    $(".subway-map > ul").append("<li data-coords='6,12' ><a href='#' >광교</a></li>"); */
 -->

</body>
</html>
