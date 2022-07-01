package com.project.pet.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.pet.entity.MemberVo;

@Repository
public class MemberDao {
	@Autowired
	SqlSession sqlSession;

	// 이메일 중복검사
	public int emailOverlap(String email) {
		return sqlSession.selectOne("member.emailOverlap", email);
	}

	// 별명 중복검사
	public int nicknameOverlap(String nickname) {
		return sqlSession.selectOne("member.nicknameOverlap", nickname);
	}

	// 회원가입
	public void insertMember(MemberVo vo) {
		sqlSession.insert("member.insert", vo);
	}

	// 비밀번호 변경
	public int updatePswd(MemberVo vo) {
		return sqlSession.update("member.updatePswd", vo);
	}

	// 별명 변경
	public int updateNickname(MemberVo vo) {
		return sqlSession.update("member.updateNickname", vo);
	}

	// 휴대폰 번호 변경
	public int updatePhone(MemberVo vo) {
		return sqlSession.update("member.updatePhone", vo);
	}
}
