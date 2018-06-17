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
<style type="text/css">

#showStation {
	display: none;
}

div>a {
	margin-right: 5px;
}

#ballMenuContainer {
	position: absolute;
	left: 25px;
	top: 0;
}

@-webkit-keyframes pulse {
    0% {
      -webkit-transform: scale(1) rotate(0deg); 
    }
    50% {
      -webkit-transform: scale(1.1) rotate(-5deg); 
    }
    100% {
      -webkit-transform: scale(1) rotate(0deg); 
    }
}
@-o-keyframes pulse {
    0% {
      -o-transform: scale(1) rotate(0deg); 
    }
    50% {
      -o-transform: scale(1.1) rotate(-5deg); 
    }
    100% {
      -o-transform: scale(1) rotate(0deg); 
    }
}
@-moz-keyframes pulse {
    0% {
      -moz-transform: scale(1) rotate(0deg); 
    }
    50% {
      -moz-transform: scale(1.1) rotate(-5deg); 
    }
    100% {
      -moz-transform: scale(1) rotate(0deg); 
    }
}
@keyframes pulse {
    0% {
      transform: scale(1) rotate(0deg); 
    }
    50% {
      transform: scale(1.1) rotate(-5deg); 
    }
    100% {
      transform: scale(1) rotate(0deg); 
    }
}

@-webkit-keyframes bump {
  0% {
      top: 0;
  }
  5% {
      top: 3px;
  }
  10% {
      top:0;
  }
  100% {
      top:0;
  }
}
@-o-keyframes bump {
  0% {
      top: 0;
  }
  5% {
      top: 3px;
  }
  10% {
      top:0;
  }
  100% {
      top:0;
  }
}
@-moz-keyframes bump {
  0% {
      top: 0;
  }
  5% {
      top: 3px;
  }
  10% {
      top:0;
  }
  100% {
      top:0;
  }
}
@keyframes bump {
  0% {
      top: 0;
  }
  5% {
      top: 3px;
  }
  10% {
      top:0;
  }
  100% {
      top:0;
  }
}
.menuBall {
	position: relative;
	width: 100px;
	height: 100px;
	margin: 5px;
	display: inline-block;
}

.ball {
	position: absolute;
	width: 100%;
	height: 100%;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	-o-border-radius: 50%;
	border-radius: 50%;
	border: 2px dashed #fff;
	margin: 10px;
	text-decoration: none;
}

.ball:hover {
	-webkit-animation: pulse 1s ease 0s infinite normal;
	-o-animation: pulse 1s ease 0s infinite normal;
	-moz-animation: pulse 1s ease 0s infinite normal;
	animation: pulse 1s ease 0s infinite normal;
}

.redball {
	background-color: #00C853;
	-moz-box-shadow: 0 0 0 3px #00C853, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	-webkit-box-shadow: 0 0 0 3px #00C853, 2px 1px 4px 4px
		rgba(10, 10, 0, .5);
	-o-box-shadow: 0 0 0 3px #00C853, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	box-shadow: 0 0 0 3px #00C853, 2px 1px 6px 4px rgba(10, 10, 0, .5);
	background-size: 20px 20px;
	background-color: #00C853;
}

.blueball {
	-moz-box-shadow: 0 0 0 3px #0D47A1, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	-webkit-box-shadow: 0 0 0 3px #0D47A1, 2px 1px 4px 4px
		rgba(10, 10, 0, .5);
	-o-box-shadow: 0 0 0 3px #0D47A1, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	box-shadow: 0 0 0 3px #0D47A1, 2px 1px 6px 4px rgba(10, 10, 0, .5);
	background-size: 20px 20px;
	background-color: #0D47A1;
}

.yellowball {
	-moz-box-shadow: 0 0 0 3px #B71C1C, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	-webkit-box-shadow: 0 0 0 3px #B71C1C, 2px 1px 4px 4px
		rgba(10, 10, 0, .5);
	-o-box-shadow: 0 0 0 3px #B71C1C, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	box-shadow: 0 0 0 3px #B71C1C, 2px 1px 6px 4px rgba(10, 10, 0, .5);
	background-size: 20px 20px;
	background-color: #B71C1C;
}

.greenball {
	-moz-box-shadow: 0 0 0 3px #827717, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	-webkit-box-shadow: 0 0 0 3px #827717, 2px 1px 4px 4px
		rgba(10, 10, 0, .5);
	-o-box-shadow: 0 0 0 3px #827717, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	box-shadow: 0 0 0 3px #827717, 2px 1px 6px 4px rgba(10, 10, 0, .5);
	background-size: 20px 20px;
	background-color: #827717;
}

.menuText {
	font-family: 'BU';
	font-size: x-large;
	color: #ffffff;
	position: relative;
	vertical-align: middle;
	text-align: center;
	top: 40%;
}

#menuBall1 {
	-webkit-animation: bump 6s linear 0s infinite normal;
}

#menuBall2 {
	-webkit-animation: bump 6s linear .5s infinite normal;
}

#menuBall3 {
	-webkit-animation: bump 6s linear 1s infinite normal;
}

#menuBall4 {
	-webkit-animation: bump 6s linear 1.5s infinite normal;
}

#menuBall1 {
	-moz-animation: bump 6s linear 0s infinite normal;
}

#menuBall2 {
	-moz-animation: bump 6s linear .5s infinite normal;
}

#menuBall3 {
	-moz-animation: bump 6s linear 1s infinite normal;
}

#menuBall4 {
	-moz-animation: bump 6s linear 1.5s infinite normal;
}

#menuBall1 {
	-o-animation: bump 6s linear 0s infinite normal;
}

#menuBall2 {
	-o-animation: bump 6s linear .5s infinite normal;
}

#menuBall3 {
	-o-animation: bump 6s linear 1s infinite normal;
}

#menuBall4 {
	-o-animation: bump 6s linear 1.5s infinite normal;
}

#menuBall1 {
	animation: bump 6s linear 0s infinite normal;
}

#menuBall2 {
	animation: bump 6s linear .5s infinite normal;
}

#menuBall3 {
	animation: bump 6s linear 1s infinite normal;
}

#menuBall4 {
	animation: bump 6s linear 1.5s infinite normal;
}

div#partyInfo {
	position: absolute;
	bottom: 30%;
	top: 30%;
	left: 20%;
	right: 20%;
	margin: 5px;
	padding: 8px;
	z-index: 2000;
	text-shadow: -1px -1px #65b37a;
	font-family: 'IdolwildRegular', Verdana, Helvetica, Sans-Serif;
	font-size: 2.5em;
	color: #FFFFFF;
	border-radius: 10px;
	border: 2px dashed #fff;
	background-color: #d90e23;
	-moz-box-shadow: 0 0 0 3px #d90e23, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	-webkit-box-shadow: 0 0 0 3px #d90e23, 2px 1px 4px 4px
		rgba(10, 10, 0, .5);
	-o-box-shadow: 0 0 0 3px #d90e23, 2px 1px 4px 4px rgba(10, 10, 0, .5);
	box-shadow: 0 0 0 3px #d90e23, 2px 1px 6px 4px rgba(10, 10, 0, .5);
}

#darkMe {
	position: absolute;
	top: 0;
	left: 0;
	height: 100%;
	width: 100%;
	background: rgba(0, 0, 0, 0.65);
	z-index: 1000;
	-webkit-filter: blur(3px);
}

#darkMe.hideMe, #partyInfo.hideMe {
	visibility: hidden;
}

#darkMe.showMe, #partyInfo.showMe {
	visibility: visible;
}

@font-face{
  font-family: 'BU';
  src: url('font/BMJUA_ttf.ttf');
}
@font-face{
  font-family: 'Cactus';
  src: url('font/Cactus Tequila.ttf');
}
.container{
  font-family: 'BU';
  font-size: x-large;
  text-align: center;
  width: 70%;
  height: 70%;
  margin-top: 23%;
}
.subway-map{
font-family: 'BU';
font-size: x-large;
/* display: none; */
}
a:link { color: red; text-decoration: none;}
a:visited { color: white; text-decoration: none;}

h1{
  color: white;
  font-size: 140px;
}
body{
width: 100%; height: 100%;
background-color : #000000;
}
.subway-map{
 display: none;
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
 
 
 
 
/* 		var canvas = $('.subway-map > canvas');
		
		var context = canvas[0].getContext("2d");
		context.lineWidth=10;
		context.stroke();
 */
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
				<li data-coords="37,3" ></li>
				<li data-coords="38,4" data-dir="E" ></li>
				<li data-coords="38,7"  ></li>
				<li data-coords="37,8" data-dir="S"  ></li>
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
