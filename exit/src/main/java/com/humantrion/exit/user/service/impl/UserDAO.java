package com.humantrion.exit.user.service.impl;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("userDAO")
public class UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	@SuppressWarnings("unchecked")
	public int selectUserID(Map<String, Object> map) throws Exception{
		Map<String, Object> resultMap = (Map<String, Object>) sqlSession.selectOne("User.selectUserID", map);
		int result = Integer.valueOf(String.valueOf(resultMap.get("result")));
		return result;
	}

	public void insertUserData(Map<String, Object> map) throws Exception{
		sqlSession.insert("User.insertUserData", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUserInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) sqlSession.selectOne("User.selectUserInfo", map);
	}

}
