package com.intern.isubway;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@RequestMapping("/")
	public String loginform(){
		return"login/loginform";
	}
	@RequestMapping("login/join")
	public void join(){
		
	}
	@RequestMapping("login/addrpopup")
	public void addrpopup(){
		
	}
	
}
