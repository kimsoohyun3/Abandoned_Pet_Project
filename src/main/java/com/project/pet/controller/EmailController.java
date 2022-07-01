package com.project.pet.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pet.service.EmailService;

@Controller
public class EmailController {
	@Autowired
	EmailService emailService;

	// 이메일 인증
	@RequestMapping("/emailCheck")
	@ResponseBody
	public String mailCheck(String email, HttpSession session) {
		String mailCheckNum = emailService.mailCheck(email);

		// 화면에서 인증번호 일치여부 판별할수 있도록 인증번호 보내기
		session.setAttribute("mailCheckNum", mailCheckNum);

		return mailCheckNum;
	}
}
