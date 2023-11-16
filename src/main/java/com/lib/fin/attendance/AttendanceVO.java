package com.lib.fin.attendance;

import java.sql.Date;

import com.lib.fin.commons.CommonVO;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class AttendanceVO extends CommonVO{

	private int atd_no;
	private String emp_no;
	private Date gtw_time;
	private Date lw_time;
	private String status;
	private Long overtime;
	private Long dayWorkTime;
}
