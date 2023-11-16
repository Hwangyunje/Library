package com.lib.fin.approval;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

@Mapper
public interface ApprovalDAO {
	
	//fileADD
	public int setFileAdd(ApprovalFileVO approvalFileVO)throws Exception;
	
	//draft Add
	public int setDraft(ApprovalDocVO approvalDocVO)throws Exception;
	
	//draft detail
	public ApprovalDocVO getDraftDetail(ApprovalDocVO approvalDocVO)throws Exception;

	//his add
	public int setApprovalHis(ApprovalHisVO approvalHisVO)throws Exception;
	
	//docList
	public List<ApprovalDocVO> getAppDocList(Map<String, Object> params)throws Exception;
	
	public List<ApprovalHisVO> getAppLine(String doc_no)throws Exception;
	
	//결재 히스토리 상태 업데이트
	public int docApproval(Map<String,Object> param)throws Exception;
	
	//결재 상태 업데이트
	public int docBaseApproval(Map<String,Object> param)throws Exception;
	
	//signAdd
	public int addSign(MemberVO memberVO)throws Exception;
	
	//update
	public int setTempUpdate(ApprovalDocVO approvalDocVO)throws Exception;
	
	//결재자 업데이트
	public int setUpdateHis(ApprovalHisVO approvalHisVO)throws Exception;

	public Long getTotal(Map<String, Object> params)throws Exception;
	
	//file detail
	public ApprovalFileVO getFileDetail(ApprovalFileVO approvalFileVO)throws Exception;
	
	//file del
	public int setFileDelete(ApprovalFileVO approvalFileVO)throws Exception;

	public int setAppCancel(String doc_no)throws Exception;
}
