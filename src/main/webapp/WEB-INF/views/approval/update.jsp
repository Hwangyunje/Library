<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import>

<link href="/css/doc.css" rel="stylesheet">
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
					
						<div class="container">
							<form action="/approval/update" method="post" id="frm" enctype="multipart/form-data">
								
								<input type="hidden" id="doc_no" name="doc_no" data-docNo="${docVO.doc_no}" value="${docVO.doc_no}">
					
							
								<input type="hidden" id="approval_state" name="approval_state" value="R">
								<input type="hidden" id="temp_save" name="temp_save" value="N">
								<input type="hidden" id="midApp" name="midApp" value="">
								<input type="hidden" id="lastApp" name="lastApp" value="">

	
	 							
			<sec:authentication property="principal" var="vo"></sec:authentication> 

						

								<div class="row">
									<!-- 각 영역 크기조절하기 -->
									<div class="col-lg-12">
										<div class="card">
											<h1 class="my-5 " align="center">
											<c:choose>
												<c:when test="${docVO.grp_cd eq 'H'}">
												휴가신청서
												</c:when>
												<c:when test="${docVO.grp_cd eq 'B'}">
												지출결의서
												
												</c:when>
												<c:otherwise>
												업무 기안
												
												</c:otherwise>
											</c:choose>
											</h1>

											<!-- 상단 왼쪽 strart -->
											<div class="row grid text-center mx-3">
												<div class="col-lg-2">
													<table class="table table-bordered">

														<tr>
															<th class="table-light">기안자</th>
															<td>${vo.name}</td>
														</tr>


														<tr>
															<th class="table-light">소속</th>
															
															<td>
															${vo.emp_team}
															</td>
														</tr>

														<tr>
															<th class="table-light">기안일</th>
															<td>${docVO.mod_date}</td>
														</tr>
														<tr>
															<th class="table-light">문서번호</th>
															<td>${docVO.doc_no}</td>
														</tr>

													</table>


												</div>
												<!-- 상단 왼쪽 end -->
												<div class="col-lg-4"></div>

												<!-- 상단 오른쪽 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">신청</th>
															
														</tr>


														<tr id="sign">
															<td><img id="sign_img" src="/files/sign/${docVO.sign_name}"></td>
														</tr>
														
														<tr>

															<td>${docVO.emp_team} ${docVO.name}</td>
														</tr>


													</table>


												</div>


												<!-- 상단 오른쪽 end -->
												<!-- 상단 오른쪽 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">중간</th>
															
														</tr>


														<tr id="sign">
	
														<td> </td>

														</tr>
														<tr id="lastTr">

															<td id="midP"></td>
														</tr>


													</table>


												</div>


												<!-- 상단 오른쪽 end -->
												<!-- 상단 오른쪽 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">최종</th>
															
														</tr>


														<tr id="sign">
															<td></td>
														</tr>
														
														<tr id="lastTr">
															<td id="lastP"></td>
														</tr>

													</table>


												</div>


												<!-- 상단 오른쪽 end -->
											</div>

											<!-- 본문 -->
											<c:choose>
												<c:when test="${docVO.grp_cd eq 'H'}">
												
												<c:import url="./temp_l.jsp"></c:import>
												</c:when>
												<c:when test="${docVO.grp_cd eq 'B'}">
											
												<c:import url="./temp_e.jsp"></c:import>
												</c:when>
												<c:otherwise>
												
												<c:import url="./temp_d.jsp"></c:import>
												</c:otherwise>
											</c:choose>
											<!-- 본문 end  -->

											<div class="row mx-3 my-3">
												<div class="col-lg-12">

													<!-- file -->

													<div id="fileList"></div>


													<div class="mb-3">
														<button type="button" class="btn btn-outline-primary"
															id="fileAdd">File추가</button>
													</div>
													
													<div class="my-5">
													<c:forEach items="${docVO.fileVOs}" var="f">
													<c:if test="${not empty f.file_no}">
															<span class="alert alert-primary me-2" role="alert" id="${f.file_no}" >
																첨부파일 : ${f.file_oriName}
															 </span>
														<span class="delets" data-delete-num="${f.file_no}" >x</span>
													</c:if>
													</c:forEach>
													</div>
													<div class="my-3">
													<!-- button  -->
													<button type="button" id="doc_send" class="btn btn-primary btn-sm">결재요청</button>
													<button type="button"  id="btn_cancle" class="btn btn-primary btn-sm mx-1">기안취소</button>
													<button type="button" id="temp_send" class="btn btn-primary btn-sm">임시저장</button>
													<button type="button" class="btn btn-primary btn-sm">취소</button>
													<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal"
															data-bs-target="#basicModal" id ='btnGetMem'>결재선</button> 
													</div>
															

												</div>


											</div>



										</div>


									</div>




								</div>
							</form>


						</div>
			</div>

			</section>

			</main>
			<!-- End #main -->

			<!-- 모달 -->

			<div class="modal fade" id="basicModal" tabindex="-1">
				<div class="modal-dialog modal-lg" style="max-width: 60%; width: 60%;">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">결재선</h5>
						
						</div>
						<div class="modal-body style="max-height: 300px; overflow-y: auto;">
						
						<div class=row>
							<div class="col-sm-3">
						
							<div>조직도</div>
							<div class="card border scrollable-card">
								<div class="overflow-auto " id="readyMem">
									
								</div>
							</div>
							
							</div>
							
							<div class="col-sm-4">
							
							<div>사원목록</div>
							<div class="card border scrollable-card">
								<div class="overflow-auto" id="memList">
									
							
									
								</div>
							
							</div>
							
							</div>
							
							<div class="col-sm-1 ">
							
							
							<div class="scrollable-card1 text-center d-flex flex-column justify-content-center align-items-center">
								<i class="bi bi-arrow-right mt-5" id="midAW"></i>
							</div>
							
							<div class="scrollable-card1 text-center d-flex flex-column justify-content-center align-items-center mt-5">
								<i class="bi bi-arrow-right mt-5" id="lastAW"></i>
							</div>
							

					
							</div>
								
							
							<div class="col-sm-4 scrollable-card">
							<div>중간 승인자</div>
							<div class="card border scrollable-card1 overflow-auto" id="fLine">
								
							</div>
							
							<div>최종 승인자</div>
							<div class="card border scrollable-card1 overflow-auto" id="lLine">
								
							</div>
							
							
							</div>
						
						</div>
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary" id="modalSave">Save
								</button>
						</div>
					</div>
				</div>
			</div>
			

			<!-- End Basic Modal-->



		</div>

	</div>

	<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import>

	</div>



	<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>




	<script src="/js/file.js"></script>
	
	<script src="/js/appLine.js"></script>
</body>

</html>