<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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


			<div class="container">

				<section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				  <div class="container">
					<div class="row justify-content-center">
					  <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
		  
						<div class="d-flex justify-content-center py-4">
						  <a href="index.html" class="logo d-flex align-items-center w-auto">
							<img src="assets/img/logo.png" alt="">
							<span class="d-none d-lg-block">사원번호</span>
						  </a>
						</div><!-- End Logo -->
						

						<div class="card mb-3">
							
						  <div class="card-body">
		  
							<div class="pt-4 pb-2">
							  <h5 class="card-title text-center pb-0 fs-4">
                                사원번호는 <br>
                                <span style="color: red; font-size: large; font-weight: bold;">${FindEmpNo.emp_no}</span><br>
                                입니다.</h5>
							</div>

							  
							  <div class="col-12">
								<button class="btn btn-primary w-100" onclick="location.href='member/login'">Login</button>
							  </div>
					
			
		  
						  </div>
						</div>
					
					
					  </div>
					</div>
				  </div>
		  
				</section>
		  
			  </div>
			
			</div>
	
			

		  </main><!-- End #main -->	

    	 		 
    	 	
    	 	</div>
			 
		</div>
    	
		<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import> 
    
	</div>
    
    

<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>
</body>
</html>