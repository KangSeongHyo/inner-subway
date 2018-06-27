<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Inner Subway</title>
<meta content="width=device-width">
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
<script type='text/javascript' src='http://malsup.github.com/jquery.form.js'></script>
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
 <!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.core.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.11/alertify.default.min.css" rel="stylesheet">

<script type="text/javascript">

function formatDate(date) { 
	var d = new Date(date),
	month = '' + (d.getMonth() + 1), 
	day = '' + d.getDate(),
	year = d.getFullYear(); 
	if (month.length < 2) month = '0' + month; 
	if (day.length < 2) day = '0' + day; 
	return [year, month, day].join('-'); }

function formatTime(date) {
	var d=new Date(date);
    hours = format_two_digits(d.getHours());
    minutes = format_two_digits(d.getMinutes());
    seconds = format_two_digits(d.getSeconds());
    return hours + ":" + minutes + ":" + seconds;
}

function format_two_digits(n) {
    return n < 10 ? '0' + n : n;
}
	
function getUrlParameter(sParam) {
	var sPageURL = decodeURIComponent(window.location.search.substring(1));
	var sURLVariables = sPageURL.split('&');
	var sParameterName;
	
	for (var i = 0; i < sURLVariables.length; i++) {
		sParameterName = sURLVariables[i].split('=');

		if (sParameterName[0] === sParam) {
			return sParameterName[1] === undefined ? true : sParameterName[1];
		}
	}
};

$(document).ready(function(){
	
	var contextPath='<%=request.getContextPath()%>';
	var SUCCESS = 1;
	var FAIL = 0;
	var CHECK=1;
	var RELEASE=0;
	var line=getUrlParameter("line");
	var modalObject;
	
	$('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });
    // 상세보기
	$(document).on("click","#modalReq",function(){
	
		modalObject=$(this).closest("#externalCard").find("#recommendIcon");
		var data=$(this).data();
		
         //외부게시판 view
         $.ajax({
		    type:'GET',
			url:'<%=request.getContextPath()%>/board/'+data.scode+'/'+data.entrynum,
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult){
				
					$("#innerImg").prop("src",serverResult.imgPath);
					$("#innerBoardTitle").html(serverResult.title);
					$("#innerBoardContent").html(serverResult.content);
					$("#innerFooter").html("From "+serverResult.writer);
					$("#regDate").html("<i id='innerRecommendIcon' class='far fa-thumbs-up'>"+serverResult.recommend+"</i>"+formatDate(serverResult.registrationDate)+"&nbsp;&nbsp;"
					+"<i class='far fa-eye'>"+"&nbsp;"+serverResult.viewCount+"</i>");
		      },
		      error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
        });
         
         //댓글리스트 불러오기
         $("#commentList").empty();
         
         $.ajax({
        	 
        	 type:'GET',
        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
 			 contentType: 'application/json; charset=UTF-8',
			 success: function(serverResult){
				
				 for(var i=0;i<serverResult.length;i++){
					 
					 var str="";
					 	str+="<dl id='comment'><dt>"+serverResult[i].writer
					 	  +"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)+" "+formatTime(serverResult[i].registrationDate);
					 	  
				      if(serverResult[i].writer=='${id}'){
				    	 str+="&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
				    	 	 +"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
			         		 +data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
			         		 +"'class='far fa-edit'></i></span>";
					 }
					 
					 str+="<dd>"+serverResult[i].content+"</dd></dl><hr>";
					 
					 $("#commentList").append(str);
				  }  
					  /*   $("#commentList").append("<dl id='comment'><dt>"+serverResult[i].writer
			         			+"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
			         			+"&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
			         		    +"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
			         			+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
			         			+"'class='far fa-edit'></i></span><dd>"
			         			+serverResult[i].content+"</dd></dl><hr>");
					  */   
				    
				 
			         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
			         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
		
			   },
			   error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
		    	 
         }); 
	
	}); //상세보기 end
	
	//검색
	$(document).on("click","#searchBoardBtn",function(e){
		e.preventDefault();
		
		var search=$("#searchBoard").val();
		
		if(search==""){
			alertify.error("검색어를 확인해주세요");
			return;
		}
		
		var data=$(this).data();
		
          $.ajax({// ajax
        	  
             type:'GET',
        	 url:'<%=request.getContextPath()%>/board/search/'+data.scode+'/'+search+'/'+data.page,
 			 contentType: 'application/json; charset=UTF-8',
			 success: function(serverResult){
				 
				$("#searchBoard").prop("disabled","disabled");
				 
				$("#reflash").empty();
				$("#searchForm > #searchCancel").remove();
				$("#searchForm").append("<button id='searchCancel' type='button' class='btn btn-danger' onClick='history.go(0)' >검색취소</button>");
				
				if(serverResult['boardList'].length==0){
					$("#reflash").append("<div id=noSearch><h2>&nbsp;&nbsp;&nbsp;&nbsp;등록된 게시글이 없습니다.</h2></div>");
					return;
				}
				
				 /* $("#reflash").append("<div class='col-lg-3 col-md-6 mb-4'>"
				  +"<div id='externalCard' class='card'><img id='outImg' class='card-img-top' src="+serverResult['boardList'][key].imgPath+">"
				  +"<i id='boardDel' data-scode="+serverResult['boardList'][key].scode+" data-entry="+serverResult['boardList'][key].entryNum
				  +" data-writer="+serverResult['boardList'][key].writer+" class='far fa-times-circle'></i>"
				  +"<div class='card-body' id='externalBox'><h4 class='card-title'>"+serverResult['boardList'][key].title+"</h4>"
				  +"<p class='card-text' id='externalContent'>"+serverResult['boardList'][key].content+"</p>"
				  +"<footer class='blockquote-footer' >From "+serverResult['boardList'][key].writer+"</footer></div>"
				  +"<div class='card-footer'><button style='margin-left: 10px' id='modalReq' type='button' "
				  +"data-entrynum="+serverResult['boardList'][key].entryNum+" data-scode="+serverResult['boardList'][key].scode
				  +" class='btn btn-outline-secondary' data-toggle='modal' data-target='.bd-example-modal-lg' >상세보기</button> "
				  +"<button style='margin-left: 10px' id='boardMod' data-entryNum="+serverResult['boardList'][key].entryNum
				  +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
				  +" class='btn btn-outline-danger'>수정하기</button></div></div></div>" );	
				*/
			for(var key in serverResult['boardList']){
				var str="";
				
				 str+="<div class='col-lg-3 col-md-6 mb-4'>"+"<div id='externalCard' class='card border-success'><img id='outImg' class='card-img-top' src="+serverResult['boardList'][key].imgPath+">";
				 
				  if(serverResult['boardList'][key].writer=='${id}'){
					 str+="<div class='card bg-light rounded-0'><span><i id='boardDel' data-scode="+serverResult['boardList'][key].scode+" data-entry="+serverResult['boardList'][key].entryNum
					  +" data-writer="+serverResult['boardList'][key].writer+" class='far fa-times-circle'></i><i style='right:36.5%' id='recommendIcon' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
				  }else{
					  str+="<div class='card bg-light rounded-0'><span><i id='recommendIcon' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
				  }
				  
				  
				  str+="<div class='card-body' id='externalBox'><h4 class='card-title'>"+serverResult['boardList'][key].title+"</h4>"
				       +"<p class='card-text' id='externalContent'>"+serverResult['boardList'][key].content+"</p>"
				       +"<footer class='blockquote-footer' >From "+serverResult['boardList'][key].writer+" ["+formatDate(serverResult['boardList'][key].registrationDate)+"]</footer></div>"
				  	   +"<div class='card-footer border-dark'><button style='margin-left: 10px' id='modalReq' type='button' "
				  	   +"data-entrynum="+serverResult['boardList'][key].entryNum+" data-scode="+serverResult['boardList'][key].scode
				  	   +" class='btn btn-outline-secondary' data-toggle='modal' data-target='.bd-example-modal-lg' >상세보기</button> ";

				  if(serverResult['boardList'][key].writer=='${id}'){
				      str+="<button id='boardMod' data-entryNum="+serverResult['boardList'][key].entryNum
				  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
				  	   +" class='btn btn-outline-danger'>수정하기</button></div></div></div>";
				  	   
				  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==false){
					  str+="<button id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
				  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
				  	   +" class='btn btn-outline-success'>추천하기</button></div></div></div>";	
				  
				  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==true){
					  str+="<button id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
				  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
				  	   +" class='btn btn-success'>추천해체</button></div></div></div>";
				  }
				  
				$("#reflash").append(str);
			 }
				$("#paging").empty();
				
				if(data.page>1){
					$("#paging").append("<li class='page-item'><a id='searchBoardBtn' data-scode="
							+data.scode+" data-page="+(data.page-1)+" class='page-link' href='#' >이전</a></li>");
				}
				
				for(var i=serverResult['pageMap'].startPage;i<=serverResult['pageMap'].endPage;i++){
					if(data.page==i){
						
						$("#paging").append("<li class='page-item active'><a id='searchBoardBtn' data-scode="
								+data.scode+" data-page="+i+" class='page-link' href='#' >"+i+"</a></li>");
						
					}else{
						$("#paging").append("<li class='page-item '><a id='searchBoardBtn' data-scode="
								+data.scode+" data-page="+i+" class='page-link' href='#' >"+i+"</a></li>");
					}
				}
				
				if(serverResult['pageMap'].endPage>data.page){
					$("#paging").append("<li class='page-item'><a id='searchBoardBtn' data-scode="
							+data.scode+" data-page="+(data.page+1)+" class='page-link' href='#' >다음</a></li>");
				}
				
			 },
			 error: function(xhr,status){
				 
				 if(xhr.status==0){
					 alertify.error('네트워크를 체크해주세요.');
				 }else if(xhr.status==400){
					 alertify.error('요청에 오류가 있습니다.');
				 }else if(xhr.status==401){
					 alertify.error('권한이 없습니다.');
				 }else if(xhr.status==404){
					 alertify.error('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
					 alertify.error('서버에 오류가 발생하였습니다.');
				 }else if(status=='timeout'){
					 alertify.error('시간을 초과하였습니다.');
				 }else {
					 alertify.error('에러가 발생하였습니다');
				 }
			 }
        	 
         });
		
	});
	
	
  //댓글 등록
  $(document).on("click","#innerBoardCommentBtn",function(){
		var data=$(this).data();
	  
		if($("#commentContent").val()==""){
			alertify.error("내용을 입력해주세요");
			return ;
		}
		
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
				if(serverResult==SUCCESS){
					
					 $.ajax({
			        	 type:'GET',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 
							 for(var i=0;i<serverResult.length;i++){
								 
									 var str="";
									 	str+="<dl id='comment'><dt>"+serverResult[i].writer
									 	  +"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)+" "+formatTime(serverResult[i].registrationDate);
									 	  
								      if(serverResult[i].writer=='${id}'){
								    	 str+="&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
								    	 	 +"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
							         		 +data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
							         		 +"'class='far fa-edit'></i></span>";
									 }
									 
									 str+="<dd>"+serverResult[i].content+"</dd></dl><hr>";
									 
									 $("#commentList").append(str);
									 
					               }
							 
							 $("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
					         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");

							 $("#commentContent").val("");
						 },
						 error: function(xhr,status){
							 if(xhr.status==0){
								 alertify.error('네트워크를 체크해주세요.');
							 }else if(xhr.status==400){
								 alertify.error('요청에 오류가 있습니다.');
							 }else if(xhr.status==401){
								 alertify.error('권한이 없습니다.');
							 }else if(xhr.status==404){
								 alertify.error('페이지를 찾을수없습니다.');
							 }else if(xhr.status==500){
								 alertify.error('서버에 오류가 발생하였습니다.');
							 }else if(status=='timeout'){
								 alertify.error('시간을 초과하였습니다.');
							 }else {
								 alertify.error('에러가 발생하였습니다');
							 }
						 }
			        	         	 
			        	 
			         });
					
					
				}else{
					alertify.error('서버에 오류가 발생하였습니다');
				}
			},
			 error: function(xhr,status){
				 if(xhr.status==0){
					 alertify.error('네트워크를 체크해주세요.');
				 }else if(xhr.status==400){
					 alertify.error('요청에 오류가 있습니다.');
				 }else if(xhr.status==401){
					 alertify.error('권한이 없습니다.');
				 }else if(xhr.status==404){
					 alertify.error('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
					 alertify.error('서버에 오류가 발생하였습니다.');
				 }else if(status=='timeout'){
					 alertify.error('시간을 초과하였습니다.');
				 }else {
					 alertify.error('에러가 발생하였습니다');
				 }
			 }
		}); 
		
		
	}); ////댓글등록 끝
   
	
   //댓글삭제
   $(document).on("click","#commentDel",function(){
		
      alertify.confirm("댓글을 삭제하시겠습니까?",function(e){
    	  if(e){
    		  callback(true);
    		  
    	  }else{
    		  callback(false);
    	  }
      });
	
		var data=$(this).data();
	
	function callback(value){
	  if(value==true){
			
		
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
					alertify.error("댓글 작성자가 아닙니다.");
				}else if(serverResult==FAIL){
					alertify.error("서버에 오류가 발생하였습니다.");				 	
				}else{
				
					$.ajax({
			        	 type:'GET',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 
							 for(var i=0;i<serverResult.length;i++){
										var str="";
										 	str+="<dl id='comment'><dt>"+serverResult[i].writer
										 	  +"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)
										 	  
									      if(serverResult[i].writer=='${id}'){
									    	 str+="&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
									    	 	 +"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
								         		 +data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
								         		 +"'class='far fa-edit'></i></span>";
										     }
										 
										 str+="<dd>"+serverResult[i].content+"</dd></dl><hr>";
										 
										 $("#commentList").append(str);
							       }

					         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
					         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
					         

							 $("#commentContent").val("");
						 },
						 error: function(xhr,status){
							 if(xhr.status==0){
								 alertify.error('네트워크를 체크해주세요.');
							 }else if(xhr.status==400){
								 alertify.error('요청에 오류가 있습니다.');
							 }else if(xhr.status==401){
								 alertify.error('권한이 없습니다.');
							 }else if(xhr.status==404){
								 alertify.error('페이지를 찾을수없습니다.');
							 }else if(xhr.status==500){
								 alertify.error('서버에 오류가 발생하였습니다.');
							 }else if(status=='timeout'){
								 alertify.error('시간을 초과하였습니다.');
							 }else {
								 alertify.error('에러가 발생하였습니다');
							 }
						 }
			        	         	 
			        	 
			         });
					
				}
			 },
			  error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
		}); 
		
	   }
	  }////confirm 
		
	}); /// 댓글 삭제 끝

	
    ////////////////////댓글수정 폼
   $(document).on("click","#commentModify",function(){
		
	 alertify.confirm("댓글을 수정하시겠습니까?",function (e){ 
		if(e) {
			callback(true); }
		else {
		   callback(false); }
		}); 

	   var data=$(this).data();
	   var ths=this;
	   
   function callback(value){
	 
	if(value==true){
		 
	 
	  $.ajax({
		 
    	 type:'GET',
    	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum+'/'+data.seq+'/'+data.wr,
		 contentType: 'application/json; charset=UTF-8',
		 success: function(serverResult){
			 
			 if(serverResult==null){
				 alertify.error("서버에 오류가 발생하였습니다.");
			 }else{
				
				 $(ths).closest("dl").children("dd").html("<div class='form-group'><label><abbr class='initialism'>댓글수정</abbr>:</label>"
							+"<textarea style='margin-bottom:10px' class='form-control' rows='5' id='modifyContent'>"+serverResult.content+"</textarea><button id='commmentModifyBtn' style='float:right' data-scode='"+serverResult.scode+"' data-entrynum="
							+serverResult.entryNum+" data-commentseq="+serverResult.commentSeq+" data-writer='"+serverResult.writer+"' class='btn btn-outline-secondary'>수정</button></div><hr style='margin-top:60px'>");
			 }
		 },
		  error: function(xhr,status){
				 if(xhr.status==0){
					 alertify.error('네트워크를 체크해주세요.');
				 }else if(xhr.status==401){
					 alertify.error('권한이 없습니다.');
				 }else if(xhr.status==404){
					 alertify.error('페이지를 찾을수없습니다.');
				 }else if(xhr.status==500){
					 alertify.error('서버에 오류가 발생하였습니다.');
				 }else if(status=='timeout'){
					 alertify.error('시간을 초과하였습니다.');
				 }else {
					 alertify.error('에러가 발생하였습니다');
				 }
			 }
		 
		 
	   });
	  }
	 }			
   }); ////// 댓글수정 폼 끝
    
   ////////////////////댓글수정
   $(document).on("click","#commmentModifyBtn",function(){
	  var data=$(this).data();
	  
	  
	 var content= $(this).closest("div").children("#modifyContent").val();
	 if(content==""){
		 alertify.error("내용을 입력해주세요");
		 return;
	 }
	 
	  
	    $.ajax({
			type:'PUT',
			url: '<%=request.getContextPath()%>/comment',
			contentType: 'application/json; charset=UTF-8',
			data: JSON.stringify({ 
				   'scode': data.scode,
				   'entryNum' : data.entrynum,
				   'writer' : data.writer,
				   'content' : content,
				   'commentSeq' : data.commentseq
			}),
			success : function(serverResult){
				
				if(serverResult==FAIL){
					alertify.error("서버에 오류가 발생하였습니다.");
					
				}else{
					$.ajax({
			        	 
			        	 type:'GET',
			        	 url:'<%=request.getContextPath()%>/comment/'+data.scode+'/'+data.entrynum,
			 			 contentType: 'application/json; charset=UTF-8',
						 success: function(serverResult){
							 
							 $("#commentList").empty();
							 for(var i=0;i<serverResult.length;i++){
						         	
										 var str="";
										 	str+="<dl id='comment'><dt>"+serverResult[i].writer
										 	  +"&nbsp;</dt><span>"+formatDate(serverResult[i].registrationDate)+" "+formatTime(serverResult[i].registrationDate)
										 	  
									      if(serverResult[i].writer=='${id}'){
									    	 str+="&nbsp;<i id='commentDel' data-scode="+data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
									    	 	 +"' class='far fa-trash-alt'></i><i id='commentModify' data-scode="
								         		 +data.scode+" data-entrynum="+data.entrynum+" data-wr='"+serverResult[i].writer+"' data-seq='"+serverResult[i].commentSeq
								         		 +"'class='far fa-edit'></i></span>";
										 }
										 
										 str+="<dd>"+serverResult[i].content+"</dd></dl><hr>";
										 
										 $("#commentList").append(str);
							      }
						         	$("#innerBoardComment").html("<button data-scode="+data.scode+" data-entrynum="
						         			+data.entrynum+" id='innerBoardCommentBtn' class='btn btn-outline-secondary'>등록</button>");
					
						   },
						   error: function(xhr,status){
								 if(xhr.status==0){
									 alertify.error('네트워크를 체크해주세요.');
								 }else if(xhr.status==400){
									 alertify.error('요청에 오류가 있습니다.');
								 }else if(xhr.status==401){
									 alertify.error('권한이 없습니다.');
								 }else if(xhr.status==404){
									 alertify.error('페이지를 찾을수없습니다.');
								 }else if(xhr.status==500){
									 alertify.error('서버에 오류가 발생하였습니다.');
								 }else if(status=='timeout'){
									 alertify.error('시간을 초과하였습니다.');
								 }else {
									 alertify.error('에러가 발생하였습니다');
								 }
							 }	 
			        	 
			         });
					
				}
				
			},
			  error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
	      });
    
     }); /////// 댓글 수정끝

     
     $(window).bind("popstate",function(event){
    	 var data=event.originalEvent.state;
    	 history.go(0);
     });
     
///////////////// 글작성 폼

	$("#boardWrite").on("click",function(){
		
		
	    history.pushState(null,null,contextPath+"/board/external?scode="+'${scode}'+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");
			
		$(".container").empty();
		$(".container").append("<h1 id='stationname'>"+'${sname}'+"역 게시판</h1><hr/>");
		$(".container").append("<br>");
		
		$(".container").append("<div id='reflash' class='row'><form id='writeForm' method='post' enctype='multipart/form-data' ><input type='hidden' name='scode' value="
				+'${scode}'+"><input type='hidden' name='writer' value='${id}'><div class='form-group'><label for='title'>제목</label>"
				+"<input size=200 type='text' class='form-control' id='titleInput' name='title'>"
				+"<small id='titleReq' class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 12글자이내)</small>"
				+"</div><div class='form-group'><textarea name='content' id='summernote'></textarea><br>"
				+"<label class='btn btn-success btn-file'>사진 첨부 <input accept='.jpg,.jpeg,.png' type='file' name='file' id='file'></label>"
				+"<small id='titleReq' class='form-text text-muted'>사진은 필수입니다.</small></div></form>"
				+"</div><button id='boardRegister' class='btn btn-outline-secondary float-right'>등록</button>"
				+"<button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");	
		
	 
       /////////// 에디터
		$('#summernote').summernote({
		      placeholder: '종류, 위치 등 자세하게 적어주세요',
		      minHeight: 300,
		      maxWidth: 700,
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

//file 첨부 확인
$(document).on("change","#file",function(){
	
  		if( $("#file").val() != "" ){
  			var ext = $('#file').val().split('.').pop().toLowerCase();
  			if($.inArray(ext, ['png','jpg','jpeg']) == -1) {
  				alertify.error('png,jpg,jpeg 파일만 업로드 할수 있습니다.');
  				 return;
  			}
  	       $("#fileCheck").remove();
  			$("#file").closest("label").after("<span id='fileCheck' style='color:green' >&nbsp;&nbsp;첨부 되었습니다.</span>");
  		      alertify.success("첨부되었습니다.");
  		}else{
  			alertify.error("파일에 오류가 있습니다. 다시 첨부해주세요");
  		}
}); 

    // 뒤로가기 버튼
	$(document).on("click","#backpage",function(){
 		location.assign(contextPath+"/board/external?scode="+'${scode}'+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");

	}); 

	
   //글삭제
   $(document).on("click","#boardDel",function(){
	   
	   var data=$(this).data();
	   
	  alertify.confirm("해당 게시물을 삭제하시겠습니까?",function (e){ 
			if(e){
				  callback(true);
			}
			else{
				  callback(false);
			} 
		});
	   
     function callback(check) {
		
		   
	   if(check==true){
	   
	   $.ajax({
		   type:'DELETE',
			url:'<%=request.getContextPath()%>/board',
			data:JSON.stringify({'scode': data.scode, 'entryNum':data.entry,'writer':data.writer}),
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult) {
				var result=JSON.parse(serverResult);
			      	
				    if(result==SUCCESS){
				    	location.assign(contextPath+"/board/external?scode="+data.scode+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");
			      	
				    } else {
				    	alert('오류가 발생하였습니다');
			      		
			      	}
			      		
			 },
			  error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
			
		   
	      });
	   
	   }
     }
   });
    
   //글수정 불러오기
   $(document).on("click","#boardMod",function(){
	   
	    history.pushState(null,null,contextPath+"/board/external?scode="+'${scode}'+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");
	   
	   var data=$(this).data();
	   $.ajax({
		   type:'GET',
			url:'<%=request.getContextPath()%>/board/'+data.scode+'/'+data.entrynum+'/'+data.writer,
			contentType: 'application/json; charset=UTF-8',
			success: function(serverResult) {
				
				$(".container").empty();
				
				$(".container").append("<h1 id='stationname'>${sname}역 게시판</h1><hr/>");
				$(".container").append("<br>")
				
				$(".container").append("<div id='reflash' class='row'><form id='modifyform' method='post' enctype='multipart/form-data' ><input type='hidden' name='entryNum' value="
						+data.entrynum+"><input type='hidden' name='scode' value="
						+data.scode+"><div class='form-group'><label for='title'>제목</label><input size=200 type='text' class='form-control' id='titleInput' name='title' value='"
						+serverResult.title+"'><small class='form-text text-muted'>장소명을 적어주세요(띄어쓰기 포함 12글자이내)</small>"
						+"</div><div class='form-group'><textarea name='content' id='summernote'>"
						+serverResult.content+"</textarea><br><label class='btn btn-success btn-file'>사진 첨부 <input type='file' accept='.jpg,.jpeg,.png' id='file' name='file'></label><small class='form-text text-muted'>기존 사진 사용시 변경할 필요가 없습니다.</small></div></form></div>"
						+"<button id='modifyBtn' class='btn btn-outline-secondary float-right'>수정</button>"
						+"<button id='backpage' style='margin-right: 5px' class='btn btn-outline-danger float-right'>뒤로가기</button>");		    
					
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
			  error: function(xhr,status){
					 if(xhr.status==0){
						 alertify.error('네트워크를 체크해주세요.');
					 }else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
					 }else if(xhr.status==401){
						 alertify.error('권한이 없습니다.');
					 }else if(xhr.status==404){
						 alertify.error('페이지를 찾을수없습니다.');
					 }else if(xhr.status==500){
						 alertify.error('서버에 오류가 발생하였습니다.');
					 }else if(status=='timeout'){
						 alertify.error('시간을 초과하였습니다.');
					 }else {
						 alertify.error('에러가 발생하였습니다');
					 }
				 }
		
	      });
	  });
	     //제목 유효성 검사  
		$(document).on("keyup","#titleInput",function(){
			var titleReg = /^[|가-힣|a-z|A-Z|0-9|\s|\*]{1,12}$/;
			
			
			if(!titleReg.test($("#titleInput").val())){
				$("#titleInput").addClass("is-invalid");
			}else{
				$("#titleInput").removeClass("is-invalid");
			}
			
		});
	     
    //글작성
	$(document).on("click","#boardRegister",function(){
		
		
		if($("#titleInput").val()==""||$("#titleInput").hasClass("is-invalid")==true){
			alertify.error("제목을 확인해 주세요");
			
		}else if($("#summernote").val()==""){
			alertify.error("내용을 확인해주세요");
			
		}else{
			
			$("#writeForm").ajaxSubmit({
			    type:'POST',
				url:'<%=request.getContextPath()%>/board',
				contentType: 'application/json; charset=UTF-8',
				data: $("#writeForm").serialize(),
				success: function(serverResult){
					var result=JSON.parse(serverResult);
					
					if(result==SUCCESS){
						location.assign(contextPath+"/board/external?scode="+'${scode}'+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");
					}else{
						alertify.error("오류가 발생하였습니다.")
					}
					
				},
				  error: function(xhr,status){
						 if(xhr.status==0){
							 alertify.error('네트워크를 체크해주세요.');
						 }else if(xhr.status==400){
							 alertify.error('요청에 오류가 있습니다.');
						 }else if(xhr.status==401){
							 alertify.error('권한이 없습니다.');
						 }else if(xhr.status==404){
							 alertify.error('페이지를 찾을수없습니다.');
						 }else if(xhr.status==500){
							 alertify.error('서버에 오류가 발생하였습니다.');
						 }else if(status=='timeout'){
							 alertify.error('시간을 초과하였습니다.');
						 }else {
							 alertify.error('에러가 발생하였습니다');
						 }
					 }
			});	
		}//else 끝
	});
	
////////글 수정 업데이트
   
$(document).on("click","#modifyBtn",function(){
	   if($("#titleInput").val()==""||$("#titleInput").hasClass("is-invalid")==true){
		   alert("제목을 확인해주세요");
	   }
	   else if($("#summernote").val()==""){
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
					
					if (result == SUCCESS) {
						location.assign(contextPath+"/board/external?scode="+'${scode}'+"&sname="+'${sname}'+"&line="+'${line}'+"&page=1");
					} else {
						alertify.error("오류가 발생하였습니다.");
					}

				},
				error : function(xhr,status) {
					if (xhr.status == 0) {
						alertify.error('네트워크를 체크해주세요.');
					}else if(xhr.status==400){
						 alertify.error('요청에 오류가 있습니다.');
				    } else if (xhr.status == 401) {
				    	alertify.error('권한이 없습니다.');
			        } else if (xhr.status == 404) {
			        	alertify.error('페이지를 찾을수없습니다.');
					} else if (xhr.status == 500) {
						alertify.error('서버에 오류가 발생하였습니다.');
				    } else if (status == 'timeout') {
				    	alertify.error('시간을 초과하였습니다.');
				    } else {
				    	alertify.error('에러가 발생하였습니다');
					    }
					}
			    });

			}
		});
		
		
		$("#logOutBtn").on("click",function(){
			
			location.assign(contextPath+"/board/logout");
			
		});
   
		//추천
		$(document).on("click","#recommend",function(){
			
			var data=$(this).data();
			var ths=$(this);
			var checkValue;
			
			if(ths.text()=='추천하기'){				
				
				alertify.confirm("해당 게시물을 추천하시겠습니까?",function (e){ 
					if(e){
						  callback(true);
					}
					else{
						  callback(false);
					} 
				});
				
				checkValue=true;
			}else{
				
				alertify.confirm("추천을 해제하시겠습니까?",function (e){ 
					if(e){
						  callback(true);
					}
					else{
						  callback(false);
					} 
				});
				
				checkValue=false;
			}
			
			function callback(value) {
				
			  if(value==true){
				 $.ajax({
					type:'PUT',
					url: '<%=request.getContextPath()%>/board/recommend',
					contentType: 'application/json; charset=UTF-8',
					data:JSON.stringify({ 
						   'scode': data.scode,
						   'entryNum' : data.entrynum,
						   'id' : '${id}',
						   'recommendCheck' : checkValue
					}),
					success : function(serverResult){
					    
						if(serverResult==SUCCESS){
							var value=ths.closest("#externalCard").find("#recommendIcon").text()*1;
						  if(ths.text()=="추천하기"){
							  ths.prop('class','btn btn-success');
							  ths.text("추천해제");
							  ths.closest("#externalCard").find("#recommendIcon").text(value+1);
				           }else{
				        	   ths.prop('class','btn btn-outline-success');
				        	   ths.text("추천하기");
				        	   ths.closest("#externalCard").find("#recommendIcon").text(value-1);
				           }
						
						}else{
							alertify.error("오류가 발생하였습니다.");
					    }
				
					},
				    error: function(xhr,status){
						 if(xhr.status==0){
						      alertify.error('네트워크를 체크해주세요.');
						 }else if(xhr.status==400){
							 alertify.error('요청에 오류가 있습니다.');
						 }else if(xhr.status==401){
							 alertify.error('권한이 없습니다.');
						 }else if(xhr.status==404){
							 alertify.error('페이지를 찾을수없습니다.');
						 }else if(xhr.status==500){
							 alertify.error('서버에 오류가 발생하였습니다.');
						 }else if(status=='timeout'){
							 alertify.error('시간을 초과하였습니다.');
						 }else {
							 alertify.error('에러가 발생하였습니다');
						 }
					 }
					
				 });
			
		       }//value
			}//callback
		});
   
   
        //정렬
		$(document).on("click","#sortBtn",function(e){
			e.preventDefault();
			
			var data=$(this).data();
			
			if($("#searchBoard").prop("disabled") && $("#searchBoard").val() != ""){

				$.ajax({/// ajax
		             type:'GET',
		        	 url:'<%=request.getContextPath()%>/board/sort/'+data.scode+'/'+data.target+'/'+data.page+'/'+$("#searchBoard").val(),
		 			 contentType: 'application/json; charset=UTF-8',
					 success: function(serverResult){
						 
						$("#reflash").empty();
						
						if(serverResult['boardList'].length==0){
							return;
						}
						
					
					for(var key in serverResult['boardList']){
						var str="";
						
						 str+="<div class='col-lg-3 col-md-6 mb-4'>"+"<div id='externalCard' class='card border-success'><img id='outImg' class='card-img-top' src="+serverResult['boardList'][key].imgPath+">";
						 
						  if(serverResult['boardList'][key].writer=='${id}'){
							 str+="<div class='card bg-light rounded-0'><span><i id='boardDel' data-scode="+serverResult['boardList'][key].scode+" data-entry="+serverResult['boardList'][key].entryNum
							  +" data-writer="+serverResult['boardList'][key].writer+" class='far fa-times-circle'></i><i id='recommendIcon' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
						  }else{
							  str+="<div class='card bg-light rounded-0'><span><i id='recommendIcon' style='margin-top: 3%;right: 35%' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
						  }
						  
						  
						  str+="<div class='card-body' id='externalBox'><h4 class='card-title'>"+serverResult['boardList'][key].title+"</h4>"
						       +"<p class='card-text' id='externalContent'>"+serverResult['boardList'][key].content+"</p>"
						       +"<footer class='blockquote-footer' >From "+serverResult['boardList'][key].writer+" ["+formatDate(serverResult['boardList'][key].registrationDate)+"]</footer></div>"
						  	   +"<div class='card-footer border-dark'><button style='margin-left: 10px' id='modalReq' type='button' "
						  	   +"data-entrynum="+serverResult['boardList'][key].entryNum+" data-scode="+serverResult['boardList'][key].scode
						  	   +" class='btn btn-outline-secondary' data-toggle='modal' data-target='.bd-example-modal-lg' >상세보기</button> ";

						  if(serverResult['boardList'][key].writer=='${id}'){
						      str+="<button style='margin-left: 10px' id='boardMod' data-entryNum="+serverResult['boardList'][key].entryNum
						  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
						  	   +" class='btn btn-outline-danger'>수정하기</button></div></div></div>";
						  	   
						  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==false){
							  str+="<button style='margin-left: 10px' id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
						  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
						  	   +" class='btn btn-outline-success'>추천하기</button></div></div></div>";	
						  
						  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==true){
							  str+="<button style='margin-left: 10px' id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
						  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
						  	   +" class='btn btn-success'>추천해체</button></div></div></div>";
						  }
						  
							$("#reflash").append(str);
					    }//end
					
			  				$("#paging").empty();
						
						if(data.page>1){
							$("#paging").append("<li class='page-item'><a id='sortBtn' data-scode="
									+data.scode+" data-page="+(data.page-1)+" data-target="+data.target+" class='page-link' href='#' >이전</a></li>");
							}
						
						for(var i=serverResult['pageMap'].startPage;i<=serverResult['pageMap'].endPage;i++){
							if(data.page==i){
								
								$("#paging").append("<li class='page-item active'><a id='sortBtn' data-scode="
										+data.scode+" data-page="+i+" data-target="+data.target+" class='page-link' href='#' >"+i+"</a></li>");
								
							}else{
								$("#paging").append("<li class='page-item '><a id='sortBtn' data-scode="
										+data.scode+" data-page="+i+" data-target="+data.target+" class='page-link' href='#' >"+i+"</a></li>");
							}
						}
						
						if(serverResult['pageMap'].endPage>data.page){
							$("#paging").append("<li class='page-item'><a id='sortBtn' data-scode="
									+data.scode+" data-page="+(data.page+1)+" data-target="+data.target+" class='page-link' href='#' >다음</a></li>");
						}
						
					 },
					  error: function(xhr,status){
							 if(xhr.status==0){
								 alertify.error('네트워크를 체크해주세요.');
							 }else if(xhr.status==401){
								 alertify.error('요청에 오류가 있습니다.');
							 }else if(xhr.status==401){
								 alertify.error('권한이 없습니다.');
							 }else if(xhr.status==404){
								 alertify.error('페이지를 찾을수없습니다.');
							 }else if(xhr.status==500){
								 alertify.error('서버에 오류가 발생하였습니다.');
							 }else if(status=='timeout'){
								 alertify.error('시간을 초과하였습니다.');
							 }else {
								 alertify.error('에러가 발생하였습니다');
							 }
						 }
		            });//ajax
				
			}else{
			
	          $.ajax({/// ajax
	             type:'GET',
	        	 url:'<%=request.getContextPath()%>/board/sort/'+data.scode+'/'+data.target+'/'+data.page,
	 			 contentType: 'application/json; charset=UTF-8',
				 success: function(serverResult){
					 
					$("#reflash").empty();
					
					if(serverResult['boardList'].length==0){
						return;
					}
					
				
				for(var key in serverResult['boardList']){
					var str="";
					
					 str+="<div class='col-lg-3 col-md-6 mb-4'>"+"<div id='externalCard' class='card border-success'><img id='outImg' class='card-img-top' src="+serverResult['boardList'][key].imgPath+">";
					 
					  if(serverResult['boardList'][key].writer=='${id}'){
						 str+="<div class='card bg-light rounded-0'><span><i id='boardDel' data-scode="+serverResult['boardList'][key].scode+" data-entry="+serverResult['boardList'][key].entryNum
						  +" data-writer="+serverResult['boardList'][key].writer+" class='far fa-times-circle'></i><i id='recommendIcon' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
					  }else{
						  str+="<div class='card bg-light rounded-0'><span><i id='recommendIcon' style='margin-top: 3%;right: 35%' class='far fa-thumbs-up'>"+serverResult['boardList'][key].recommend+"</i></span></div>";
					  }
					  
					  
					  str+="<div class='card-body' id='externalBox'><h4 class='card-title'>"+serverResult['boardList'][key].title+"</h4>"
					       +"<p class='card-text' id='externalContent'>"+serverResult['boardList'][key].content+"</p>"
					       +"<footer class='blockquote-footer' >From "+serverResult['boardList'][key].writer+" ["+formatDate(serverResult['boardList'][key].registrationDate)+"]</footer></div>"
					  	   +"<div class='card-footer border-dark'><button style='margin-left: 10px' id='modalReq' type='button' "
					  	   +"data-entrynum="+serverResult['boardList'][key].entryNum+" data-scode="+serverResult['boardList'][key].scode
					  	   +" class='btn btn-outline-secondary' data-toggle='modal' data-target='.bd-example-modal-lg' >상세보기</button> ";

					  if(serverResult['boardList'][key].writer=='${id}'){
					      str+="<button style='margin-left: 10px' id='boardMod' data-entryNum="+serverResult['boardList'][key].entryNum
					  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
					  	   +" class='btn btn-outline-danger'>수정하기</button></div></div></div>";
					  	   
					  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==false){
						  str+="<button style='margin-left: 10px' id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
					  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
					  	   +" class='btn btn-outline-success'>추천하기</button></div></div></div>";	
					  
					  }else if(serverResult['boardList'][key].writer!='${id}' && serverResult['boardList'][key].recommendCheck==true){
						  str+="<button style='margin-left: 10px' id='recommend' data-entryNum="+serverResult['boardList'][key].entryNum
					  	   +" data-scode="+serverResult['boardList'][key].scode+" data-writer="+serverResult['boardList'][key].writer
					  	   +" class='btn btn-success'>추천해체</button></div></div></div>";
					  }
					  
						$("#reflash").append(str);
				    }//end
				
		  				$("#paging").empty();
					
					if(data.page>1){
						$("#paging").append("<li class='page-item'><a id='sortBtn' data-scode="
								+data.scode+" data-page="+(data.page-1)+" data-target="+data.target+" class='page-link' href='#' >이전</a></li>");
						}
					
					for(var i=serverResult['pageMap'].startPage;i<=serverResult['pageMap'].endPage;i++){
						if(data.page==i){
							
							$("#paging").append("<li class='page-item active'><a id='sortBtn' data-scode="
									+data.scode+" data-page="+i+" data-target="+data.target+" class='page-link' href='#' >"+i+"</a></li>");
							
						}else{
							$("#paging").append("<li class='page-item '><a id='sortBtn' data-scode="
									+data.scode+" data-page="+i+" data-target="+data.target+" class='page-link' href='#' >"+i+"</a></li>");
						}
					}
					
					if(serverResult['pageMap'].endPage>data.page){
						$("#paging").append("<li class='page-item'><a id='sortBtn' data-scode="
								+data.scode+" data-page="+(data.page+1)+" data-target="+data.target+" class='page-link' href='#' >다음</a></li>");
					}
					
				 },
				  error: function(xhr,status){
						 if(xhr.status==0){
							 alertify.error('네트워크를 체크해주세요.');
						 }else if(xhr.status==401){
							 alertify.error('요청에 오류가 있습니다.');
						 }else if(xhr.status==401){
							 alertify.error('권한이 없습니다.');
						 }else if(xhr.status==404){
							 alertify.error('페이지를 찾을수없습니다.');
						 }else if(xhr.status==500){
							 alertify.error('서버에 오류가 발생하였습니다.');
						 }else if(status=='timeout'){
							 alertify.error('시간을 초과하였습니다.');
						 }else {
							 alertify.error('에러가 발생하였습니다');
						 }
					 }
	            });//ajax
			}//else
	      });
        
        //호선 누르면 main으로 가기
		$(document).on("click","#sidebar ul p",function(){
			location.assign(contextPath+"/main");
		});
		
        //로고 새로고침
	     $(document).on("click","#sideHeader",function(){
		     history.go(0);
		}); 

/* 	     $("#bsModal").on('hide.bs.modal', function(e){
	    	 modalObject.text("변경");
	     	e.stopImmediatePropagation();

	     }); */
  
});///// ready 끝
</script>

<style>
@font-face {
	font-family: 'BU';
	src: url('../font/BMJUA_ttf.ttf');
}

@font-face {
	font-family: '28D';
	src: url('../font/28DaysLater.ttf');
}
@font-face {
	font-family: 'NS';
	src: url('../font/NanumSquareRoundR.ttf');
}
#externalContent {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 150px;
	display: inline-block;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">

</head>
<body>

<div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
            <div class="sidebar-header">
                <h1 id='sideHeader'>InnerSubway</h1>
            </div>
            
            <ul class="list-unstyled components">
                <c:if test="${stationList[0].line==10}">
				  <p>분당선</p>
				</c:if>
                <c:if test="${stationList[0].line<10}">
				  <p>${stationList[0].line}호선</p>
				</c:if>
				
                <c:forEach var="key" items="${stationList}">
				<li><a id="stationlist" href="<%=request.getContextPath()%>/board/external?scode=${key.scode}&sname=${key.sname}&line=${key.line}&page=1">${key.sname}&nbsp;&nbsp;<span class="badge badge-light badge-pill">${key.boardCount}</span></a></li>
			    </c:forEach>
            </ul>
        </nav>

        <!-- Page Content  -->
        <div id="content">

            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                
                    <button type="button" id="sidebarCollapse" class="btn btn-info">
                        <i class="fas fa-align-left"></i>
                        <span>목록</span>
                    </button>
                  <button id="logOutBtn" type="button" class="btn btn-danger">로그아웃</button>
                </div>
            </nav>
            
            <!-- 카드게시판 -->
            
           <div id="page-wrapper">
           
           <div class="container">
		    <h1 id="stationname">${sname}역 게시판</h1><hr/>
		    
		   
		    <div id="searchForm" class="text-right">
			  <span>
			   <span id='sort'>
			   		<a id='sortBtn' data-scode='${scode}' data-target='EntryNum' data-page=1  href="#" >최신순<i class="fas fa-sort-down"></i></a>&nbsp;&nbsp;
			   		<a id='sortBtn' data-scode='${scode}' data-target='recommend' data-page=1  href="#" >추천순<i class="fas fa-sort-down"></i></a>&nbsp;&nbsp;
			   		<a id='sortBtn' data-scode='${scode}' data-target='viewCount' data-page=1  href="#" >조회수순<i class="fas fa-sort-down"></i></a>
			   </span>
				
				
				<input type="search" class="form-control mr-sm-2" id="searchBoard"  size="20" placeholder="장소이름&작성자">
				<button class="btn btn-success" data-scode='${scode}' data-page=1 id="searchBoardBtn" >검색</button>
			  </span>
			 </div>  
			 
			   <c:if test="${fn:length(boardList)==0}">
			   <div id="noBoard"><h1>게시물이 없습니다.<br>등록해주세요~</h1></div>
			   </c:if>
			              <br>
			 <div id="reflash" class="row text-center">
				<c:forEach var="board" items="${boardList}">
					<div class="col-lg-3 col-md-6 mb-4">
						<div id="externalCard" class="card border-success">
							<img id="outImg" class="card-img-top" src='${board.imgPath}' >
							
							<c:if test="${board.writer==id}">
							<div class="card bg-light rounded-0">
								<span><i id="boardDel" data-scode='${board.scode}' data-entry='${board.entryNum}'
								data-writer='${board.writer}' class="far fa-times-circle"></i><i style="right:36.5%" id='recommendIcon' class="far fa-thumbs-up">${board.recommend}</i></span> 
							</div>
							</c:if>
							
						    <c:if test="${board.writer!=id}">
							<div class="card bg-light rounded-0">
								<span><i id='recommendIcon' class="far fa-thumbs-up">${board.recommend}</i></span> 
							</div>
							</c:if>
							
							<div class="card-body" id="externalBox">
								<h4 class="card-title">${board.title}</h4>
								<p class="card-text" id="externalContent">${board.content}</p>
								<footer class="blockquote-footer">From
									${board.writer}&nbsp;[${board.registrationDate}]</footer>
							</div>

							<div class="card-footer border-dark">
								<button id="modalReq" type="button"
									data-entrynum='${board.entryNum}' data-scode='${board.scode}'
									class="btn btn-outline-secondary" data-toggle="modal"
									data-target=".bd-example-modal-lg">상세보기</button>
								<c:if test="${board.writer==id}">	
								<button id="boardMod" type="button"
									data-entryNum='${board.entryNum}' data-scode='${board.scode}'
									data-writer='${board.writer}' class="btn btn-outline-danger">수정하기</button>
							   </c:if>
							   <c:if test="${board.writer!=id && board.recommendCheck==false}">	
								<button id="recommend" type="button"
									data-entryNum='${board.entryNum}' data-scode='${board.scode}'
									data-writer='${board.writer}' class="btn btn-outline-success">추천하기</button>
							   </c:if>
							   <c:if test="${board.writer!=id && board.recommendCheck==true}">	
								<button id="recommend" type="button"
									data-entryNum='${board.entryNum}' data-scode='${board.scode}'
									data-writer='${board.writer}' class="btn btn-success">추천해제</button>
							   </c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
       

			<!--페이지 처리-->
			<hr>
			<button id="boardWrite" class="btn btn-outline-secondary float-right">글작성</button>
			<ul id="paging" class="pagination mx-auto justify-content-center">
				<c:if test="${param.page>1}">
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&line=${line}&page=${param.page-1}">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMap.startPage}" end="${pageMap.endPage}"
					var="i">
					<c:if test="${param.page==i}">
						<li class="page-item active"><a class="page-link"
							href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&line=${line}&page=${i}">${i}</a></li>
					</c:if>
					<c:if test="${param.page!=i}">
						<li class="page-item"><a class="page-link"
							href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&line=${line}&page=${i}">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${pageMap.totalPage > param.page}">
					<li class="page-item"><a class="page-link"
						href="<%=request.getContextPath()%>/board/external?scode=${scode}&sname=${sname}&line=${line}&page=${param.page+1}">다음</a></li>
				</c:if>
			  </ul>
		   </div>
		   </div>
		  </div>
	    </div>




	<!-- 게시판 상세보기 -->
	<div id='bsModal' style="font-family: 'BU'" class="modal fade bd-example-modal-lg"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<!--        모달창 내부                      -->

				<div class="card bg-light mb-3">
					<div class="card-header">상세보기</div>
					<div id="innerImgdiv" class="card-body">
						<p class="card-text">
							<img id="innerImg" alt="이미지" src="">
							<!-- <img alt="이미지" src="https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"> -->
						</p>
					</div>
				</div>

				<div class="card text">
					<div class="card-header">내용</div>
					<div class="card-body">
						<h5 id="innerBoardTitle" class="card-title">title</h5>
						<p class="card-text" id="innerBoardContent">error</p>
						<footer id='innerFooter'
							class="blockquote-footer">From 작성자</footer>
					</div>

					<div id="regDate" class="card-footer text-right text-muted">
						2018-10-04&nbsp;&nbsp; <i class="far fa-eye">&nbsp;3</i>
					</div>
				</div>
				<br>


				<div id='commentListFm' class="alert alert-secondary">
					<strong>댓글목록 </strong>
					<hr>

					<div id="commentList"></div>

					<div class="form-group">
						<label><abbr class="initialism">댓글작성</abbr>:</label>
						<textarea class="form-control" rows="5" id="commentContent"></textarea>
					</div>

					<div id="innerBoardComment" class="text-right"></div>
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