<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=3">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/loginstyle.css" type="text/css">
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
label{
    font-family: 'NS';

}


</style>
<script type="text/javascript">
$(document).ready(function(){
	/* $("body").css("background","url(img/background.jpg)"); */
	
	var contextPath='<%=request.getContextPath()%>';
	var FAIL = 0;
	var DISCORDANCE = -2;
	
	$("#btn").on("click",function(){
		
		  $.ajax({
  			type:'POST',
  			url:'<%=request.getContextPath()%>/member/login',
  			contentType : "application/json; charset=UTF-8",
  		    data:JSON.stringify({ 
  		    	 "id" : $('#id').val(),
  		    	"pw" :$('#pw').val()
  		    }),
  		    
  	  	    dataType : 'JSON',
  			success:function(serverResult){
  				
  				var result=JSON.parse(serverResult);
  				
  				if(result==FAIL){
	                alert("아이디가 없습니다.")
  				}else if(result==DISCORDANCE){
  					alert("비밀번호가 일치하지 않습니다.")
  				}else{		
  					location.assign(contextPath+"/main");
  				}
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

</head>
<body class="bg-dark">
	<div class="container py-5">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center text-white mb-4" style="font-size: 100px;margin-top: 10%;font-family: '28D'">Inner Subway</h1>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <!-- form card login -->
                    <div class="card rounded-1">
                        <div class="card-header">
                            <h3 class="mb-0" style="font-family:'NS'">로그인</h3>
                        </div>
                        <div class="card-body">
                            <form class="form" id="formLogin"  method="POST">
                                <div class="form-group">
                                    <label style="font-family: 'BM'">아이디</label>
                                    <input type="text" class="form-control form-control-lg rounded-1" id="id">
                                </div>

                                <div class="form-group">
                                    <label style="font-family: 'BM'">비밀번호</label>
                                    <input type="password" class="form-control form-control-lg rounded-1" id="pw">
                                </div>
                                                                     혹시 회원이 아니신가요? <a href="login/join">회원가입</a>
                                <button type="button" class="btn btn-success btn-lg float-right" id="btn" style="font-family:'BM'">로그인</button>
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
