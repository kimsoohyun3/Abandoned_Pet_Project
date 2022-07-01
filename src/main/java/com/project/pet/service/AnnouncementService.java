package com.project.pet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.pet.entity.AnnouncementVo;
import com.project.pet.entity.PagingProcessingVo;
import com.project.pet.repository.AnnouncementDao;

@Service
public class AnnouncementService {
	@Autowired
	AnnouncementDao announcementDao;

	// 공지사항 등록
	public void insertAnnouncement(AnnouncementVo vo) {
		announcementDao.insertAnnouncement(vo);
	}

	// 조회수 증가
	public void hitsUpAnnouncement(int announcementNo) {
		announcementDao.hitsUpAnnouncement(announcementNo);
	}

	// 공지사항 목록 조회
	public List<AnnouncementVo> pagingListInquiry(PagingProcessingVo vo) {
		return announcementDao.pagingListInquiry(vo);
	}

	// 상세 공지사항 조회
	public AnnouncementVo detailAnnouncement(int announcementNo) {
		return announcementDao.detailAnnouncement(announcementNo);
	}

	// 공지사항 목록 화면에서 공지사항 삭제
	public void deleteAnnouncement(List<String> announcementArray) {
		announcementDao.deleteAnnouncement(announcementArray);
	}

	// 상세 공지사항 화면에서 공지사항 삭제
	public void deleteOneAnnouncement(int announcementNo) {
		announcementDao.deleteOneAnnouncement(announcementNo);
	}

	// 공지사항 수정
	public void alterAnnouncement(AnnouncementVo vo) {
		announcementDao.alterAnnouncement(vo);
	}

	// 전체 게시물 수
	public int totalAnnouncement() {
		return announcementDao.totalAnnouncement();
	}
}
