<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
									<div class="card">
										<form action="/approval/addSign" method="post" id="frm" enctype="multipart/form-data">
											<div class="mb-3">
												<label for="addSign" class="form-label">싸인추가</label> 
													<input type="file" class="form-control" id="addSign" name="file">
	
											</div>
											
											<button type="submit" class="btn btn-primary">싸인추가</button>
										</form>
									</div>
								</div>

							</div>
						</div>
			</div>

			</section>

			</main>
			<!-- End #main -->

			<div class="container-fluid">

				<div class="row">
					<!-- 각 영역 크기조절하기 -->
					<div class="col-lg-6">
						<div class="card">


							<div class=""></div>
						</div>

					</div>

					<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import>

				</div>



				<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>
</body>

</html>