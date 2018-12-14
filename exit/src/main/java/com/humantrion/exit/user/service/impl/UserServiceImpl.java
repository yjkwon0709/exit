package com.humantrion.exit.user.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.humantrion.exit.user.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDAO;

	public int selectUserID(Map<String, Object> map) throws Exception {
		return userDAO.selectUserID(map);
	}

	public void insertUserData(Map<String, Object> map) throws Exception {
		userDAO.insertUserData(map);
	}

	public Map<String, Object> selectUserInfo(Map<String, Object> map) throws Exception {
		return userDAO.selectUserInfo(map);
	}
}
