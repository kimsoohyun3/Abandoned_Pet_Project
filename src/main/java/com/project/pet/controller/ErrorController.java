package com.project.pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {

	// 로그인 하지않고 로그인이 필요한 기능을 이용하려 할 경우
	@RequestMapping("/nonLogin")
	public String nonLogin() {

		return "error/nonLogin";
	}

	// 로그인 되어 있는 상태에서 로그아웃이 되어있는 상태만 이용할수 있는 기능을 이용하려 할 경우
	@RequestMapping("/nonLogout")
	public String nonLogout() {

		return "error/nonLogout";
	}
	
	// HTTP 오류 코드 404 경우
	@RequestMapping("/errorPage/400")
	public String errorPage400(Model model) {
		model.addAttribute("errorMessage", "잘못된 요청입니다.");
		model.addAttribute("errorCode", "400");
		
		return "error/commonErrorPage";
	}
	
	// HTTP 오류 코드 403 경우
	@RequestMapping("/errorPage/403")
	public String errorPage403(Model model) {
		model.addAttribute("errorMessage", "접근이 금지되었습니다.");
		model.addAttribute("errorCode", "403");
		
		return "error/commonErrorPage";
	}
	
	// HTTP 오류 코드 404 경우
	@RequestMapping("/errorPage/404")
	public String errorPage404(Model model) {
		model.addAttribute("errorMessage", "요청하신 페이지는 존재하지 않습니다.");
		model.addAttribute("errorCode", "404");
		
		return "error/commonErrorPage";
	}
	
	// HTTP 오류 코드 405 경우
	@RequestMapping("/errorPage/405")
	public String errorPage405(Model model) {
		model.addAttribute("errorMessage", "요청된 메서드가 허용되지 않습니다.");
		model.addAttribute("errorCode", "405");
		
		return "error/commonErrorPage";
	}
	
	// HTTP 오류 코드 500 경우
	@RequestMapping("/errorPage/500")
	public String errorPage500(Model model) {
		model.addAttribute("errorMessage", "서버에 오류가 발생하였습니다.");
		model.addAttribute("errorCode", "500");
		
		return "error/commonErrorPage";
	}
	
	// HTTP 오류 코드 503 경우
	@RequestMapping("/errorPage/503")
	public String errorPage503(Model model) {
		model.addAttribute("errorMessage", "서비스를 사용할 수 없습니다.");
		model.addAttribute("errorCode", "503");
		
		return "error/commonErrorPage";
	}
}
