package com.nhj.springProjectmelon.model.comment.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqMusicDetailDto {

	private int id;
	private int joinId;
	private int userId;
	private String content;
	private String type;
}
