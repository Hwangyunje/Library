package com.lib.fin.facility;

import com.lib.fin.commons.CommonVO;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class FacilityVO extends CommonVO {

	private int facility_no;
	private String grp_cd;
	private String facility_name;
	private String facility_contents;
}
