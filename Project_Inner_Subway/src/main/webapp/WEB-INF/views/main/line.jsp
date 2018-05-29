<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
 div{
    display: none;
 }
 div > a{
     margin-right: 5px;
 }
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("button").on("click",function(){
	
		alert($(this).val());
		
	$.ajax({
		type:'post',
		url:'<%=request.getContextPath()%>/main/getstationinfo',
		data:{'line_number': $(this).val()},
		success:function(server_result){			
			$("div").css("display","block");
			var str="";
			for(var i=0;i<server_result.length;i++){
		      str+="<a href='<%=request.getContextPath()%>/board/external?scode="+server_result[i].scode+"'>"+server_result[i].sname+"</a>";      
			}
			$("div").html(str);
			alert(str);
		}
	});
	});
	
});

</script>
</head>
<body>
===============메인페이지================<br>
<button value="1">1호선</button></br>
<button value="2">2호선</button></br>
<button value="7">7호선</button></br>
<div id="dv"></div>

</body>
</html>