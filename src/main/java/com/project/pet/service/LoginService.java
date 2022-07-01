package com.project.pet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.pet.entity.MemberVo;
import com.project.pet.repository.LoginDao;

@Service
public class LoginService {
	@Autowired
	LoginDao loginDao;
	@Autowired
	BCryptPasswordEncoder pswdEncoder;

	// 로그인 인증
	public boolean validateMember(String email, String pswd) {
		// DB에 로그인 시도한 email부터 존재한지 확인
		String dbPswd = loginDao.validateMember(email);
		if (dbPswd == null)
			return false;

		// 로그인 시도한 pswd와 DB에 암호화된 비밀번호랑 일치 확인
		return pswdEncoder.matches(pswd, dbPswd);
	}

	// 회원정보 가져오기
	public MemberVo findtMember(String email) {
		return loginDao.findtMember(email);
	}
}
