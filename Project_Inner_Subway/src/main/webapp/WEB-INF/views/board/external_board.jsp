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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js" integrity="sha384-u/bQvRA/1bobcXlcEYpsEdFVK/vJs3+T+nXLsBYJthmdBuavHvAW6UsmqO2Gd/F9" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<script type="text/javascript">
function formatDate(date) { 
	var d = new Date(date),
	month = '' + (d.getMonth() + 1), 
	day = '' + d.getDate(), 
	year = d.getFullYear(); 
	if (month.length < 2) month = '0' + month; 
	if (day.length < 2) day = '0' + day; 
	return [year, month, day].join('-'); }
	

$(document).ready(function() {

	var scode="";
	var entry_num=0;
	
	
	$(".card-footer > button").on("click",function(){
	
		var data=$(this).data();
		scode=data.scode;
		entry_num=data.entry_num;
		
	 $.ajax({
			type:'post',
			url:'<%=request.getContextPath()%>/board/inner_board',
			data:{'scode': scode, 'entry_num':entry_num},
			success:function(server_result){
			$("#inner_board_title").html(server_result[0].title);
			$("#inner_board_content").html(server_result[0].content);
			$(".blockquote-footer").html("From "+server_result[0].writer);
			$("#reg_date").html(formatDate(server_result[0].registration_date)+"&nbsp;&nbsp;"+"<i class='far fa-eye'>"+"&nbsp;"+server_result[0].viewcount+"</i>");
			
			$("#commentList").empty();
			for(var i=1;i<server_result.length;i++){
	         	$("#commentList").append("<dl id='comment'><dt>"+server_result[i].writer
	         			+"&nbsp;</dt><span>"+formatDate(server_result[i].registration_date)
	         			+"&nbsp;<i id='comment_del' data-wr='"+server_result[i].writer+"' data-seq='"+server_result[i].comment_seq+"' class='far fa-trash-alt'></i></span><dd>"
	         			+server_result[i].content+"</dd></dl><hr>");
	         	
			    }
		      
			}
		});
		
		
	});
	
 $("#inner_board_comment").on("click",function(){
		
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath()%>/comment/insert',
			data:{ 'scode':scode,
				   'entry_num' : entry_num,
				   'content' : $("#comment_content").val()
			},
			success : function(server_result){
				$("#commentList").empty();
				for(var i=0;i<server_result.length;i++){
		         	$("#commentList").append("<dl id='comment'><dt>"+server_result[i].writer
		         			+"&nbsp;</dt><span>"+formatDate(server_result[i].registration_date)
		         			+"&nbsp;<i id='comment_del' data-wr='"+server_result[i].writer+"' data-seq='"+server_result[i].comment_seq+"' class='far fa-trash-alt'></i></span><dd>"
		         			+server_result[i].content+"</dd></dl><hr>");
				    }
				$("#comment_content").val("");
			}

		}); 
		
		
	});
	
	$(document).on("click","#comment_del",function(){
		
		var check=confirm("댓글을 삭제하시겠습니까?");
		
		if(check==true){
			
		var data=$(this).data();
		
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath()%>/comment/del',
			data:{ 'scode':scode,
				   'entry_num' : entry_num,
				   'comment_seq' : data.seq,
				   'writer':data.wr
			  },
			success : function(server_result){
				if(server_result==""){
					alert("댓글 작성자가 아닙니다.");
				}else{
				$("#commentList").empty();
				for(var i=0;i<server_result.length;i++){
		         	$("#commentList").append("<dl id='comment'><dt>"+server_result[i].writer
		         			+"&nbsp;</dt><span>"+formatDate(server_result[i].registration_date)
		         			+"&nbsp;<i id='comment_del' data-wr='"+server_result[i].writer+"' data='"+server_result[i].comment_seq+"' class='far fa-trash-alt'></i></span><dd>"
		         			+server_result[i].content+"</dd></dl><hr>");
				    }
				$("#comment_content").val("");
					
				}
				
				
			}

		}); 
		
		}
		
	});
});


</script>

<style>
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
  
  p > img{
     width: auto;
     height: 200px;
  
  }
  dt {
    display:inline;
  }
  
</style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Inner Subway</a>
</nav>
<!-- 사이드바 -->
<div id="page-wrapper">
  <!-- 사이드바 -->
  <div id="sidebar-wrapper">
    <ul class="sidebar-nav">
      <li class="sidebar-brand">
        ${slist[0].line}호선
      </li>
      <c:forEach var="i" begin="0" end="${fn:length(slist)-1}" >
      <li><a href="<%=request.getContextPath()%>/board/external?scode=${slist[i].scode}">${slist[i].sname}</a></li>
      </c:forEach>
    </ul>
   </div>  
</div>
  
 <form action="<%=request.getContextPath()%>/board/write">
 <input type="submit" class="btn btn-light" value="글쓰기">
 </form>
   <div class="container">
      <!-- Page Features -->
      <h1>정보공유 게시판</h1>
      <div class="row text-center">
      <c:forEach var="i" begin="0" end="3" >
        <div class="col-lg-3 col-md-6 mb-4">
          <div class="card">
            <img class="card-img-top" src="http://placehold.it/500x325" alt="">
            <div class="card-body">
              <h4 class="card-title">${list[i].title}</h4>
              <p class="card-text">${list[i].content}</p>
            </div>
            <div class="card-footer">
              <button id="modal_req" type="button" data-entry_num='${list[i].entry_num}' data-scode='${list[i].scode}' class="btn btn-outline-secondary" data-toggle="modal" data-target=".bd-example-modal-lg">상세보기</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
</div>

<!-- 게시판 상세보기 -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
  <!--        모달창 내부                      -->

 <div class="card bg-light mb-3" style="max-width: auto;">
  <div class="card-header">상세보기</div>
  <div class="card-body">
      <!--  <h5 class="card-title">금천구 도서 대여관</h5> -->
     <p class="card-text"><img alt="이미지" src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"></p>
     </div>
  </div>
  
 <div class="card text">
   <div class="card-header">내용</div>
      <div class="card-body">
         <h5 id="inner_board_title" class="card-title">title</h5>
         <p class="card-text" id="inner_board_content">error</p>
         <footer class="blockquote-footer">From 작성자</footer>  
     </div>
   <div id="reg_date" class="card-footer text-right text-muted">
     2018-10-04&nbsp;&nbsp;
     <i class="far fa-eye">&nbsp;3</i>
  </div>
</div><br>


<div class="alert alert-secondary">
   <strong>댓글목록 </strong><hr>
 <div id="commentList">
   <!-- <dl id="comment">
    <dt>작성자</dt>
    <span>2018-10-04 10:10&nbsp;<i id="comment_del" data-seq='1' class="far fa-trash-alt"></i></span>
    <dd>여기 햄토스트 2000원</dd>
    </dl><hr> -->
</div>
 
 <div class="form-group">
  <label><abbr class="initialism">댓글작성</abbr>:</label>
  <textarea class="form-control" rows="5" id="comment_content"></textarea>
</div>

<div class="text-right" style="margin-right: 23px">
  <button id="inner_board_comment" class="btn btn-outline-secondary" >등록</button>
</div><br>

 </div>
 
 
   <div class="modal-footer">
   <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
   </div>
 </div>
  </div>
</div>

</body>
</html>