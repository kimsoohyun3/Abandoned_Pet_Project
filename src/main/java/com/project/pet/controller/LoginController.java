package com.project.pet.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.project.pet.entity.MemberVo;
import com.project.pet.naverLoginApi.NaverLoginBO;
import com.project.pet.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	LoginService loginService;

	// 로그인 화면
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		// 해당 상단메뉴 css 주기 위해
		model.addAttribute("nav", "login");

		// login.jsp 의 modelAttribute 에서 지정한 form 요소들에 값을 제공할 객체 담기
		model.addAttribute("memberVo", new MemberVo());

		// 네이버 아이디로 인증 URL을 생성하기 위하여 naverLoginBO 클래스의 getAuthorizationUrl 메서드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		model.addAttribute("url", naverAuthUrl);

		return "login/login";
	}

	// 로그인 시도
	@PostMapping("/loginSession")
	public String loginSessionHandle(@RequestParam String email, @RequestParam String pswd, HttpSession session, Model model) {
		boolean validation = loginService.validateMember(email, pswd);
		
		// 아이디와 비번 일치할 경우
		if (validation) {
			// 로그인 멤버 정보 화면에 보내기 위해
			MemberVo vo = loginService.findtMember(email);
			session.setAttribute("loginMember", vo);

			// 비밀번호 변경 input에 암호화된 비밀번호를 value 값으로 둘수 없으니 암호화 전 비밀번호 session 에 담기
			session.setAttribute("pswd", pswd);

			// 관리자 권한주기 위해
			session.setAttribute("auth", vo.getAuth());

			return "redirect:/";
		// 아이디와 불비번 일치할 경우
		} else {
			model.addAttribute("fail", "아이디나 비밀번호가 일치하지 않습니다.");

			// 로그인 실패시 입력했던 email을 화면에 다시 띄워주기 위해
			model.addAttribute("email", email);
			
			return "login/login";
		}
	}

	NaverLoginBO naverLoginBO;
	String apiResult = null;

	@Autowired
	public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// 네이버 로그인 성공시 callback 호출 메서드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(@RequestParam String code, @RequestParam String state, HttpSession session, Model model) throws IOException, ParseException{
		// 토큰 가져오기
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 로그인 사용자 정보 가져오기
		apiResult = naverLoginBO.getUserProfile(oauthToken);

		// String형식인 apiResult를 json 형태로
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		// 네이버 로그인 멤버 정보 화면에 보내기
		session.setAttribute("naverLoginMember", response_obj);
		// 휴대폰 번호 '-' 제외하고 화면에 보내기 위해
		String mobile = (String) response_obj.get("mobile");
		String[] phoneArray = mobile.split("-");
		String phone = phoneArray[0] + phoneArray[1] + phoneArray[2];
		session.setAttribute("phone", phone);
		// emailId 화면에 보내기
		String email = (String) response_obj.get("email");
		String emailId = email.substring(0, email.indexOf("@"));
		session.setAttribute("naverLoginId", emailId);
		
		return "home";
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session){
		session.invalidate();

		return "redirect:/";
	}
}
