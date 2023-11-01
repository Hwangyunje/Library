<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@page import="java.util.List"%>
<%@page import="com.lib.fin.schedule.ScheduleVO"%>
<%@page import="java.util.ArrayList"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import> 
<meta charset='utf-8'>
	
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>calendar</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- bootstrap 4 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- fullcalendar -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
	

   
    <style>
        #calendarBox{
            width: 70%;
            padding-left: 15%;
            width:1000px;
        }
		.calendar{
		width:1000px;	
		}
		.card{
		width:1200px;
		height:850px;	
		}
		.fc .fc-daygrid-day-number {
    position: relative;
    z-index: 4;
    padding: 4px;
    color: black;
  }
  
 
   </style>

</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
    	<!-- sidebar -->
    	<c:import url="/WEB-INF/views/layout/sidebar.jsp"></c:import>
    	
    	 <div id="content-wrapper" class="d-flex flex-column">
    	 	<div id="content">
    	 		
    	  <c:import url="/WEB-INF/views/layout/topbar.jsp"></c:import> 
    	 		
		  <main id="main" class="main">

			<section class="section dashboard">

			<div class="container-fluid">
			
						
				<div class="row">
					<!-- 각 영역 크기조절하기 -->
					<div class="col-lg-6">
						<div class="card">
						  <div id="calendarBox">
						       <div class="hstack gap-3 text-decoration-underline">
								  <div class="p-1">전체</div>
								  <div class="p-2">일정</div>
								  <div class="p-3">예약</div>
								</div>
        <div id="calendar"></div>
    </div>
 <!------------------------------------------------- Add modal ------------------------------------------------->
 <div class="modal fade" id="calendarAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" onclick="location.href='/schedule/schedule'">&times;</span>
                    </button>
                </div>
                
                <form id="addForm" action="./add" method="post">
                <div class="modal-body">
                    <div class="form-group">
                    	<input type="hidden" value="memberVO.emp_no">
                    	
                    					
                        <label for="taskId" class="col-form-label">일정시작일</label>
                        <input type="date" class="form-control" id="schedule_start_time" name="schedule_start_time">
                        
                        <label for="taskId" class="col-form-label">일정종료일</label>
                        <input type="date" class="form-control" id="schedule_end_time" name="schedule_end_time">
                        
                        <label for="taskId" class="col-form-label">일정 종류</label>
                        <select class="form-select form-select-sm" aria-label="Small select example" id="grp_cd" name="grp_cd">
						  <option selected>일정종류을 선택하세요</option>
						  <option value="S001A">연차</option>
						  <option value="S001B">회의</option>
						  <option value="S001C">교육</option>
						  <option value="S001D">외근</option>
						  <option value="S001E">출장</option>
						</select>
						
                        <label for="taskId" class="col-form-label">일정제목</label>
                        <input type="text" class="form-control" id="schedule_title" name="schedule_title">
                        
                        
                        <label for="taskId" class="col-form-label">일정내용</label>
                        <textarea class="form-control" id="schedule_contents" name="schedule_contents"></textarea>
                        
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-warning" id="addCalendar">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose" onclick="location.href='/schedule/schedule'">취소</button>
                </div>
    			</form>
            </div>
        </div>
    </div>
<!------------------------------------------------- Add modal ------------------------------------------------->
    			
 <!------------------------------------------------- Add modal ------------------------------------------------->
 <div class="modal fade" id="reservationAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">예약추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" onclick="location.href='/schedule/schedule'">&times;</span>
                    </button>
                </div>
                
                <form id="addForm" action="./add" method="post">
                <div class="modal-body">
                    <div class="form-group">
                    	<input type="hidden" value="memberVO.emp_no">
                    	
                    					
                        <label for="taskId" class="col-form-label">예약시작일</label>
                        <input type="date" class="form-control" id="schedule_start_time" name="schedule_start_time">
                        
                        <label for="taskId" class="col-form-label">예약종료일</label>
                        <input type="date" class="form-control" id="schedule_end_time" name="schedule_end_time">
                        
                        <label for="taskId" class="col-form-label">예약 종류</label>
                        <select class="form-select form-select-sm" aria-label="Small select example" id="schedule_content" name="schedule_kind">
						  <option selected>예약종류을 선택하세요</option>
						  <option value="시설">시설</option>
						  <option value="공용품">공용품</option>
						</select>                        
                        <label for="taskId" class="col-form-label">사용목적</label>
                        <textarea class="form-control" id="schedule_contents" name="schedule_contents"></textarea>
                        
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-warning" id="addReservation">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose" onclick="location.href='/schedule/schedule'">취소</button>
                </div>
    			</form>
            </div>
        </div>
    </div>
<!------------------------------------------------- Add modal ------------------------------------------------->
    			
						<div class=""></div>
						</div>
					</div>

				  </div><!-- End Sales Card -->
				</div>

			</div>
	
			</section>

		  </main><!-- End #main -->	

    	 		 
    	 	
    	 	</div>
			 
		</div>
    	
		<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import> 
    
	</div>
    
    

<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>
<script type="text/javascript">

		
		
		var obj = JSON.parse(${List});
		
		const arr = new Array();
		const res = arr.keys();
		function timeFormat(time){
		      return String(time).padStart(2, "0");
		   }
		
		 $.ajax({
		        url: "/schedule/schedule",
		        data: formdata,
		        processData: false,    // 필수
		        contentType: false,    // 필수
		        method: "post",
		        cache: false,
		        enctype: "multipart/form-data",
		        dataType: "json",
		        success: function (data) {
		            console.log(data);
		            if (data.success === "Y") {
		                $("#schedule_title").val(data.schedule_title);
		                $("#schedule_start_time").val(data.schedule_start_time);
		                $("#schedule_end_time").val(data.schedule_end_time);
		                console.log(data.schedule_title);
		                $("#requestForm").submit();
		            } else {
		                alert("잠시 후 다시 시도해주세요.");
		            }
		        },
		        error: function (error) {
		            console.log("Error:", error);
		        }
		    });
		/*
		$.ajax({
			  type: "GET", 
			  url: "/schedule/scheduleList",
			  async: false,
			  success: function (res) {
			   
			    console.log(res);
			    
			    
			
			  },
			  error: function (XMLHttpRequest, textStatus, errorThrown) {
			    console.log('error')
			  }
			});
*/

	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	    	 
	    	locale: "ko",
	      timeZone: 'Asia/Seoul',
	      initialView: 'dayGridMonth',
	      navLinks:true,
	      eventLimit:true,
	      select: function(){
	    	 href="/schedule/schedulelist"	    	  	
	      },
	      
	      
	      customButtons: {
	    	  myResButton:{
	    		  text:'예약추가'
	    	  }
	    	  ,
	    	    myCustomButton: {
	    	      text: '일정 추가',
	    	      click: function() {
	    	    	  $("#calendarAddModal").modal("show");
	    	    	  
	    	    
	    	    		
	    	    	  $('#sprintSettingModalClose').click(function(){
	    	    			$('#calendarAddModal').modal('hide')	
	    	    		})
	    	    	  
	    	      }
	    	    }
	    	  },
	    	    	  
	      headerToolbar: {
	    	    left: '',
	    	    center: 'prev,title,next',
	    	    right: 'myCustomButton,myResButton'
	    	  },
	    	  
	      buttonText:{
	    	  
	    	 
	      },
	      
	      
	      
        	events:[
        		{
        			title:'test',
        			start:'2023-11-01',
        			end:'2023-11-01'
        			
        		}
        		.
        	]
        
        	
        	
	    	  
	    });
	    
	    calendar.render();
	  });
	
	
	
		

	</script>
</body>
</html></html>