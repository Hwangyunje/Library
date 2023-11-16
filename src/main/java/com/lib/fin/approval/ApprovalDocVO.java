package com.lib.fin.approval;

import java.sql.Date;
import java.util.List;

import com.lib.fin.commons.CommonVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovalDocVO extends CommonVO {
	
	private Long doc_no;
	private String emp_no;
	private String grp_cd;
	private String approval_state;
	private String doc_title;
	private String doc_contents;
	private Date start_date;
	private Date end_date;
	private String adtn_info1;
	private String adtn_info2;
	private String adtn_info3;
	private String temp_save;
	
	private String emp_team;
	private String name;
	private String sign_name;

	private List<ApprovalFileVO> fileVOs;
	
	public Date getEnd_date() {
		if(this.end_date == null) {
			return new Date(System.currentTimeMillis());
		}
		
		return this.end_date;
	}
}
