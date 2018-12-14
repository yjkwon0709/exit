package com.humantrion.exit.common.util;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	private static final String filePath = "D:\\dev\\file\\";
	
	public List<Map<String, Object>> parseInsertFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = mreq.getFileNames();
		
		MultipartFile mfile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		BigDecimal boardIdx = new BigDecimal(map.get("IDX").toString());
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		}
		/*if(mfile.getSize()==0) {
			return list;
		}*/
		while(iterator.hasNext()) {
			mfile = mreq.getFile(iterator.next());
			if(mfile.isEmpty() == false) {
				originalFileName = mfile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = commonUtils.getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				mfile.transferTo(file);
				
				listMap = new HashMap<String, Object>();
				listMap.put("BOARD_IDX", boardIdx);
				listMap.put("ORIGINAL_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", mfile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request)
			throws Exception {
		MultipartHttpServletRequest mreq = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = mreq.getFileNames();

		MultipartFile mfile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		BigDecimal boardIdx = new BigDecimal(map.get("IDX").toString());
		String requestName = null;
		String idx = null;
		
		File file = new File(filePath);
		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			mfile = mreq.getFile(iterator.next());
			if (mfile.isEmpty() == false) {
				originalFileName = mfile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = commonUtils.getRandomString() + originalFileExtension;

				mfile.transferTo(new File(filePath + storedFileName));

				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("BOARD_IDX", boardIdx);
				listMap.put("ORIGINAL_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", mfile.getSize());
				list.add(listMap);
			} else {
				requestName = mfile.getName();
				idx = "IDX_" + requestName.substring(requestName.indexOf("_")+1);
				if(map.containsKey(idx) == true & map.get(idx) != null) {
					listMap = new HashMap<String, Object>();
					listMap.put("IS_NEW", "N");
					listMap.put("FILE_IDX", map.get(idx));
					list.add(listMap);
				}
			}
		}
		return list;
	}
}
