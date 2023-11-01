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
<style>
	.col-lg-6{
	width:1550px;
	}
	.tg-1{
	width:800px;
	}
	#res_list{
	margin:15px;
	border:solid 1px;
	}
	.tg-01ax{
	margin:15px;
	border:solid 1px;
	}
	.tg{

	text-align:center;
	border:solid 1px;
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
							<h1 id="date">날짜</h1>
						<table class="tg tg-1">
							<thead>
							  <tr id="sch_list">
							    <th class="tg-0lax">시작시간</th>
							    <th class="tg-0lax">종료시간</th>
							    <th class="tg-0lax">내용</th>
							  </tr>
							</thead>
							<tbody>
							  <tr>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							     <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
								  수정
								</button>

								<!-- Modal -->
								<form>
								<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h1 class="modal-title fs-5" id="exampleModalLabel">일정 수정</h1>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        ...
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								        <button type="submit" class="btn btn-primary" id="updateCalendar">수정</button>
								      </div>
								    </div>
								  </div>
								</div>
								</form>
							  	<button id="deleteCalendar">삭제</button>
							  </tr>
							</tbody>
							</table>
						<br><br><br>
						<table class="tg tg-2">
							<thead>
							  <tr id="res_list">
							    <th class="tg-0la">공용품종류</th>
							    <th class="tg-0la">공용품번호</th>
							    <th class="tg-0la">예약자</th>
							    <th class="tg-0la">예약시간</th>
							    <th class="tg-0la">사용목적</th>
							    <th class="tg-0la">예약날짜</th>
							  </tr>
							</thead>
							<tbody>
							  <tr>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <td class="tg-0lax"></td>
							    <button>수정</button>
							  	<button>삭제</button>
							  </tr>
							</tbody>
							</table>
						<div class="">
						</div>
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