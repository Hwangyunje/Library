<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <input type="hidden" id="grp_cd" name="grp_cd" value="B">
    
	<div class="row mx-3 text-center">
				<div class="col-lg-12">
				<table class="table table-bordered">
					<tr>
						<th class="table-light" style="width: 12%">제목</th>
						<td><input type="text" class="form-control w-75" id="doc_title" name="doc_title" value="${docVO.doc_title}"></td>
					</tr>
					<tr>
						<th class="table-light">작성일자</th>
						<td><input type="date" class="form-control w-25" id="startDate" name="start_date" value="${docVO.start_date}"></td>
					</tr>
					
					<tr>
						<th class="table-light"">총금액</th>
						<td>
							<input type="text" class="form-control w-25" id="adtn_info1" name="adtn_info1" value="${docVO.adtn_info1}">
						</td>
					</tr>
				
					<tr >
						<td colspan="2">
							<div>
								<textarea id="summernote" name="doc_contents">${docVO.doc_contents}</textarea>
							</div>
						</td>
						
					</tr>
				</table>	
				</div>
				
			</div>