<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<title>Insert title here</title>
					<c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import>
				<style>
				    th, td {
				        text-align: center;
				       
				    }
				    
				    .card{
				    	height:1000px;
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
												<div class="col-lg-12">
													<div class="card">
													
														<h1 class="my-5 " align="center">${kindName}</h1>
													<table class="table mt-5">
														    <colgroup>
													        <col style="width: 15%;">
													        <col style="width: 10%;">
													        <col style="width: 60%;">
													        <col style="width: 10%;">
													        <col style="width: 5%;">
													    </colgroup>
		
															<thead>
																 <th>기안일</th>
																 <th>결재양식</th>
																 <th>제목</th>
																 <th>문서번호</th>
																 <th>상태	</th>
															</thead>
														<c:forEach items="${list}" var="d">
															<tr>
																<td>${d.reg_date}</td>
																<td>${d.grp_cd}</td>
																
																
																<c:choose>
																<c:when test="${param.k ne 'temp'}">
																<td><a style="text-decoration: none; color: black;" href="./draftDetail?k=${param.k}&doc_no=${d.doc_no}">${d.doc_title}</a></td>
																</c:when>
																<c:otherwise>
																<td><a style="text-decoration: none; color: black;" href="./update?doc_no=${d.doc_no}">${d.doc_title}</a></td>
																</c:otherwise>
																</c:choose>
<%-- 																<c:choose>
																  <c:when test="${d.grp_cd eq '업무기안'}">
																   	<td><a style="text-decoration: none; color: black;" href="./draftDetail?doc_no=${d.doc_no}">${d.doc_title}</a></td>
																  </c:when>
																  <c:when test="${d.grp_cd eq '휴가신청서'}">
																    <td><a style="text-decoration: none; color: black;" href="./draftDetail?doc_no=${d.doc_no}">${d.doc_title}</a></td>
																  </c:when>
																  <c:when test="${d.grp_cd eq '지출결의서'}">
																 	 <td><a style="text-decoration: none; color: black;" href="./expenseDetail?doc_no=${d.doc_no}">${d.doc_title}</a></td>
																  </c:when>
																</c:choose> --%>
																
																<td>${d.doc_no}</td>
																<td>${d.approval_state}</td>
															</tr>
														</c:forEach>
														
															</tbody>
															</table>	
											
											
												<nav class="nav justify-content-center" aria-label="Page navigation example">
												  <ul class="pagination">
												    <li class="page-item ${pager.pre?'':'disabled'}">
												      <a class="page-link" href="./list?k=${param.k}&page=${pager.startNum-1}&kind=${pager.kind}&search=${pager.search}" aria-label="Previous">
												        <span aria-hidden="true">&laquo;</span>
												      </a>
												    </li>
												    <c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
													    <li class="page-item"><a class="page-link" href="./list?k=${param.k}&page=${i}&kind=${pager.kind}&search=${pager.search}">${i}<a></a></li>
												    </c:forEach>
												    <li class="page-item ${pager.next?'':'disabled'}">
												      <a class="page-link" href="./list?k=${param.k}&page=${pager.lastNum+1}&kind=${pager.kind}&search=${pager.search}" aria-label="Next">
												        <span aria-hidden="true">&raquo;</span>
												      </a>
												    </li>
												  </ul>
												</nav>
													<div class="search">
														<form method="get" action="./list">
															<table class="pull-right">
															<input type="hidden" name="k" value="${param.k}"/>
															<%-- <input type= "hidden" name=page value="${pager.page}"/> --%>
																<tr>
																	<td><select class="form-select" name="kind" >
																			<option value="grp_cd">결재양식</option>
																			<option value="title">제목</option>
																			<option value="cotents">내용</option>
																			<option value="state">상태</option>
																	</select></td>
																	<td><input type="text" class="form-control" name="search" maxlength="100" value="${pager.search}"></td>
																	<td><button type="submit" class="btn btn-danger">검색</button></td>
																</tr>
															</table>
														
														
													</div>
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