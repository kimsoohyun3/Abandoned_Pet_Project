package com.project.pet.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.pet.entity.MemberVo;

@Repository
public class SearchDao {
	@Autowired
	SqlSession sqlSession;

	// 이메일 존재여부
	public int searchEmailCheck(MemberVo vo) {
		return sqlSession.selectOne("search.emailCheck", vo);
	}

	// 이메일 찾기
	public List<String> searchEmail(MemberVo vo) {
		return sqlSession.selectList("search.email", vo);
	}

	// 비밀번호 존재여부
	public int searchPswdCheck(MemberVo vo) {
		return sqlSession.selectOne("search.pswdCheck", vo);
	}

	// 비밀번호 찾기
	public int searchPswd(MemberVo vo) {
		return sqlSession.update("search.pswd", vo);
	}
}
