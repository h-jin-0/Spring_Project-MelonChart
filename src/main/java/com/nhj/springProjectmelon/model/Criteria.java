package com.nhj.springProjectmelon.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Criteria {
	private int page;
	private int perPageNum;

	public Criteria() {
		this.page=1;//페이지 갯수
		this.perPageNum=10;//페이지당 레코드 갯수
	}
	public void setPage(int page) {
		if(page<=0) {
			this.page=1;
			return;
		}
		this.page=page;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum<=0||perPageNum>100) {
			this.perPageNum=10;
			return;
		}
		this.perPageNum=perPageNum;
	}
}