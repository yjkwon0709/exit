package com.humantrion.exit.board.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BoardService {
	List<Map<String, Object>> selectBoardList() throws Exception;
	
	List<Map<String, Object>> pagingtBoardList(Map<String, Object> map) throws Exception;
	
	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	Map<String, Object> selectBoardDetail(BigDecimal IDX) throws Exception;
	
	void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	void deleteBoard(BigDecimal IDX) throws Exception;
	
	public void deleteFileList(BigDecimal IDX) throws Exception;
	
	public void updateFile(BigDecimal FILE_IDX) throws Exception;
}
