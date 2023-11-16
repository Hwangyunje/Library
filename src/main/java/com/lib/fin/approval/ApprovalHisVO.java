package com.lib.fin.approval;

import com.lib.fin.commons.CommonVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApprovalHisVO extends CommonVO{
	
	private Long approval_no;
	private String emp_no;
	private Long doc_no;
	private Integer approval_level;
	private String approval_state;
	
	private String name;
	private String emp_team; 
	private String sign_name;

}
