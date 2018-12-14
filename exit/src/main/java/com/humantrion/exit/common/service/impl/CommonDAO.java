package com.humantrion.exit.common.service.impl;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("commonDAO")
public class CommonDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(BigDecimal map) throws Exception{
		return (Map<String, Object>) sqlSession.selectOne("Common.selectFileInfo", map);
	}
}
