package com.humantrion.exit.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MapController {
	
	@RequestMapping(value="/map/openMap.do")
	public ModelAndView openMap() throws Exception {
		return new ModelAndView("/map/map");
	}
}
