<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<h1>로그인</h1>
<form action=<%=request.getContextPath()%>/login/loginck method="POST">
<input type="text" name="id" placeholder="아이디"><br>
<input type="password" name="pw" placeholder="비밀번호"><br>
<input type="submit" value="로그인"><br>
혹시 회원이 아니신가요? <a href="login/join" >회원가입</a>
</form>

</body>
</html>