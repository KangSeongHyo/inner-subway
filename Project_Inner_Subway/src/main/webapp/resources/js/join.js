function goPopup() {
	var pop = window.open("addrpopup", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");
}
function addressCallBack(roadFullAddr) {
	$("#address").val(roadFullAddr);
}

$(document).ready(function(){
	var FAIL=0;
	var pwCheck=false;
	var idPtn=false;
	var pwPtn=false;
	var namePtn=false;
	
	var contextPath=location.pathname.substring(0, 8);

	//비밀번호 일치확인
	$("#pw").on("keyup",function() {
		
	  if($("#pw").val()!="" && $("#pwCheck").val()!=""){
			if($("#pwCheck").val()==$("#pw").val()){
				$("#pwEqualView").css("color","green");
				$("#pwEqualView").text("비밀번호가 일치합니다");
				pwCheck=true;
			}else{
				$("#pwEqualView").css("color","red");
				$("#pwEqualView").text("비밀번호가 일치하지 않습니다.");
				pwCheck=false;
			}	
	    }
	});
	
	$("#pwCheck").on("keyup",function() {
		if($("#pw").val()!="" && $("#pwCheck").val()!=""){
			if($("#pwCheck").val()==$("#pw").val()){
				$("#pwEqualView").css("color","green");
				$("#pwEqualView").text("비밀번호가 일치합니다");
				pwCheck=true;
			}else{
				$("#pwEqualView").css("color","red");
				$("#pwEqualView").text("비밀번호가 일치하지 않습니다.");
				pwCheck=false;
			}
		}
	});
	
	//이름 패턴
	$('#name').on('keyup',function(){
		var nameReg = /^[|가-힣|a-z|A-Z|\*]+$/;
		
		if(!nameReg.test($("#name").val())){
			$("#name").addClass("is-invalid");
			$("#namePatternCheckView").text("내용을 확인해 주세요.");
			namePtn=false;
		}else{
			$("#name").removeClass("is-invalid");
			$("#namePatternCheckView").empty();
			namePtn=true;
		}
	});
	
	//아이디 패턴
	$('#id').on('keyup',function(){
		var idReg = /^[a-z|A-Z]{3,}[0-9]+[0-9|a-z|A-Z]*$/;
		
		if(!idReg.test($("#id").val())){
			$("#id").addClass("is-invalid");
			$("#idPatternCheckView").text("영문(3자리 이상)과 숫자로 구성해주세요");
			idPtn=false;
		}else{
			$("#id").removeClass("is-invalid");
			$("#idPatternCheckView").empty();
			idPtn=true;
		}
	});
	
	//pw패턴
	$('#pw').on('keyup',function(){
		var pwReg = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;

		
		if(!pwReg.test($("#pw").val())){
			$("#pw").addClass("is-invalid");
			$("#pwPatternCheckView").text("영문과 숫자로 구성해주세요(6자리 이상 20자리 이내)");
			pwPtn=false;
		}else{
			
			$("#pw").removeClass("is-invalid");
			$("#pwPatternCheckView").empty();
			pwPtn=true;
		}
	});
	
	
	//중복체크 & 공백체크
	$("#btn").on("click",function(){
		var arr=new Array();
		
	    arr[0]=$("#id").val();
	    arr[1]=$("#pw").val();
	    arr[2]=$("#pwCheck").val();
	    arr[3]=$("#address").val();
	    
	    //공백체크
	    for(var i=0;i<arr.length;i++){
	    	   if(arr[i]==""){
	    		 alert("입력을 확인해주세요");
	    		 return; 
	    	     }
	         }
	    
	    
	     //패턴&비밀번호 확인체크
	     if(pwPtn==false||idPtn==false||pwCheck==false||namePtn==false){
	    	 alert("양식을 확인해주세요.");
	    	 return;
	     }
	    
	    
	 $.ajax({
		type:'GET',
		url:contextPath+'/member/'+$("#id").val(),
		contentType : "application/json; charset=UTF-8",
		success:function(serverResult){		
			var result=JSON.parse(serverResult);
			var str="";
			var idCheck=true;
			
	         if(result==FAIL){
		        alertify.error("이미 사용하고 있는 아이디 입니다.");
	         }else{
	        	 
	    	  $.ajax({
	    			type:'POST',
	    			url: contextPath+'/member/',
	    			contentType : "application/json; charset=UTF-8",
	    		    data:JSON.stringify({ 
	    		    	 "id" : $('#id').val(),
	    		    	 "pw" :$('#pw').val(),
	    		    	 "name" : $('#name').val(), 
	    		    	 "gender" : $('input[type=radio]').val(), 
	    		    	 "address" :$('#address').val()
	    		    }),
	    	  	    dataType : 'JSON',
	    			success:function(serverResult){
	    				
	    				if(JSON.parse(serverResult)==1){
		                 location.assign(contextPath+"/");
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
							 alertify.error('페이지를 찾을 수 없습니다.');
						 }else if(xhr.status==500){
							 alertify.error('서버에 오류가 발생하였습니다.');
						 }else if(status=='timeout'){
							 alertify.error('시간을 초과하였습니다.');
						 }else {
							 alertify.error("오류가 발생하였습니다.");
						 }
					 }

	             });
	      }
    
	   }
	
	 });
   });

});