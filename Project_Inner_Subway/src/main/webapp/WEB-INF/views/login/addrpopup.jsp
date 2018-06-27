<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inner Subway</title>
<% 	
String inputYn = request.getParameter("inputYn"); 
String roadFullAddr = request.getParameter("roadFullAddr"); 
%>
</head>
<script>
function init(){
	var url = location.href;
	var confmKey ="U01TX0FVVEgyMDE4MDUyNDIxMzYzMDEwNzg5OTk=";//승인키
	var resultType = "1"; // 도로명주소 검색결과 화면 출력유형, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType; // resultType항목 추가(2016.10.06)
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; // 인터넷망
		document.form.submit();
	}else{
		/** API 서비스 제공항목 확대 (2017.02) **/
		opener.addressCallBack("<%=roadFullAddr%>");
		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" /> 
		<input type="hidden" id="returnUrl" name="returnUrl"  /> 
		<input type="hidden" id="resultType" name="resultType" />
	</form>
</body>
</html>