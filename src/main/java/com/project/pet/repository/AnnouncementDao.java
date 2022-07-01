package com.project.pet.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.pet.entity.AnnouncementVo;
import com.project.pet.entity.PagingProcessingVo;

@Repository
public class AnnouncementDao {
	@Autowired
	SqlSession sqlSession;

	// 공지사항 등록
	public void insertAnnouncement(AnnouncementVo vo) {
		sqlSession.insert("announcement.insert", vo);
	}

	// 조회수 증가
	public void hitsUpAnnouncement(int announcementNo) {
		sqlSession.update("announcement.hitsUp", announcementNo);
	}

	// 공지사항 목록 조회
	public List<AnnouncementVo> inquiryAnnouncement() {
		return sqlSession.selectList("announcement.inquiry");
	}

	// 공지사항 목록 조회
	public List<AnnouncementVo> pagingListInquiry(PagingProcessingVo vo) {
		return sqlSession.selectList("announcement.pagingListInquiry", vo);
	}

	// 상세 공지사항 조회
	public AnnouncementVo detailAnnouncement(int announcementNo) {
		return sqlSession.selectOne("announcement.detail", announcementNo);
	}

	// 공지사항 목록 화면에서 공지사항 삭제
	public void deleteAnnouncement(List<String> announcementArray) {
		for (int i = 0; i < announcementArray.size(); i++) {
			sqlSession.delete("announcement.delete", announcementArray.get(i));
		}
	}

	// 상세 공지사항 화면에서 공지사항 삭제
	public void deleteOneAnnouncement(int announcementNo) {
		sqlSession.delete("announcement.oneDelete", announcementNo);
	}

	// 공지사항 수정
	public void alterAnnouncement(AnnouncementVo vo) {
		sqlSession.update("announcement.alter", vo);
	}

	// 전체 게시물 수
	public int totalAnnouncement() {
		return sqlSession.selectOne("announcement.total");
	}
}
