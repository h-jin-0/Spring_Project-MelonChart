package com.nhj.springProjectmelon.model.likes.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqMelonChartDto {
	private int musicId;
	private int userId;
}
