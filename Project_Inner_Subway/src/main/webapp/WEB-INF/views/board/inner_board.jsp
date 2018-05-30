<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
 <table width="500" border="3">
  <tr>
    <th colspan=2 heigth=4 align="center" bgcolor="yellow">글보기</th>
  </tr>
  <tr>
    <td>제목</td>
    <td>${vo.title}</td>
  </tr>
  <tr>
    <td colspan=2>사진</td>
  </tr>
  <tr>
    <td colspan=2><img src="${vo.img_path}" style="width:400px; height:200px"></td>
  </tr>
  <tr>
    <td colspan=2>설명</td>
  </tr>
  <tr>
    <td colspan=2><textarea name="content" cols=70 rows=10 contenteditable="false">${vo.content}</textarea></td>
  </tr>
  <tr>
    <td>작성자</td>
    <td>${vo.writer}</td>
  </tr>
</table>
</body>
</html>