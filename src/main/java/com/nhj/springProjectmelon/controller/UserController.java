package com.nhj.springProjectmelon.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.ReturnCode;
import com.nhj.springProjectmelon.model.user.dto.ReqJoinDto;
import com.nhj.springProjectmelon.model.user.dto.ReqProfileDto;
import com.nhj.springProjectmelon.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Value("${file.path}")
	private String fileRealPath;

	@GetMapping("/user/login")
	public String login(Model model) {
		return "/user/login";
	}

	@GetMapping("/user/logout")
	public String login() {
		return "/";
	}

	@GetMapping("/user/profile")
	public String profile() {
		return "/user/profile";
	}

	@GetMapping("/user/join")
	public String join(Model model) {
		return "/user/join";
	}

	@GetMapping("/user/doubleCheck/{checkId}")
	public ResponseEntity<?> doubleCheck(@PathVariable String checkId) {
		int result = userService.doubleCheck(checkId);
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(ReturnCode.아이디중복, "아이디중복"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
	}

	@PostMapping("/user/join")
	public ResponseEntity<?> join(@Valid @RequestBody ReqJoinDto reqJoinDto, BindingResult bindingResult) {

		int result = userService.join(reqJoinDto);

		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// form:form 사용함!!
	@PostMapping("/user/profile")
	public @ResponseBody String profile(int id, String password, @RequestParam MultipartFile profile) {

		UUID uuid = UUID.randomUUID();
		String uuidFilename = uuid + "_" + profile.getOriginalFilename();

		Path filePath = Paths.get(fileRealPath + uuidFilename);

		try {
			Files.write(filePath, profile.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}

		ReqProfileDto reqProfileDto = new ReqProfileDto(id, password, uuidFilename);

		StringBuffer sb = new StringBuffer();
		int result = userService.profile(reqProfileDto);

		if (result == 1) {
			sb.append("<script>");
			sb.append("alert('수정완료');");
			sb.append("location.href='/';");
			sb.append("</script>");
			return sb.toString();
		} else {
			sb.append("<script>");
			sb.append("alert('수정실패');");
			sb.append("history.back;");
			sb.append("</script>");
			return sb.toString();
		}
	}
}
