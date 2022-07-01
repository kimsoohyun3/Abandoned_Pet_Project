package com.project.pet.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.project.pet.entity.MemberVo;
import com.project.pet.service.SearchService;

@Controller
public class SearchController {
	@Autowired
	SearchService searchService;

	// 이메일 찾기 화면
	@RequestMapping("/searchEmail")
	public String searchEmail() {
		return "search/email";
	}

	// 이메일 찾기
	@PostMapping(path = "/searchEmailOk", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchEmailOk(@ModelAttribute MemberVo vo) {
		// 해당 정보의 이메일이 없을시
		if (searchService.searchEmailCheck(vo) == 0) {
			return "fail";
		// 해당 정보의 이메일이 있을시
		} else {
			List<String> voList = searchService.searchEmail(vo);

			Gson gson = new Gson();
			return gson.toJson(voList);
		}
	}

	// 비밀번호 찾기 화면
	@RequestMapping("/searchPswd")
	public String searchPswd() {
		return "search/password";
	}

	// 비밀번호 찾기
	@PostMapping("/searchPswdOk")
	@ResponseBody
	public String searchPswdOk(@ModelAttribute MemberVo vo){
		// 해당 정보의 비밀번호가 없을시
		if (searchService.searchPswdCheck(vo) == 0) {
			return "fail";
		// 해당 정보의 비밀번호가 있을시
		} else {
			searchService.searchPswd(vo);

			return "success";
		}
	}
}
