package com.project.pet.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class NonLoginInterceptor implements HandlerInterceptor {
	// Controller 처리 전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		// 로그인 유무에 따라 화면이동 실패 안내페이지로 이동 
		if(request.getSession().getAttribute("loginMember") == null && request.getSession().getAttribute("naverLoginMember") == null) {
			response.sendRedirect("/nonLogin");
		}
		return true;
	}
	
	// Controller 처리 후
	@Override
	public void postHandle( HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav) throws Exception {
	}

	// View 처리 후
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object obj, Exception e) throws Exception {
	}
}
