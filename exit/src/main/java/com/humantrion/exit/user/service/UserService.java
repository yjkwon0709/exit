package com.humantrion.exit.user.service;

import java.util.Map;

public interface UserService {

	int selectUserID(Map<String, Object> map) throws Exception;

	void insertUserData(Map<String, Object> map) throws Exception;

	Map<String, Object> selectUserInfo(Map<String, Object> map) throws Exception;
}
