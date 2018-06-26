$(document).ready(function() {
	
 $(document).on("click",".menuText",function(){
	var data=$(this).data();
	var contextPath=location.pathname.substring(0, 8);
	
    	$.ajax({
			type:'GET',
			url:contextPath+'/station/'+data.line,
			success:function(serverResult){		
				
				$(".subway-map").css("display","none");
			    $(".subway-map").empty();
				$(".subway-map").subwayMap({ debug: false });
				
				var str="";
				var stationCount=0;
				var color="";
				
				switch (data.line) {
					case 1:
						color="#0D47A1";
						break;
						
					case 2:
						color="#00C853";
						break;
						
					case 7:
						color="#827717";
						break;
					case 10:
						color="#B71C1C";
						break;
	
					default:
						break;
					}
				
				
				
				$(".subway-map").append("<ul data-color='"+color+"' data-label='jQuery Widgets'></ul>");

				
				  if(data.line==1||data.line==7){
					  
					 for(var key in serverResult){
						 
					 
					  $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
							+serverResult[key].scode+"&sname="+serverResult[key].sname
						 +"&line="+serverResult[key].line+"&page=1'>"+serverResult[key].sname+"</a></li>");
					
					      if(key==(serverResult.length-1)){
						    break;
					      } 
					
					      stationCount++;
					
				       if(stationCount==6){
					       
				    	   var x=serverResult[key].x;
					       var y=serverResult[key].y;
						
					       $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+1)+"' data-dir='E' ></li>");
					       $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+5)+"'></li>");
					       $(".subway-map > ul").append("<li data-coords='"+x+","+(y+5+1)+"' data-dir='S' ></li>");
					   												
					    }else if(stationCount==12){
						 
					    	var x=serverResult[key].x;
						    var y=serverResult[key].y;
						
					        $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+1)+"' data-dir='W' ></li>");
					        $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+5)+"'></li>");
					        $(".subway-map > ul").append("<li data-coords='"+(x)+","+(y+5+1)+"' data-dir='S' ></li>");
						
					        stationCount=0;
					     }
					   }
				 
			       }else if(data.line==2){
			    	  for(var key in serverResult){
			    	   
			    	    if(stationCount==6){
							   var x=serverResult[key].x;
							   var y=serverResult[key].y;
								
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y-4)+"' data-dir='E' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
										+serverResult[key].scode+"&sname="+serverResult[key].sname
									 +"&line="+serverResult[key].line+"&page=1'>"+serverResult[key].sname+"</a></li>");
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y+4)+"' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+(x-1)+","+(y+5)+"' data-dir='S' ></li>");
	
							    stationCount++;
							continue;
						
								
						}else if(stationCount==13){
								var x=serverResult[key].x;
								var y=serverResult[key].y;
								
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y+4)+"' data-dir='W' ></li>");
							    $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
										+serverResult[key].scode+"&sname="+serverResult[key].sname
									 +"&line="+serverResult[key].line+"&page=1'>"+serverResult[key].sname+"</a></li>");
							    $(".subway-map > ul").append("<li data-coords='"+x+","+(y-4)+"'></li>");
							    $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y-5)+"' data-dir='N' ></li>");
								
								
							     stationCount=0;
							     continue; 
					     }
			    	    
			    	   $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
								+serverResult[key].scode+"&sname="+serverResult[key].sname
							 +"&line="+serverResult[key].line+"&page=1'>"+serverResult[key].sname+"</a></li>");
			    	    if(key==(serverResult.length-1)){
							break;
						}
			    	    
			    	    stationCount++;
			    	        	   
			          }
			    	  
			    	   
			    	  
			       }else if(data.line==10){
			    	   
			    	   for(var key in serverResult){
			    	     
			    		   var x=serverResult[key].x;
					       var y=serverResult[key].y;
					   
					       $(".subway-map > ul").append("<li data-coords='"+serverResult[key].x+","+serverResult[key].y+"'><a href='"+contextPath+"/board/external?scode="
								+serverResult[key].scode+"&sname="+serverResult[key].sname
							 +"&line="+serverResult[key].line+"&page=1'>"+serverResult[key].sname+"</a></li>");
			    	   
					    stationCount++;
					   
					   if(stationCount==2){
						   $(".subway-map > ul").append("<li data-coords='"+(x+1)+","+(y+1)+"' data-dir='S' ></li>");
					   }
					   
			          }
			       }
			  
    	          $(".subway-map").show(1000);
				  $(".subway-map").subwayMap({ debug: true });
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
						 alertify.error('오류가 발생하였습니다.');
					 }
				 }
			
		 }); 
   });

});