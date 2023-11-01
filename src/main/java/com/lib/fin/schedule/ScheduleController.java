package com.lib.fin.schedule;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView getSchedule() throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> listMap = new HashMap<>();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/schedule/schedule");
		List<Map<String, Object>> events = scheduleService.getScheduleList();
		
		JSONObject json = new JSONObject();
		json.put("List", events );
		
		
		mv.addObject("List" ,json);
		
		
		
		
		return mv;
		 
		 
	}
	
	@PostMapping("add")
	public String setScheduleAdd(HttpServletRequest request, ScheduleVO scheduleVO)throws Exception{ 
			        
		 int result = scheduleService.setScheduleAdd(scheduleVO);
		
		 return "redirect:./schedule";
	}
	
	@GetMapping("scheduleList")
	@ResponseBody
	public JSONObject getEvents(ScheduleVO scheduleVO) throws Exception{
		JSONObject resultJson = new JSONObject();

	    return resultJson;
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