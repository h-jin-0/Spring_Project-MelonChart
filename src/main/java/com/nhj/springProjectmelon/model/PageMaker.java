package com.nhj.springProjectmelon.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int perPageNum;
	
	private int displayPageNum = 10;


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();// 페이징 계산하는 메서드
	}

	private void calcData() {
		if(startPage>=0) {
			startPage=1;
		}
		endPage=(int)(Math.ceil(startPage/(double)displayPageNum)*displayPageNum);
		int tendPage=(int)(Math.ceil(totalCount)/(double)perPageNum);
		if(endPage>tendPage) endPage=tendPage;
		prev=startPage==1?false:true;
		next=endPage>=tendPage?false:true;
	}


}