package com.lib.fin.attendance;

import java.util.Map;

public interface AttendanceService {

	AttendanceVO checkWorkTime(Map<String, Object> param);
	
	int insertStartWork(String emp_no);
	
	int updateStartWork(Map<String, Object> param);
	
	int updateEndWork(Map<String, Object> param);
	
	int updateDayWorkTimeHalf(Map<String, Object> param);
	
	int updateDayWorkTime(Map<String, Object> param);

	int weekTotalTime(Map<String, Object> param);
	
	int selectWeekOverTime(Map<String, Object> startEndMap);
}
