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
            
                        
                <div class="row"  id="image">
                    <!-- 각 영역 크기조절하기 -->
                    <div class="col-lg-10">
                        <h1>임시 비밀번호 발송</h1>
                        <br><br>
                    
                        <h3>입력하신 이메일로 임시비밀번호를 발송했습니다. 
                            <br>확인 후 로그인 해주세요</h3>
                
                    <br>
                <button type="submit" class="btn btn-primary" onclick="location.href='member/login'">로그인</button> 
                            
                                    

            
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