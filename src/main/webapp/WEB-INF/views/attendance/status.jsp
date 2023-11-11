<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import> 

</head>
<script type="text/javascript">
	// init(${isAuthenticated});
	let weeksOfMonthInfo_json = ${weeksOfMonthInfo_json};
	let attendances_json = ${attendances_json};
	
	let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];

	$(function(){
		let startBtn_status = "on";
		let endBtn_status = "on";
		if(${commuteWhether.goWork}) startBtn_status = "off";
		if(${commuteWhether.leaveWork}) endBtn_status = "off";

		let serverDate = getServerDate();
		let cur_time = new Date(serverDate).toTimeString().split(" ")[0];
		
		$("#attendance").html("<p id='cur_date'></p>" +
									   "<p id='cur_time'>" + cur_time + "</p>" +
									   "<div id='start_time' class='attendance_time'><i>출근 시간</i> <span>미등록</span></div>" +
									   "<div id='end_time' class='attendance_time'><i>퇴근 시간</i> <span>미등록</span></div>" +
									   "<div id='attendance_btn'>" +
										   "<button id='start_btn' class='" + startBtn_status + "'>출근하기</button> &nbsp;" +
										   "<button id='end_btn' class='" + endBtn_status + "'>퇴근하기</button>" +
									   "</div>");
		
		let dayOfWeek = new Date(serverDate).getDay();
		let cur_date = new Date(serverDate).toLocaleDateString().replace(/\./g, "").replace(/\s/g, "-");
		$("#cur_date").html(cur_date + "(" + daysOfWeek[dayOfWeek] + ")");
		
		setInterval(function(){
			cur_time = new Date(getServerDate()).toTimeString().split(" ")[0];
			$("#cur_time").html(cur_time);
		}, 1000);
	});

	$(function(){
		let month_accrue = "00:00:00"; // 이번달 누적
		let month_over = "00:00:00"; // 이번달 연장
		$.each(attendances_json, function(index, element){
			let dataDateAttribute = dateToDataDateAttribute(new Date(element.attendanceDate));

			let attendanceStart = new Date(element.attendanceStart);
			let formatted_attendanceStart = formatTime(attendanceStart.getHours(), attendanceStart.getMinutes(), attendanceStart.getSeconds(), ":");
			let dayOfWeek = "(" + daysOfWeek[attendanceStart.getDay()] + ")";
			$("[data-date='" + dataDateAttribute + "']").find(".start").html(formatted_attendanceStart + dayOfWeek);

			if(element.attendanceEnd == undefined) return; // 아직 퇴근은 하지 않은 경우

			let attendanceEnd = new Date(element.attendanceEnd);
			let formatted_attendanceEnd = formatTime(attendanceEnd.getHours(), attendanceEnd.getMinutes(), attendanceEnd.getSeconds(), ":");
			dayOfWeek = "(" + daysOfWeek[attendanceEnd.getDay()] + ")";
			$("[data-date='" + dataDateAttribute + "']").find(".end").html(formatted_attendanceEnd + dayOfWeek);
			
			/*
				총 근무 시간 구하기
				-근무 시간은 09시부터 적용
				-점심 시간 제외(-1시간) : 3시간 이상 근무 시 적용
			*/
			if(attendanceStart.getHours() < 9){
				attendanceStart.setHours(9);
				attendanceStart.setMinutes(0);
				attendanceStart.setSeconds(0);
			}
			
			let lunch_time;
			let total = timeDiffToTimeString(attendanceEnd.getTime() - attendanceStart.getTime(), ":");
			let total_timeObj = splitTimeString(total, ":");
			if(total_timeObj.hours >= 4){
				lunch_time = 1000 * 60 * 60;
				total = timeDiffToTimeString(attendanceEnd.getTime() - attendanceStart.getTime() - lunch_time, ":");
			}else if(total_timeObj.hours == 3){
				let minutes = attendanceEnd.getMinutes();
				let seconds = attendanceEnd.getSeconds();
				lunch_time = "00:" + minutes + ":" + seconds;
				
				total = hoursToTimeString(timeStringToHours(total, ":") - timeStringToHours(lunch_time, ":"), ":");
			}

			$("[data-date='" + dataDateAttribute + "']").find(".total").html(total);

			month_accrue = hoursToTimeString(timeStringToHours(month_accrue, ":") + timeStringToHours(total, ":"), ":");
			
			// 근무 시간 상세 구하기
			let detail = "";
			let basic = "08:00:00";

			if(parseInt(total.split(":")[0]) < 8) basic = total;
			detail += "기본 " + basic;
			
			let over = hoursToTimeString(timeStringToHours(total, ":") - timeStringToHours("08:00:00", ":"), ":"); // 기본 8시간 초과 시 연장 및 야간 적용
			let over_timeObj = splitTimeString(over, ":");

			if(timeStringToHours(over, ":") - timeStringToHours("00:00:00", ":") > 0){
			// 또는 if(over > "00:00:00")
				detail += " / 연장 " + over;
				if(over_timeObj.hours > 4){
					detail += "(야간 " + formatTime(over_timeObj.hours - 4, over_timeObj.minutes, over_timeObj.seconds, ":") + ")";
				}

				month_over = hoursToTimeString(timeStringToHours(month_over, ":") + timeStringToHours(over, ":"), ":");
			}
			
			$("[data-date='" + dataDateAttribute + "']").find(".detail").html(detail);
		});

		month_accrue = convertFormatTime(month_accrue, ":", "hms");
		$("#total #month_accrue > .time > span").html(month_accrue);

		month_over = convertFormatTime(month_over, ":", "hms");
		$("#total #month_over > .time > span").html(month_over);
	});

	$(function(){
		$("#weeksOfMonthInfo").on("click", ".week > .week_title > img", function(){
			if($(this).hasClass("open")){
				$(this).removeClass("open").addClass("close");
			}else if($(this).hasClass("close")){
				$(".week > .week_title > img").not(this).removeClass("open").addClass("close");
				$(this).removeClass("close").addClass("open");
				
				let selected_weekOfMonth = $(this).siblings("h3").html();
				$("#total  #week_accrue > h3").html(selected_weekOfMonth + " 누적");
				$("#total  #week_excess > h3").html(selected_weekOfMonth + " 초과");
				$("#total  #week_remain > h3").html(selected_weekOfMonth + " 잔여");

				// ===================================================================================
				
				// - 선택한 주차의 누적, 초과, 잔여 시간 구하기 -
				
				// 누적
				let week = parseInt(selected_weekOfMonth.split("주")[0]);
				let accrue = "00:00:00";
				
				$.each(weeksOfMonthInfo_json[week], function(index, element){
					if(index == 0) return true; // == continue
					
					let date = element.split(" ")[0];
					let total = $("[data-date='" + date + "']").find(".total").html();

					if(total != ""){
						accrue = hoursToTimeString(timeStringToHours(accrue, ":") + timeStringToHours(total, ":"), ":");
					}
				});

				let accrue_timeObj = splitTimeString(accrue, ":");
				accrue = convertFormatTime(accrue, ":", "hms");
				$("#total #week_accrue > .time > span").html(accrue);
				$(this).siblings("p").find("span:first-of-type").html("누적 근무 시간 " + accrue);
				
				// 초과
				let excess = "0h 0m 0s";
				if(accrue_timeObj.hours >= 40){
					excess = hoursToTimeString(timeStringToHours(accrue, "hms") - timeStringToHours("40h 0m 0s", "hms"), "hms");
				}
				
				$("#total #week_excess > .time > span").html(excess);
				$(this).siblings("p").find("span:last-of-type").html("(초과 근무 시간 " + excess + ")");

				// 잔여
				let remain = "0h 0m 0s";
				if(accrue_timeObj.hours < 40){
					remain = hoursToTimeString(timeStringToHours("40h 0m 0s", "hms") - timeStringToHours(accrue, "hms"), "hms");
				}

				$("#total #week_remain > .time > span").html(remain);
			}
		});
		
		$("#weeksOfMonthInfo .week > .week_title > img.close").trigger("click");
		let weekOfMonth = (${date.weekOfMonth} == 0) ? 1 : ${date.weekOfMonth};
		$("#weeksOfMonthInfo .week[data-weekOfMonth='" + weekOfMonth + "'] > .week_title > img.close").trigger("click");
	});
</script>

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
						<div class="card"><h1 id="title">근태 현황</h1>
<div id="move_month">
	<i id="before_month">《</i>
	<h2>${date.year}.<fmt:formatNumber value="${date.month}" pattern="00" /></h2>
	<i id="after_month">》</i>
</div>
<div id="total">
	<div class="wrap">
		<div id="week_accrue" class="component">
			<h3></h3>
			<div class="time">
				<span>0h 0m 0s</span>
			</div>
		</div>
	</div>
	<p class="dividing"></p>
	<div class="wrap">
		<div id="week_excess" class="component">
			<h3></h3>
			<div class="time">
				<span>0h 0m 0s</span>
			</div>
		</div>
		<div id="week_remain" class="component">
			<h3></h3>
			<div class="time">
				<span>0h 0m 0s</span>
			</div>
		</div>
	</div>
	<p class="dividing"></p>
	<div class="wrap">
		<div id="month_accrue" class="component">
			<h3>이번달 누적</h3>
			<div class="time">
				<span>0h 0m 0s</span>
			</div>
		</div>
		<div id ="month_over" class="component">
			<h3>이번달 연장</h3>
			<div class="time">
				<span>0h 0m 0s</span>
			</div>
		</div>
	</div>
</div>
<div id="weeksOfMonthInfo">
	<ul>
		<c:forEach items="${weeksOfMonthInfo}" var="week" varStatus="week_status">
			<c:if test="${week_status.index != 0}">
				<li class="week" data-weekOfMonth="${week_status.index}">
					<div class="week_title">
						<img class="close">
						<h3>${week_status.index}주차</h3>
						<p>
							<span></span><span></span>
						</p>
					</div>
					<table>
						<tr>
							<th>일자</th> <th>업무 시작</th> <th>업무 종료</th> <th>총 근무 시간</th> <th>근무 시간 상세</th>
						</tr>
						<c:forEach items="${week}" var="date" varStatus="date_status">
							<c:if test="${date_status.index != 0}">
								<tr data-date="${fn:split(date, ' ')[0]}">
									<td class="day">${fn:replace(fn:split(date, "m")[1], "d", "")}</td>
									<td class="start"></td>
									<td class="end"></td>
									<td class="total"></td>
									<td class="detail"></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</li>
			</c:if>
		</c:forEach>
	</ul>
</div><div class=""></div>
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
</body>
</html>