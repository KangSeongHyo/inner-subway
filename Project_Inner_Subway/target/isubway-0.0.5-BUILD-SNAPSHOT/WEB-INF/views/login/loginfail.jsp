<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var result=confirm("아이디 또는 비밀번호를 확인해주세요");
	
	if(result){
		location.replace(location.pathname+"/");
	}else{
		location.replace(location.pathname+"/");
	}
	
});
</script>
</head>
<body>

</body>
</html>