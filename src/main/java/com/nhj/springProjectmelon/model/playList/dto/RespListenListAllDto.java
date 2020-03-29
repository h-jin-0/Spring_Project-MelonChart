package com.nhj.springProjectmelon.model.playList.dto;

import com.nhj.springProjectmelon.model.RespCM;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RespListenListAllDto {
	private int musicId;
	private RespCM status;
}
