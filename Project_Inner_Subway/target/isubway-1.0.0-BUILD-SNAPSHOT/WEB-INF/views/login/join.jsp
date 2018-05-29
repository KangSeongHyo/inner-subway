<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

$(document).ready(function(){
	
	//비밀번호 일치확인
	$("#pwcheck").keyup(function() {
		if($("#pwcheck").val()==$("#pw").val()){
			$("#equal_ck").css("color","green");
			$("#equal_ck").text("비밀번호가 일치합니다");
		}else{
			$("#equal_ck").css("color","red");
			$("#equal_ck").text("비밀번호가 일치하지 않습니다.");
		}		
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
<h1>회원가입</h1>

<form action=<%=request.getContextPath()%>/login/bcrypt name="form" id="form" method="post">
	<table >
	  <colgroup>
			<col style="width:20%"><col>
		</colgroup>
			<tbody>
			<tr>
			<th>이름</th>
			<td><input type="text" name="name" ></td>
			</tr>
						
			<tr>
			<th>성별</th>
			<td>남자<input type="radio" name="gender" value="M">
			여자<input type="radio" name="gender" value="F">
			</td>
			</tr>
			
			<tr>
			<th>아이디</th>
			<td><input type="text" name="id" ></td>
			</tr>
			
			<tr>
			<th>비밀번호</th>
			<td><input type="password" id="pw" name="pw" ></td>
			</tr>
		
			<tr>
			<th>비밀번호확인</th>
			<td><input type="password" id="pwcheck" title="ss" ></td>
			<td><div id="equal_ck"></div></td>
			</tr>
			
			<tr>
				<th>도로명주소</th>
			<td><input type="text" id="address" name="address" style="width:90%"></td>
			<td><input type="button"  value="주소검색" onclick="goPopup();"></td>
			</tr>
			
			<tr>
			<td><input type="submit" value="회원가입"><td>
			</tr>
			
			</tbody>
		</table>
</form>
</body>
</html>