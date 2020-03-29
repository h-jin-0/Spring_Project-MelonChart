package com.nhj.springProjectmelon.model.music.dto;

import com.nhj.springProjectmelon.model.RespCM;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespListenListDto {
	private RespCM status;
	
	private String title;
	private String singer;
	private String photo;
	private String videoLink;
}
