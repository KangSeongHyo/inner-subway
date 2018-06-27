<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Inner Subway</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=3">
<title>Insert title here</title>
<link 
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.core.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.default.min.css" rel="stylesheet">
<script type="text/javascript">

</script>
<script src="js/login.js"></script>
<style type="text/css">
@font-face {
	font-family: 'NS';
	src: url('font/NanumSquareRoundR.ttf');
}
@font-face {
	font-family: '28D';
	src: url('font/28DaysLater.ttf');
}
@font-face {
	font-family: 'BM';
	src: url('font/BMJUA_ttf.ttf');
}
</style>
<link rel="stylesheet" href="resources/css/loginstyle.css" type="text/css">
</head>

<body class="bg-dark">
	<div class="container py-5">
    <div class="row">
        <div class="col-md-12">
            <h1 id="header" class="text-center text-white mb-4">Inner Subway</h1>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <!-- form card login -->
                    <div class="card rounded-1">
                        <div class="card-header">
                            <h3 class="mb-0" >로그인</h3>
                        </div>
                        <div class="card-body">
                            <form class="form" id="formLogin"  method="POST">
                                <div class="form-group">
                                    <label>아이디</label>
                                    <input type="text" class="form-control form-control-lg rounded-1" id="id">
                                </div>

                                <div class="form-group">
                                    <label>비밀번호</label>
                                    <input type="password" class="form-control form-control-lg rounded-1" id="pw">
                                </div>
                                                                     혹시 회원이 아니신가요? <a href="login/join">회원가입</a>
                                <button type="button" class="btn btn-success btn-lg float-right" id="btn" >로그인</button>
                            </form>
                        </div>
                        <!--/card-block-->
                    </div>
                    <!-- /form card login -->

                </div>

            </div>
        </div>
        <!--/col-->
    </div>
    <!--/row-->
</div>
</body>
</html>
