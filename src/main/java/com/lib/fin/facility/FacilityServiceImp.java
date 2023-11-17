package com.lib.fin.facility;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.fin.commons.Pager;
@Service
public class FacilityServiceImp implements FacilityService {
	
	@Autowired
	private FacilityDAO facilityDAO;
	@Override
	public List<FacilityVO> getFacilityList(Map<String,Object> params, Pager pager)throws Exception{
		
		params.put("pager", pager);
		
		pager.setPerPage(5L);
		pager.makeRowNum2();
		Long total = facilityDAO.getTotal(params);
		pager.makeRowNum();
		
		return facilityDAO.getFacilityList(params);
	}
	@Override
	public int getTotalFacilityCount() throws Exception{
		return facilityDAO.getTotalFacilityCount();
	}
	@Override
	public int setFacilityAdd(FacilityVO facilityVO) throws Exception{
		return facilityDAO.setFacilityAdd(facilityVO);
	};
	@Override
	public int setFacilityUpdate(FacilityVO facilityVO) throws Exception{
		return facilityDAO.setFacilityUpdate(facilityVO);
	};
	@Override
	public int setFacilityDelete(FacilityVO facilityVO) throws Exception{
		return facilityDAO.setFacilityDelete(facilityVO);
	}

	
}
