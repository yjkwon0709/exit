package com.humantrion.exit.board.controller;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.humantrion.exit.board.service.BoardService;
import com.humantrion.exit.common.common.CommandMap;
import com.humantrion.exit.common.util.FileUtils;

@Controller
public class BoardController {
	
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private BoardService boardService;
	@SuppressWarnings("unused")
	@Autowired
	private FileUtils fileUtils;
	public void logTest() {
		log.debug("test");
		log.info("test");
		log.error("test");
		log.warn("test");
		log.fatal("test");
	}
	
	
	@RequestMapping(value="/board/boardList.do")
	public ModelAndView boardList(CommandMap map) throws Exception{
		return new ModelAndView("/board/boardList");
	}
	
	@RequestMapping(value="/board/setBoardList.do")
	public ModelAndView selectBoardList(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		//ModelAndView mv = new ModelAndView("/board/boardList");
		
		List<Map<String, Object>> list = boardService.pagingtBoardList(map.getMap());
		mv.addObject("list", list);
		if(list.size() > 0) {
			mv.addObject("total", list.get(0).get("total_count"));
		} else {
			mv.addObject("total", 0);
		}
		return mv;
	}
	
	@RequestMapping(value="/board/boardWrite.do")
	public ModelAndView boardWrite(HttpServletRequest req,HttpServletResponse res, CommandMap map) throws Exception{
		return new ModelAndView("/board/boardWrite", "map", map);
	
	}
	
	@RequestMapping(value="/board/insertBoard.do")
	public ModelAndView insertBoard(HttpServletRequest req,HttpServletResponse res,  CommandMap map) throws Exception{
		boardService.insertBoard(map.getMap(), req);
		
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
		Iterator<String> iterator = mreq.getFileNames();
		MultipartFile file = null;
		while(iterator.hasNext()){
			file = mreq.getFile(iterator.next());
			if(file.isEmpty() == false) {
				  log.info("------------ file start --------------");
				  log.info("name : " + file.getName());
				  log.info("filename : " + file.getOriginalFilename());
				  log.info("size : " + file.getSize());
				  log.info("------------ file end   --------------\n");
			}
	
		}
		return new ModelAndView("redirect:/board/boardList.do", "map", map);
	}
	
	@RequestMapping(value="/board/boardDetail.do")
	public ModelAndView boardDetail(CommandMap map, HttpServletRequest req) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardDetail");
		Map<String, Object> selectedOne;
		if(map.isEmpty()) {
			@SuppressWarnings("unchecked")
			Map<String, Object> flashMap = (Map<String, Object>) RequestContextUtils.getInputFlashMap(req);	
			selectedOne = boardService.selectBoardDetail(new BigDecimal((String)flashMap.get("IDX")));
		} else {
			selectedOne = boardService.selectBoardDetail(new BigDecimal((String)map.get("IDX")));
		}
		
		mv.addObject("selectedOne", selectedOne.get("map"));
		mv.addObject("list", selectedOne.get("list"));
		return mv;
	}
	
	@RequestMapping(value="/board/boardUpdate.do")
	public ModelAndView updateBoard(CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardUpdate");
		Map<String, Object> selectedOne = boardService.selectBoardDetail(new BigDecimal((String)map.get("IDX")));
		mv.addObject("selectedOne", selectedOne.get("map"));
		mv.addObject("list",selectedOne.get("list"));
		return mv;
	}
	
	@RequestMapping(value="/board/setBoardUpdate.do")
	public ModelAndView setUpdateBoard(CommandMap map, HttpServletRequest req, RedirectAttributes atr) throws Exception {
		atr.addFlashAttribute("IDX", map.get("IDX"));
		map.put("IDX", new BigDecimal((String)map.get("IDX")));
		boardService.updateBoard(map.getMap(), req);
		
		return new ModelAndView("redirect:/board/boardDetail.do");
	}
	
	@RequestMapping(value="/board/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap map) throws Exception{
		boardService.deleteBoard(new BigDecimal((String)map.get("IDX")));
		return new ModelAndView("redirect:/board/boardList.do","map", map);
	}

	///////////////////////  tiles test//////////////////////////
	@RequestMapping(value="/test.do")
	public ModelAndView test() {
		ModelAndView mv = new ModelAndView("/test");
		return mv;
	}
	
	@RequestMapping(value="/testPage.do")
	public ModelAndView testPage() {
		ModelAndView mv = new ModelAndView("/test.page");
		return mv;
	}
	
	@RequestMapping(value="/testPart.do")
	public ModelAndView testPart() {
		ModelAndView mv = new ModelAndView("/test.part");
		return mv;
	}
	///////////////////////  tiles test///////////////////////////////
}