<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Inner Subway</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/jquery.subwayMap-0.5.0.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="resources/css/mainstyle.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.core.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.default.min.css" rel="stylesheet">
<script type="text/javascript" src="js/main.js"></script>
<style type="text/css">
@font-face {
	font-family: 'BU';
	src: url('font/BMJUA_ttf.ttf');
}

@font-face {
	font-family: '28D';
	src: url('font/28DaysLater.ttf');
}
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
	
</body>
</html>
