		$('#btnGetMem').click(function() {

			
			$("#readyMem").empty(); //조직도 비우기
			$('#memList').empty();	//사원정보 비우기
			$('#fLine').empty();	//중간승인자 비우기
			$('#lLine').empty();	//최종승인자 비우기
			
			$.ajax({
				url:"/dept/getDeptInfo"
				,data:{}
				,dateType:"json"
				,method:"post"
				,success:function(data){
					console.log(data);
					
					
					
					let readyMemElement = $("#readyMem");
					
					let ul = $("<ul>"); 

					
					for (let i = 0; i < data.length; i++) {
					    let deptName = data[i].cd_nm;
					    
					    
					    let id = 'a' + i;
		                
		                let li = '<div id="' + id + '" class="mt-3 memList"><li>' + deptName + '</li></div>';
					    
					    
					    ul.append(li);
					}

					
					readyMemElement.append(ul);
					
					       
				}
				
			});
			
			
			

		});
		
		
		//이벤트 위임 부서 클릭시		
  		   $("#readyMem").on("click", ".memList", function () {
			 
  			   
  			 let deptName = $(this).text();
  			 
  			 
  			//부서 클릭시 emp_name값가져옴
  			let emp_team = getDeptList(deptName);
  	
	
			   $.ajax({
					url:"/dept/getEmpInfo"
					,data:{
						emp_team:emp_team
					}
					,method:"post"
					,success:function(data){
						console.log(data);
						
						$('#memList').empty();
						
						
						
				        // 머리글을 변수에 저장
				        let tableHeader = '<thead><tr>' +
				            '<th></th>' +
				            '<th>이름</th>' +
				            '<th>직책</th>' +
				            '<th>부서</th>' +
				            '</tr></thead>';

				        // 테이블 시작 태그
				        let tableStart = '<table class="table table1">';
				        $('#memList').append(tableStart);

				        // 테이블 머리글 추가
				        $('.table1').append(tableHeader);

				        // 테이블 본문 시작 태그
				        $('.table1').append('<tbody>');

				        for (let i = 0; i < data.length; i++) {
				            let emp = data[i];

				            let newRow = '<tr>' +
				                '<td><input type="radio" name="selectNm" value="' + emp.emp_no + '"></td>' +
				                '<td>' + emp.name + '</td>' +
				                '<td>' + emp.emp_position + '</td>' +
				                '<td>' + emp.emp_team + '</td>' +
				                '</tr>';

				            // 테이블 본문에 행 추가
				            $('.table1').append(newRow);
				        }

				        // 테이블 본문 종료 태그
				        $('.table1').append('</tbody>');

				        // 테이블 종료 태그
				        $('#memList').append('</table>');
						}
					,
					error: function(error) {
						console.log('Error:', error);
						
						
						       
					}
					
				});
	 
	        }); 
		
  		 function getDeptList(deptName) {
  		    let emp_team = "";

  		    switch (deptName) {
  		  		case "대표":
	            	emp_team = "A";
	            	break;
  		    	
  		        case "운영과":
  		            emp_team = "B";
  		            break;
  		        case "정책과":
  		            emp_team = "C";
  		            break;
  		        case "서비스과":
  		            emp_team = "D";
  		            break;
  		        case "가발령":
  		            emp_team = "E";
  		            break;
  		    }

  		    return emp_team;
  		}

  		//중간결재자 화살표 클릭시
  		$("#midAW").click(function() {
  		    // 체크된 항목을 가져오기
  		    $("#fLine").empty();
  		    let selectedEmps = [];
  		    $("#memList input[name='selectNm']:checked").each(function() {
  		    	
  		    	
  		        // 여기서 "emp" 객체로 변환
  		        let emp = {
  		        	emp_no:$(this).val(),
  		            name: $(this).closest('tr').find('td:eq(1)').text(), // emp.name 가져오기
  		            emp_position: $(this).closest('tr').find('td:eq(2)').text(), // emp.emp_position 가져오기
  		            emp_team: $(this).closest('tr').find('td:eq(3)').text() // emp.emp_team 가져오기
  		        };
  		        selectedEmps.push(emp);
  		       
  		    });
  		    
	  		  let fLine = $("#fLine");
			    for (let emp of selectedEmps) {
			        let newRow = '<div><table class="table">' +
			            '<tr id="midEmpNo" data-mid-empNo="'+ emp.emp_no+'"><td id="mn">' + emp.name + '</td>' +
			            '<td id="mp">' + emp.emp_position + '</td>' +
			            '<td>' + emp.emp_team + '</td>' +
			            '<td><span id="fx">x</span></td></tr></table></div>';
			        fLine.append(newRow);
			    }

  		});
  		
  	  	
  		//최종결재자 화살표 클릭시
  		$("#lastAW").click(function() {
  		    // 체크된 항목을 가져오기
  		    $("#lLine").empty();
  		    let selectedEmps = [];
  		    $("#memList input[name='selectNm']:checked").each(function() {
  		    	
  		        // 여기서 "emp" 객체로 변환
  		        let emp = {
  		        	emp_no:$(this).val(),
  		            name: $(this).closest('tr').find('td:eq(1)').text(), // emp.name 가져오기
  		            emp_position: $(this).closest('tr').find('td:eq(2)').text(), // emp.emp_position 가져오기
  		            emp_team: $(this).closest('tr').find('td:eq(3)').text() // emp.emp_team 가져오기
  		        };
  		        selectedEmps.push(emp);
  		        
  		     	
  		    });
  		    
  		    
	  		  let lLine = $("#lLine");
	  		  
			    for (let emp of selectedEmps) {
			        let newRow = '<div><table class="table">' +
			            '<tr id="lastEmpNo" data-last-empNo="'+ emp.emp_no+'"><td id="ln">' + emp.name + '</td>' +
			            '<td id="lp">' + emp.emp_position + '</td>' +
			            '<td>' + emp.emp_team + '</td>' +
			            '<td><span id="lx">x</span></td></tr></table></div>';
			        lLine.append(newRow);
			       
			    }

  		});
  		
  		
  		
  		$("#fLine").on('click', '#fx', function () {
  		    $(this).parent().parent().parent().remove(); 
  		});
  		
  		$("#lLine").on('click', '#lx', function () {
  		    $(this).parent().parent().parent().remove(); 
  		});
  			

	
		$('#modalSave').click(function() {
			
			    $('#midP').text($('#mp').text()+" "+$("#mn").text());
			    $('#lastP').text($('#lp').text()+" "+$("#ln").text());
			
			    let midApp =$("#midEmpNo").attr("data-mid-empNo");
			    let lastApp =$("#lastEmpNo").attr("data-last-empNo");
			 
			    $("#midApp").val(midApp);
			    $("#lastApp").val(lastApp);
			    
			   
			     
			$('#basicModal').modal("hide");
			
			
		});