	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>      
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>My Page</title>
	<c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import> 

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
				
							
					<div class="row"  id="image"  data-image="${photo.file_name}" data-ww="${ww}">
						<!-- 각 영역 크기조절하기 -->
						<div class="col-lg-6">
							<h1>마이 페이지</h1>
							
					<form action="/member/update" method="post" enctype="multipart/form-data">		  
			

						<!-- <div class="form-group">
							<br>
							<label for="photo">프로필사진</label>
							<c:choose>
								<c:when test="${not empty profileImage.getFile_name()}">
									  <img src="${filePath}" alt="프로필사진" class="rounded-circle">
								</c:when>
								<c:otherwise>
									<img src="assets/img/defalut_image.jpg" alt="프로필사진" class="rounded-circle">	
								</c:otherwise>
							</c:choose>   
						 
							<small id="photoHelp" class="form-text text-muted"></small>
						</div>
						 -->

						<div class="card">
							<div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
				
								<c:choose>
									<c:when test="${not empty profileImage.getFile_name()}">
										  <img src="${filePath}" alt="프로필사진" class="rounded-circle">
									</c:when>
									<c:otherwise>
										<img src="assets/img/defalut_image.jpg" alt="프로필사진" class="rounded-circle">	
									</c:otherwise>
								</c:choose>
							  <h2>${memberVO.name}</h2>
							  <h3>${memberVO.emp_position}</h3>
							  <div class="social-links mt-2">
								<a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
								<a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
								<a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
								<a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
							  </div>
							</div>
						  </div>
					
						<div class="form-group">
							<br>	
							<label for="name">이름</label>
							<input type="text" value="${memberVO.name}" name="name" class="form-control" readonly/>
						</div>
						
									
						
						<div class="form-group">
						<br>
							<label for="emp_no">사원번호</label>
							<input type="text" value="${memberVO.emp_no}" name="emp_no" class="form-control" readonly/>
						</div>
					
						

						<div class="form-group">
							<br>
							<label for="email">이메일</label>
							<input type="email" value="${memberVO.email}" name="email" class="form-control" readonly/>
							
						</div>

						
						<div class="form-group">
							<br>
							<label for="birth">생일</label>
							<input type="date" value="${memberVO.birth}" name="birth" class="form-control" readonly/>
						</div>	
						
						<div class="form-group">
							<br>
							<label for="phone">전화번호</label>
							<input id="phone" type="tel" value="${memberVO.phone}" placeholder="010-1234-5678" name="phone" pattern="[0-1]{3}-[0-9]{4}-[0-9]{4}" class="form-control" readonly/>
						</div>

						
						<div class="form-group">
							<br>
							<label for="emp_team">부서</label>
							<input id="emp_team" type="text"  value="${memberVO.emp_team}" class="form-control" readonly/>
						</div>

						<div class="form-group">
							<br>
							<label for="emp_position">직급</label>
							<input id="emp_position" type="text" value="${memberVO.emp_position}" class="form-control" readonly/>
						</div>
		
						
						
					
						<br>
					<button type="submit" class="btn btn-primary" href="/member/update">정보수정</button> 
								
										

					</form>
							</div>
						</div>

				
					
					
					
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