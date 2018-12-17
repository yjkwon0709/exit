package com.humantrion.exit.board.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDAO")
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectBoardList(){
		return sqlSession.selectList("Board.selectBoardList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> pagingBoardList(Map<String, Object> map) {
		String strPageIndex = (String) map.get("PAGE_INDEX");
		String strPageRow = (String) map.get("PAGE_ROW");
		int nPageIndex = 0;
		int nPageRow = 10;
		
		if(StringUtils.isEmpty(strPageIndex) == false) {
			nPageIndex = Integer.parseInt(strPageIndex)-1;
		}
		if(StringUtils.isEmpty(strPageRow) == false) {
			nPageRow = Integer.parseInt(strPageRow);
		}
		map.put("START", (nPageIndex * nPageRow) + 1);
		map.put("END", (nPageIndex * nPageRow) + nPageRow);
		
		return sqlSession.selectList("Board.pagingBoardList", map);
	}
	
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception{
		sqlSession.insert("Board.insertBoard", map);
	}
	
	public void updateHitCnt(BigDecimal IDX) throws Exception{
		sqlSession.update("Board.updateHitCnt", IDX);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail( BigDecimal IDX) throws Exception {
		return (Map<String, Object>) sqlSession.selectOne("Board.selectBoardDetail", IDX);
	}
	
	public void updateBoard(Map<String, Object> map) throws Exception {
		sqlSession.update("Board.updateBoard", map);
	}
	
	public void deleteBoard(BigDecimal IDX) throws Exception {
		sqlSession.delete("Board.deleteBoard", IDX);
	}
	
	public void insertFile(Map<String, Object> map) throws Exception{
		sqlSession.insert("Board.insertFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(BigDecimal IDX) throws Exception{
		return sqlSession.selectList("Board.selectFileList", IDX);
	}
	
	public void deleteFileList(BigDecimal IDX) throws Exception {
		sqlSession.delete("Board.deleteFileList", IDX);
	}
	
	public void updateFile(BigDecimal FILE_IDX) throws Exception {
		sqlSession.update("Board.updateFile", FILE_IDX);
	}
}
