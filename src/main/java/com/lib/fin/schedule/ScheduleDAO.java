package com.lib.fin.schedule;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ScheduleDAO {

	public int setScheduleAdd(ScheduleVO scheduleVO) throws Exception;
	
	public List<ScheduleVO> getSchedule(ScheduleVO scheduleVO) throws Exception;
	
	public int setScheduleUpdate(ScheduleVO scheduleVO) throws Exception;
	
	public int setScheduleDelete(ScheduleVO scheduleVO) throws Exception;
	
	public List<Map<String, Object>> getScheduleList() throws Exception;
}