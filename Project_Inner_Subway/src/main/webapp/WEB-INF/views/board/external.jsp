<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"
	integrity="sha384-u/bQvRA/1bobcXlcEYpsEdFVK/vJs3+T+nXLsBYJthmdBuavHvAW6UsmqO2Gd/F9"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
	integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
	crossorigin="anonymous">
<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script type='text/javascript' src='http://malsup.github.com/jquery.form.js'></script>
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

	var scode='${scode}';
	/* var entryNum=0; */
	var contextPath='<%=request.getContextPath()%>';
	var sname='${sname}';
	
	$(".card-footer > button").on("click",function(){
	
		var data=$(this).data();
		scode=data.scode;
		entryNum=data.entryNum;
		
	/////////////////외부게시판 view, 검색
	 $.ajax({
			type:'post',
			url:'<%=request.getContextPath()%>/board/inner_board',
			data:{'scode': scode, 'entryNum':entryNum},
			success:function(server_result){
			//$("#inner_img").prop("src",server_result[0].img_path);
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
	
	//////////////////////댓글 불러오기
 $("#inner_board_comment").on("click",function(){
		
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath()%>/comment/insert',
			data:{ 'scode':scode,
				   'entryNum' : entryNum,
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
	
	////////////////댓글삭제
	$(document).on("click","#comment_del",function(){
		
		var check=confirm("댓글을 삭제하시겠습니까?");
		
	if(check==true){
			
		var data=$(this).data();
		
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath()%>/comment/del',
			data:{ 'scode':scode,
				   'entryNum' : entryNum,
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
		         			+"&nbsp;<i id='comment_del' data-wr='"+server_result[i].writer+"' data-seq='"+server_result[i].comment_seq+"' class='far fa-trash-alt'></i></span><dd>"
		         			+server_result[i].content+"</dd></dl><hr>");
				    }
				$("#comment_content").val("");
					
				}
			 }

		}); 
		
	} //////////if문끝
		
	});

////////////글작성 폼
	$("#boardWrite").on("click",function(){
		if('${id}'==''){
			alert("로그인 뒤에 이용해주세요");
		}else{
		$(".container").empty();
		$(".container").append("<div id='reflash' class='row'><form id='writeForm' method='post' enctype='multipart/form-data' ><input type='hidden' name='scode' value="+scode+"><input type='hidden' name='writer' value='${id}'><div class='form-group'><label for='title'>제목</label><input size=200 type='text' class='form-control' id='titleInput' name='title'><small id='title_req' class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 8글자이내)</small></div><div class='form-group'><textarea name='content' id='summernote'></textarea><br><label class='btn btn-success btn-file'>사진 첨부 <input type='file' name='file' id='file'></label><small id='title_req' class='form-text text-muted'>사진은 필수입니다.</small></div></form></div><button id='boardRegister' class='btn btn-outline-secondary float-right'>등록</button><button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");	
		}
	 
       ///////////에디터
		$('#summernote').summernote({
		      placeholder: '종류, 위치 등 자세하게 적어주세요',
		      minHeight: 300, 
		      Width: 700,
		      lang: 'ko-KR',
		      toolbar: [
		    	    ['style', ['bold', 'italic', 'underline', 'clear']],
		    	    ['font', ['strikethrough', 'superscript', 'subscript']],
		    	    ['color', ['color']],
		    	    ['para', ['ul', 'ol', 'paragraph']],
		    	    ['height', ['height']]
		    	  ],
		        popover: {image: []}
		});
	});
	
/////////////////// 뒤로가기 버튼		
	$(document).on("click","#backpage",function(){
		location.assign(contextPath+"/board/external?scode="+scode+"&sname="+sname);
	}); 

//////////////////글작성
	$(document).on("click","#boardRegister",function(){
		if($("#titleInput").val()==null){
			alert("내용을 확인해주세요");
			
		}else{
			$("#writeForm").ajaxSubmit({
			    type:'post',
				url:'<%=request.getContextPath()%>/board',
				contentType: 'application/json; charset=UTF-8',
				data:$("#writeForm").serialize(),
				success: function(serverResult){
					var result=JSON.parse(serverResult);
					
					if(result==0){
						alert("서버에 오류가 발생하였습니다.")
					}else{
						location.assign(contextPath+"/board/external?scode="+scode+"&sname="+sname);
					}
					
				},
				error: function(x,e){
					 if(x.status==0){
					      alert('네트워크를 체크해주세요.');
					      }else if(x.status==404){
					      alert('페이지를 찾을수없습니다.');
					      }else if(x.status==500){
					      alert('서버에러 발생하였습니다.');
					      }else if(e=='parsererror'){
					      alert('Error.\nParsing JSON Request failed.');
					      }else if(e=='timeout'){
					      alert('시간을 초과하였습니다.');
					      }else {
					      alert('알수없는 에러가 발생하였습니다.\n'+x.responseText);
					      }
				}
			});

			
		}
	});
	
///////////////글삭제
   $("#externalCard > i").on("click",function(){
	   
	   var data=$(this).data();
	   alert(data.entry);
	   
	   var check=confirm("삭제 하시겠습니까?");
	   
	   if(check==true){
	   
	   $.ajax({
		   type:'delete',
			url:'<%=request.getContextPath()%>/board',
			data:JSON.stringify({'scode': scode, 'entryNum':data.entry,'writer':data.writer}),
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult) {
				var result=JSON.parse(serverResult);
			      	if(result==-1){
			      		alert("작성자가 아닙니다.");
			      	}else if(result==0){
			      	    alert("서버에 오류가 발생하였습니다");	
			      	}else{
			      		
			        location.assign(contextPath+"/board/external?scode="+scode+"&sname="+sname);
			      		
			      	}
			      		
			 },
			 error: function(x,e){
				 if(x.status==0){
				      alert('네트워크를 체크해주세요.');
				      }else if(x.status==404){
				      alert('페이지를 찾을수없습니다.');
				      }else if(x.status==500){
				      alert('서버에러 발생하였습니다.');
				      }else if(e=='parsererror'){
				      alert('Error.\nParsing JSON Request failed.');
				      }else if(e=='timeout'){
				      alert('시간을 초과하였습니다.');
				      }else {
				      alert('알수없는 에러가 발생하였습니다.\n'+x.responseText);
				      }
			 }
			
		   
	      });
	   
	  }
   });
    
/////////////////글수정 불러오기
   $(".card-footer > #board_mod").on("click",function(){
	   
	   var data=$(this).data();
	   
	   $.ajax({
		   type:'post',
			url:'<%=request.getContextPath()%>/board/modify_call',
			data:{'scode': scode, 'entryNum':data.entryNum},
			success: function(server_result) {
				$(".container").empty();
				$(".container").append("<div id='reflash' class='row'><form method='post' enctype='multipart/form-data' ><input type='hidden' name='entryNum' value="+data.entryNum+"><input type='hidden' name='scode' value="+scode+"><div class='form-group'><label for='title'>제목</label><input size=200 type='text' class='form-control' id='titleInput' value='"+server_result.title+"'><small class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 8글자이내)</small></div><div class='form-group'><textarea id='summernote'>"+server_result.content+"</textarea><br><label class='btn btn-primary btn-file'>사진 첨부 <input type='file' id='file'></label><small class='form-text text-muted'>사진은 필수입니다.</small></div></form></div><button id='modifyBtn' class='btn btn-outline-secondary float-right'>수정</button><button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");
		    
		    $('#summernote').summernote({
		      placeholder: '종류, 위치 등 자세하게 적어주세요',
		      minHeight: 300, 
		      Width: 700,
		      lang: 'ko-KR',
		      toolbar: [
		    	    ['style', ['bold', 'italic', 'underline', 'clear']],
		    	    ['font', ['strikethrough', 'superscript', 'subscript']],
		    	    ['color', ['color']],
		    	    ['para', ['ul', 'ol', 'paragraph']],
		    	    ['height', ['height']]
		    	  ],
		        popover: {image: []}
		    });
				
				
				
			 }
			
	      });
	  });
//////////////////////글 수정 업데이트
   
$(document).on("click","#modifyBtn",function(){
	   if($("#titleInput").val()==null){
		alert("제목을 확인해주세요"); }
	   else if($("#summernote").val()==null){
		   alert("내용을 확인해주세요");
	   }
    else {
	    $("form").prop("action","<%=request.getContextPath()%>/board/modify").submit();
	}
	   
   });
	
});


</script>

<style>
#boardDel {
	position: relative;
	top: 10px;
	left: 110px;
}

#external_content {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 150px;
	display: inline-block;
}

.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	min-height: 100%;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}

#page-wrappe {
	padding-left: 250px;
}

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

.sidebar-nav>.sidebar-brand {
	font-size: 1.3em;
	line-height: 3em;
	color: gray;
}

#inner_img {
	width: auto;
	height: 200px;
}

#outImg {
	height: 225px;
	width: 253px;
}

dt {
	display: inline;
}
</style>
</head>
<body>

	<!--상단바-->
	<nav>
		<div id="topbar" class="navbar navbar-dark bg-dark fixed-top">
			<a class="navbar-brand" href="#" onclick="history.go(0)">Inner
				Subway</a>
		</div>
		<!--/상단바-->

		<!-- 사이드바 -->
		<div id="page-wrapper">
			<div id="sidebar-wrapper">
				<ul class="sidebar-nav">
					<li class="sidebar-brand"></li>
					<li class="sidebar-brand">${stationList[0].line}호선</li>
					<c:forEach var="key" items="${stationList}" >
						<li><a href="<%=request.getContextPath()%>/board/external?scode=${key.scode}&sname=${key.sname}">${key.sname}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>

	</nav>
	<!-- /사이드바 -->

	<!--카드게시판-->
	<%--  <form action="<%=request.getContextPath()%>/board/write">
 <input type="submit" class="btn btn-light" value="글쓰기">
 </form> --%>

	<div id="page-wrapper" style="padding-top: 150px">
		<h1 style="margin-left: 150px">${sname}역 게시판
			<hr/>
		</h1>
		<div class="container">
			<form action="<%=request.getContextPath()%>/board/external"
				method="post" class="text-right">
				<input type="hidden" name="scode"
					value="<%=session.getAttribute("scode")%>"> <select
					name="select"><option value="title">제목</option>
					<option value="writer">작성자</option></select> <input type="search"
					name="search" size="30"> <input type="submit" value="검색">
			</form>
			<br>
			<div id="reflash" class="row text-center">
				 <c:forEach var="board" items="${boardList}">
					<div class="col-lg-3 col-md-6 mb-4">
						<div id="externalCard" class="card">
							<img id="outImg" class="card-img-top"
								src="http://placehold.it/500x325" alt="">
								<i id="boardDel"
								data-entry='${board.entryNum}'  data-writer='${board.writer}'  class="far fa-times-circle"></i>
							<%-- <img class="card-img-top" src="${list[i].img_path}" alt=""><i id="boardDel" data-writer='${list[i].writer}' data-entryNum="${list[i].entryNum}" class="far fa-times-circle"></i> --%>
							<div class="card-body" id="external_box">
								<h4 class="card-title"></h4>
								<p class="card-text" id="external_content">${board.content}</p>
								<footer class="blockquote-footer">From
									${board.writer}</footer>
							</div>
							<div class="card-footer">
								<button style="margin-left: 10px" id="modal_req" type="button"
									data-entryNum='${board.entryNum}'
									data-scode='${board.scode}' class="btn btn-outline-secondary"
									data-toggle="modal" data-target=".bd-example-modal-lg">상세보기</button>
								<button style="margin-left: 10px" id="board_mod" type="button"
									data-entryNum='${board.entryNum}'
									data-scode='${board.scode}' class="btn btn-outline-danger">수정하기</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<button id="boardWrite" class="btn btn-outline-secondary float-right">글작성</button>
			<ul style="text-align: center" class="pagination mx-auto">
				<c:forEach begin="${pageMap.startPage}" end="${pageMap.endPage}" var="i">
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&page=${i}">${i}</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!--카드게시판-->

	<!-- 게시판 등록 -->


	<!--/ 게시판 등록 -->



	<!-- 게시판 상세보기 -->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">

			<div class="modal-content">
				<!--        모달창 내부                      -->

				<div class="card bg-light mb-3" style="max-width: auto;">
					<div class="card-header">상세보기</div>
					<div class="card-body">
						<p class="card-text">
							<img id="inner_img" alt="이미지"
								src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png">
							<!-- <img alt="이미지" src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"> -->
						</p>
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
						2018-10-04&nbsp;&nbsp; <i class="far fa-eye">&nbsp;3</i>
					</div>
				</div>
				<br>


				<div class="alert alert-secondary">
					<strong>댓글목록 </strong>
					<hr>
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
						<button id="inner_board_comment" class="btn btn-outline-secondary">등록</button>
					</div>
					<br>

				</div>


				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /게시판 상세보기 -->

</body>
</html>