<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			
						
				<div class="row">
					<!-- 각 영역 크기조절하기 -->
					<div class="col-lg-6">
						
				<form:form modelAttribute="memberVO" method="post" enctype="multipart/form-data" id="joinForm">
					<div class="form-group">
						<form:label path="name">이름</form:label>
						<form:input id="name"  path="name" cssClass="form-control"/>
						<form:errors path="name"></form:errors>
					</div>
					
					
					<div class="form-group">
						<br>
						<form:label path="password">비밀번호</form:label>
						<form:password path="password" cssClass="form-control" id="password" aria-describedby="pwstyle"/>
						<small id="pwstyle" class="form-text text-muted">비밀번호는 6~12자 이며 소문자,특수문자,숫자를 하나 이상씩 넣어야합니다.</small>
						<form:errors path="password"></form:errors>
					</div> 
					<div class="form-group">
						<br>
						<form:label path="passwordCheck">비밀번호확인</form:label>
						<form:password path="passwordCheck" cssClass="form-control" id="passwordCheck"/>
						<form:errors path="passwordCheck"></form:errors>
					</div>
					<div class="form-group">
						<br>
						<form:label path="email">이메일</form:label>
						<form:input id="email" type="email" path="email" cssClass="form-control"/>
						<form:errors path="email"></form:errors>
					</div>

					
					<div class="form-group">
						<br>
						<form:label path="birth">생일</form:label>
						<form:input id="birth" type="date" path="birth" cssClass="form-control"/>
						<form:errors path="birth"></form:errors>
					</div>	
					
					<div class="form-group">
						<br>
						<form:label path="emp_in_date">입사일</form:label>
						<form:input id="emp_in_date" type="date" path="emp_in_date" cssClass="form-control"/>
						<form:errors path="emp_in_date"></form:errors>
					</div>
						
			
					<div class="form-group">
						<br>
						<label for="phone">전화번호</label>
						<input id="phone" type="tel" placeholder="010-1234-5678" name="phone" pattern="[0-1]{3}-[0-9]{4}-[0-9]{4}" class="form-control"/>
					</div>

						<div class="form-group">
							<br>
							<form:label path="emp_team">부서</form:label>
							<form:select name="selectTeam" id="emp_team" path="emp_team" cssClass="form-control">
								<form:option value="" label="부서 선택 시 클릭하세요" /> 	
								<form:option value="A" label="대표" />
								<form:option value="B" label="운영과" />
								<form:option value="C" label="정책과" />
								<form:option value="D" label="서비스과" />
								<form:option value="E" label="미정" />
								</form:select>
							<form:errors path="emp_team"></form:errors>
						</div>
						
					
						<div class="form-group">
						<br>
						<form:label path="emp_position">직급</form:label>
						<form:select name="selectPosition" id="emp_position"  path="emp_position" cssClass="form-control">
							<form:option value="" label="직급 선택 시 클릭하세요" /> 
							<form:option value="A" label="관장" /> 
							<form:option value="B" label="팀장" /> 
							<form:option value="C" label="주무관" /> 
							<form:option value="D" label="사서" /> 
						</form:select>
						<form:errors path="emp_position"></form:errors>
					</div>
					
						<!-- <div class="form-group">
						<br>
						<label for="profile">프로필사진</label>
						<input type="file" name="profile" class="form-control" id="profile" aria-describedby="photoHelp">
						<small id="photoHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
					</div> -->
					<br> 
					<br>
				<button type="submit" id="joinModal" class="btn btn-primary">회원가입</button>
		
			 </form:form>
								<!-- 사원번호 모달 버튼 -->
							<!-- <button type="button" id="joinModal" data-emp_no="${empNo}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#empNoModal">
									회원가입
									</button>  -->
								
									
								
							
								<!-- <div class="modal fade" id="empNoModal" tabindex="-1">
									<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
										<h5 class="modal-title">사원번호</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											
											<p id="emp_info">${empNo}ddd </p></p>
										</div>
										<div class="modal-footer">
										<button type="submit" class="btn btn-primary" data-bs-dismiss="modal" href="member/login">확인</button>
										</div>
									</div>
									</div>
								</div>  	
								 -->
									
									<!-- <script>
										$(document).ready(function() {
											$('#empNoModal').modal('show');

											$('#joinModal').click(function() {
												// let empNo = $('#joinModal').data('emp_no');
												// console.log("사원번호:"+empNo)

												
												 // 폼 데이터를 직렬화하여 가져오기
												let formData = $('#joinForm').serialize();


												//비동기방식으로 해야 사원번호를 가져올 수 있어서 ajax사용
												$.ajax({
													url: '/member/join', 
													type: 'POST',
													data: formData,
													success: function(data) {	
													console.log('응답 데이터:', data);
													if(data.emp_no){
														$('#emp_info').text('당신의 사원번호는 ' + data.emp_no + '입니다.');
														}
														//
													
													},
													error: function() {
														// alert('사원번호 가져오기에 실패했습니다.');
														console.error('Ajax 요청 실패');
													}
												});
											});
										}); 


										</script>	 -->
									
									 
									
									

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