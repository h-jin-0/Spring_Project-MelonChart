package com.nhj.springProjectmelon.repository;


import com.nhj.springProjectmelon.model.user.User;
import com.nhj.springProjectmelon.model.user.dto.ReqJoinDto;
import com.nhj.springProjectmelon.model.user.dto.ReqLoginDto;

public interface UserRepository {
	int save(ReqJoinDto reqJoinDto);
	User findByUsernameAndPassword(ReqLoginDto dto);
	User authentication(String username);
	int findByUsername(String username);
}
