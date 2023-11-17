package com.lib.fin.facility;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.lib.fin.commons.Pager;

import lombok.extern.slf4j.Slf4j;
@Mapper

public interface FacilityDAO {

	public int getCount(Pager pager)throws Exception;
	
	public int setFacilityAdd(FacilityVO facilityVO) throws Exception;
		
	public List<FacilityVO> getFacilityList(Map<String, Object> params) throws Exception;
	
	public int setFacilityUpdate(FacilityVO facilityVO) throws Exception;
	
	public int setFacilityDelete(FacilityVO facilityVO) throws Exception;
	
	public Long getTotal(Map<String, Object> params) throws Exception;
	
	public int getTotalFacilityCount()throws Exception;
}
