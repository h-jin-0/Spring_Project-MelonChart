package com.nhj.springProjectmelon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	
//	@Autowired
//	private MusicService musicService;

	@GetMapping("/login")
	public String login(Model model) {

		return "/user/login";
	}

}
