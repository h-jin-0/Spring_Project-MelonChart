package com.nhj.springProjectmelon.model.playList.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RespMyPlayListDetailDto {
	private int id;
	private int musicId;
	private String listName;
	private String title;
	private String singer;
	private String album;
	private String photo;
	private String genre;
}
