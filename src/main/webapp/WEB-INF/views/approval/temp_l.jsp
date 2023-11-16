<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<input type="hidden" id="grp_cd" name="grp_cd" value="H">
<input type="hidden" id="adtn_info3" name="adtn_info3" value="">
<div class="row mx-3 text-center">
	<div class="col-lg-12">
		<table class="table table-bordered">
			<tr>
				<th class="table-light" style="width: 12%">제목</th>
				<td><input type="text" class="form-control w-75" id="title" name="doc_title" value="${docVO.doc_title}"></td>
			</tr>
			<tr>
				<th class="table-light">휴가종류</th>
				<td><select class="form-select"
					aria-label="Default select example" name="adtn_info1" id="leaveVal" value="${docVO.adtn_info1}" >
						<option id="leaveVal1" value="B">연차</option>
						<option id="leaveVal2" value="A">조퇴</option>
						<option id="leaveVal3"value="C">반차</option>
				</select></td>
			</tr>
			<tr>
				<th class="table-light">기간 및 일시</th>
				<td>
					<div style="display: flex; gap: 10px;">
						<input type="date" class="form-control w-25" id="startDate"
							name="start_date" value="${docVO.start_date}"> <span>~</span> <input type="date"
							class="form-control w-25" id="endDate" name="end_date" value="${docVO.end_date}" >
					</div>
				</td>
			</tr>
			<tr>
				<th class="table-light">반차</th>
				<td>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="adtn_info2"
							id="inlineRadio1" value="오전"> <label
							class="form-check-label" for="inlineRadio1">오전</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="adtn_info2"
							id="inlineRadio2" value="오후"> <label
							class="form-check-label" for="inlineRadio2">오후</label>
					</div>

				</td>
			</tr>
			<tr>
				<th class="table-light">연차일수</th>

				<td>잔여연차: <span id="id1"><sec:authentication property="principal.remain_holiday" /></span>   신청연차:<span id="id2"></span>
				</td>
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

<script>



	 $(document).ready(function () {
		 
		 
	        // 페이지 로드 시 실행되는 초기화 코드
	        toggleHalfDayOptions();
	        updateVacationDays();

	        // 휴가 종류가 변경될 때 실행되는 이벤트 핸들러
	        $("#leaveVal").change(function () {
	            toggleHalfDayOptions();
	            updateVacationDays();
	        });

	        // 날짜가 변경될 때 실행되는 이벤트 핸들러
	        $("#startDate, #endDate").change(function () {
	            updateVacationDays();
	        });

	        function toggleHalfDayOptions() {
	            let leaveType = $("#leaveVal").val();
	            let halfDayOptions = $("input[name='adtn_info2']");

	            if (leaveType === "C") { // "C"는 반차
	                halfDayOptions.prop("disabled", false); // 활성화
	            } else {
	                halfDayOptions.prop("disabled", true); // 비활성화
	            }
	        }

	        function updateVacationDays() {
	            let leaveType = $("#leaveVal").val();
	            let startDate = new Date($("#startDate").val());
	            let endDate = new Date($("#endDate").val());
	            
	            
	            if (leaveType === "B") { // 연차
	                var daysDiff = (endDate - startDate) / (1000 * 60 * 60 * 24)+1;
	                $("#id2").text(daysDiff);
	            } else if (leaveType === "A") { // 조퇴
	                $("#id2").text("0");
	            } else if (leaveType === "C") { // 반차
	                var daysDiff = (endDate - startDate) / (1000 * 60 * 60 * 24) * 0.5 +0.5;
	               
	                $("#id2").text(daysDiff);
	                
	            }
	            
	            $("#adtn_info3").val(daysDiff);
	        }
	        
	      

	    });
	 
	 
	 

     
	  

</script>