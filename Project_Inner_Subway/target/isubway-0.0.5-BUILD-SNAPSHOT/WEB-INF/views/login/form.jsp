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
<!-- 스타일 -->
<style type="text/css">
.container {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 300px;
	height: 200px;
	margin-top: -150px;
	margin-left: -150px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var contextPath='<%=request.getContextPath()%>';
	$("#btn").on("click",function(){
		
		  $.ajax({
  			type:'post',
  			url:'<%=request.getContextPath()%>/member/login',
  			contentType : "application/json; charset=UTF-8",
  		    data:JSON.stringify({ 
  		    	 "id" : $('#id').val(),
  		    	"pw" :$('#pw').val()
  		    }),
  		    
  	  	    dataType : 'JSON',
  			success:function(serverResult){
  				var result=JSON.parse(serverResult);
  				
  				if(result==-1){
	                alert("아이디가 없습니다.")
  				}else if(result==0){
  					alert("비밀번호가 일치하지 않습니다.")
  				}else{
  					
  					location.assign(contextPath+"/main");
  				}
	         },
	            error : function(request,status, error) {
              alert("code = "+ request.status+ " message = "+ request.responseText+ " error = "+ error); // 실패 시 처리
	            }

           });
		
		
		
	});
	
	
	
});

</script>
</head>
<body>

	<div class="container">
		<h1>로그인</h1>
		<form class="form-signin">
			<input class="form-control" type="text" id="id" placeholder="아이디"><br>
			<input class="form-control" type="password" id="pw" placeholder="비밀번호"><br> 
			<input id="btn" class="btn btn-lg btn-success btn-block" type="button" value="로그인"><br>
			혹시 회원이 아니신가요? <a href="login/join">회원가입</a>
		</form>
	</div>

</body>
</html>
