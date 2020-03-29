package com.nhj.springProjectmelon.model.music.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReqPageDto {
	private int startPage=1;
	private int perPageNum;
	private String listName;

	public void setStartPage(int startPage) {
		if(startPage<=0) {
			startPage=1;
		}
		this.startPage=(startPage-1)*perPageNum;
	}
}
