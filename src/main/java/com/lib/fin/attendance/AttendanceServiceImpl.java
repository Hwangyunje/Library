package com.lib.fin.attendance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

import java.util.Map;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	private AttendanceDAO attendanceDAO;
	
	@Override
	public AttendanceVO checkWorkTime(Map<String, Object> param) {
		return attendanceDAO.checkWorkTime(param);
	}
	@Override
	public int insertStartWork(String emp_no) {
		return attendanceDAO.insertStartWork(emp_no);
	}
	@Override
	public int updateStartWork(Map<String, Object> param) {
		return attendanceDAO.updateStartWork(param);
	}
	@Override
	public int updateEndWork(Map<String, Object> param) {
		return attendanceDAO.updateEndWork(param);
	}
	@Override
	public int updateDayWorkTimeHalf(Map<String, Object> param) {
		return attendanceDAO.updateDayWorkTimeHalf(param);
	}
	@Override
	public int updateDayWorkTime(Map<String, Object> param) {
		return attendanceDAO.updateDayWorkTime(param);
	}
	@Override
	public int weekTotalTime(Map<String, Object> param) {
		return attendanceDAO.weekTotalTime(param);
	}
	@Override
	public int selectWeekOverTime(Map<String, Object> startEndMap) {
		return attendanceDAO.selectWeekOverTime(startEndMap);
	}
	
}
