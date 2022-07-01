package com.project.pet.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.pet.entity.MemberVo;

@Repository
public class LoginDao {
	@Autowired
	SqlSession sqlSession;

	// 로그인 인증
	public String validateMember(String email) {
		return sqlSession.selectOne("login.validateMember", email);
	}

	// 회원정보 가져오기
	public MemberVo findtMember(String email) {
		return sqlSession.selectOne("login.findMember", email);
	}
}
