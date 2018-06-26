$(document).ready(function(){
	
	var FAIL = 0;
	var DISCORDANCE = -2;
	
	$("#btn").on("click",function(){
		var contextPath=location.pathname.substring(0, 8);
		
		  $.ajax({
  			type:'POST',
  			url: contextPath+'/member/login',
  			contentType : "application/json; charset=UTF-8",
  		    data:JSON.stringify({ 
  		    	 "id" : $('#id').val(),
  		    	 "pw" :$('#pw').val()
  		    }),
  		    
  	  	    dataType : 'JSON',
  			success:function(serverResult){
  				
  				var result=JSON.parse(serverResult);
  				
  				if(result==FAIL){
  					alertify.error("아이디가 없습니다.")
  				}else if(result==DISCORDANCE){
  					alertify.error("비밀번호가 일치하지 않습니다.")
  				}else{		
  					location.assign(contextPath+"/main");
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
					 alertify.error('서버에러 발생하였습니다.');
				 }else if(status=='timeout'){
					 alertify.error('시간을 초과하였습니다.');
				 }else {
					 alertify.error('에러가 발생하였습니다');
				 }
			 }

           });
		
	});

});
