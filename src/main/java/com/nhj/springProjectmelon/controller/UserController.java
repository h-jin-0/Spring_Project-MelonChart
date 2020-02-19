package com.nhj.springProjectmelon.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.user.dto.ReqJoinDto;
import com.nhj.springProjectmelon.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping("/user/login")
	public String login(Model model) {
		return "/user/login";
	}

	@GetMapping("/user/join")
	public String join(Model model) {
		return "/user/join";
	}

	@PostMapping("/user/join")
	public ResponseEntity<?> join(@Valid @RequestBody ReqJoinDto reqJoinDto, BindingResult bindingResult) {
		int result = userService.join(reqJoinDto);
		System.out.println(bindingResult.getFieldError("username").getDefaultMessage());
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}