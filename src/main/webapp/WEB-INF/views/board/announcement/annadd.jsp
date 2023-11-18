<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import>
</head>
<style>
    .btn-danger {
        float: right;
        margin-bottom: 30px;
        margin-right: 30px;
    }

    .btn-secondary {
        float: right;
        margin-bottom: 30px;
        margin-right: 10px;
    }

    .col-sm-12 {
        text-align: center;
    }

    .col-sm-8 {
        margin-left: 17%;
        margin-top: 5%;
    }

    .a {
        display: flex;
        justify-content: space-between;
    }
</style>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/layout/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/layout/topbar.jsp"></c:import>
                <main id="main" class="main">
                    <section class="section dashboard">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="row col-sm-8">
                                        <h2 class="font-weight-bold text-primary heading">공지사항</h2>
                                    </div>
                                    <div class="row col-sm-8">
                                        <form id="announcementForm" action="/board/addAnn" method="post" enctype="multipart/form-data">
                                            <div class="mb-3" style="width: 100%;">
                                                <label for="board_title" class="form-label">Title</label>
                                                <input type="text" class="form-control" name="board_title" id="board_title" placeholder="제목을 입력하세요">
                                            </div>
                                            <div class="mb-3" style="width: 100%;">
                                                <label for="board_writer" class="form-label">Writer</label>
                                                <input type="text" class="form-control" name="board_writer" id="board_writer" value="${member.emp_no}" readonly>
                                            </div>
                                            <div class="form-check form-check-inline mt-3">
                                                <input class="form-check-input" type="checkbox" name="board_kind" id="board_kind">
                                                <label class="form-check-label">비밀글 설정</label>
                                            </div>
                                            <div class="mb-3" style="width: 100%;">
                                                <label for="board_content" class="form-label">Contents</label>
                                                <textarea class="form-control" id="board_content" name="board_content" rows="17"></textarea>
                                            </div>
                                            <div id="fileList"></div>
                                            <div class="mb-3">
                                                <button type="button" class="btn btn-outline-primary" id="fileAdd">File 추가</button>
                                            </div>
                                            <button class="btn btn-danger" id="add_btn">등록</button>
                                            <button class="btn btn-secondary" id="add_cancel">취소</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="row mx-3 my-3">
                                    <div class="col-lg-12">
                                
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </main>
            </div>
        </div>
    </div>
    <c:import url="/WEB-INF/views/layout/footer.jsp"></c:import>
    <c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>
    <script src="/js/boardnote.js"></script>
</body>
</html>
