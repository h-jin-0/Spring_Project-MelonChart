package com.nhj.springProjectmelon.model.playList.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqDeleteListDto {
	private int[] deleteList;
}
