package com.humantrion.exit.common.service.impl;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.humantrion.exit.common.service.CommonService;

@Service("commonService")
public class CommonServiceImpl implements CommonService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonDAO commonDAO;
	
	public Map<String, Object> selectFileInfo(BigDecimal map) throws Exception {
		return commonDAO.selectFileInfo(map);
	}

}
