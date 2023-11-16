<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import> 
<style>
.col-lg-6{
width:300px;
height:400px;
}
.card{
width:300px;
height:400px;
}
.div-padding{
position:relative;
top:-400px;
left:310px;
width:900px;
}
.font-14{
float:left;
}
.main-color{
float:left;
}
.color-gray{
float:left;
}
#work-week-container{
    position: relative;
    border: .5px solid gray;
    height: 100px;
    width: 100%;
}
#work-week-time{
    position: absolute;
    display: flex;
    justify-content: space-around;
    text-align: center;
    height: 100%;
}
#work-week-time div{
    width: 180px;
    padding-top: 17px;
}
#work-week-time p {
    margin-bottom: 5px;
}
#date-box{
    text-align: center;
}
.font-14{
float:left;
}
.main-color{
float:left;
}
.color-gray{
float:left;
}
#work-week-container{
    position: relative;
    border: .5px solid gray;
    height: 100px;
    width: 100%;
}
#work-week-time{
    position: absolute;
    display: flex;
    justify-content: space-around;
    text-align: center;
    height: 100%;
}
#work-week-time div{
    width: 180px;
    padding-top: 17px;
}
#work-week-time p {
    margin-bottom: 5px;
}
#date-box{
    text-align: center;
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
						<table id="home-work-tbl">
                            <thead>
                                <tr>
                                    <th colspan="2">
                                        <h4 class="text-left font-bold">근태관리</h4>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            	<form id="insertGtw_time" action="./insertStartWork.do" method="post">
                                 <input type="hidden" name="_csrf" value="{{#_csrf}}token{{/_csrf}}" />
                                <tr>
                                    <td id="year" colspan="2" class="font-14">clock</td>
                                </tr>
                                <tr>
                                    <td colspan="2" id="clock" style="color:black;">clock</td>
                                </tr>
                                <tr>
                                    <td class="font-14 font-bold">업무상태</td>
                                    <input type="hidden" value="G001" id="grp_cd" name="grp_cd">
                                    <td class="text-right font-14 color-red font-bold" id="work-state">
                                    <select class="form-select" aria-label="Default select example" id="status" name="status">
									  <option selected>출근전</option>
									  <option value="A">조퇴</option>
									  <option value="B">연차</option>
									  <option value="C">반차</option>
									  <option value="D">정상</option>
									  <option value="E">출장</option>
									  <option value="F">외근</option>
									</select></td>
                                </tr>            
                                <tr>
                                    <td class="font-14 font-bold">출근시간</td>
                                    <td class="text-right font-14" id="startwork-time">미등록</td>
                                    <input type="hidden" value="${sysdate}" id="gtw_time" name="gtw_time"></input>
                                    <input type="hidden" value="${sysdate}" id="startwork-time" name="startwork-time"></input>

                                </tr>
                                <tr>
                                    <td class="font-14 font-bold">퇴근시간</td>
                                    <td class="text-right font-14" id="endwork-time">미등록</td>
                                    <input type="hidden" value="${sysdate}" id="lw_time" name="lw_time">
                                </tr>
                                	<input type="hidden" value="${memberVO.emp_no}" id="emp_no" name="emp_no">
                                <tr class="btn-tr">
                                    <td>
                                    <button type="submit" id="insertGtw_time">출근하기</button>
                                </form>
                                    </td>
                                <form id="updateLw-time" action="./updateEndWork.do" method="post">
                                    <td class="text-right">
                                    <input type="hidden" value="${sysdate}" id="lw_time" name="lw_time">
                                    <input type="hidden" value="${memberVO.emp_no}" id="emp_no" name="emp_no">
                                    <button type="submit" id="updateLw_time">퇴근하기</button>
                                    </td>
                                    </form>
                                </tr>
                            </tbody>
                        </table>
						<div class=""></div>
						</div>
					</div>
					<div class="div-padding">
                        <div id="date-box">
                            <h4>
                                <button id="prev-btn"><i class="fa-solid fa-chevron-left"></i></button>
                                <span id="date-text">2023.11</span>
                                <button id="next-btn"><i class="fa-solid fa-chevron-right"></i></button>
                            </h4>
                        </div>

                        <div class="work-week-container" id="work-week-container">
                            <div id="work-week-time">
                                
                                <div>
                                    <p class="font-14">이번주 누적</p><br>
                                    <h4 class="main-color" id="main-totalwork-time">0h 0m 0s</h4>
                                </div>
                                
                                <div>
                                    <p class="font-14">이번주 초과</p><br>
                                    <h4 class="main-color" id="main-week-over-time">0h 0m 0s</h4>
                                </div>
                                <div>
                                    <p class="font-14">이번주 잔여</p><br>
                                    <h4 class="main-color" id="main-work-time">40h 0m 0s</h4>
                                </div>
                                
                            </div>
                        </div>

							
                        <div id="work-info-container"></div>

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

<script>
    window.addEventListener('load', function(){
        
        getStartAndEndDateOfWeek();
        
        const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
        
        $.ajax({
            url : './attendanceHome',
            contentType : "application/json; charset=utf-8",
            success(data){
                console.log(data);
                if(data){
                    const {atd_no,emp_no,gtw_time,lw_time,reg_id,reg_date,mod_id,mod_date,use_yn,status,overtime,dayWorkTime} = data;
                    var starttime = new Date(gtw_time);
                    var endtime = new Date(lw_time);
                    
                    //하루 근무시간 계산
                    const daytimes = endtime - starttime; //퇴근시간 - 출근시간
                    console.log(daytimes);
                    
                    const workState = document.querySelector("#work-status");
                    workState.textContent = status;
                    
                    
                    if(startWork){
                      var hours = (starttime.getHours()); 
                     var minutes = starttime.getMinutes();
                     var seconds = starttime.getSeconds();
                     var startWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                     // 출근시간 정보 출력
                     document.querySelector('#startwork-time').textContent = startWorkTime;
                    }
                    
                    if(endWork){
                        var hours = (endtime.getHours()); 
                      var minutes = endtime.getMinutes();
                      var seconds = endtime.getSeconds();
                      var endWorkTime = `\${hours < 10 ? '0' + hours : hours}:\${minutes < 10 ? '0'+minutes : minutes}:\${seconds < 10 ? '0'+seconds : seconds}`;
                      // 퇴근시간 정보 출력
                       document.querySelector('#endwork-time').textContent = endWorkTime;
                    }
                    
                    if(daytimes > 0){
                        //하루 근무시간 update
                       updateDayWorkTime(daytimes);
                    }
                }
            },
            error : console.log
        });
       
    });
    
    
    
    //출근 버튼 클릭 시
    document.querySelector('#btn-startwork').addEventListener('click', function () {
        
        const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
        
        $.ajax({
           url : './insertStartWork.do',
           method : 'POST',
           headers,
           contentType : "application/json; charset=utf-8",
           success(data){
                console.log(data);
               if(data.state === "성공"){
                   alert("출근이 성공적으로 등록됬습니다.");
                   location.reload();
               }else if(data.state === '출장'){
                   alert("출장시에는 자동적으로 출근처리가 완료됩니다.");
                  return;
               }else if(data.state === '연차'){
                   alert("연차중입니다.");
                   return;
               }
               else{
                   alert("이미 출근하셨습니다.");
                       return;
               }
           },
           error : console.log
       });
    });
    
    //퇴근하기 버튼 누를시
    document.querySelector('#btn-endwork').addEventListener('click', function () {
        
        const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
        
        $.ajax({
           url : './updateEndWork.do',
           method : 'POST',
           headers,
           contentType : "application/json; charset=utf-8",
           success(data){
               console.log(data);
               
               if(data.state === "성공"){
                   alert("퇴근이 성공적으로 등록됬습니다.");
                   location.reload();
               }else if(data.state === '출근전'){
                   alert("출근전입니다.");
                   return;
               }else if(data.state === '출장'){
                   alert("출장시에는 자동적으로 퇴근처리가 완료됩니다.");
                  return;
               }else if(data.state === '연차'){
                   alert("연차중입니다.");
                   return;
               }
               else{
                   alert("이미 퇴근하셨습니다.");
                   return;
               }
            },
           error : console.log
       });
    });
    
    const updateDayWorkTime = (daytimes) =>{
        
        const csrfHeader = "${_csrf.headerName}";
        const csrfToken = "${_csrf.token}";
        const headers = {};
        headers[csrfHeader] = csrfToken;
        
        $.ajax({
            url: './updateDayWorkTime.do',
            method: 'POST',
            headers,
            data: {daytimes},
            success(data) {
              console.log(data);
              getStartAndEndDateOfWeek();
            },
            error: console.log
          });
        };
    
    //이번주 누적시간 가져오기
    function getStartAndEndDateOfWeek() {
          const today = new Date();
          const todayDay = today.getDay(); // 오늘 날짜의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)
    
          const startDate = new Date(today); // 해당 주의 시작일
          startDate.setDate(startDate.getDate() - todayDay);
    
          const endDate = new Date(today); // 해당 주의 종료일
          endDate.setDate(endDate.getDate() + (6 - todayDay));
    
          const start = startDate.getFullYear() + "." + (startDate.getMonth() + 1) + "." + startDate.getDate();
          const end = endDate.getFullYear() + "." + (endDate.getMonth() + 1) + "." + endDate.getDate();
          
          $.ajax({
              url : "./weekTotalTime.do",
              data : {start, end},
              contentType : "application/json; charset=utf-8",
              success(data){
                  console.log(data);
                  const {weekOverTime ,weekTotalTime} = data;
                  const totalWorkTime = document.querySelector("#totalwork-time");
                  
                  totalWorkTime.textContent = chageWorkTime(weekTotalTime + weekOverTime);
              },
              error : console.log
              
          });
    }
    
    function chageWorkTime(times){
        const time = times / 1000;
        const hours = Math.floor(time / 3600); // 시간 계산
        const minutes = Math.floor((time % 3600) / 60); // 분 계산
        const seconds = Math.floor(time % 60); // 초 계산
        
        return `\${hours}h \${minutes}m \${seconds}s`;	
    }
    
    </script>			
    <script src="/js/attendance.js"></script>
</body>
<!-- CSRF -->
		<s:csrf/>	
	
</html>