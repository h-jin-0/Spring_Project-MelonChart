package com.nhj.springProjectmelon.model.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReqMessageDto {
	private String field;
	private String inputMsg;
	
}
