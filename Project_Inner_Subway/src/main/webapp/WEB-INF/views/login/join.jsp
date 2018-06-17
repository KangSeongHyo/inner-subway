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
	width: 500px;
	height: 200px;
	margin-top: 7%;
	margin-left: 35%;
}
</style>

<script>
function goPopup() {
	var pop = window.open("addrpopup", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}
function addressCallBack(roadFullAddr) {
	$("#address").val(roadFullAddr);
}

$(document).ready(function(){

	var pwCheck;
	var contextPath="<%=request.getContextPath()%>"

	//비밀번호 일치확인
	$("#pwcheck").keyup(function() {
		if($("#pwcheck").val()==$("#pw").val()){
			$("#pwEqualView").css("color","green");
			$("#pwEqualView").text("비밀번호가 일치합니다");
			pwCheck=true;
		}else{
			$("#pwEqualView").css("color","red");
			$("#pwEqualView").text("비밀번호가 일치하지 않습니다.");
			pwCheck=false;
		}		
	});
		
	$("#btn").on("click",function(){
		var arr=new Array();
	    arr[0]=$("#id").val();
	    arr[1]=$("#pw").val();
	    arr[2]=$("#pwcheck").val();
	    arr[3]=$("#address").val();
	  
	    
	 $.ajax({
		type:'get',
		url:'<%=request.getContextPath()%>/member',
  	    dataType :'text',
		success:function(serverResult){		
			var result=JSON.parse(serverResult);
			var str="";
			var idCheck=true;
			
			   for(var i=0;i<result.length;i++){				  
				   
				   if(result[i]==$("#id").val()){
					  idCheck=false; 
					  break;
				  }
	    	   }
			
	         for(var i=0;i<arr.length;i++){
	    	   if(arr[i]==""){
	    		 alert("양식을 확인해주세요");
	    		 return; 
	    	     }
	          }
	       
	    	
	         if(idCheck==false){
		        alert("이미 사용하고 있는 아이디 입니다.");
	         }else if(pwCheck==false){
		      alert("비밀번호가 일치하지 않습니다")
	         }else{
	        	 
	    	  $.ajax({
	    			type:'POST',
	    			url:'<%=request.getContextPath()%>/member/',
	    			contentType : "application/json; charset=UTF-8",
	    		    data:JSON.stringify({ 
	    		    	 "id" : $('#id').val(),
	    		    	 "pw" :$('#pw').val(),
	    		    	 "name" : $('#name').val(), 
	    		    	 "gender" : $('input[type=radio]').val(), 
	    		    	 "address" :$('#address').val()
	    		    }),
	    		 
	    	  	    dataType : 'JSON',
	    			success:function(serverResult){
	    				
	    				if(JSON.parse(serverResult)==1){
		                 location.assign(contextPath+"/");
	    				}
		            },
		            error: function(xhr,status){
						 if(xhr.status==0){
						      alert('네트워크를 체크해주세요.');
						 }else if(xhr.status==404){
						      alert('페이지를 찾을수없습니다.');
						 }else if(xhr.status==500){
						      alert('서버에러가 발생하였습니다.');
						 }else if(status=='timeout'){
						      alert('시간을 초과하였습니다.');
						 }else {
						      alert('에러가 발생하였습니다.');
						 }
					 }

	             });
	      }
    
	   }
	
	 });
   });

});

	
</script>
</head>
<body>

	<div class="container">

		<form class="form-signin" id="form" method="post">

			<h1>회원가입</h1>
			<input class="form-control" type="text" id="name"  placeholder="이름" ><br>

			<div class="btn-group radio-group">
				<label class="btn btn-outline-secondary not-active">남자
				<input type="radio" value="M" name="gender"></label> 
				<label class="btn btn-outline-secondary not-active">여자
				<input type="radio" value="F" name="gender"></label>
			</div><br><br> 
			<input class="form-control" type="text" id="id"  placeholder="아이디"><br>
			
			<input class="form-control" type="password" id="pw"  placeholder="비밀번호">
			<br> <input class="form-control" type="password" id="pwcheck" placeholder="비밀번호 확인">
			<div id="pwEqualView"></div>
			
			<br> <input class="form-control" type="text" disabled="disabled" id="address" placeholder="도로명 주소"> <input type="button"
				class="btn btn-lg btn-default btn-block" value="주소검색"
				onclick="goPopup()"><br> <input
				class="btn btn-lg btn-success btn-block" id="btn" type="button"
				value="회원가입">
		</form>
		<br>
		<h7>가입 시 이용약관 및 쿠키 사용을 포함한 개인정보 처리방침에 동의하게 됩니다.</h7>
	</div>

</body>
</html>