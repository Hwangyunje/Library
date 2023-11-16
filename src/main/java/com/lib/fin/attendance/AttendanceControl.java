package com.lib.fin.attendance;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lib.fin.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

import java.util.Map;
import java.util.HashMap;
@Controller
@Slf4j
@RequestMapping("/attendance/*")
public class AttendanceControl {
	@Autowired
	private AttendanceService attendanceService;
	
	DateTimeFormatter dayff = DateTimeFormatter.ofPattern("yy-MM"); //날짜 패턴 변경
	DateTimeFormatter dayfff = DateTimeFormatter.ofPattern("yy/MM"); //날짜 패턴 변경
	DateTimeFormatter dayf = DateTimeFormatter.ofPattern("yy-MM-dd"); //날짜 패턴 변경
	LocalDateTime now = LocalDateTime.now(); //현재 시간
	
	
	@GetMapping("attendanceHome")
	public String getAttendance()throws Exception{
		return "attendance/attendanceHome";
	}
	@GetMapping("checkWorkTime.do")
	public ResponseEntity<AttendanceVO> checkWorkTime(Authentication authentication) {
		 MemberVO principal = (MemberVO) authentication.getPrincipal();
		 String emp_no = principal.getEmp_no();
		 String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
		 Map<String,Object> param = new HashMap<>();
		 param.put("emp_no", emp_no);
		 param.put("time", time);
		 
		 AttendanceVO work = attendanceService.checkWorkTime(param);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(work);
	}
	
	//출근하기 버튼 누를시 근무 시작 일시,시간 저장
	@ResponseBody
	@PostMapping("insertStartWork.do")
	public ResponseEntity<?> insertStartWork(Authentication authentication) {
	    MemberVO principal = (MemberVO) authentication.getPrincipal();
	    String emp_no = principal.getEmp_no();
	    String time = now.format(dayf); //현재날짜를 yy/MM/dd 형식으로 변경
	    Map<String,Object> param = new HashMap<>();
	    Map<String,Object> state = new HashMap<>();
	    log.debug(time);
	    param.put("emp_no", emp_no);
	    param.put("time", time);

	    AttendanceVO work = attendanceService.checkWorkTime(param); //금일 출근기록이 있는지 확인

	    if(work == null) {
	        int result = attendanceService.insertStartWork(emp_no); // insert
	        state.put("status", "성공");
	    }else if(work.getStatus().equals("반차")) {
	    	int result = attendanceService.updateStartWork(param); //반차일시 반차 행 update
			state.put("status", "성공");
		}else if(work.getStatus().equals("출장")) {
			state.put("status", "출장");
		}else if(work.getStatus().equals("연차")) {
			state.put("status", "연차");
	    }else {
	        state.put("status", "실패");
	    }
	    
	    return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(state)
				;
	}
	
	//퇴근하기 버튼 누를시 퇴근시간 update
	@PostMapping("updateEndWork.do")
	public ResponseEntity<?> updateEndWork(Authentication authentication){
		MemberVO principal = (MemberVO) authentication.getPrincipal();
		String emp_no = principal.getEmp_no();
		String time = now.format(dayf);
		Map<String,Object> param = new HashMap<>();
		Map<String,Object> status = new HashMap<>();
		param.put("emp_no", emp_no);
		param.put("time", time);
		 
		AttendanceVO work = attendanceService.checkWorkTime(param);
		log.debug("work = {}",work);
		
		if(work!=null) {
			status.put("status","출근전");
		}else if(work.getStatus().equals("출장")) {
			status.put("status", "출장");
		}else if(work.getStatus().equals("연차")) {
			status.put("status", "연차");
		}
		else if(work.getLw_time() == null || work.getStatus().equals("반차")) {
			//퇴근시간 업데이트
			int result = attendanceService.updateEndWork(param);
			status.put("status", "성공");	
		}
		else {
			 status.put("status", "실패");
		}
			
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(status);
	}
	
	//퇴근버튼 눌렀을시 오늘 근무시간 업데이트
	@PostMapping("updateDayWorkTime.do")
	public ResponseEntity<?> updateDayWorkTime(Long daytimes, Authentication authentication) {
		log.debug("daytime = {}", daytimes);
		
		long daytime = daytimes; // 기본근무시간
		long overtime = 0; //연장근무시간
		
		// 5시간 이상 일했을 시 점심시간 1시간 제외
		if(daytimes > 18000000) {
			daytime = daytimes - 3600000;
		}
		
		//근무시간이 8시간이 넘었을때 기본근무시간과 연장근무시간 처리
		if(daytime > 28800000) {
			overtime = daytime - 28800000;
			daytime = 28800000;
		}
		
	  	MemberVO principal = (MemberVO) authentication.getPrincipal();
		String emp_no = principal.getEmp_no();
		String time = now.format(dayf);
		
		Map<String,Object> param = new HashMap<>();
		param.put("emp_no", emp_no);
		param.put("time", time);
		param.put("daytime", daytime);
		param.put("overtime", overtime);
		
		AttendanceVO work = attendanceService.checkWorkTime(param);
		int result = 0;
		if(work.getStatus().equals("반차")) {
			result = attendanceService.updateDayWorkTimeHalf(param); //반차 근무시간 업데이트시 4시간 추가 
		}else {
			result = attendanceService.updateDayWorkTime(param); // 금일 근무시간 업데이트
		}
		
		Map<String,Object> state = new HashMap<>();
		if(result > 0)
			state.put("state", "성공");	
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(state);
	}
	@GetMapping("weekTotalTime.do")
	public ResponseEntity<?> weekTotalTime(String start, String end, Authentication authentication){
		log.debug("start = {}",start);
		log.debug("end = {}",end);
		MemberVO principal = (MemberVO) authentication.getPrincipal();
		String emp_no = principal.getEmp_no();
		
		String monthTime = now.format(dayfff);
		
		
		Map<String,Object> param = new HashMap<>();
		Map<String,Object> time = new HashMap<>();
		param.put("emp_no", emp_no);
		param.put("start", start);
		param.put("end", end);
		param.put("monthTime", monthTime);
		
		// 금주 누적시간 가져오기
		int weekTotalTime = attendanceService.weekTotalTime(param);
		time.put("weekTotalTime",weekTotalTime);
		
		// 금주 연장시간 가져오기
		int weekOverTime = attendanceService.selectWeekOverTime(param);
		time.put("weekOverTime",weekOverTime);
		
		
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(time);
	}
}
