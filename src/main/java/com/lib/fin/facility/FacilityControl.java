package com.lib.fin.facility;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;
import com.lib.fin.schedule.ScheduleVO;

@Controller
@RequestMapping("/facility/*")
public class FacilityControl {
	@Autowired
	private FacilityService facilityService;
	
	@GetMapping("getFacilitylist")
	public String getFacilityList(@AuthenticationPrincipal MemberVO memberVO,String f,Pager pager,Model model) throws Exception {
		
		String emp_no = memberVO.getEmp_no();
		
		Map<String, Object> params = new HashMap<>();
		params.put("emp_no", emp_no);
		params.put("F", f);
		
		List<FacilityVO> ar=facilityService.getFacilityList(params, pager);
		model.addAttribute("list",ar);
		model.addAttribute("pager",pager);
		
		return "facility/facilitylist";
	}
	@PostMapping("add")
	public String setFacilityAdd(HttpServletRequest request, FacilityVO facilityVO)throws Exception{ 
			        
		 int result = facilityService.setFacilityAdd(facilityVO);
		
		 return "redirect:./getFacilitylist";
	}
		
	
	@PostMapping("update")
	public String setFacilityUpdate(FacilityVO facilityVO)throws Exception{;
		 
		int result = facilityService.setFacilityUpdate(facilityVO);
		return "redirect:./getFacilitylist";
	}
	
	@PostMapping("delete")
	public String setFacilityDelete(FacilityVO facilityVO) throws Exception{
		int result = facilityService.setFacilityDelete(facilityVO);
		return "redirect:./getFacilitylist";
	}
	

}

