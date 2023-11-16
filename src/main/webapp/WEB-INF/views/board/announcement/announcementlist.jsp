<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
			<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<title>Insert title here</title>
					<c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import>
				</head>

				<style>
.first {
	position: absolute;
	left: 20%;
}

.second {
	position: absolute;
	right: 7%;
}

.searchCategory {
	display: flex;
}

.searchtext {
	margin-right: 5px;
}

.searchselect {
	margin-left: 3px;
	margin-right: 5px;
}

.searchBtn {
	margin-left: 3px;
}

.board_no {
	width: 5%;
	text-align: center;
}

.board_title {
	width: 35%;
	text-align: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.txt_line {
	width: 70px;
	padding: 0 5px;
	text-align: left;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.reg_id {
	width: 10%;
	text-align: center;
}

.reg_date {
	width: 10%;
	text-align: center;
}

.board_views {
	width: 7%;
	text-align: center;
}

table {
	border-collapse: separate;
	border: solid black 1px;
	border-radius: 6px;
}

td, th {
	border-left: solid black 1px;
	border-top: solid black 1px;
}

th {
	background-color: blue;
	border-top: none;
}

td:first-child, th:first-child {
	border-left: none;
}
.lock{
	max-width: 3%;
	max-height: 3%;
}
</style>

				<body id="page-top">
					<div id="wrapper">

						<c:import url="/WEB-INF/views/layout/sidebar.jsp"></c:import>

						<div id="content-wrapper" class="d-flex flex-column">
							<div id="content">

								<c:import url="/WEB-INF/views/layout/topbar.jsp"></c:import>

								<main id="main" class="main">

									<section class="container mt-5">
										<h1 class="mb-3 text-center">공지사항</h1>

										<table class="table table-Info table-sm">
											<thead>
												<th class="board_no"> 번호 </th>
												<th class="board_title">제목</th>
												<th class="reg_id">작성자</th>
												<th class="reg_date">작성날짜</th>
												<th class="board_views">조회수</th>
											</thead>
											<tbody>
												<c:forEach items="${list}" var="d" varStatus="i">
													<tr>
														<td class="board_no" id="kind_${d.board_no}" data-kind="${d.board_kind}">${d.board_no}</td>
														<td class="kind" id="kind_${d.board_no}" data-kind="${d.board_kind}">
															<c:choose>
																<c:when test='${d.board_kind == "on"}'>
																	<sec:authorize access="hasRole('ADMIN') or ${d.reg_id eq member.emp_no}">
																		<a href="./annDetail?board_no=${d.board_no}">${d.board_title}</a>
																	</sec:authorize>
																	<sec:authorize access="!hasRole('ADMIN') and ${d.reg_id ne member.emp_no}">
																		<img class="lock" src="/assets/img/lock.png" alt="lock">
																		<span>읽기 권한이 없습니다.</span>
																	</sec:authorize>
																</c:when>
																<c:when test='${d.board_kind == "off"}'>
																	<a href="./annDetail?board_no=${d.board_no}">${d.board_title}</a>
																</c:when>
															</c:choose>
														</td>
														<td class="reg_id" id="level">${d.board_wirter}</td>
														<td>${d.reg_date}</td>
														<td class="board_views">${d.board_views}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>

										<nav aria-label="Page navigation example">

											<ul class="pagination">
												<c:if test="${pager.pre}">
													<li class="page-item"><a class="page-link" href="./announcement?page=${pager.startNum-1}" aria-label="Previous">
														<span aria-hidden="true">&laquo;</span>
													</a></li>
												</c:if>
												
												<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
													<li class="page-item <c:if test='${pager.page eq i}'>active</c:if>">
														<a class="page-link" href="./announcement?page=${i}">${i}</a>
													</li>
												</c:forEach>
												
												<c:if test="${pager.next}">
													<li class="page-item"><a class="page-link" href="./announcement?page=${pager.lastNum+1}" aria-label="Next">
														<span aria-hidden="true">&raquo;</span>
													</a></li>
												</c:if>
											</ul>
										</nav>
										
										

										<div class="input-group mb-3 searchCategory first">
											<form action="./announcement" method="get">
												<div class="searchselect">
													<select name="kind" class="form-select" aria-label="Default select example">
														<option value="N">제목</option>
														<option value="W">작성자</option>
													</select>
												</div>
												<div class="searchtext">
													<input type="text" name="search" class="form-control"
														aria-label="Amount (to the nearest dollar)">
												</div>
												<div class="col-auto searchBtn">
													<button type="submit" class="btn btn-info">검색</button>
												</div>
											</form>
										</div>

										
										<a class="btn btn-outline-success second" for="btn-check-outlined"
											href="./addAnn">글쓰기</a>


									</section>
								</main>
							</div>
						</div>
					</div>
					<div>
					<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import>
					<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>
					</div>
					<script src="/js/annlist.js"></script>
				</body>

				</html>