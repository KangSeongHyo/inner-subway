<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
crossorigin="anonymous">

<script type="text/javascript">


</script>

<style>
  /* 사이드바 래퍼 스타일 */
  
  #page-wrapper {
    padding-left: 250px;
  }
  
  #sidebar-wrapper {
    position: fixed;
    width: 250px;
    height: 100%;
    margin-left: -250px;
    background: #000;
    overflow-x: hidden;
    overflow-y: auto;
  }
  
  #page-content-wrapper {
    width: 100%;
    padding: 20px;
  }
  /* 사이드바 스타일 */
  
  .sidebar-nav {
    width: 250px;
    margin: 0;
    padding: 0;
    list-style: none;
  }
  
  .sidebar-nav li {
    text-indent: 1.5em;
    line-height: 2.8em;
  }
  
  .sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #999;
  }
  
  .sidebar-nav li a:hover {
    color: #fff;
    background: rgba(255, 255, 255, 0.2);
  }
  
  .sidebar-nav > .sidebar-brand {
    font-size: 1.3em;
    line-height: 3em;
    color: gray;  }
  
  

</style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Inner Subway</a>
</nav>


<div id="page-wrapper">
  <!-- 사이드바 -->
  <div id="sidebar-wrapper">
    <ul class="sidebar-nav">
      <li class="sidebar-brand">
        ${slist[0].line}호선
      </li>
      <c:forEach var="i" begin="0" end="${fn:length(slist)-1}" >
      <li><a href="#">${slist[i].sname}</a></li>
      </c:forEach>
    </ul>
  </div>
  <!-- /사이드바 -->

  <!-- 본문 -->
  <div id="page-content-wrapper">
    <div class="container-fluid">
    <table class='table table-bordered table-hover' id='tbl'>
    <h1>정보 공유 게시판</h1>
    <thead class='thead-dark'>
    <tr><th>#</th>
       <th>말머리</th>
       <th>제목</th>
       <th>작성자</th>
       <th>작성일</th>
       <th>조회수</th>
       </tr>
    </thead>
       <tbody>
       <c:forEach var="i" begin="0" end="${fn:length(list)-1}">
       <tr><td style="width: 5px">${list[i].entry_num}</td><td style="width:90px">${list[i].head}</td><td><a href="<%=request.getContextPath()%>/board/inner_board?entry_num=${list[i].entry_num}">${list[i].title}</a></td><td style="width:100px">${list[i].writer}</td><td style="width:200px">${list[i].registration_date}</td><td style="width:100px">${list[i].viewcount}</td></tr>
      </c:forEach>
      </tbody>
   </table>      
 </div>
 <form action="<%=request.getContextPath()%>/board/write">
 <input type="submit" value="글쓰기">
 </form>
</div>

</body>
</html>