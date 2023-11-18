package com.lib.fin.member;

import java.io.File;
import java.lang.reflect.Member;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties.Authentication;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lib.fin.commons.FileManager;
import com.lib.fin.commons.FileManagerProfile;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {
	
	//service 생성자 주입
	@Autowired
	private MemberService memberService;
	@Autowired
	//private FileManager fileManager;
	private FileManagerProfile fileManagerProfile;
	@Autowired
	private PasswordEncoder passwordEncoder;
	//local file 위치
	@Value("${app.upload}")
	private String filePath;
		
	
	//관리자페이지
	@GetMapping("adminPage")
	public String adminPage()throws Exception{
		  return "member/adminPage";
	}
	
	
	//멤버관리자페이지 멤버리스트
	@RequestMapping("adminMemberPage")
	public String AdminMemList(Model model, MemberVO memberVO)throws Exception{
		List<MemberVO> adminMemList = memberService.getAdminMemList(memberVO);
		log.info("=====authorities{}",memberVO.getAuthorities());
		model.addAttribute("adminMemList",adminMemList);
		return "member/adminMemberPage";
	}
	
	//멤버관리자페이지 상세정보
	@RequestMapping("adminDetailPage")
	public String getAdminDetail(@RequestParam("emp_no")String emp_no, Model model)throws Exception{
		MemberVO memberVO = memberService.getAdminDetail(emp_no);
		// memberVO를 adminDetailPage 뷰로 전달
		model.addAttribute("memberVO",memberVO);
		return "member/adminDetailPage";
	}

	
	
//		//멤버 관리자 상세정보 업데이트 페이지
		@GetMapping("adminUpdate")
		public String adminMemUpdate(@RequestParam("emp_no")String emp_no, Model model)throws Exception{
			//emp_no를 사용하여 회원정보가져오기
			MemberVO memberVO = memberService.getAdminDetail(emp_no);
			//memberVO 를 adminUpdate 뷰로 전달
			model.addAttribute("memberVO",memberVO);
			return "member/adminUpdate";
	}
		
		@PostMapping("adminUpdate")
		public String adminMemUpdate(@ModelAttribute MemberVO memberVO)throws Exception{
			int result = memberService.adminMemUpdate(memberVO);
			
			if(result>0) {
				log.info("관리자 멤버 정보 변경 성공");
			}else {
				log.info("관리자 멤버 정보 변경 실패");
			}
			return "member/adminDetailPage";
			//return "redirect:/adminDetailPage?emp_no="+memberVO.getEmp_no();
		}
		
		
	
	
	//멤버리스트
	@GetMapping("memberList")
	public String memList(Model model, MemberVO memberVO)throws Exception{
		List<MemberVO> memberList = memberService.getList(memberVO);
		model.addAttribute("memberList",memberList);
		return "member/memberList";
	}
	
	
	
	//회원가입 페이지 출력 요청
	@GetMapping("join")
	public void memJoin (@ModelAttribute MemberVO memberVO) throws Exception {
		
	}
	
	
	
    @PostMapping("join")
    public String memJoin(@Valid MemberVO memberVO, BindingResult bindingResult,Model model, RedirectAttributes redirectAttributes) throws Exception {
    	boolean check = memberService.getMemberError(memberVO, bindingResult);
    	log.info("===check:{}====", check);
    	if(bindingResult.hasErrors() || check) {
    		log.info("==========실패했습니다==========");
    		return "member/join";
    	}
    	
    	   	
        int result = memberService.memJoin(memberVO, model);
        
        log.info("===result:{}====", result);
        
       
        
        if (result>0) {
            // 회원 가입이 성공한 경우에 대한 처리
            log.info("===========회원 가입이 성공했습니다.=========");
           
            // 최신의 사원번호를 얻어옴
            String empPage = memberService.getNewEmpNo(memberVO);
            memberVO.setEmp_no(empPage);
            
            // 사원번호를 모델에 추가
            model.addAttribute("empPage", memberVO);
            
            return "member/newEmpNo";
        }else {
             
        return "member/join";
        }
     }
  
    
	    @GetMapping("newEmpNo")
	    public String getNewEmpNo(@ModelAttribute("empPage") MemberVO memberVO )throws Exception{
	    	//String empPage = memberService.getNewEmpNo(memberVO);
	    	//memberVO.setEmp_no(empPage);
	    	
	    	log.info("========empPage{}==========",memberVO.getEmp_no());
	    	//model.addAttribute("empPage",memberVO);
	    	return "member/newEmpNo";	
	    }

    
    
    
	@GetMapping("login")
	public String getLogin(@ModelAttribute MemberVO memberVO)throws Exception{
		SecurityContext context = SecurityContextHolder.getContext();
				
		
		String check=context.getAuthentication().getPrincipal().toString();
		
		//String password = context.getAuthentication().getCredentials().toString();
		
		log.info("===== Name : {} =====", context.getAuthentication().getPrincipal().toString());
		
		
		if(!check.equals("anonymousUser")) {
			return "redirect:../";
		}
		
		return "member/login";
		
	}


	
	//마이페이지
	@GetMapping("mypage")
	public String memberInfo(@AuthenticationPrincipal MemberVO memberVO, Model model, String emp_no)throws Exception{
		//프로필 사진 가져오기
		MemberFileVO profileImage = memberService.getMemImage(memberVO.getEmp_no());
		String filePath = "/files/" + profileImage.getFile_name(); // 파일 경로 설정
		model.addAttribute("profileImage",profileImage);
		model.addAttribute("filePath", filePath);
		log.info("===profileImage:{}===",profileImage);
		log.info("===filePath:{}===",filePath);
		model.addAttribute("memberVO",memberVO);
		return "member/mypage";	
	}


	
	//정보수정 프로필 출력, 정보읽어와 뷰로 전달
	@GetMapping("update")
	public String getUpdateMember(@AuthenticationPrincipal MemberVO memberVO, Model model)throws Exception{
		log.info("======정보수정 시도중 ====");
		model.addAttribute("memberVO",memberVO);
		return "member/update";
	}
	
	 @PostMapping("/update")
	    public String postUpdateMember(@Valid MemberVO memberVO, BindingResult bindingResult, Model model,MultipartFile photo)throws Exception {
	        	
		 	boolean check = memberService.getMemberError(memberVO, bindingResult);
			log.info("===업데이트check:{}====", check);
		 	if (bindingResult.hasErrors()||check) {
	            // 유효성 검사 에러가 있을 경우 처리
	            return "member/update";
	        }
		
		 		  	
		 		  	int result = memberService.updateMember(memberVO, photo);

		 	        if (result > 0) {
		 	            log.info("===========프로필 이미지 및 정보 수정이 성공했습니다.=========");
		 	           // log.info("photo : name: {} " , fileName);
		 			 	log.info("photo : size : {} ", photo.getSize());
		 			 	log.info("photo : size : {} ", photo.getOriginalFilename());
		 	            
		 			 	//이미지저장
		 			 	boolean imageResult = memberService.setMemImage(photo, memberVO);
		 			 	MemberFileVO memberFileVO = memberService.getMemImage(memberVO.getEmp_no());
		 				log.info("===업데이트memberFileVO:{}====", memberFileVO.toString());
		 	            model.addAttribute("memberVO", memberVO);
		 	            model.addAttribute("photo",memberFileVO);
		 	           log.info("===업데이트photo:{}====", memberFileVO.getFile_name());
		 	        } else {
		 	            log.info("===========프로필 이미지 또는 정보 수정이 실패했습니다.=========");
		 	            model.addAttribute("error", "프로필 이미지 또는 정보 수정에 실패했습니다.");
		 	        }
		 	  


		 	    return "member/mypage";
	 }
         

	
	@GetMapping("findEmpNo")
	public String findEmpNo()throws Exception {
		return "member/findEmpNo";
	}
	
	
	@PostMapping("findEmpNo")
	public String postFindEmpNo(@RequestParam String name, @RequestParam String phone, Model model)throws Exception{
		MemberVO memberVO = memberService.findEmpNo(name, phone);
		//String emp_no = memberService.findEmpNo(name, phone);
		log.info("=======사원번호:{}=======",memberVO.getName());
		 if (name == null || name.isEmpty() || phone == null || phone.isEmpty()) {
		 model.addAttribute("error", "이름과 전화번호를 입력해야 합니다.");
		 return "member/findEmpNo";
		}
		//이름과 이메일이 일치하지 않으면 에러메세지 띄워주기
		
		if(memberVO != null) {
			model.addAttribute("FindEmpNo",memberVO);
		}else {
			model.addAttribute("error", "해당 사원번호를 찾을 수 없습니다.");
		}
		return "member/empResult";
	}
	
	//비밀번호찾기
	@GetMapping("findPassword")
	public String getFindPassword()throws Exception {
		return "member/findPassword";
	}
	
	@PostMapping("findPassword")
	public String postFindPassword(@RequestParam String emp_no,@RequestParam String email, Model model)throws Exception{
		try {
			//멤버서비스에서 메서드호출
			//서비스 리턴값 반환
			String resultMessage = memberService.findPassword(emp_no, email);
			log.info("=====resultMemssage:{}=======",resultMessage);
			//성공적으로 보낸경우 메시지 모델에 추가
			model.addAttribute("resultMessage", resultMessage);

		} catch (Exception e) {
			// 예외가 발생하면 메세지 모델에 추가
			model.addAttribute("errorMessage",e.getMessage());
			log.error("에러 발생", e);
		}
		return "member/passwordResult";
	}
	
}

