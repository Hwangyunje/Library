package com.lib.fin.reservation;

import java.sql.Date;

import com.lib.fin.commons.CommonVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter

public class ReservationVO extends CommonVO{

	private int res_no;
	private String emp_no;
	private String grp_cd;
	private String cd;
	private Date res_start_time;
	private Date res_end_time;
	private String res_purpose;


}
