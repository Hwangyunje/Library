<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

		<div class="row mx-3" id="Body">
			<div class="col-lg-12">
				<table class="table table-bordered">
					<tr>
						<th class="table-light" style="width: 10%">시행일자</th>
						<td>${docVO.start_date}</td>
					</tr>
					
					<tr>
						<th class="table-light">제목</th>
						<td>${docVO.doc_title}</td>
					</tr>
					<tr>
						<td colspan="2">
							<div>
								${docVO.doc_contents}
							</div >
						</td>
	
					</tr>
				</table>
			</div>
	
		</div>