<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<header id="header" class="header fixed-top d-flex align-items-center">

  <div class="d-flex align-items-center justify-content-between">
    <a href="/" class="logo d-flex align-items-center">
      <img src="/assets/img/logo.png" alt="">
      <span class="d-none d-lg-block">NiceAdmin</span>
    </a>
    <i class="bi bi-list toggle-sidebar-btn"></i>
  </div><!-- End Logo -->

<!--   <div class="search-bar">
    <form class="search-form d-flex align-items-center" method="POST" action="#">
      <input type="text" name="query" placeholder="Search" title="Enter search keyword">
      <button type="submit" title="Search"><i class="bi bi-search"></i></button>
    </form>
  </div>End Search Bar -->

  <nav class="header-nav ms-auto">
    <ul class="d-flex align-items-center">

  
      <!--로그인 전-->
  

  <sec:authorize access="!isAuthenticated()">
    <a class="nav-link" href="/member/login" id="login" role="button">
      <!-- <i class="bi bi-arrow-right-circle-fill" style='font-size:24px;color:red'></i> -->
      <button  class="btn btn-primary">로그인</button>
    </a>
  </sec:authorize>



  <!-- 로그인 후 -->
<sec:authorize access="isAuthenticated()">
  <sec:authentication property="principal.emp_position"  var="position"></sec:authentication> 
  <sec:authentication property="principal.name"  var="memberName"></sec:authentication> 
  <li class="nav-item dropdown pe-3">
    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
      <i class="bi bi-award-fill"></i>
   <img src="/static/assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
      <span class="d-none d-md-block dropdown-toggle ps-2">${memberName}님</span>
    </a>

    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
      <li class="dropdown-header">
        <h6>${memberName}</h6>
        <span>${position}</span>
      </li>
      <li>
        <hr class="dropdown-divider">
      </li>
      <li>
        <a class="dropdown-item d-flex align-items-center" href="/member/mypage">
          <i class="bi bi-person"></i>
          <span>My Page</span>
        </a>
      </li>
      <li>
        <hr class="dropdown-divider">
      </li>
      <li>
        <a class="dropdown-item d-flex align-items-center" href="/member/logout">
          <i class="bi bi-box-arrow-right"></i>
          <span>로그아웃</span>
        </a>
      </li>
    </ul>
  </li>
</sec:authorize>
  </nav><!-- End Icons Navigation -->

</header><!-- End Header -->
