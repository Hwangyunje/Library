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

                        <div class="pt-4 pb-2">
                            <h5 class="card-title text-center pb-0 fs-4" style="font-weight: bold;">비밀번호찾기</h5>
                            <p class="text-center small">사원번호와 회원가입시 입력한 이메일을 입력하세요.<br> 임시 비밀번호를 발급해 드리겠습니다.</p>
                          </div>
				
                          <form action="/member/findPassword" method="post" enctype="multipart/form-data">		 
                         
                            <div class="form-group">
                            <label for="name">사원번호</label>
                            <input type="text" name="emp_no" class="form-control"/>
                          </div>
					
					
				
			
					  <div class="form-group">
						<br>
						<label for="email">이메일</label>
						<input id="email" type="email" name="email"  class="form-control"/>
					</div>

						
				    
				
					<br>
			    <button type="submit" class="btn btn-primary">임시 비밀번호 발급</button> 
                <button type="reset" class="btn btn-danger ">취소</button> 
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