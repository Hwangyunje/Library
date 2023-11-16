<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <input type="hidden" id="grp_cd" name="grp_cd" value="A">
			<div class="row mx-3" id="Body">
				<div class="col-lg-12">
					<table class="table table-bordered">
						<tr>
							<th class="table-light" style="width: 10%">시행일자</th>
							<td><input type="date" class="form-control w-25" id="startDate" name="start_date" value="${docVO.start_date}"></td>
						</tr>
						
						<tr>
							<th class="table-light">제목</th>
							<td><input type="text" class="form-control w-75" id="title" name="doc_title" value="${docVO.doc_title}"></td>
						</tr>
						<tr>
							<td colspan="2">
								<div>
									<textarea id="summernote" name="doc_contents">${docVO.doc_contents}</textarea>
								</div>
							</td>

						</tr>
					</table>
				</div>

			</div>