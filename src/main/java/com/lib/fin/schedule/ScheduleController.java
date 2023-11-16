package com.lib.fin.schedule;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lib.fin.commons.CommonJava;
import com.lib.fin.member.MemberVO;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.util.HashMap;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/schedule/*")
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
	@GetMapping("getSchedule")
	public ModelAndView getSchedule(@AuthenticationPrincipal MemberVO memberVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> listMap = new HashMap<>();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/schedule/schedule");
		mv.addObject("emp_no", memberVO.getEmp_no());
		
		/*
		List<Map<String, Object>> events = scheduleService.getScheduleList();

		JSONObject json = new JSONObject();
		json.put("List", events );

		mv.addObject("List" ,json.toJSONString());
*/
		return mv;
		      
		 
	}
	
	@PostMapping("add")
	public String setScheduleAdd(@AuthenticationPrincipal MemberVO memberVO, HttpServletRequest request, ScheduleVO scheduleVO)throws Exception{
			        
		scheduleVO.setEmp_no(memberVO.getEmp_no());
		
		 int result = scheduleService.setScheduleAdd(scheduleVO);
		
		 return "redirect:./getSchedule";
	}
	
	@RequestMapping("scheduleList")
	@ResponseBody
	public void getEvents(@AuthenticationPrincipal MemberVO memberVO,HttpServletRequest request,
								HttpServletResponse response) throws Exception{
		JSONObject resultJson = new JSONObject();
		Map<String, Object> params = CommonJava.getParameterMap(request);
		params.put("EMP_NO",params.get("EMP_NO"));
		List<Map<String, Object>> scheList = scheduleService.getScheduleList(params);

		resultJson.put("list", scheList );
		log.info("한글  {}", scheList);
		response.setCharacterEncoding("UTF-8");
		response .getWriter().write(resultJson.toJSONString());
		
	}
	
	
	@PostMapping("update")
	public String setScheduleUpdate(ScheduleVO scheduleVO)throws Exception{;
		 
		int result = scheduleService.setScheduleUpdate(scheduleVO);
		return "redirect:./schedule";
	}
	
	@PostMapping("delete")
	public String setScheduleDelete(ScheduleVO scheduleVO) throws Exception{
		int result = scheduleService.setScheduleDelete(scheduleVO);
		return "redirect:./schedule";
	}
	

}