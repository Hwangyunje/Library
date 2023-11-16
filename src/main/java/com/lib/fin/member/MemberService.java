	package com.lib.fin.member;
	
	import java.io.File;
import java.lang.reflect.Member;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.security.core.userdetails.User;
	import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.AutoConfiguration;
	import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties.Authentication;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
	import org.springframework.security.core.context.SecurityContextHolder;
	import org.springframework.security.core.userdetails.UserDetails;
	import org.springframework.security.core.userdetails.UserDetailsService;
	import org.springframework.security.core.userdetails.UsernameNotFoundException;
	import org.springframework.security.crypto.factory.PasswordEncoderFactories;
	import org.springframework.security.crypto.password.PasswordEncoder;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
	import org.springframework.web.multipart.MultipartFile;

import com.lib.fin.commons.FileManager;
import com.lib.fin.commons.FileManagerProfile;

import lombok.extern.slf4j.Slf4j;
	
	@Service
	@Slf4j
	public class MemberService implements UserDetailsService {
	
	
		//DAO
		@Autowired
		private MemberDAO memberDAO;
		
		@Autowired
		//private FileManager fileManager;
		private FileManagerProfile fileManagerProfile;
		//이메일 전송	


		@Autowired
		private JavaMailSender mailSender;
		//보내는사람
		@Value("${spring.mail.username}")
		private String sender;

		
		@Autowired
		private PasswordEncoder passwordEncoder;
		
		//local file 위치
		@Value("${app.upload}")
		private String filePath;
			
	

	
		//관리자멤버리스트
		   public List<MemberVO> getAdminMemList(MemberVO memberVO)throws Exception {
		        List<MemberVO> getAdminMemList = memberDAO.getAdminMemList(memberVO);
		        return getAdminMemList;
		    }
	   //관리자 멤버 상세정보
		   public MemberVO getAdminDetail(String emp_no) throws Exception {
		        return memberDAO.getAdminDetail(emp_no);
		    }
		   

		//관리자 멤버 정보 업데이트
		  public int adminMemUpdate(MemberVO memberVO)throws Exception{
			  return memberDAO.adminMemUpdate(memberVO);
		  }
		   
		
		//멤버리스트
		   public List<MemberVO> getList(MemberVO memberVO)throws Exception {
		        List<MemberVO> list = memberDAO.getList(memberVO);
		        return list;
		    }
		   
		
	
		//검증메서드
		public boolean getMemberError(MemberVO memberVO, BindingResult bindingResult) throws Exception{
			boolean check = false; 
			//false = error가 없다, true = error가 있다. 검증실패
			
			//password 일치 검증
			if(memberVO.getPassword() != null && memberVO.getPassword().equals(memberVO.getPasswordCheck())) {
				check=false; // 비밀번호가 비어있지않고 패스워드가 패스워드체크랑 같다면 일치
			}else {	
				//비밀번호 누락 or 불일치
				check=true;
				bindingResult.rejectValue("passwordCheck", "password.mismatch", "비밀번호가 일치해야 합니다.");
			}
				
			
			return check;
		}
		


		//회원가입
		 @Transactional(rollbackFor = Exception.class)
		    public int memJoin(MemberVO memberVO, Model model) throws Exception {
		        memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));
			 	
		        // 회원 정보 저장
		        int result = memberDAO.memJoin(memberVO);
		        Map<String, Object> map = new HashMap<>();
		        map.put("roleNum",memberVO.getEmp_position());
		        result = memberDAO.setMemberRole(map);
	        return result;
		    }   
		 	
		 //사원번호페이지
//		 public String getNewEmpNo(String emp_no)throws Exception{
//			
//			 //MemberVO EmpNo = new MemberVO(memberVO.getEmp_no());
//			 MemberVO EmpNo = memberDAO.getNewEmpNo(null)
//			 log.info("====사원번호페이지:{}=====", emp_no);
//			 
//			 return emp_no; 
//			 
//		 }
//	
		 public String getNewEmpNo(MemberVO memberVO)throws Exception{
			String EmpNo = memberDAO.getNewEmpNo(memberVO);	
			 log.info("====사원번호페이지:{}=====", EmpNo);
			 return EmpNo; 
			 
		 }
	
		
		 
		 //이미지저장
		 public boolean setMemImage(MultipartFile photo, MemberVO memberVO)throws Exception{
			boolean flag = true;
		 		
		 		//String path =filePath +photo;
			
				String saveFileName = fileManagerProfile.save(filePath, photo, memberVO);
		 		log.info("===saveFileName{}=========",saveFileName);
		 		log.info("===이미지사원번호{}=========",memberVO.getEmp_no());
	   
			   try {
				   //이미지가져오기
				   MemberFileVO existImage = memberDAO.getMemImage(memberVO.getEmp_no());
				   
				   if(photo != null) {
					   //이전에 설정한 프로필 사진 삭제
					   if (existImage != null) { // 기존회원 이미지 변경시
						   existImage = memberDAO.getMemImage(memberVO.getEmp_no());
				            String filePath = "C:/STS4/upload/"; // 파일 경로 
				            File existFile = new File(filePath + existImage.getFile_name());
				          
				     	   //이미지 존재하면 업데이트
							   //emp_no는 String , file_no는 Long이라 valueOf사용, db에 long타입 emp_no로 저장
							   existImage.setFile_no(Long.valueOf(memberVO.getEmp_no()));
							   existImage.setFile_name(saveFileName);
							   existImage.setEmp_no(memberVO.getEmp_no());
							   existImage.setFile_oriName(photo.getOriginalFilename());
					           existImage.setMod_id(memberVO.getEmp_no());
					           existImage.setReg_id(memberVO.getEmp_no());
					           existImage.setUse_yn("Y");
					           memberDAO.updateMemImage(existImage);
					           
					           flag=false;
				        }else {//새로운 이미지 올릴때
				        	  //이미지없으면 추가
							   MemberFileVO memberFileVO = new MemberFileVO();
							   log.info("===memberFileVO{}=========",memberFileVO);
							   memberFileVO.setFile_no(Long.valueOf(memberVO.getEmp_no()));
							   log.info("===memberFileVO{}=========",memberFileVO.getFile_no());
							   memberFileVO.setEmp_no(memberVO.getEmp_no());
							   memberFileVO.setFile_name(saveFileName);
							   memberFileVO.setFile_oriName(photo.getOriginalFilename());
							   memberFileVO.setReg_id(memberVO.getEmp_no());
							   memberFileVO.setMod_id(memberVO.getEmp_no());
							   memberFileVO.setUse_yn("Y");
							   log.info("======{}====",memberFileVO);
							   //DB에 저장
							   memberDAO.setMemImage(memberFileVO);
							   
				        }
				
				   } else {
					   log.info("=====사진없음=====");
				   }
				
			} catch (Exception e) {
				log.info("파일업로드실패"+e.getMessage());
		
			}
			return flag;
		}
	
		
		//프로필사진보기
		public MemberFileVO getMemImage(String emp_no)throws Exception{
			return memberDAO.getMemImage(emp_no);
		}
		//프로필이미지 존재시 업데이트
		public void updateMemImage(MemberFileVO memberFileVO)throws Exception{
			memberDAO.updateMemImage(memberFileVO);
		}
		        
		 
			//로그인
			@Override
			public UserDetails loadUserByUsername(String emp_no) throws UsernameNotFoundException {
				// TODO Auto-generated method stub
				log.info("====== 로그인 시도 중 ==========");
				MemberVO memberVO = new MemberVO();
				memberVO.setEmp_no(emp_no);

			
				
				try {
					memberVO = memberDAO.getLogin(memberVO);

					log.info("====== 로그인 시도 중  {}==========",memberVO);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					memberVO=null;
				}
				
				List<GrantedAuthority> authorities = new ArrayList<>();
				for(RoleVO roleVO : memberVO.getRoleVOs()) {
					authorities.add(new SimpleGrantedAuthority(roleVO.getRoleName()));
				}

				
				log.info("=====권한보기{}=====", authorities);
				return memberVO;
				
			}
		
			
			//업데이트
			@Transactional(rollbackFor = Exception.class)
			public int updateMember(MemberVO memberVO, MultipartFile photo)throws Exception{
				  //MemberVO updatedMember = new MemberVO();
				  MemberVO updatedMember = memberDAO.getLogin(memberVO);
				  
				  // 기존 정보를 유지하도록 설정
				  memberVO.setEmp_team(updatedMember.getEmp_team());
				  memberVO.setEmp_position(updatedMember.getEmp_position());
				  memberVO.setBirth(updatedMember.getBirth());
				  
				  log.info("===업데이트시 사원번호:{}===", memberVO.getEmp_no());
				  log.info("===업데이트시 생일:{}===", memberVO.getBirth());
				  log.info("===업데이트시 부서:{}===", memberVO.getEmp_team());
				  
				  
				  // 비밀번호가 입력된 경우에만 업데이트
			    if (memberVO.getPassword() != null && !memberVO.getPassword().isEmpty()) {
			        // 비밀번호 변경, 암호화처리
			    	String encodedPassword = passwordEncoder.encode(memberVO.getPassword());
			        memberVO.setPassword(encodedPassword);
			    }else {
			    	//비밀번호 변경하지않을경우 null로 설정해서 업데이트에서 제외
			    	memberVO.setPassword(null);
			    }
			    
			    //이메일과 전화번호
			    //이메일이 null이 아니고 비어있지않으면 이메일 업데이트 처리
			    if(memberVO.getEmail() != null && !memberVO.getEmail().isEmpty()) {
			    	memberVO.setEmail(memberVO.getEmail());
			    }else {
			    	//수정 안할 시 이전 이메일
			    	memberVO.setEmail(memberVO.getEmail());
			    }
			    //전화번호가 null이 아니고 비어있지 않으면 전화번호 업데이트 처리
			    if (memberVO.getPhone() != null && !memberVO.getPhone().isEmpty()) {
			    	memberVO.setPhone(memberVO.getPhone());
			    }else {
			    	memberVO.setPhone(null);
			    }
			    if(memberVO.getBirth()==null) {
			    	memberVO.setBirth(memberVO.getBirth());
			    }
			    if(memberVO.getEmp_team()==null) {
			    	memberVO.setEmp_team(memberVO.getEmp_team());
			    }
			    if(memberVO.getBirth()==null) {
			    	memberVO.setEmp_position(memberVO.getEmp_position());
			    }
				log.info("====정보수정중{}====", memberVO);
				
				int result = memberDAO.updateMember(memberVO);
				
				  
				  if (result==1) {
				      return result;
				  } else {
				      return 0;
				  }
				
			   //return result;
			}
	

			   //아이디찾기
			   public MemberVO  findEmpNo(String name, String phone)throws Exception{
				   log.info(phone);
				   log.info(name);
				   return memberDAO.findEmpNo(name, phone);
				   
			   }
			   
				   //비밀번호 찾기
				   public String findPassword(String emp_no, String email)throws Exception{
					   
					   MemberVO memberVO = memberDAO.findPassword(emp_no, email);
					   
					   if(memberVO == null) {
						   throw new UsernameNotFoundException("이메일과 일치하는 사용자를 찾지 못 하였습니다 :"+ email);
					   }else {
						//임시비밀번호 암호화
						//String tempPassword = passwordEncoder.encode(createTempPassword());
						String tempPassword = createTempPassword();
						log.info("====임시번호{}====",tempPassword);
						//임시비밀번호 저장
						//MemberVO saveTempPassword = new MemberVO();
						memberVO.setPassword(tempPassword);
						//이메일 정보 저장
						memberVO.setEmail(email);
						//saveTempPassword.setPassword(tempPassword);
					    //임시비밀번호 db업데이트
	
						memberDAO.updateTempPassword(memberVO);
				        log.info("====임시번호memberVO:{}====",memberVO.toString());
				               
			            MimeMessage mimeMessage = mailSender.createMimeMessage();
			            MimeMessageHelper  helper = new MimeMessageHelper(mimeMessage, "UTF-8");
			            helper.setFrom(sender);
			            log.info("===보낼Email:{}======", sender);
			            helper.setTo(memberVO.getEmail());
			            log.info("===받을Email:{}======", memberVO.getEmail());
			            helper.setSubject(memberVO.getEmp_no()+"님 임시 비밀번호 발급입니다.");//이메일제목
			            
			            // 개행 문자를 이용하여 여러 줄로 나눠서 메일 내용을 구성.. \n 줄바꿈
			            String emailText = 	"임시비밀번호 입니다.\n\n" +
			                                  tempPassword + "\n\n" +
			                                  "로그인 후 비밀번호를 변경해 주세요.";
			            helper.setText(emailText);
			            
			            log.info("====임시번호2:{}====",tempPassword);
			            mailSender.send(mimeMessage);
//			            //메세지 생성하고 보낼 메일 설정 저장
//			            //javamailsender 클래스
//			            SimpleMailMessage message = new SimpleMailMessage();
//			          
//			            message.setTo(email);//받을이메일
//			            message.setFrom(sender);//보내는사람
//			            log.info("====보내는사람:{}====",sender);
//			            message.setSubject(memberVO.getName()+" :님 임시 비밀번호 발급입니다.");//이메일제목
//			            message.setText("임시비밀번호 입니다. 로그인 후 비밀번호를 변경해 주세요: " + tempPassword);
//			            
//			            javaMailSender.send(message);
//			            log.info("====메일메시지발송{}====",message.toString());

			            return "임시 비밀번호를 이메일로 보냅니다.";
			        }
			    }
				   
				   public static String createTempPassword() {
					    char pwCollectionSpCha[] = new char[] {'!', '@', '#', '$', '%', '^', '&', '*', '(', ')'};
					    char pwCollectionNum[] = new char[] {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
					    char pwCollectionAll[] = new char[] {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
					            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
					            '!', '@', '#', '$', '%', '^', '&', '*', '(', ')'};
					    return getRandPw(1, pwCollectionSpCha) + getRandPw(8, pwCollectionAll) + getRandPw(1, pwCollectionNum);
					}

					public static String getRandPw(int size, char[] pwCollection) {
					    String ranPw = "";
					    for (int i = 0; i < size; i++) {
					        int selectRandomPw = (int) (Math.random() * (pwCollection.length));
					        ranPw += pwCollection[selectRandomPw];
					    }
					    return ranPw;
					}

			   
			   

				  

			   
}
