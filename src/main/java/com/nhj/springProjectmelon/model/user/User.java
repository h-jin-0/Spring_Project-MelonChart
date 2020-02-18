package com.nhj.springProjectmelon.model.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	private int id;
	private String loginId;
	private String name;
	private String password;
	private String email;
	private String profile;
}
