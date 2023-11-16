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
<style type="text/css">
.update-btn{width:80px;
	position:absolute;
	left:970px;
	margin:6px;
	top:80px;
	}
.add-btn{width:80px;
position:relative;
left:1070px;
top:30px
}
.del-btn{width:80px;
position:relative;
left:1170px;
top:0px}
.pagination{
position:relative;
top:180px;
}
.page-item{
position:relative;
left:700px;
}
.title{
text-align:center;
}
.card{
position:relative;
left:0px;
width:1400px;
}
.mt-0{
width:20px;
}
.th-0{
width:40px;
}
.th-1{
width:100px;
}
.th-2{
width:150px;
}
.tg{
position:absolute;
top:130px;
left:150px;
}
.card{width:1400px;height:500px;}
.hstack{width:1100px}
.col-lg-6 {width:1400px }
.tg  {border-collapse:collapse;border-spacing:0;width:1100px;text-align: center;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:center;vertical-align:top;height:10px;}
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
						
						<h1 class="title">공용품리스트</h1>
						
						  <div>
								  <div></div>
								  <div></div>
								  <div></div>
						
								 </div>
						<button type="button" class="add-btn" data-bs-toggle="modal" data-bs-target="#addFacilityModal">추가</button>
													<!-- Modal -->
						<form id="addForm" action="./add" method="post">
							<div class="modal fade" id="addFacilityModal" tabindex="-1" aria-labelledby="addFacilityModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="addFacilityModalLabel">공용품추가</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							       <label for="taskId" class="col-form-label">종류구분</label>
                        				<input type="text" class="form-control" id="grp_cd" name="grp_cd">
									  <label for="taskId" class="col-form-label">상세구분</label>
									  <input type="text" class="form-control" id="cd" name="cd">
							        <label for="taskId" class="col-form-label">공용품명</label>
                        				<input type="text" class="form-control" id="facility_name" name="facility_name">
							        <label for="taskId" class="col-form-label">상세내용</label>
                        				<input type="text" class="form-control" id="facility_contents" name="facility_contents">
							      	<input type="hidden" value="${member.emp_no}" id="reg_id" name="reg_id">
							      	<input type="hidden" value="${member.emp_no}" id="mod_id" name="mod_id">
							      
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <button type="submit" class="btn btn-primary" id="addFacility">추가</button>
							      </div>
							    </div>
							  </div>
							</div>
							</form>
													<!--modal-->
								<form id="deleteForm" action="./delete" method="post">
						<button type="submit" id="del-btn" class="del-btn" onclick="FacilityDelete()">삭제</button>
							
						<table class="tg">
							<thead>
							  <tr>
							    <th class="tg-0pky th-0">선택</th>
							    <th class="tg-0pky th-1">공용품코드</th>
							    <th class="tg-0pky th-1">상세코드</th>
							    <th class="tg-0pky th-2">공용품이름</th>
							    <th class="tg-0pky th-3">상세내용</th>
							  </tr>
							</thead>
							<tbody>
							  <c:forEach items="${list}" var="vo" varStatus="i">
							
							  <tr>
							    <td class="tg-0pky">
							
								    <input class="form-check-input mt-0" name="facility_no" type="checkbox" value="${vo.facility_no}" " aria-label="Checkbox for delete data">
								  
							    </td>
							    </form>
							    <td class="tg-0pky mt-1">${vo.grp_cd}</td>
							    <td class="tg-0pky mt-1">${vo.cd}</td>
							    <td class="tg-0pky mt-2">${vo.facility_name}</td>
							    <td class="tg-0pky mt-3">${vo.facility_contents}</td><br>
										
							</c:forEach>
							 	 <button type="button" class="update-btn" data-bs-toggle="modal" data-bs-target="#updateFacilityModal">수정</button>
							</div>
							</tbody>
													<!-- Modal -->
							<div class="modal fade" id="updateFacilityModal" tabindex="-1" aria-labelledby="updateFacilityModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="updateFacilityModalLabel">공용품수정</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							  
							      		<br>
							      		<input type="hidden" value="member.emp_no" name="mod_id"></input>
							       <label for="taskId" class="col-form-label">종류구분</label>
                        				<input type="text" class="form-control" id="grp_cd" name="grp_cd" value="${vo.grp_cd}">
							        <label for="taskId" class="col-form-label">상세구분</label>
                        				<input type="text" class="form-control" id="cd" name="cd" value="${vo.cd}">
							        <label for="taskId" class="col-form-label">공용품명</label>
                        				<input type="text" class="form-control" id="facility_name" name="facility_name" value="${vo.facility_name}">
							        <label for="taskId" class="col-form-label">상세내용</label>
                        				<input type="text" class="form-control" id="facility_contents" name="facility_contents" value="${vo.facility_contents}">
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <button type="submit" class="btn btn-primary" id="updateFacility">수정</button>
							      </div>
							    </div>
							  </div>
							</div>
							</form>
							  </tr>
												<!-- modal -->
							
							</table>
							<nav aria-label="Page navigation example">
											<ul class="pagination">
												<c:if test="${pager.pre}">
													<li class="page-item"><a class="page-link"
															href="./facilitylist?page=${pager.startNum-1}"
															aria-label="Previous">
															<span aria-hidden="true">◁</span>
														</a></li>
												</c:if>
												<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
													<li class="page-item"><a class="page-link"
															href="./facilitylist?page=${i}">${i}</a></li>
												</c:forEach>
												<c:if test="${pager.next}">
													<li class="page-item"><a class="page-link"
															href="./facilitylist?page=${pager.lastNum+1}" aria-label="Next">
															<span aria-hidden="true">▷</span>
														</a></li>
												</c:if>
											</ul>
										</nav>
							
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
<script src="/js/facility.js"></script>
</body>
</html>