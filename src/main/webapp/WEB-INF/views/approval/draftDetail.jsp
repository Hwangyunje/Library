<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSP에서 properties이 메세지를 사용할 수 있도록 하는 API -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/layout/headCSS.jsp"></c:import>



<link href="/css/doc.css" rel="stylesheet">
</head>


<body id="page-top">
		<sec:authentication property="principal" var="vo"></sec:authentication> 
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- sidebar -->
		<c:import url="/WEB-INF/views/layout/sidebar.jsp"></c:import>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<c:import url="/WEB-INF/views/layout/topbar.jsp"></c:import>

				<main id="main" class="main">

					<section class="section dashboard">

						<div class="container">
							
		
	

								<div class="row">
									<!-- 각 영역 크기조절하기 -->
									<div class="col-lg-12">
										<div class="card">
											<h1 class="my-5 " align="center">
												<c:choose>
												<c:when test="${docVO.grp_cd eq 'H'}">
												휴가신청서
												</c:when>
												<c:when test="${docVO.grp_cd eq 'B'}">
												지출결의서
												
												</c:when>
												<c:otherwise>
												업무 기안
												
												</c:otherwise>
												</c:choose>
											</h1>

											<!-- 상단 왼쪽 strart -->
											<div class="row grid text-center mx-3">
												<div class="col-lg-2">
													<table class="table table-bordered">

														<tr>
															<th class="table-light">기안자</th>
															<td >${docVO.name}</td>
														</tr>


														<tr>
															<th class="table-light">소속</th>
															
															<td>
																${docVO.emp_team}
															</td>
														</tr>

														<tr>
															<th class="table-light">기안일</th>
															<td> ${docVO.reg_date}</td>
														</tr>
														<tr>
															<th class="table-light">문서번호</th>
															<td>${docVO.doc_no}</td>
														</tr>

													</table>


												</div>
												<!-- 상단 왼쪽 end -->
												<div class="col-lg-4"></div>

												<!-- 신청 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">신청</th>
															
														</tr>


														<tr id="sign">
															<td><img id="sign_img" src="/files/sign/${docVO.sign_name}"></td>
														</tr>
														
														<tr>

															<td>${docVO.emp_team} ${docVO.name}</td>
														</tr>


													</table>


												</div>


												<!-- 신청 end -->
												<!-- 중간 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">중간</th>
															
														</tr>


														<tr>
														
														 <td id="midSign"></td>
															
														</tr>
														<tr>

															<td id="midP" data-midEmp="${appLine0.emp_no}">${appLine0.emp_team} ${appLine0.name}</td>
														</tr>


													</table>


												</div>


												<!-- 상단 오른쪽 end -->
												<!-- 상단 오른쪽 strart -->

												<div class="col-lg-2">
													<table class="table table-bordered custom_table">

														<tr>
															<th class="table-light">최종</th>
															
														</tr>


														<tr >
														
															<td id="lastSign"></td>
														</tr>
														
														<tr>
															<td id="lastP" data-lastEmp="${appLine1.emp_no}">${appLine1.emp_team} ${appLine1.name}</td>
														</tr>

													</table>


												</div>


												<!-- 상단 오른쪽 end -->
											</div>

										
											<!-- 본문 -->
											<c:choose>
												<c:when test="${docVO.grp_cd eq 'A'}">
													<c:import url="./temp_detail_d.jsp"></c:import>
												</c:when>
												<c:when test="${docVO.grp_cd eq 'B'}">
													<c:import url="./temp_detail_e.jsp"></c:import>
												</c:when>
												<c:otherwise>
													<c:import url="./temp_detail_l.jsp"></c:import>
												</c:otherwise>
											</c:choose>
											
											<!-- 본문 end  -->

											<div class="row mx-3 my-3">
												<div class="col-lg-12">

													<!-- file -->

													<div id="fileList" ></div>


													<!-- button  -->
													<div class="btn-group my-3" role="group" aria-label="Document Approval Buttons">
														<button type="button" id="btn_appr" style="display:none" class="btn btn-primary btn-sm mx-1">승인</button>
														<button type="button" id="btn_refusal"  style="display:none" class="btn btn-primary btn-sm mx-1">반려</button>
														<button type="button"  id="btn_cancle" style="display:none" class="btn btn-primary btn-sm mx-1">기안취소</button>
													    <a class="btn btn-primary btn-sm mx-1" id="re" style="display:none" href="./update?doc_no=${docVO.doc_no}">재기안</a>
														<a class="btn btn-primary btn-sm mx-1" href="./list?k=${param.k}">목록</a>
													
													</div>
									 				<c:forEach items="${docVO.fileVOs}" var="f">
														<div>첨부파일 <a href="./fileDown?file_no=${f.file_no}">${f.file_oriName}</a><div>
													</c:forEach> 

												</div>


											</div>



										</div>


									</div>




								</div>
						

						</div>
			</div>


			</section>

			</main>
			<!-- End #main -->

		



		</div>

	</div>

	<c:import url="/WEB-INF/views/layout/footer.jsp"></c:import>

	</div>



	<c:import url="/WEB-INF/views/layout/footjs.jsp"></c:import>

	<script type="text/javascript">
	let midEmpNo = $("#midP").attr("data-midEmp"); //중간결재자 사원번호
	let lastEmpNo = $("#lastP").attr("data-lastEmp"); //최종결재자 사원번호
	let loginEmpNo = "${loginEmpNo}"; // 로그인 사원번호
	let docWriter = "${docVO.emp_no}"; // 작성자 사원번호
	let stateLv1 = "${appLine0.approval_state}"; //중간결재자 상태
	let stateLv2 = "${appLine1.approval_state}"; //최종결재자 상태
	let empNoLv1 = "${appLine0.emp_no}"; //중간결재자 사원번호
	let empNoLv2 = "${appLine1.emp_no}"; // 최종결재자사원번호
	let doc_no = "${docVO.doc_no}";
	
	console.log("midEmpNo:", midEmpNo);
	console.log("lastEmpNo:", lastEmpNo);
	console.log("loginEmpNo:", loginEmpNo);
	console.log("docWriter:", docWriter);
	console.log("stateLv1:", stateLv1);
	console.log("stateLv2:", stateLv2);
	console.log("empNoLv1:", empNoLv1);
	console.log("empNoLv2:", empNoLv2);
	console.log("doc_no", doc_no);
	
	$(document).ready(function(){
		
		//로그인한 사람과 작성자가같다면
		if(loginEmpNo == docWriter){
			if((stateLv1=="R" && stateLv2 =="R") || (stateLv1=="C" || stateLv2 =="C")){
				$("#btn_cancle").css("display","block"); //결재취소 버튼 보여줌
				$("#re").css("display","block"); //결재취소 버튼 보여줌
				
			}
		}else if(midEmpNo == loginEmpNo){   //중간결재자와 로그인한사람이 같다면
			if(stateLv1 =="R"){ 			//중간결재 상태가 대기 라면
				$("#btn_appr").css("display","block");  	//결재승인
				$("#btn_refusal").css("display","block");	//반려
			}
		}else if(lastEmpNo == loginEmpNo){ //최종결재자와 로그인한사람이 같다면
			if(stateLv1 =="S" && stateLv2 =="R"){  //중간 승인, 최종 대기
				$("#btn_appr").css("display","block");
				$("#btn_refusal").css("display","block");
			}
		}
		
		if(stateLv1 =="S"){ //중간결재자 승인상태면
			var strHtml = "<img id='sign_img' src='/files/sign/${appLine0.sign_name}'>";
			
			$("#midSign").append(strHtml);
				
		}else if(stateLv1 == "C"){  //중간결재자가 반려상태면
			var strHtml = "<img id='sign_img' src='/files/sign/반려.jpg'>";
			
			$("#midSign").append(strHtml);
		}
		
		
		if(stateLv2 =="S"){// 최종결재자가 승인 상태면
			var strHtml = "<img id='sign_img' src='/files/sign/${appLine1.sign_name}'>";
			
			$("#lastSign").append(strHtml);		
		}else if(stateLv2 == "C"){  //중간결재자가 반려상태면
			var strHtml = "<img id='sign_img' src='/files/sign/반려.jpg'>";
			
			$("#lastSign").append(strHtml);
		}
		
		 // 승인 버튼 클릭 이벤트
        $("#btn_appr").on("click", function () {
        	doc_approval("S"); //승인
        });

        // 반려 버튼 클릭 이벤트
        $("#btn_refusal").on("click", function () {
        	doc_approval("C"); //반려
        	

        });

        // 기안취소 버튼 클릭 이벤트
        $("#btn_cancle").on("click", function () {
          
            $.ajax({
        		type:'post',
        		url:"/approval/AppCancel",
        		data : {
        			doc_no : doc_no
        			
        		}, 
			   success:function(result){
				   console.log(result)
				   if(result ==1){
				
					window.location.replace("/approval/list?k=${param.k}"); 
				   }
			   },
			   error:function(){
					alert("다시시도해주세요.");
			   }
        	}) 
        });
		

	});
	
	function doc_approval(val){
		var flag = ""; // approval_doc State 바꾸기 위함
		if(loginEmpNo == empNoLv1 ){
			flag = "G"; //진행
		}else if(loginEmpNo == empNoLv2 ){
			flag = "O"; // 완료
		}else if(val == 'C'){
			flag = "C" //반려
		}
		
		$.ajax({
			type: "post",
			url : "/approval/docApproval",
			data: {
					"approval_state":val, 
					"EMP_NO" : loginEmpNo, 
					"DOC_NO" : doc_no,
					"flag" : flag
					},
			dataType:"json" , 
			success: function(result){
				console.log(result);
				if(result.code="0000"){
					location.reload();
				}else{
					alert("다시시도해주세요.");
				}
			},
			error:function(){  
	            //에러가 났을 경우 실행시킬 코드
			}
		})
	}
	
	</script>
	<script src="/js/file.js"></script>

</body>

</html>