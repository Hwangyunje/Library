package com.lib.fin.member;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.lib.fin.commons.CommonVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Getter
@Setter
@ToString
@Slf4j
public class MemberVO extends CommonVO implements UserDetails{
	
	private String emp_no;

	@NotBlank(message = "비밀번호를 입력하세요")
//	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\\\W)(?=\\\\S+$).{6,12}", message = "비밀번호는 6~12자 영문 소문자, 숫자, 특수문자를 하나 이상 포함해야 합니다.")
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}", message = "비밀번호는 6~12자 영문 소문자, 숫자, 특수문자를 하나 이상 포함해야 합니다.")
	
	private String password;
	
	private String passwordCheck;
	
	@NotBlank(message = "이름을 입력하세요.")
	private String name;
	@Email(message = "이메일 형식에 맞지 않습니다.")
	private String email;
	
	private Date birth;
	@NotBlank(message = "핸드폰 번호를 입력하세요")
	private String phone;
	
	private String emp_team;
	
	private String emp_position;
	
	private int remain_holiday;
	
	private Date emp_in_date;
	
	private Date emp_out_date;
	
	private String sign_oriName;

	private String sign_name;

	
	private List<RoleVO> roleVOs = new ArrayList<>();


	
	
//	@Override
//	public Collection<? extends GrantedAuthority> getAuthorities() {
//		// TODO Auto-generated method stub
//		return null;
//	}
		@Override
		public Collection<? extends GrantedAuthority> getAuthorities() {
			List<GrantedAuthority> authorities = new ArrayList<>();
			
			// mem_info와 role 조인 시킨 곳에서 authority 이부분에서 권한이 확인가능
			// 직책 변경 시 권한 변경
			if ("A".equals(emp_position) || "B".equals(emp_position)) {
				authorities.add(new SimpleGrantedAuthority("ADMIN"));
			} else {
				authorities.add(new SimpleGrantedAuthority("USER"));
			}
			for(RoleVO roleVO:roleVOs) {
				authorities.add(new SimpleGrantedAuthority(roleVO.getRoleName()));
				log.info("=====role{}====",roleVO.getRoleName());
			}
			
			return authorities;
		}

    // 시큐리티의 userName
    // -> 따라서 얘는 인증할 때 id를 봄
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return emp_no;
	}
	////
    @Override
	public String getPassword() {
		return password;
	}

    
    
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}


	

	
	
	
}
