package com.lib.fin.member;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lib.fin.member.MemberVO;

@Mapper
public interface MemberDAO {
	

	//로그인
	//시큐리티
	public MemberVO getLogin(MemberVO memberVO)throws Exception;	
	
	//회원가입
	//int reuslt= memberDAO.memJoin(memberVO); service에서 데이터 타입 
	public int memJoin(MemberVO memberVO)throws Exception;
	
	//회원목록
	public List<MemberVO> getList(MemberVO memberVO)throws Exception;
	
	//관리자 회원목록
	public List<MemberVO> getAdminMemList(MemberVO memberVO)throws Exception;
	
	//관리자 멤버 상세 정보 조회
	public MemberVO getAdminDetail(String emp_no)throws Exception;
	
	//관리자 멤버 정보 변경
	public int adminMemUpdate (MemberVO memberVO)throws Exception;
	
	//image저장
	public int setMemImage(MemberFileVO memberFileVO)throws Exception;
	
	//이미지업데이트
	public void updateMemImage(MemberFileVO memberFileVO)throws Exception;
	
	//이미지파일 출력 가져오기
	public MemberFileVO getMemImage(String emp_no)throws Exception;
	
	//이전프로필사진삭제
	public void deleteMemImage(Long file_no)throws Exception;
	
	//권한부여
	public int setMemberRole(Map<String, Object> map) throws Exception;

	//업데이트
	public int updateMember(MemberVO memberVO)throws Exception;
	
	//사원번호 찾기
	public MemberVO findEmpNo(String name, String phone)throws Exception;
	//비밀번호 찾기
	public MemberVO findPassword(String emp_no,String email) throws Exception;
	
	//임시비밀번호 저장
	public void updateTempPassword(MemberVO memberVO)throws Exception;
	
	//사원번호 
	//public String getNewEmpNo(String emp_no)throws Exception;
	public String getNewEmpNo(MemberVO memberVO)throws Exception;


}
