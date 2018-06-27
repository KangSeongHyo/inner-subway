<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Inner Subway</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.core.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.default.min.css" rel="stylesheet">
<script src="../js/join.js"></script>
<style type="text/css">
@font-face {
	font-family: '28D';
	src: url('../font/28DaysLater.ttf');
}

@font-face {
	font-family: 'BM';
	src: url('../font/BMJUA_ttf.ttf');
}
@font-face {
	font-family: 'NS';
	src: url('../font/NanumSquareRoundR.ttf');
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/joinstyle.css" type="text/css">
</head>
<body class="bg-dark">

<div class="container py-5">
    <div class="row">
        <div class="col-md-12">
           <h1 class="text-center text-white mb-4">Inner Subway</h1>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="card rounded-1">
                        <div class="card-header">
                            <h3 class="mb-0">회원가입</h3>
                        </div>
                        <div class="card-body">
                            <form class="form" id="join"  method="POST">
                                <div class="form-group">
                                    <label>이름</label>
                                    <input type="text" class="form-control form-control-lg rounded-1" id="name">
                                </div>
                                <span id="namePatternCheckView"></span>


                               <label>성별</label><br>
                               <div class="btn-group radio-group">
				                <label class="btn btn-outline-secondary not-active">남자
				                <input type="radio" value="M" name="gender"></label> 
				                <label class="btn btn-outline-secondary not-active">여자
				                <input type="radio" value="F" name="gender"></label>
			                   </div><br>

			                   <div class="form-group">
                                    <label>아이디</label>
                                    <input type="text" class="form-control form-control-lg rounded-1" id="id">
                                </div>
                                <span id="idPatternCheckView"></span>

                                <div class="form-group">
                                    <label>비밀번호</label>
                                    <input type="password" class="form-control form-control-lg rounded-1" id="pw">
                                </div>
                                <span id="pwPatternCheckView"></span>

                                <div class="form-group">
                                    <label>비밀번호 확인</label>
                                    <input type="password" class="form-control form-control-lg rounded-1" id="pwCheck">
                                </div>
                                <span id="pwEqualView"></span>
                                
                                <input class="form-control" type="text" disabled="disabled" id="address" placeholder="도로명 주소"> 
                                <input type="button" class="btn btn-lg btn-default btn-block" value="주소검색" onclick="goPopup()"><br> 
			                    <input class="btn btn-lg btn-success btn-block" id="btn" type="button" value="회원가입">
                            </form>
                        </div>
                        <!--/card-block-->
                    </div>
                    <!-- /form card login -->

                </div>


            </div>
            <!--/row-->

        </div>
        <!--/col-->
    </div>
    <!--/row-->
</div>

</body>
</html>