package com.project.pet.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pet.entity.MemberVo;
import com.project.pet.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	// 회원가입 화면
	@RequestMapping("/join")
	public String join(Model model) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "join");

		// join.jsp 의 modelAttribute 에서 지정한 form 요소들에 값을 제공할 객체 담기
		model.addAttribute("memberVo", new MemberVo());

		return "member/join";
	}

	// 이메일 중복검사
	@PostMapping("/emailOverlap")
	@ResponseBody
	public String emailOverlap(String email){
		int result = memberService.emailOverlap(email);
		// 입력했던 이메일이 DB에 있을 경우
		if (result != 0) {
			return "fail";
		// 입력했던 이메일이 DB에 없을 경우
		} else {
			return "success";
		}
	}

	// 별명 중복검사(회원가입시)
	@PostMapping("/joinNicknameOverlap")
	@ResponseBody
	public String joinNicknameOverlap(String nickname, HttpSession session){
		int result = memberService.nicknameOverlap(nickname);
		// 입력했던 별명이 DB에 있을 경우
		if (result != 0) {
			return "fail";
		// 입력했던 별명이 DB에 없을 경우
		} else {
			return "success";
		}
	}

	// 별명 중복검사(내 정보 변경시)
	@PostMapping("/alterNicknameOverlap")
	@ResponseBody
	public String alterNicknameOverlap(String nickname, HttpSession session){
		// session에 담겨있는 회원정보 가져오기
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");

		int result = memberService.nicknameOverlap(nickname);

		// 변경 안하고 기본 정보값으로 유지했을 경우
		if (nickname.equals(loginMember.getNickname())) {
			return "alterNot";
		// 입력했던 별명이 DB에 있을 경우
		} else if (result != 0) {
			return "fail";
		// 입력했던 별명이 DB에 없을 경우
		} else {
			return "success";
		}
	}

	// 회원가입
	@RequestMapping("/joinOK")
	public String joinOK(@ModelAttribute @Valid MemberVo vo, BindingResult result, HttpSession session, Model model) {

		// 서버에서 한번 더 유효성 검사
		if (session.getAttribute("mailCheckNum") != null) {
			int mailCheckNum = Integer.parseInt((String) session.getAttribute("mailCheckNum"));
			if (vo.getCode() != mailCheckNum) {
				// 실패시 실패 메세지 화면에 보내기
				model.addAttribute("mailCheckFail", "!");

				return "member/join";
			}
		}

		// MemberVo에 validation Pattern에 일치하지 않을시
		if (result.hasErrors()) {
			model.addAttribute("emailReCheck", "재인증 요망");

			return "member/join";
		}

		memberService.join(vo);

		return "redirect:/";
	}

	// 회원정보 화면
	@RequestMapping("/profile")
	public String profile(Model model) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "my");

		// join.jsp의 modelAttribute에서 지정한 form 요소들에 값을 제공할 객체 담기
		model.addAttribute("memberVo", new MemberVo());

		return "member/profile";
	}

	// 회원정보 변경
	@PostMapping("/alterProfile")
	public String alterProfile(@ModelAttribute @Valid MemberVo vo, BindingResult result, HttpSession session, Model model) {
		// MemberVo에 validation Pattern에 일치하지 않을시
		if (result.hasErrors()) {
			return "member/profile";
		}

		// session에 담겨있는 회원정보 가져오기
		MemberVo loginMember = (MemberVo) session.getAttribute("loginMember");

		// 비밀번호 변경
		int alterPswdResult = memberService.alterPswd(vo.getPswd(), loginMember);
		// 변경하고자 하는 비밀번호가 기존 비밀번호와 달라 변경이 성공할 경우
		if (alterPswdResult == 1) {
			model.addAttribute("resultOfAlterPswd", "비밀번호가 변경되었습니다.");

			// 비밀번호 변경 input에 암호화된 비밀번호를 value값으로 둘수 없으니 암호화 전 비밀번호 session에 담기
			session.setAttribute("pswd", vo.getPswd());
		}

		// 별명 변경
		int alterNicknameResult = memberService.alterNickname(vo.getNickname(), loginMember);
		// 변경하고자 하는 별명이 기존 별명과 달라 변경이 성공할 경우
		if (alterNicknameResult == 1) {
			model.addAttribute("resultOfAlterNickname", "별명이 변경되었습니다.");
		}

		// 휴대폰 번호 변경
		int alterPhoneResult = memberService.alterPhone(vo.getPhone(), loginMember);
		// 변경하고자 하는 휴대폰 번호가 기존 휴대폰 번호와 달라 변경이 성공할 경우
		if (alterPhoneResult == 1) {
			model.addAttribute("resultOfAlterPhone", "휴대폰 번호가 변경되었습니다.");
		}

		return "member/profile";
	}

}
