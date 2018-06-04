<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">

.container {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 500px;
	height: 200px;
	margin-top: -250px;
	margin-left: -210px;
}
</style>
<script>

$(document).ready(function(){

	var pw_ck;
	var arr=new Array();

	//비밀번호 일치확인
	$("#pwcheck").keyup(function() {
		if($("#pwcheck").val()==$("#pw").val()){
			$("#equal_ck").css("color","green");
			$("#equal_ck").text("비밀번호가 일치합니다");
			pw_ck=true;
		}else{
			$("#equal_ck").css("color","red");
			$("#equal_ck").text("비밀번호가 일치하지 않습니다.");
			pw_ck=false;
		}		
	});
	
	
	
	$("#btn").on("click",function(){
	    arr[0]=$("#id").val();
	    arr[1]=$("#pw").val();
	    arr[2]=$("#pwcheck").val();
	    arr[3]=$("#address").val();
	    
	 $.ajax({
		type:'post',
		url:'<%=request.getContextPath()%>/login/id_check',
		success:function(server_result){			
			var str="";
			var id_ck=true;
			
			for(var i=0;i<server_result.length;i++){
				if(server_result[i]==$("#id").val()){
					id_ck=false;	
					break;
				  }
	    	   }
			
	       for(var i=0;i<arr.length;i++){
	    	if(arr[i]==""){
	    		alert("양식을 확인해주세요");
	    		return; 
	    	  }
	        }
	       
	    	
	   if(id_ck==false){
		   alert("이미 사용하고 있는 아이디 입니다.");
	   }else if(pw_ck==false){
		   alert("비밀번호가 일치하지 않습니다")
	   }else{
		  $("form").prop("action","<%=request.getContextPath()%>/login/bcrypt").submit();
	   }	
	   
     }
	});	 
	    
	});
	
	
});

function goPopup(){
   var pop = window.open("addrpopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr){
	document.form.address.value = roadFullAddr;
}

</script>
</head>
<body>

	<div class="container">

		<form class="form-signin" id="form"
			<%-- action="<%=request.getContextPath()%>/login/bcrypt" --%> method="post">

			<h1>회원가입</h1>
			<input class="form-control" type="text" name="name" placeholder="이름"><br>

			<div class="btn-group radio-group">
				<label class="btn btn-outline-secondary not-active">남자<input
					type="radio" value="M" name="gender"></label> <label
					class="btn btn-outline-secondary not-active">여자<input
					type="radio" value="F" name="gender"></label>
			</div>
			<br> <br> <input class="form-control" type="text" id="id"
				name="id" placeholder="아이디"><br>
			<div id="id_check"></div>
			<input class="form-control" type="password" id="pw" name="pw" placeholder="비밀번호"><br> <input class="form-control"
				type="password" id="pwcheck" title="ss" placeholder="비밀번호 확인">
			<div id="equal_ck"></div>
			<br> <input class="form-control" type="text" contenteditable="false" id="address" name="address" placeholder="도로명 주소"> <input type="button"
				class="btn btn-lg btn-default btn-block" value="주소검색"
				onclick="goPopup()"><br> 
	     <input class="btn btn-lg btn-success btn-block" id="btn" type="button" value="회원가입">
		</form>
		<br>
		<h7>가입 시 이용약관 및 쿠키 사용을 포함한 개인정보 처리방침에 동의하게 됩니다.</h7>
	</div>

</body>
</html>