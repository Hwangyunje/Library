package com.lib.fin.approval;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lib.fin.commons.FileManager;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ApprovalService {

	@Value("${app.upload}")
	private String filePath;

	@Value("${app.approval.doc}")
	private String approvalName;

	@Autowired
	private FileManager fileManager;

	@Autowired
	private ApprovalDAO approvalDAO;

	//일반기안
	@Transactional
	public int setDraft(Map<String, String> params,ApprovalDocVO approvalDocVO ,MultipartFile[] files)throws Exception{

		String path = this.filePath+this.approvalName;
		int result= approvalDAO.setDraft(approvalDocVO);

		log.info("===============path: {} =========",path);
		log.info("===============path: {} =========",filePath);
		log.info("===============path: {} =========",approvalName);


		ApprovalHisVO approvalHisVO = new ApprovalHisVO();

		String midApp = params.getOrDefault("midApp","");
		String lastApp = params.getOrDefault("lastApp","");


		//중간 결재자 insert
		if(!"".equals(midApp)) {
			approvalHisVO.setDoc_no(approvalDocVO.getDoc_no());
			approvalHisVO.setEmp_no(midApp);
			approvalHisVO.setApproval_level(1);
			approvalHisVO.setApproval_state(approvalDocVO.getApproval_state());
			approvalHisVO.setReg_id(midApp);
			approvalHisVO.setMod_id(midApp);
			approvalHisVO.setUse_yn("Y");
			result = approvalDAO.setApprovalHis(approvalHisVO);

		}

		//최종결재자 insert
		if(!"".equals(lastApp)) {
			approvalHisVO.setDoc_no(approvalDocVO.getDoc_no());
			approvalHisVO.setEmp_no(lastApp);
			approvalHisVO.setApproval_level(2);
			approvalHisVO.setApproval_state(approvalDocVO.getApproval_state());
			approvalHisVO.setReg_id(lastApp);
			approvalHisVO.setMod_id(lastApp);
			approvalHisVO.setUse_yn("Y");
			result = approvalDAO.setApprovalHis(approvalHisVO);

		}



		if(files != null) {
			for(MultipartFile multipartFile: files) {

				if(multipartFile.isEmpty()) {
					continue;
				}

				ApprovalFileVO approvalFileVO = new ApprovalFileVO();
				String fileName = fileManager.save(path, multipartFile);
				approvalFileVO.setDoc_no(approvalDocVO.getDoc_no());
				approvalFileVO.setFile_name(fileName);
				approvalFileVO.setFile_oriName(multipartFile.getOriginalFilename());
				approvalFileVO.setReg_id(approvalDocVO.getEmp_no());
				approvalFileVO.setMod_id(approvalDocVO.getEmp_no());
				approvalFileVO.setUse_yn("Y");
				result = approvalDAO.setFileAdd(approvalFileVO);


			}

		}

		return result;
	}

	//기안 detail
	public ApprovalDocVO getDraftDetail(ApprovalDocVO approvalDocVO)throws Exception {

		return approvalDAO.getDraftDetail(approvalDocVO);

	}

	//update
	@Transactional
	public int setTempUpdate(Map<String, String> params, ApprovalDocVO approvalDocVO, MultipartFile[] files)throws Exception{
		
		String path = this.filePath+this.approvalName;
		
		log.info("{} ==============", approvalDocVO);
		
		int result = approvalDAO.setTempUpdate(approvalDocVO);
		
		ApprovalHisVO approvalHisVO = new ApprovalHisVO();
		
		String midApp = params.getOrDefault("midApp","");
		String lastApp = params.getOrDefault("lastApp","");
		
		
				//중간 결재자 update
				if(!"".equals(midApp)) {
					approvalHisVO.setDoc_no(approvalDocVO.getDoc_no());
					approvalHisVO.setEmp_no(midApp);
					approvalHisVO.setApproval_level(1);
					approvalHisVO.setApproval_state(approvalDocVO.getApproval_state());
					approvalHisVO.setReg_id(midApp);
					approvalHisVO.setMod_id(midApp);
					
					result = approvalDAO.setUpdateHis(approvalHisVO);
				
				}
				
				//최종결재자 update
				if(!"".equals(lastApp)) {
					approvalHisVO.setDoc_no(approvalDocVO.getDoc_no());
					approvalHisVO.setEmp_no(lastApp);
					approvalHisVO.setApproval_level(2);
					approvalHisVO.setApproval_state(approvalDocVO.getApproval_state());
					approvalHisVO.setReg_id(lastApp);
					approvalHisVO.setMod_id(lastApp);
				
					result = approvalDAO.setUpdateHis(approvalHisVO);
				
				}
		
		
		
		
		
		//파일 업로드
		if(files != null) {
			for(MultipartFile multipartFile: files) {
				
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				ApprovalFileVO approvalFileVO = new ApprovalFileVO();
				String fileName = fileManager.save(path, multipartFile);
				approvalFileVO.setDoc_no(approvalDocVO.getDoc_no());
				approvalFileVO.setFile_name(fileName);
				approvalFileVO.setFile_oriName(multipartFile.getOriginalFilename());
				approvalFileVO.setReg_id(approvalDocVO.getEmp_no());
				approvalFileVO.setMod_id(approvalDocVO.getEmp_no());
				approvalFileVO.setUse_yn("Y");
				result = approvalDAO.setFileAdd(approvalFileVO);
				
				
			}
		}
		
		return result;
		
		
	}
	
	//결제라인
	public List<ApprovalHisVO> getAppLine(String doc_no)throws Exception{
		
		return approvalDAO.getAppLine(doc_no);
	}
	
	//DOCList
	public List<ApprovalDocVO> getAppDocList(Map<String, Object> params, Pager pager)throws Exception{
		
		params.put("pager", pager);
		
		pager.setPerPage(5L);
		pager.makeRowNum2();
		Long total = approvalDAO.getTotal(params);
		pager.makePageNum(total);
		
		
		return approvalDAO.getAppDocList(params);
		
	}
	
	//sign add
	public int addSign(MemberVO memberVO,MultipartFile file)throws Exception{
		String path = this.filePath+"sign";
		
		String fileName = fileManager.save(path, file);
		memberVO.setSign_name(fileName);
		memberVO.setSign_oriName(file.getOriginalFilename());
		int result = approvalDAO.addSign(memberVO);
				
		return result;

	}
	
	//결재 상태 변화
	@Transactional
	public Map<String,Object> docApproval(Map<String,Object> param)throws Exception{
		Map<String,Object> resultMap = new HashMap<>();
				
		
		int resultInt = approvalDAO.docApproval(param); // history
		 
		int resultInt1 = approvalDAO.docBaseApproval(param); //doc
		
		if(resultInt > 0) {
			resultMap.put("code", "0000");
		}else {
			resultMap.put("code", "9999");
		}
		return resultMap;
		
	}
	

	
	//summernote 이미지 업로드
	public String setContentsImg(MultipartFile files) throws Exception{
		
		String path = this.filePath+"docImg";
		String fileName = fileManager.save(path, files);
		return "/files/docImg/"+fileName;
	}
	
	//summernote 이미지 삭제
		public boolean setContentsImgDelete(String path)throws Exception{
			
			FileVO fileVO = new FileVO();
			fileVO.setFile_name(path.substring(path.lastIndexOf("/")+1));
		
			path = this.filePath+"docImg";
			return fileManager.fileDelete(fileVO, path);
		}
		
	//fileDown
		public ApprovalFileVO getFileDetail(ApprovalFileVO approvalFileVO) throws Exception {
			
			
			return approvalDAO.getFileDetail(approvalFileVO);
		}
		
		//fileDelete
		@Transactional
		public int setFileDelete(ApprovalFileVO approvalFileVO)throws Exception{
			String path = this.filePath + this.approvalName;
			
			approvalFileVO = approvalDAO.getFileDetail(approvalFileVO);
			boolean flag = fileManager.fileDelete(approvalFileVO, path);
			
			if(flag) {
				return approvalDAO.setFileDelete(approvalFileVO); //de 삭제
			}
			return 0;
		}
		
		public int setAppCancel(String doc_no)throws Exception{
			
			return approvalDAO.setAppCancel(doc_no);
		}

}
