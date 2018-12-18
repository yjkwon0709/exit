package com.humantrion.exit.user.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.humantrion.exit.common.common.CommandMap;
import com.humantrion.exit.user.service.UserService;

@Controller
public class UserController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserService userService;
	
	////////////////	회원가입	////////////////
	@RequestMapping(value="/user/openSignUp.do")
	public ModelAndView openSignUp(CommandMap map) throws Exception{
		return new ModelAndView("/user/signUp.page");
	}
	@RequestMapping(value="/user/checkUserID.do")
	@ResponseBody
	public int checkUserID(CommandMap map) throws Exception{
		int checkResult = userService.selectUserID(map.getMap());
		return checkResult;
	}
	@RequestMapping(value="/user/signUp.do")
	public ModelAndView signUp(CommandMap map) throws Exception{
		userService.insertUserData(map.getMap());
		return new ModelAndView("/user/signUpComplete.page","msg","회원가입이 되었습니다.");
	}
	
	///////////////		로그인		////////////////
	@RequestMapping(value="/user/openLogin.do")
	public ModelAndView openLogin(HttpServletRequest req, HttpServletResponse res, CommandMap map) throws Exception {
		if(req.getSession().getAttribute("loginInfo") != null) {
			String msg="이미 로그인된 상태입니다.";
			return new ModelAndView("/user/loginSuccess.page", "msg", msg);
		} else {
			return new ModelAndView("/user/login.page");
		}
	}
	@RequestMapping(value="/user/loginTry.do")
	public ModelAndView login(HttpServletRequest req, CommandMap map) throws Exception{
		ModelAndView mv = new ModelAndView("/user/loginSuccess.page");
		Map<String, Object> userMap = userService.selectUserInfo(map.getMap());
		
		if(userMap == null) {
			mv.addObject("msg", "로그인에 실패하였습니다.");
		} else {
			req.getSession().setAttribute("loginInfo", userMap);
			req.getSession().setMaxInactiveInterval(60*30);
			mv.addObject("msg", "로그인에 성공하였습니다.");
		}
		return mv;
	}
	
	///////////////		로그아웃	///////////////
	@RequestMapping(value="/user/logoutTry.do")
	public ModelAndView logout(HttpServletRequest req) throws Exception{
		req.getSession().removeAttribute("loginInfo");
		return new ModelAndView("/user/logout.page","msg","로그아웃 되었습니다.");
	}
	
	//////////////		로그인  요청	//////////////
	@RequestMapping(value="/user/needLogin.do")
	public ModelAndView needLogin() throws Exception {
		return new ModelAndView("/user/loginWarning.page", "msg", "로그인 후 이용해주시기 바랍니다.");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
