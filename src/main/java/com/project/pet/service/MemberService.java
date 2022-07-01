package com.project.pet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.pet.entity.MemberVo;
import com.project.pet.repository.LoginDao;
import com.project.pet.repository.MemberDao;

@Service
public class MemberService {
	@Autowired
	MemberDao memberDao;
	@Autowired
	BCryptPasswordEncoder pswdEncoder;

	// 이메일 중복검사
	public int emailOverlap(String email) {
		return memberDao.emailOverlap(email);
	}

	// 별명 중복검사
	public int nicknameOverlap(String nickname) {
		return memberDao.nicknameOverlap(nickname);
	}

	// 회원가입
	public void join(MemberVo vo) {
		// 보안을 위해 비밀번호 암호화
		String pswd = vo.getPswd();
		String encodedPswd = pswdEncoder.encode(pswd);
		vo.setPswd(encodedPswd);

		memberDao.insertMember(vo);
	}

	// 비밀번호 변경
	public int alterPswd(String pswd, MemberVo vo) {
		// 변경된 비밀번호 값 암호화
		String encodedPswd = pswdEncoder.encode(pswd);

		// 변경하고자 하는 비밀번호가 기존 비밀번호와 같으면 실패 코드인 '0' 리턴
		if (pswdEncoder.matches(pswd, vo.getPswd())) {
			return 0;
		} else {
			vo.setPswd(encodedPswd);

			return memberDao.updatePswd(vo);
		}
	}

	// 별명 변경
	public int alterNickname(String nickname, MemberVo vo) {
		// 변경하고자 하는 별명이 기존 별명과 같으면 실패 코드인 '0' 리턴
		if (nickname.equals(vo.getNickname())) {
			return 0;
		} else {
			vo.setNickname(nickname);

			return memberDao.updateNickname(vo);
		}
	}

	// 휴대폰 번호 변경
	public int alterPhone(String phone, MemberVo vo) {
		// 변경하고자 하는 휴대폰 번호가 기존 휴대폰 번호와 같으면 실패 코드인 '0' 리턴
		if (phone.equals(vo.getPhone())) {
			return 0;
		} else {
			vo.setPhone(phone);

			return memberDao.updatePhone(vo);
		}
	}
}
