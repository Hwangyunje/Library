package com.lib.fin.facility;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lib.fin.commons.CommonJava;
import com.lib.fin.commons.Pager;
import com.lib.fin.commons.ProfileImage;
import com.lib.fin.member.MemberVO;
import com.lib.fin.schedule.ScheduleVO;

@Controller
@RequestMapping("/facility/*")
public class FacilityControl {
	@Autowired
	private FacilityService facilityService;
	
	@Autowired
	private ProfileImage profileImage;
		
	@ResponseBody
	@GetMapping("getFacilitylist")
	public List<FacilityVO> getFacilityList(@RequestParam("page") int page, @RequestParam("pageSize") int pageSize, HttpServletRequest ret, @AuthenticationPrincipal MemberVO memberVO, Model model) throws Exception {

		Map<String, Object> params = CommonJava.getParameterMap(ret);
		pageSize = Integer.valueOf((String) params.getOrDefault("rows", "5")) ;
		
		   List<FacilityVO> paginatedList = facilityService.getPaginatedList(page, pageSize);
		   
		   profileImage.addProfileImage(model, memberVO.getEmp_no());
		   return paginatedList;
	}
	
	@GetMapping("facility")
	public ModelAndView getFacility(ModelAndView mv)throws Exception{
		List<FacilityVO> list = facilityService.getFacilityList();
		mv.addObject("list",list);
		mv.setViewName("facility/facilitylist");
		
		return mv;
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

