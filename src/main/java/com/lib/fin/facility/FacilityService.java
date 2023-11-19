package com.lib.fin.facility;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class FacilityService {

	@Autowired
	private FacilityDAO facilityDAO;
	
	public int setFacilityAdd(FacilityVO facilityVO) throws Exception {
		return facilityDAO.setFacilityAdd(facilityVO);
	}
	
	public List<FacilityVO> getFacilitylist(FacilityVO facilityVO) throws Exception{
		return facilityDAO.getFacilitylist(facilityVO);
	}
	
	public int setFacilityUpdate(FacilityVO facilityVO) throws Exception{
		return facilityDAO.setFacilityUpdate(facilityVO);
	}
	
	public int setFacilityDelete(FacilityVO facilityVO) throws Exception{
		return facilityDAO.setFacilityDelete(facilityVO);
	}
	

}