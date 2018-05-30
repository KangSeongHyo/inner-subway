<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<table>
<thead>
<tr><td>NO</td><td>말머리</td><td>제목</td><td>작성자</td><td>작성일</td><td>조회수</td></tr>
</thead>
<tbody>
<c:forEach var="i" begin="0" end="${fn:length(list)}">
<tr><td>${list[i].entry_num}</td><td>${list[i].head}</td><td><a href="<%=request.getContextPath()%>/board/inner_board?entry_num=${list[i].entry_num}">${list[i].title}</a></td><td>${list[i].writer}</td><td>${list[i].registration_date}</td><td>${list[i].viewcount}</td></tr>
</c:forEach>
</tbody>
</table>
<form action="<%=request.getContextPath()%>/board/write">
<input type="submit" value="글쓰기">
</form>
</body>
</html>