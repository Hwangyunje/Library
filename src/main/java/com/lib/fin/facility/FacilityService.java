package com.lib.fin.facility;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.fin.commons.Pager;
@Service
public interface FacilityService {


	
	public int setFacilityAdd(FacilityVO facilityVO) throws Exception;
		
	public int getTotalFacilityCount()throws Exception;
	
	public int setFacilityUpdate(FacilityVO facilityVO) throws Exception;
	
	public int setFacilityDelete(FacilityVO facilityVO) throws Exception;

	List<FacilityVO> getFacilityList(Map<String, Object> params, Pager pager) throws Exception;
	


}
