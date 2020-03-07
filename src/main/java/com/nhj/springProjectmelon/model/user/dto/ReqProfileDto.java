package com.nhj.springProjectmelon.model.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqProfileDto {
	private int id;
	private String password;
	private String profile;
}
