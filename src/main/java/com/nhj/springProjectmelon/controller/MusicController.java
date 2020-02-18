package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.nhj.springProjectmelon.service.MusicService;

@Controller
public class MusicController {
	
	@Autowired
	private MusicService musicService;
 
	@GetMapping({"","/"})
	public String music(Model model) {
		model.addAttribute("musics",musicService.melonChart());
		return "melonChart";
	}
	@GetMapping("/insert")
	public String insert() {
		musicService.musicSave();
		return "melonChart";
	}
}
