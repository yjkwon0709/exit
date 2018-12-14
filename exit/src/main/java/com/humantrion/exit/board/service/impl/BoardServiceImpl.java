package com.humantrion.exit.board.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.humantrion.exit.board.service.BoardService;
import com.humantrion.exit.common.util.FileUtils;

@Service("BoardService")
public class BoardServiceImpl implements BoardService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private FileUtils fileUtils;
	
	@Autowired
	private BoardDAO boardDAO;
	
	public List<Map<String,Object>> selectBoardList() throws Exception {
		return boardDAO.selectBoardList();
	}
	
	public List<Map<String, Object>> pagingtBoardList(Map<String, Object> map) throws Exception {
		return boardDAO.pagingBoardList(map);
	}
	
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		boardDAO.insertBoard(map, request);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i=0, size=list.size(); i <size; i++) {
			boardDAO.insertFile(list.get(i));
		}
	}
	
	public Map<String, Object> selectBoardDetail(BigDecimal IDX) throws Exception {
		boardDAO.updateHitCnt(IDX);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = boardDAO.selectBoardDetail(IDX);
		resultMap.put("map", tempMap);									// boardList
		
		List<Map<String, Object>> list = boardDAO.selectFileList(IDX);
		resultMap.put("list", list);									// fileList
		
		return resultMap;//boardDAO.selectBoardDetail(map);
	}
	
	public void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		boardDAO.updateBoard(map);
		
		boardDAO.deleteFileList((BigDecimal) map.get("IDX"));
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String,Object> tempMap = null;
		for(int i=0, size=list.size(); i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				boardDAO.insertFile(tempMap);
			} else {
				boardDAO.updateFile(new BigDecimal((String)tempMap.get("FILE_IDX")));
			}
		}
	}
	
	public void deleteBoard(BigDecimal IDX) throws Exception {
		boardDAO.deleteBoard(IDX);
	}

	public void deleteFileList(BigDecimal IDX) throws Exception {
		boardDAO.deleteFileList(IDX);
	}

	public void updateFile(BigDecimal FILE_IDX) throws Exception {
		boardDAO.updateFile(FILE_IDX);
	}



	
}
