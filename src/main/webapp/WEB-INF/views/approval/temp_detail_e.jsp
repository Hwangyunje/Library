<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<div class="row mx-3">
	
		<div class="col-lg-12">
		<table class="table table-bordered Ttable">
			<tr>
				<th class="table-light" style="width: 12%">제목</th>
				<td>${docVO.doc_title}</td>
			</tr>
			<tr>
				<th class="table-light">작성일자</th>
				<td>${docVO.start_date}</td>
			</tr>
			<tr>
				<th class="table-light">작성자</th>
				<td>${docVO.name}</td>
			</tr>
			<tr>
				<th class="table-light"">총금액</th>
				
				<td>
				${docVO.adtn_info1}
					
				</td>
			</tr>
		

			<tr >
				<td colspan="2"> ${docVO.doc_contents}</td>
				
			</tr>
		</table>	
		</div>
		
	</div>