package com.lib.fin.approval;

import java.security.Provider.Service;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.AssertFalse.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lib.fin.commons.CommonJava;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

import io.netty.handler.codec.http.HttpRequest;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/approval/*")
@Slf4j
public class ApprovalController {

	@Autowired
	private ApprovalService approvalService;
	
	@ModelAttribute("name")
	public String getApproval() {
		return "doc";
	}
	

	// 기안
	@GetMapping("draft")
	public String setDraft(@AuthenticationPrincipal MemberVO memberVO, Model model) throws Exception {

		model.addAttribute("member", memberVO);

		return "approval/draft";
	}

	@PostMapping("draft")
	public String setDraft(@AuthenticationPrincipal MemberVO memberVO, @RequestParam("midApp") String midApp,
			@RequestParam("lastApp") String lastApp, ApprovalDocVO approvalDocVO, MultipartFile[] files1)
			throws Exception {

		// 결재자 정보 받음
		Map<String, String> params = new HashMap<>();
		params.put("midApp", midApp);
		params.put("lastApp", lastApp);

		approvalDocVO.setEmp_no(memberVO.getEmp_no());
		approvalDocVO.setReg_id(memberVO.getEmp_no());
		approvalDocVO.setMod_id(memberVO.getEmp_no());
		approvalDocVO.setUse_yn("Y");

		approvalService.setDraft(params, approvalDocVO, files1);

		return "redirect:list?k=com";
	}

	// 기안 detail
	@GetMapping("draftDetail")
	public String getDraftDetail(@AuthenticationPrincipal MemberVO memberVO, ApprovalDocVO approvalDocVO, Model model,
			String k) throws Exception {
		log.info("Kind = {} ", k);
		// 기안문서 정보 가져오기
		approvalDocVO = approvalService.getDraftDetail(approvalDocVO);

		String doc_no = approvalDocVO.getDoc_no().toString();

		// 결재자 정보가져오기
		java.util.List<ApprovalHisVO> ar = approvalService.getAppLine(doc_no);

		// 로그인한 사원번호 담기
		model.addAttribute("loginEmpNo", memberVO.getEmp_no());

		// 모델에 중간,최종 결재자 담기
		for (int i = 0; i < ar.size(); i++) {
			ApprovalHisVO approvalHisVO = ar.get(i);
			model.addAttribute("appLine" + i, approvalHisVO);
		}

		// approvalDocVO 담기
		model.addAttribute("docVO", approvalDocVO);
		return "approval/draftDetail";
	}

	// 기안 list
	@GetMapping("list")
	public String getAppDocList(@AuthenticationPrincipal MemberVO memberVO, Model model, String k, Pager pager)
			throws Exception {

		String kindName = "";
		if (k.equals("ready")) {
			kindName = "결재대기 문서";
		} else if (k.equals("com")) {
			kindName = "기안문서함";
		} else if (k.equals("temp")) {
			kindName = "임시문서함";
		} else {
			kindName = "결재문서함";
		}
		model.addAttribute("kindName", kindName);
		String emp_no = memberVO.getEmp_no(); // 세션에서 사번 꺼내오기

		Map<String, Object> paramas = new HashMap<>();
		paramas.put("emp_no", emp_no);
		paramas.put("k", k);

		java.util.List<ApprovalDocVO> ar = approvalService.getAppDocList(paramas, pager);
		model.addAttribute("list", ar);
		model.addAttribute("pager", pager);

		return "approval/comDocList";
	}

	// 문서 업데이트
	@GetMapping("update")
	public String setTempUpdate(@AuthenticationPrincipal MemberVO memberVO, ApprovalDocVO approvalDocVO, Model model)
			throws Exception {

		// 기안문서 정보 가져오기
		approvalDocVO = approvalService.getDraftDetail(approvalDocVO);

		// approvalDocVO 담기
		model.addAttribute("docVO", approvalDocVO);

		return "approval/update";
	}

	@PostMapping("update")
	public String setTempUpdate(@AuthenticationPrincipal MemberVO memberVO, @RequestParam("midApp") String midApp,
			@RequestParam("lastApp") String lastApp, ApprovalDocVO approvalDocVO, MultipartFile[] files1)
			throws Exception {

		// 결재자 정보 받음
		Map<String, String> params = new HashMap<>();
		params.put("midApp", midApp);
		params.put("lastApp", lastApp);

		// 세션에서 수정자 사번 받기
		approvalDocVO.setEmp_no(memberVO.getEmp_no());
		// mapper에서 쓰기위해
		approvalDocVO.setGrp_cd(approvalDocVO.getGrp_cd() + "1");

		approvalService.setTempUpdate(params, approvalDocVO, files1);

		return "redirect:list?k=com";
	}

	// 싸인등록
	@GetMapping("addSign")
	public String setSign() throws Exception {

		return "approval/signAdd";

	}

	@PostMapping("addSign")
	public String addSign(@AuthenticationPrincipal MemberVO memberVO, MultipartFile file) throws Exception {

		approvalService.addSign(memberVO, file);
		return "approval/signAdd";

	}

	// 상태 변경
	@RequestMapping("docApproval")
	@ResponseBody
	public Map<String, Object> docApproval(HttpServletRequest request) throws Exception {

		Map<String, Object> params = CommonJava.getParameterMap(request);
		Map<String, Object> resultMap = new HashMap<>();

		resultMap = approvalService.docApproval(params);

		return resultMap;

	}

	// summernote 이미지 업로드
	@PostMapping("setContentsImg")
	@ResponseBody
	public String setContentsImg(MultipartFile files, Model model) throws Exception {

		String path = approvalService.setContentsImg(files);
		

		return path;
	}

	//summernote이미지 삭제
	@PostMapping("setContentsImgDelete")
	@ResponseBody
	public Boolean setContentsImgDelete(String path, Model model) throws Exception {

		
		  boolean check = approvalService.setContentsImgDelete(path);
		 
		return check;

	}
	//파일다운
	@GetMapping("fileDown")
	public String getFileDown(ApprovalFileVO approvalFileVO,Model model)throws Exception {
		
		approvalFileVO = approvalService.getFileDetail(approvalFileVO);
		
		
		model.addAttribute("fileVO",approvalFileVO);
		return "fileDownView";
		
	}
	
	//파일삭제
	@GetMapping("fileDelete")
	public String setFileDelete(ApprovalFileVO approvalFileVO, Model model)throws Exception{
		
		int result = approvalService.setFileDelete(approvalFileVO);
		model.addAttribute("result",result);
		return "commons/ajaxResult";
	}
	
	@PostMapping("AppCancel")
	@ResponseBody
	public int setAppCancel(String doc_no)throws Exception{
		
		int result =  approvalService.setAppCancel(doc_no);
		return result;
		
	}
	
	

}
