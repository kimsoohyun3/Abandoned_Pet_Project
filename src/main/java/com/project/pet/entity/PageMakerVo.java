package com.project.pet.entity;

public class PageMakerVo {

	int startPage; // 화면에 보이는 시작 페이지
	int endPage; // 화면에 보이는 끝 페이지
	boolean prev, next; // 화면에 보이는 10개 페이지의 이전 페이지, 다음 페이지 존재유무
	int total; // 전체 게시물 수
	PagingProcessingVo pagingProcessingVo;

	public PageMakerVo(PagingProcessingVo pagingProcessingVo, int total) {
		this.pagingProcessingVo = pagingProcessingVo;
		this.total = total;
		this.endPage = (int) (Math.ceil(pagingProcessingVo.getCurrentPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;

		// 전체 끝 페이지
		int allEndPage = (int) (Math.ceil(total * 1.0 / pagingProcessingVo.getAmount()));

		// 전체 끝 페이지가 화면에 보이는 끝 페이지보다 작을 시
		if (allEndPage < this.endPage) {
			this.endPage = allEndPage;
		}

		// 화면에 보이는 시작 페이지 값이 1 보다 큰 경우 true
		this.prev = this.startPage > 1;

		// 화면에 보이는 마지막 페이지 값이 1 보다 큰 경우 true
		this.next = this.endPage < allEndPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public PagingProcessingVo getPagingProcessingVo() {
		return pagingProcessingVo;
	}

	public void setPagingProcessingVo(PagingProcessingVo pagingProcessingVo) {
		this.pagingProcessingVo = pagingProcessingVo;
	}
}
