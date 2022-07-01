package com.project.pet.entity;

import java.sql.Date;

public class AnnouncementVo {
	int announcementNo, announcementHits;
	String announcementTitle, announcementContent;
	Date announcementDate;
	String[] announcementArray;

	public int getAnnouncementNo() {
		return announcementNo;
	}

	public void setAnnouncementNo(int announcementNo) {
		this.announcementNo = announcementNo;
	}

	public int getAnnouncementHits() {
		return announcementHits;
	}

	public void setAnnouncementHits(int announcementHits) {
		this.announcementHits = announcementHits;
	}

	public String getAnnouncementTitle() {
		return announcementTitle;
	}

	public void setAnnouncementTitle(String announcementTitle) {
		this.announcementTitle = announcementTitle;
	}

	public String getAnnouncementContent() {
		return announcementContent;
	}

	public void setAnnouncementContent(String announcementContent) {
		this.announcementContent = announcementContent;
	}

	public Date getAnnouncementDate() {
		return announcementDate;
	}

	public void setAnnouncementDate(Date announcementDate) {
		this.announcementDate = announcementDate;
	}

	public String[] getAnnouncementArray() {
		return announcementArray;
	}

	public void setAnnouncementArray(String[] announcementArray) {
		this.announcementArray = announcementArray;
	}
}
