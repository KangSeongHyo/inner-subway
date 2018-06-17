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
<script type='text/javascript'
	src='http://malsup.github.com/jquery.form.js'></script>
<script type="text/javascript">

function formatDate(date) { 
	var d = new Date(date),
	month = '' + (d.getMonth() + 1), 
	day = '' + d.getDate(),
	year = d.getFullYear(); 
	if (month.length < 2) month = '0' + month; 
	if (day.length < 2) day = '0' + day; 
	return [year, month, day].join('-'); }
	
$(document).ready(function(){

	var scode='${scode}';
	var entryNum=0;
	var contextPath='<%=request.getContextPath()%>';
	var sname='${sname}';
	
///////////// 상세보기
	$(".card-footer > #modalreq").on("click",function(){
	
		var data=$(this).data();
		
    ////////////외부게시판 view, 검색
         $.ajax({
        	 ////ajax
		    type:'get',
			url:'<%=request.getContextPath()%>/board/'+data.scode+'/'+data.entrynum,
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult){
				
					$("#innerImg").prop("src",serverResult.imgPath);
					$("#innerBoardTitle").html(serverResult.title);
					$("#innerBoardContent").html(serverResult.content);
					$("#innerFooter").html("From "+serverResult.writer);
					$("#regDate").html(formatDate(serverResult.registrationDate)+"&nbsp;&nbsp;"+"<i class='far fa-eye'>"+"&nbsp;"+serverResult.viewCount+"</i>");
		      },
		      error: function(xhr,status){
					 if(xhr.status==0){
					      alert('네트워크를 체크해주세요.');
					 }else if(xhr.status==404){
					      alert('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
					      alert('서버에러 발생하였습니다.');
					 }else if(status=='parsererror'){
					      alert('Error.\nParsing JSON Request failed.');
					 }else if(status=='timeout'){
					      alert('시간을 초과하였습니다.');
					 }else {
					      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
					 }
				 }
        });/////// ajax 끝
	
         $("#commentList").empty();
         //댓글리스트 불러오기
         $.ajax({/// ajax
        	 
        	 type:'get',
        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
 			 contentType: 'application/json; charset=UTF-8',
			 success: function(serverResult){
				
				 for(var i=0;i<serverResult.length;i++){
			         	
					    $("#commentList").append("<dl id='comment'><dt>"+serverResult[i].writer
			         			+"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
			         			+"&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
			         			+"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
			         			+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
			         			+"'class='far fa-edit'></i></span><dd>"
			         			+serverResult[i].content+"</dd></dl><hr>");
				      }
			         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
			         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
		
			   },
			   error: function(xhr,status){
					 if(xhr.status==0){
					      alert('네트워크를 체크해주세요.');
					 }else if(xhr.status==404){
					      alert('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
					      alert('서버에러 발생하였습니다.');
					 }else if(status=='parsererror'){
					      alert('Error.\nParsing JSON Request failed.');
					 }else if(status=='timeout'){
					      alert('시간을 초과하였습니다.');
					 }else {
					      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
					 }
				 }
        	         	 
        	 
         }); /////ajax 끝
	
	}); /////상세보기
	
	//////////////////////댓글 등록
  $(document).on("click","#innerBoardCommentBtn",function(){
		var data=$(this).data();
	  
		$.ajax({
			type:'POST',
			url: '<%=request.getContextPath()%>/comment',
			contentType: 'application/json; charset=UTF-8',
			data:JSON.stringify({ 
				   'scode':data.scode,
				   'entryNum' : data.entrynum,
				   'content' : $("#commentContent").val()
			}),
			success : function(serverResult){
				/////댓글 불러오기(reflash)
				if(serverResult==1){
					
					 $.ajax({
			        	 type:'get',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 
							 for(var i=0;i<serverResult.length;i++){
								 $("#commentList").append("<dl id='comment'><dt>"+serverResult[i].writer
						         			+"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
						         			+"&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
						         			+"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
						         			+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
						         			+"'class='far fa-edit'></i></span><dd>"
						         			+serverResult[i].content+"</dd></dl><hr>");
					               }
							 
							 $("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
					         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");

							 $("#commentContent").val("");
						 },
						 
						 error: function(xhr,status){
							 if(xhr.status==0){
							      alert('네트워크를 체크해주세요.');
							 }else if(xhr.status==404){
							      alert('페이지를 찾을수없습니다.');
							 }else if(xhr.status==500){
							      alert('서버에러 발생하였습니다.');
							 }else if(status=='parsererror'){
							      alert('Error.\nParsing JSON Request failed.');
							 }else if(status=='timeout'){
							      alert('시간을 초과하였습니다.');
							 }else {
							      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
							 }
						 }
			        	         	 
			        	 
			         });
					
					
				}else{
					alert('서버에 오류가 발생하였습니다');
					
				}
			},
			 error: function(xhr,status){
				 if(xhr.status==0){
				      alert('네트워크를 체크해주세요.');
				 }else if(xhr.status==404){
				      alert('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
				      alert('서버에러 발생하였습니다.');
				 }else if(status=='parsererror'){
				      alert('Error.\nParsing JSON Request failed.');
				 }else if(status=='timeout'){
				      alert('시간을 초과하였습니다.');
				 }else {
				      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
				 }
			 }

		}); 
		
		
	}); ////댓글등록 끝


////////////////댓글삭제
   $(document).on("click","#commentDel",function(){
		
	var check=confirm("댓글을 삭제하시겠습니까?");	
	  if(check==true){
			
		var data=$(this).data();
		
		$.ajax({
			type:'DELETE',
			url: '<%=request.getContextPath()%>/comment',
			contentType: 'application/json; charset=UTF-8',
			data:JSON.stringify({ 
				   'scode':data.scode,
				   'entryNum' : data.entrynum,
				   'commentSeq' : data.seq,
				   'writer':data.wr
			  }),
			success : function(serverResult){
				if(serverResult==-1){
					alert("댓글 작성자가 아닙니다.");
				}else if(serverResult==0){
					alert("서버에 오류가 발생하였습니다.");				 	
				}else{
				
					$.ajax({
			        	 type:'GET',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 
							 for(var i=0;i<serverResult.length;i++){
						         	$("#commentList").append("<dl id='comment'><dt>"+serverResult[i].writer
						         			+"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
						         			+"&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"
						         			+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq+"' class='far fa-trash-alt'></i>"
						         			+"<i id='commentModify' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"
						         			+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq+"' class='far fa-edit'></i></span><dd>"
						         			+serverResult[i].content+"<hr></dd></dl>");
							       }

					         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
					         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
					         

							 $("#commentContent").val("");
						 },
						 
						 error: function(xhr,status){
							 if(xhr.status==0){
							      alert('네트워크를 체크해주세요.');
							 }else if(xhr.status==404){
							      alert('페이지를 찾을수없습니다.');
							 }else if(xhr.status==500){
							      alert('서버에러 발생하였습니다.');
							 }else if(status=='parsererror'){
							      alert('Error.\nParsing JSON Request failed.');
							 }else if(status=='timeout'){
							      alert('시간을 초과하였습니다.');
							 }else {
							      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
							 }
						 }
			        	         	 
			        	 
			         });
					
				}
			 },
			 error: function(xhr,status){
				 if(xhr.status==0){
				      alert('네트워크를 체크해주세요.');
				 }else if(xhr.status==404){
				      alert('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
				      alert('서버에러 발생하였습니다.');
				 }else if(status=='parsererror'){
				      alert('Error.\nParsing JSON Request failed.');
				 }else if(status=='timeout'){
				      alert('시간을 초과하였습니다.');
				 }else {
				      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
				 }
			 }

		}); 
		
	  }////confirm 
		
	}); /// 댓글 삭제 끝

	
    ////////////////////댓글수정 폼
   $(document).on("click","#commentModify",function(){
	 var confm=confirm("댓글을 수정하시겠습니까?");
	
	 if(confm==true){
	 var data=$(this).data();
	 var ths=this;
	 
	 $.ajax({
		 
    	 type:'GET',
    	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum+'/'+data.seq+'/'+data.wr,
		 contentType: 'application/json; charset=UTF-8',
		 success: function(serverResult){
			 
			 if(serverResult==null){
				 alert("서버에 오류가 발생하였습니다.");
			 }else{
				
				 $(ths).closest("dl").children("dd").html("<div class='form-group'><label><abbr class='initialism'>댓글수정</abbr>:</label>"
							+"<textarea class='form-control' rows='5' id='modifyContent'>"+serverResult.content+"</textarea><button id='commmentModifyBtn' style='float:right' data-scode='"+serverResult.scode+"' data-entrynum="
							+serverResult.entryNum+" data-commentseq="+serverResult.commentSeq+" data-writer='"+serverResult.writer+"' class='btn btn-outline-secondary'>수정</button></div>");
				 
			 }
		 },
		 error: function(xhr,status){
			 if(xhr.status==0){
			      alert('네트워크를 체크해주세요.');
			 }else if(xhr.status==401){
				 alert('권한이 없습니다');
			 }else if(xhr.status==404){
			      alert('페이지를 찾을수없습니다.');
			 }else if(xhr.status==500){
			      alert('서버에러 발생하였습니다.');
			 }else if(status=='parsererror'){
			      alert('Error.\nParsing JSON Request failed.');
			 }else if(status=='timeout'){
			      alert('시간을 초과하였습니다.');
			 }else {
			      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
			 }
		 }
		 
		 
	   });
	 }			
   }); ////// 댓글수정 폼 끝
    
   ////////////////////댓글수정
   $(document).on("click","#commmentModifyBtn",function(){
	  var data=$(this).data();
	  
	    $.ajax({
			type:'PUT',
			url: '<%=request.getContextPath()%>/comment',
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify({ 
				   'scode': data.scode,
				   'entryNum' : data.entrynum,
				   'content' : $(this).closest("div").children("#modifyContent").val(),
				   'commentSeq' : data.commentseq
			}),
			success : function(serverResult){
				
				if(serverResult==0){
					alert("서버에 오류가 발생하였습니다.");
					
				}else{
					$.ajax({
			        	 
			        	 type:'get',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 for(var i=0;i<serverResult.length;i++){
						         	
								    $("#commentList").append("<dl id='comment'><dt>"+serverResult[i].writer
						         			+"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
						         			+"&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
						         			+"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
						         			+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
						         			+"'class='far fa-edit'></i></span><dd>"
						         			+serverResult[i].content+"</dd></dl><hr>");
							      }
						         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
						         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
					
						   },
						   error: function(xhr,status){
								 if(xhr.status==0){
								      alert('네트워크를 체크해주세요.');
								 }else if(xhr.status==404){
								      alert('페이지를 찾을수없습니다.');
								 }else if(xhr.status==500){
								      alert('서버에러 발생하였습니다.');
								 }else if(status=='parsererror'){
								      alert('Error.\nParsing JSON Request failed.');
								 }else if(status=='timeout'){
								      alert('시간을 초과하였습니다.');
								 }else {
								      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
								 }
							 }
			        	         	 
			        	 
			         });
					
				}
				
			},
		  error: function(xhr,status){
				 if(xhr.status==0){
				      alert('네트워크를 체크해주세요.');
				 }else if(xhr.status==404){
				      alert('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
				      alert('서버에러 발생하였습니다.');
				 }else if(status=='parsererror'){
				      alert('Error.\nParsing JSON Request failed.');
				 }else if(status=='timeout'){
				      alert('시간을 초과하였습니다.');
				 }else {
				      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
				 }
		       }
	      });
    
     }); /////// 댓글 수정끝

///////////////// 글작성 폼

	$("#boardWrite").on("click",function(){
		
		if('${id}'==''){
			alert("로그인 뒤에 이용해주세요");
		} else {
			
		$(".container").empty();
		$(".container").append("<div id='reflash' class='row'><form id='writeForm' method='post' enctype='multipart/form-data' ><input type='hidden' name='scode' value="
				+scode+"><input type='hidden' name='writer' value='${id}'><div class='form-group'><label for='title'>제목</label><input size=200 type='text' class='form-control' id='titleInput' name='title'><small id='title_req' class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 8글자이내)</small></div><div class='form-group'><textarea name='content' id='summernote'></textarea><br><label class='btn btn-success btn-file'>사진 첨부 <input type='file' name='file' id='file'></label><small id='title_req' class='form-text text-muted'>사진은 필수입니다.</small></div></form></div><button id='boardRegister' class='btn btn-outline-secondary float-right'>등록</button><button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");	
		}
	 
       /////////// 에디터
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

	
///////////////글삭제

   $("#externalCard > i").on("click",function(){
	   
	   var data=$(this).data();
	   alert(data.entry);
	   
	   var check=confirm("삭제 하시겠습니까?");
	   
	   if(check==true){
	   
	   $.ajax({
		   type:'DELETE',
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
			 error: function(xhr,status){
				 if(xhr.status==0){
				      alert('네트워크를 체크해주세요.');
				      }else if(xhr.status==404){
				      alert('페이지를 찾을수없습니다.');
				      }else if(xhr.status==500){
				      alert('서버에러 발생하였습니다.');
				      }else if(status=='parsererror'){
				      alert('Error.\nParsing JSON Request failed.');
				      }else if(status=='timeout'){
				      alert('시간을 초과하였습니다.');
				      }else {
				      alert('알수없는 에러가 발생하였습니다.\n'+xhr.responseText);
				      }
			      }
			
		   
	      });
	   
	  }
   });
    
/////////////////글수정 불러오기
   $(".card-footer > #boardMod").on("click",function(){
	   
	   var data=$(this).data();
	   $.ajax({
		   type:'get',
			url:'<%=request.getContextPath()%>/board/'+scode+'/'+data.entrynum+'/'+data.writer,
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult) {
				
				if(serverResult==""){
					alert("권한이 없습니다.")
				}else{
					
				$(".container").empty();
				$(".container").append("<div id='reflash' class='row'><form id='modifyform' method='post' enctype='multipart/form-data' ><input type='hidden' name='entryNum' value="+data.entrynum+"><input type='hidden' name='scode' value="+scode+"><div class='form-group'><label for='title'>제목</label><input size=200 type='text' class='form-control' id='titleInput' name='title' value='"+serverResult.title+"'><small class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 8글자이내)</small></div><div class='form-group'><textarea name='content' id='summernote'>"+serverResult.content+"</textarea><br><label class='btn btn-primary btn-file'>사진 첨부 <input type='file' id='file'></label><small class='form-text text-muted'>기존 사진 사용시 변경할 필요가 없습니다.</small></div></form></div><button id='modifyBtn' class='btn btn-outline-secondary float-right'>수정</button><button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");		    
					
				}
				
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
	  });
	  
///////////////////글 작성
	$(document).on("click","#boardRegister",function(){
		if($("#titleInput").val()==null){
			alert("내용을 확인해주세요");
			
		}else{
			$("#writeForm").ajaxSubmit({
			    type:'post',
				url:'<%=request.getContextPath()%>/board',
				contentType: 'application/json; charset=UTF-8',
				data: $("#writeForm").serialize(),
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
		}//else 끝
	});
	
//////////////////////글 수정 업데이트
   
$(document).on("click","#modifyBtn",function(){
	   if($("#titleInput").val()==null){
		alert("제목을 확인해주세요"); 
		}
	   else if($("#summernote").val()==null){
		   alert("내용을 확인해주세요");
	   }
       else {
    	   
    	   $("#modifyform").ajaxSubmit({
			    type:'post',
				url:'<%=request.getContextPath()%>/board/modify',
	            contentType : 'application/json; charset=UTF-8',
	            data : $("#modifyform").serialize(),
	            success : function(serverResult) {
		         
	            	var result = JSON.parse(serverResult);

		              if (result == 0) {
			            alert("서버에 오류가 발생하였습니다.");
		              } else {
			            location.assign(contextPath+ "/board/external?scode="+ scode+ "&sname="+ sname);
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
});///// ready 끝

</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
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
					<li class="sidebar-brand">${stationList[0].line}호선</li>
					<li class="sidebar-brand">${stationList[0].line}호선</li>
					<c:forEach var="key" items="${stationList}">
						<li><a
							href="<%=request.getContextPath()%>/board/external?scode=${key.scode}&sname=${key.sname}&page=1">${key.sname}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>

	</nav>
	<!-- /사이드바 -->

	<!--카드게시판-->

	<div id="page-wrapper" style="padding-top: 150px">
		<h1 style="margin-left: 150px">${sname}역
			게시판
			<hr />
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
								src="http://placehold.it/500x325" alt=""> <i id="boardDel"
								data-entry='${board.entryNum}' data-writer='${board.writer}'
								class="far fa-times-circle"></i>

							<div class="card-body" id="external_box">
								<h4 class="card-title">${board.title}</h4>
								<p class="card-text" id="external_content">${board.content}</p>
								<footer class="blockquote-footer">From ${board.writer}</footer>
							</div>

							<div class="card-footer">
								<button style="margin-left: 10px" id="modalreq" type="button"
									data-entrynum='${board.entryNum}' data-scode='${board.scode}'
									class="btn btn-outline-secondary" data-toggle="modal"
									data-target=".bd-example-modal-lg">상세보기</button>
								<button style="margin-left: 10px" id="boardMod" type="button"
									data-entryNum='${board.entryNum}' data-scode='${board.scode}'
									data-writer='${board.writer}' class="btn btn-outline-danger">수정하기</button>
							</div>

						</div>
					</div>
				</c:forEach>
			</div>


     <!--페이지 처리-->
			<button id="boardWrite" class="btn btn-outline-secondary float-right">글작성</button>
			<ul style="float:center" class="pagination mx-auto justify-content-center">
		   <c:if test="${param.page>1}" >
				<li class="page-item"><a class="page-link"  href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&page=${param.page-1}" >이전</a></li>
            </c:if>
				<c:forEach begin="${pageMap.startPage}" end="${pageMap.endPage}" var="i" >
				    <c:if test="${param.page==i}">
				     <li class="page-item active"><a class="page-link"  href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&page=${i}">${i}</a></li>
				    </c:if>
				    <c:if test="${param.page!=i}">
				    <li class="page-item"><a class="page-link"  href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&page=${i}">${i}</a></li>
				    </c:if>
				</c:forEach>
			<c:if test="${pageMap.totalPage > param.page}" >
				<li class="page-item"><a class="page-link"  href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&page=${param.page+1}" >다음</a></li>
            </c:if>
			</ul>
		</div>
	</div>
	<!--카드게시판-->



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
							<img id="innerImg" alt="이미지"
								src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png">
							<!-- <img alt="이미지" src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"> -->
						</p>
					</div>
				</div>

				<div class="card text">
					<div class="card-header">내용</div>
					<div class="card-body">
						<h5 id="innerBoardTitle" class="card-title">title</h5>
						<p class="card-text" id="innerBoardContent">error</p>
						<footer id='innerFooter' class="blockquote-footer">From
							작성자</footer>
					</div>

					<div id="regDate" class="card-footer text-right text-muted">
						2018-10-04&nbsp;&nbsp; <i class="far fa-eye">&nbsp;3</i>
					</div>
				</div>
				<br>


				<div class="alert alert-secondary">
					<strong>댓글목록 </strong>
					<hr>

					<div id="commentList"></div>

					<div class="form-group">
						<label><abbr class="initialism">댓글작성</abbr>:</label>
						<textarea class="form-control" rows="5" id="commentContent"></textarea>
					</div>

					<div id="innerBoardComment" class="text-right"
						style="margin-right: 23px"></div>

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