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
<style>
.add-btn{width:80px;
position:relative;
left:1050px;
top:20px}
.title{
text-align: center;
}
.del-btn{width:80px;
position:relative;
left:1150px;
top:-10px}
.card{width:1400px}
.col-lg-6 {width:1400px }
.tg  {border-collapse:collapse;border-spacing:0;width:1080px;position:relative;left:150px;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0lax{text-align:left;vertical-align:top}
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
						
 						<h1 class="title">도서목록</h1>
						
						<button type="button" class="add-btn" data-bs-toggle="modal" data-bs-target="#addBookModal">추가</button>
													<!-- Modal -->
						<form id="addForm" action="./add" method="post">
							<div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="addBookModalLabel">도서추가</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							      		<input type="hidden" value="${member.emp_no}" id="reg_id" name="reg_id">
							      		<input type="hidden" value="${member.emp_no}" id="mod_id" name="mod_id">
							       <label for="taskId" class="col-form-label">도서명</label>
                        				<input type="text" class="form-control" id="book_name" name="book_name">
							        <label for="taskId" class="col-form-label">저자명</label>
                        				<input type="text" class="form-control" id="book_author" name="book_author">
							        <label for="taskId" class="col-form-label">발행처</label>
                        				<input type="text" class="form-control" id="book_publisher" name="book_publisher">
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <button type="submit" class="btn btn-primary" id="addBook">추가</button>
							      </div>
							    </div>
							  </div>
							</div>
							</form>
							<form id="deleteForm" action="./delete" method="post">
						<button type="submit" id="del" class="del-btn">폐기</button>
						
						<table class="tg">
							<thead>
							  <tr>
							    <th class="tg-0lax">선택</th>
							    <th class="tg-0lax">도서번호</th>
							    <th class="tg-0lax">도서명</th>
							    <th class="tg-0lax">저자명</th>
							    <th class="tg-0lax">발행처</th>
							    <th class="tg-0lax">입고일</th>
							  </tr>
							</thead>
							<tbody>
							 <c:forEach items="${list}" var="vo">
							  <tr>
							    <td class="tg-0lax">
							    <input class="form-check-input mt-0" name="book_no" type="checkbox" value="${vo.book_no}" " aria-label="Checkbox for delete data">
							    </td>
							    </form>
							    <td class="tg-0lax">${vo.book_no}</td>
							    <td class="tg-0lax">${vo.book_name}</td>
							    <td class="tg-0lax">${vo.book_author}</td>
							    <td class="tg-0lax">${vo.book_publisher}</td>
							    <td class="tg-0lax">${vo.reg_date}</td>
							   </tr>
							   </c:forEach>
							</tbody>
							</table>
						
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
<script>


                        $(document).ready(function () {
                            $("#grid").jqGrid({

                                url: "/book/getBooklist", // 데이터를 가져올 서버 엔드포인트의 URL
                                datatype: "json", // 데이터 타입을 JSON으로 설정
                                colNames: ['도서번호', '도서명', '저자명', '발행처', '입고일'],
                                colModel: [
                                    {
                                        name: 'book_no',
                                        index: 'book_no', 
                                        hidedlg : true,
                                        width: 50, 
                                        align: 'center'
                                    },

                                    { 
                                        name: 'book_name', 
                                        index: 'book_name', 
                                        width: 200 
                                    },
                                    { 
                                        name: 'board_author', 
                                        index: 'board_author',
                                         width: 100, 
                                         align: 'center' 
                                        },
                                    { 
                                        name: 'book_publisher', 
                                        index: 'book_publisher', 
                                        width: 80,
                                         align: 'center' 
                                    },
                                    { 
                                        name: 'reg_date', 
                                        index: 'reg_date', 
                                        width: 70, 
                                        align: 'center' 
                                    }
                                ],
                                rowNum: 10,
                                rowList: [10, 15, 20],
                                pager: '#pager',
                                viewrecords: true,
                                autowidth: true,
                                height: 'auto',
                                pgbuttons:true,
                                onCellSelect: function (rowid, index, contents, event) {
                                    var data = $(this).jqGrid('getGridParam', 'colModel');
                                    if (data[index].name == "book_name") {
                                        var id = $("#grid").jqGrid("getGridParam", "selrow");

                                        var rowData = $("#grid").jqGrid("getRowData", id);
                                        let no = rowData.book_no;

                                        $.ajax({
                                            url: "./booklist?" + no,
                                            type: "get",
                                            data: {
                                                book_no: rowData.book_no
                                            },
                                            success: function (data) {
                                                if (no !== null && no !== undefined) {
                                                    location.replace("./booklist?book_no=" + no);
                                                }

                                            },
                                            error: function () {
                                                console.log("error");
                                            }
                                        });
                                    }
                                }
                            }).navGrid('#pager', {
                                search: true,
                                edit: true,
                                add: true,
                                del: true
                            });
                            $("#grid").jqGrid('filterToolbar', { searchOperators: true, stringResult: true, searchOnEnter: true });

                        });
                    </script>
</body>
</html>