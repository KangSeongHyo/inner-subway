<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>

<form method="post" action="<%=request.getContextPath()%>/board/write_result" enctype="multipart/form-data">
<table width="500" border="3">
  
  <tr>
    <th colspan=3 heigth=4 align="center" bgcolor="yellow">글쓰기</th>
  </tr>
  
  <tr>
    <td>말머리<select name="head" ><option>개찰구안</option><option>개찰구밖</option></select></td>
  </tr>
  
  <tr>
    <td colspan=2>제목 <input  name="title" type="text" size=50/></td>
  </tr>
  
  <tr>
    <td colspan=3 bgcolor="orange" >설명</td>
  </tr>
  
  <tr>
    <td colspan=3><textarea name="content" cols=70 rows=10></textarea></td>
  </tr>
  
  <tr>
    <td><input type="file" name=file></td>
  </tr>
</table>
<input type="submit" value="글작성">
</form>





</body>
</html>