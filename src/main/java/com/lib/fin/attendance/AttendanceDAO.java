package com.lib.fin.attendance;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
	public interface AttendanceDAO {
		public List<AttendanceVO> getStatus(Map<String, String> params);
		public AttendanceVO getAttendance(Map<String, Object> params);
		public int getLeaveWorkWhether(String employeeId);
		public int setGoWork(AttendanceVO attendanceVO);
		public int setLeaveWork(AttendanceVO attendanceVO);
	}
