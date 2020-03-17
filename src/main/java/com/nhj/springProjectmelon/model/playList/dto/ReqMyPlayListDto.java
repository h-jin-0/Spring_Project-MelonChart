package com.nhj.springProjectmelon.model.playList.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqMyPlayListDto {
	private String listName;
	private int userId;
}
