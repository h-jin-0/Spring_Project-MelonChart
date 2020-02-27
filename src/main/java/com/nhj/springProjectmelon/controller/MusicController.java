package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.nhj.springProjectmelon.service.MusicService;

@Controller
public class MusicController {
	
	@Autowired
	private MusicService musicService;
	
	@GetMapping({ "", "/" })
	public String music(Model model) {
		model.addAttribute("musics", musicService.musicCharts());
		return "/music/melonChart";
	}

	@GetMapping("/music/{id}")
	public String musicDetail(@PathVariable int id, Model model) {
		model.addAttribute("music", musicService.musicDetail(id));
		return "/music/musicDetail";
	}

	@GetMapping("/music/musicSave")
	public String insert() {
		musicService.musicSave();
		return "/music/melonChart";
	}

	@GetMapping("/music/videoSave")
	public String video(Model model) {
		musicService.videoSave();
		return "/music/melonChart";
	}
}
