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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/joinstyle.css" type="text/css">
<script>
function goPopup() {
	var pop = window.open("addrpopup", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}
function addressCallBack(roadFullAddr) {
	$("#address").val(roadFullAddr);
}

$(document).ready(function(){
	var FAIL=0;
	var pwCheck=false;
	var idPtn=false;
	var pwPtn=false;
	var namePtn=false;
	
	var contextPath="<%=request.getContextPath()%>";

	//비밀번호 일치확인
	$("#pw").on("keyup",function() {
		if($("#pwCheck").val()==$("#pw").val()){
			$("#pwEqualView").css("color","green");
			$("#pwEqualView").text("비밀번호가 일치합니다");
			pwCheck=true;
		}else{
			$("#pwEqualView").css("color","red");
			$("#pwEqualView").text("비밀번호가 일치하지 않습니다.");
			pwCheck=false;
		}		
	});
	$("#pwCheck").on("keyup",function() {
		
		if($("#pwCheck").val()==$("#pw").val()){
			$("#pwEqualView").css("color","green");
			$("#pwEqualView").text("비밀번호가 일치합니다");
			pwCheck=true;
		}else{
			$("#pwEqualView").css("color","red");
			$("#pwEqualView").text("비밀번호가 일치하지 않습니다.");
			pwCheck=false;
		}		
	});
	
	//이름 패턴
	$('#name').on('change',function(){
		var nameReg = /^[|가-힣|a-z|A-Z|\*]+$/;
		
		if(!nameReg.test($("#name").val())){
			$("#name").addClass("is-invalid");
			$("#namePatternCheckView").text("내용을 확인해 주세요.");
			namePtn=false;
		}else{
			$("#name").removeClass("is-invalid");
			$("#namePatternCheckView").empty();
			namePtn=true;
		}
	});
	
	//아이디 패턴
	$('#id').on('change',function(){
		var idReg = /^[a-z]{3,}[0-9|a-z]+$/;
		
		if(!idReg.test($("#id").val())){
			$("#id").addClass("is-invalid");
			$("#idPatternCheckView").text("영문소문자(3자리 이상)와 숫자로 구성해주세요");
			idPtn=false;
		}else{
			$("#id").removeClass("is-invalid");
			$("#idPatternCheckView").empty();
			idPtn=true;
		}
	});
	
	$('#pw').on('change',function(){
		var pwReg = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;

		
		if(!pwReg.test($("#pw").val())){
			$("#pw").addClass("is-invalid");
			$("#pwPatternCheckView").text("영문과 숫자로 구성해주세요(6자리 이상 20자리 이내)");
			pwPtn=false;
		}else{
			
			$("#pw").removeClass("is-invalid");
			$("#pwPatternCheckView").empty();
			pwPtn=true;
		}
	});
	
	
	//중복체크 & 공백체크
	$("#btn").on("click",function(){
		var arr=new Array();
		
	    arr[0]=$("#id").val();
	    arr[1]=$("#pw").val();
	    arr[2]=$("#pwCheck").val();
	    arr[3]=$("#address").val();
	    
	    //공백체크
	    for(var i=0;i<arr.length;i++){
	    	   if(arr[i]==""){
	    		 alert("입력을 확인해주세요");
	    		 return; 
	    	     }
	         }
	    
	    
	     //패턴&비밀번호 확인체크
	     if(pwPtn==false||idPtn==false||pwCheck==false||namePtn==false){
	    	 alert("양식을 확인해주세요.");
	    	 return;
	     }
	    
	    
	 $.ajax({
		type:'GET',
		url:'<%=request.getContextPath()%>/member/'+$("#id").val(),
		contentType : "application/json; charset=UTF-8",
		success:function(serverResult){		
			var result=JSON.parse(serverResult);
			var str="";
			var idCheck=true;
			
	         if(result==FAIL){
		        alert("이미 사용하고 있는 아이디 입니다.");
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
						 }else if(xhr.status==400){
						      alert('요청에 오류가 있습니다.');
						 }else if(xhr.status==401){
						      alert('권한이 없습니다.');
						 }else if(xhr.status==404){
						      alert('페이지를 찾을 수 없습니다.');
						 }else if(xhr.status==500){
						      alert('서버에 오류가 발생하였습니다.');
						 }else if(status=='timeout'){
						      alert('시간을 초과하였습니다.');
						 }else {
						      alert("오류가 발생하였습니다.");
						 }
					 }

	             });
	      }
    
	   }
	
	 });
   });

});
</script>
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
label{
  font-family: 'BM';
}
span{
  display : block;
  font-family: 'NS';
  color: red;
}
</style>
</head>
<body class="bg-dark">

<div class="container py-5">
    <div class="row">
        <div class="col-md-12">
           <h1 class="text-center text-white mb-4" style="font-size: 100px;font-family: '28D'">Inner Subway</h1>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <div class="card rounded-1">
                        <div class="card-header">
                            <h3 class="mb-0" style="font-family: 'NS'">회원가입</h3>
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

	<!-- <div class="container">
	
	 <h1>회원가입</h1>

		<form class="form-signin" id="form" name="form" method="POST">

			<input class="form-control" type="text" id="name"  placeholder="이름">
			<span id="namePatternCheckView"></span><br>
			
			<div class="btn-group radio-group">
				<label class="btn btn-outline-secondary not-active">남자
				<input type="radio" value="M" name="gender"></label> 
				<label class="btn btn-outline-secondary not-active">여자
				<input type="radio" value="F" name="gender"></label>
			</div><br><br>
			   
			   <input class="form-control"  type="text" id="id" placeholder="아이디">
			   <span id="idPatternCheckView"></span><br>	
			
			<input class="form-control" type="password" id="pw"  placeholder="비밀번호" >
			 <span id="pwPatternCheckView"></span><br>
			 
			<input class="form-control" type="password" id="pwCheck" placeholder="비밀번호 확인">
			<span id="pwEqualView"></span><br>
			
			<input class="form-control" type="text" disabled="disabled" id="address" placeholder="도로명 주소"> <input type="button"
				class="btn btn-lg btn-default btn-block" value="주소검색"
				onclick="goPopup()"><br> 
			<input class="btn btn-lg btn-success btn-block" id="btn" type="button" value="회원가입">
		</form>
		<br>
		<h6>가입 시 이용약관 및 쿠키 사용을 포함한 개인정보 처리방침에 동의하게 됩니다.</h6>
	</div>
 -->
</body>
</html>