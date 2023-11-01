<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link " href="/">
          <i class="bi bi-grid"></i>
          <span>Home</span>
        </a>
      </li><!-- End Dashboard Nav -->

      
      <li class="nav-heading">인사관리</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-people-fill"></i><span>조직체계</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="forms-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="forms-elements.html">
              <i class="bi bi-circle"></i><span>사원 리스트</span>
            </a>
          </li>
          <li>
            <a href="forms-layouts.html">
              <i class="bi bi-circle"></i><span>부서 리스트</span>
            </a>
          </li>
          <li>
            <a href="forms-editors.html">
              <i class="bi bi-circle"></i><span>차트</span>
            </a>
          </li>
          
        </ul>
      </li><!-- End Forms Nav -->

      <li class="nav-heading">전자결재</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#approval_new" data-bs-toggle="collapse">
          <i class="bi bi-pencil-square"></i><span>새결재</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="approval_new" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="/approval/draft">
              <i class="bi bi-circle"></i><span>업무기안</span>
            </a>
          </li>
          <li>
            <a href="/approval/leave">
              <i class="bi bi-circle"></i><span>휴가신청서</span>
            </a>
          </li>
          <li>
            <a href="/approval/expense">
              <i class="bi bi-circle"></i><span>지출결의서</span>
            </a>
          </li>
        
        </ul>
      </li><!-- End Components Nav -->

      <li class="nav-item">
        <!--data-bs-target="#approval_nav", id="approval_nav" 이름 다르게 설정하면 동시에 열리지 않음.-->
        <a class="nav-link collapsed" data-bs-target="#approval_nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-ui-checks"></i><span>결재하기</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="approval_nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>결재 대기 문서</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>결재 예정 문서</span>
            </a>
          </li>
          
        
        </ul>
      </li><!-- End Components Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#approval_doc" data-bs-toggle="collapse" href="#">
          <i class="bi bi-files"></i><span>개인문서함</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="approval_doc" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>기안 문서함</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>임시 문서함</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>참조 문서함</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>결재 문서함</span>
            </a>
          </li>
        
        </ul>
      </li><!-- End Components Nav -->



      <li class="nav-heading">근태관리</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" href="/attendance/attendance">
          <i class="bi bi-layout-text-window-reverse"></i><span>근태관리</span>
        </a>
 
      </li><!-- End Tables Nav -->

      <li class="nav-heading">게시판</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-clipboard"></i><span>게시판</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="charts-chartjs.html">
              <i class="bi bi-circle"></i><span>공지사항</span>
            </a>
          </li>
          <li>
            <a href="charts-apexcharts.html">
              <i class="bi bi-circle"></i><span>자유 게시판</span>
            </a>
          </li>
         
        </ul>
      </li><!-- End Charts Nav -->

      <li class="nav-heading">예약</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#icons-nav" href="/schedule/schedule">
          <i class="bi bi-gem"></i><span>예약하기</span>
        </a>
        
      </li><!-- End Icons Nav -->

      <li class="nav-heading">관리</li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav01" data-bs-toggle="collapse" href="#">
          <i class="bi bi-box-seam-fill"></i><span>물품 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav01" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="/book/booklist">
              <i class="bi bi-circle"></i><span>도서 관리</span>
            </a>
          </li>
          <li>
            <a href="/facility/facilitylist">
              <i class="bi bi-circle"></i><span>공용품 관리</span>
            </a>
          </li>
         
        </ul>
      </li><!-- End Charts Nav -->

    </ul>

  </aside><!-- End Sidebar-->