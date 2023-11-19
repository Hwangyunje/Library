package com.lib.fin.facility;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import lombok.extern.slf4j.Slf4j;
@Mapper

public interface FacilityDAO {

	public int setFacilityAdd(FacilityVO facilityVO) throws Exception;
		
	public List<FacilityVO> getFacilitylist(FacilityVO facilityVO) throws Exception;
	
	public int setFacilityUpdate(FacilityVO facilityVO) throws Exception;
	
	public int setFacilityDelete(FacilityVO facilityVO) throws Exception;
	
}