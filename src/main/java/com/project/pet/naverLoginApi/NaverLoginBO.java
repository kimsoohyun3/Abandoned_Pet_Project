package com.project.pet.naverLoginApi;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class NaverLoginBO {

	// 애플리케이션 등록 후 발급받은 클라이언트 아이디
	private final static String CLIENT_ID = "FilNbONaGaZTEZtfwaFJ";
	// 인증 과정에 대한 구분값
	private final static String CLIENT_SECRET = "gK_tNRqLVD";
	// 네이버 로그인 인증 결과를 전달받을 Callback URL
	private final static String REDIRECT_URI = "http://abandonedpet.co.uk:8080/callback";
//	private final static String REDIRECT_URI = "http://localhost:8081/callback";
	// 애플리케이션이 생성한 상태 토큰
	private final static String SESSION_STATE = "oauth_state";
	// 프로필 조회 API URL
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";

	// 네이버 아이디로 인증 URL 생성 method
	public String getAuthorizationUrl(HttpSession session) {
		// 세션 유효성 검증을 위하여 난수 생성
		String state = generateRandomString();

		setSession(session, state);

		// scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네이버 아이디로 인증 URL 생성
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).state(state) // 앞서 생성한 난수값을 인증 URL 생성시 사용
				.build(NaverLoginApi.instance());
		return oauthService.getAuthorizationUrl();
	}

	// 네이버 아이디로 callback 처리 및 accessToken 획득 method
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
		// callback으로 전달받은 세션검증용 난수값과 세션에 저장되어 있는 값이 일치하는 확인
		String sessionState = getSession(session);
		if (StringUtils.pathEquals(sessionState, state)) {
			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());

			// scribe에서 제공하는 accessToken 획득 기능으로 네이버 아이디로 accessToken을 획득
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}

	// 세션 유효성 검증을 위한 난수 생성기
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	// HttpSession에 데이터 저장
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	// HttpSession에서 데이터 가져오기
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}

	// accessToken을 이용하여 네이버 사용자 프로필 API를 호출
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).build(NaverLoginApi.instance());
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}
}
