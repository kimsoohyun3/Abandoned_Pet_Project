package com.project.pet.entity;

public class PagingProcessingVo {

	int currentPageNum; // 현재 페이지 pageNum
	int amount; // 한개의 페이지에 보여질 게시글 갯수

	// 기본 세팅값
	public PagingProcessingVo() {
		this(1, 10);
	}

	// 원하는 세팅값
	public PagingProcessingVo(int currentPageNum, int amount) {
		this.currentPageNum = currentPageNum;
		this.amount = amount;
	}

	public int getCurrentPageNum() {
		return currentPageNum;
	}

	public void setCurrentPageNum(int currentPageNum) {
		this.currentPageNum = currentPageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
}
