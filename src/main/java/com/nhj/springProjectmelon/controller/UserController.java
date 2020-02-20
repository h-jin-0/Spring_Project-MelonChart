package com.nhj.springProjectmelon.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.user.dto.ReqJoinDto;
import com.nhj.springProjectmelon.model.user.dto.ReqMessageDto;
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

	@PostMapping("/user/message")
	public @ResponseBody String message(@Valid @RequestBody ReqMessageDto reqMessageDto, BindingResult bindingResult) {
		System.out.println(reqMessageDto.getInputMsg());
		ReqJoinDto test = new ReqJoinDto();
		test.setUsername(reqMessageDto.getInputMsg());

		System.out.println(reqMessageDto.getField());
		while (bindingResult.hasErrors()) {
			String message = bindingResult.getFieldError(reqMessageDto.getField()).getDefaultMessage();
			System.out.println(message);
			return message;
		}
		return null;

	}

	@PostMapping("/user/join")
	public ResponseEntity<?> join(@Valid @RequestBody ReqJoinDto reqJoinDto, BindingResult bindingResult) {
		int result = userService.join(reqJoinDto);
		System.out.println(bindingResult.getFieldError("username").getDefaultMessage());

		// 인풋이 다 다르니까 인풋의 아이디를 넘겨서 저 필드에러의 스트링에 넣고 그다음 메세지를 얻으면 된다!

		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
