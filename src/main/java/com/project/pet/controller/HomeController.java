package com.project.pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	// 홈 화면
	@RequestMapping("/")
	public String home() {

		return "home";
	}
}
