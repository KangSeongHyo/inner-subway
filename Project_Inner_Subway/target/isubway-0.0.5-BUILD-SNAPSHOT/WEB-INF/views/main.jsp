<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
#showStation {
	display: none;
}

div>a {
	margin-right: 5px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("button").on("click",function(){
		
	$.ajax({
		type:'get',
		url:'<%=request.getContextPath()%>/station/'+$(this).val(),
		success:function(serverResult){			
			$("#showStation").css("display","block");
			
			var str="";
			var result=JSON.parse(JSON.stringify(serverResult));
			for(var i=0;i<result.length;i++){
		      str+="<a href=<%=request.getContextPath()%>/board/external?scode="+result[i].scode+"&sname="+result[i].sname+"&page=1>"+result[i].sname+"</a>";      
			}
			$("#showStation").html(str);
		},
	  error :function(request,status, error){
          alert("code = "+ request.status+ " message = "+ request.responseText+ " error = "+ error); // 실패 시 처리

	  }
	});
	
	});
	
});

</script>
</head>
<body>
	===============메인페이지================
	<br>
	<button value="1">1호선</button>
	</br>
	<button value="2">2호선</button>
	</br>
	<button value="7">7호선</button>
	</br>
	<div id="showStation"></div>

</body>
</html>