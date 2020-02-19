package com.nhj.springProjectmelon.model.user.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqJoinDto {
	@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "ID는 영어와 숫자 조합만 가능합니다.")
	@Size(min=5,max=15, message = "ID 길이가 잘못되었습니다. ")
	@NotBlank(message="유저네임을 입력하세요.")
	private String username;
	
	@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "유저네임은 영어와 숫자 조합만 가능합니다.")
	@Size(min=2,max=10, message = "이름 길이가 잘못되었습니다.")
	@NotBlank(message="유저네임을 입력하세요.")
	private String name;
	
	@Size(min=8, max=20, message = "패스워드 길이가 잘못되었습니다.")
	@NotBlank(message="패스워드를 입력하세요.")
	private String password;
	
	@Size(min=10, max=20, message = "이메일 길이가 잘못되었습니다.")
	@Email(message = "이메일 양식이 틀렸습니다.")
	@NotBlank(message="이메일을 입력하세요.")
	private String email;
}
