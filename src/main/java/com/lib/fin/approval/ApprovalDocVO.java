package com.lib.fin.approval;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApprovalDocVO {
	
	private Integer doc_no;
	private String emp_no;
	private String grp_cd;
	private String approval_state;
	private String doc_title;
	private String doc_contents;
	private Date start_date;
	private Date end_date;
	private String adtn_info1;
	private String adtn_info2;
	private String temp_save;
	private String reg_id;
	private String mod_id;
	private Date reg_date;
	private Date mod_date;
	private String use_yn;
	

}
