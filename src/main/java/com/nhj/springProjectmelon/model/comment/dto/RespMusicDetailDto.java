package com.nhj.springProjectmelon.model.comment.dto;

import java.sql.Timestamp;

import com.nhj.springProjectmelon.model.RespCM;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RespMusicDetailDto {
	private RespCM status;

	private int id;
	private String username;
	private String content;
	private String profile;
	private int recommend;
	private int opposite;
	private Timestamp writeDate; 
}
