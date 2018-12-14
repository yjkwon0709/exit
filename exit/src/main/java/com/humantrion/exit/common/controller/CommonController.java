package com.humantrion.exit.common.controller;

import java.io.File;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.humantrion.exit.common.common.CommandMap;
import com.humantrion.exit.common.service.CommonService;

@Controller
public class CommonController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value="/common/downloadFile.do")
	public void downloadFile(CommandMap map, HttpServletResponse res) throws Exception{
		Map<String, Object> fileMap = commonService.selectFileInfo(new BigDecimal((String)map.get("IDX")));
		String storedFileName = (String)fileMap.get("stored_file_name");
	    String originalFileName = (String)fileMap.get("original_file_name");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File("D:\\dev\\file\\"+storedFileName));
		res.setContentType("application/octet-stream");
		res.setContentLength(fileByte.length);
		res.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(fileByte);
		
		res.getOutputStream().flush();
		res.getOutputStream().close();
	}
}
