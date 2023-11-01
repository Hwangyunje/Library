package com.lib.fin.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.inject.Inject;
import java.util.Map;
import java.util.HashMap;

@Service
public class ScheduleService {
	@Autowired
	private ScheduleDAO scheduleDAO;
	
	public int setScheduleAdd(ScheduleVO scheduleVO) throws Exception {
		return scheduleDAO.setScheduleAdd(scheduleVO);
	}
	
	public List<ScheduleVO> getSchedule(ScheduleVO scheduleVO) throws Exception{
		return scheduleDAO.getSchedule(scheduleVO);
	}
	
	public int setScheduleUpdate(ScheduleVO scheduleVO) throws Exception{
		return scheduleDAO.setScheduleUpdate(scheduleVO);
	}
	
	public int setScheduleDelete(ScheduleVO scheduleVO) throws Exception{
		return scheduleDAO.setScheduleDelete(scheduleVO);
	}
	
	public List<Map<String, Object>> getScheduleList() throws Exception{
		return scheduleDAO.getScheduleList();
	}
}