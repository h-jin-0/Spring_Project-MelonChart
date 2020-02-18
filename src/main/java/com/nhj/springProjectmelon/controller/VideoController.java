package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.nhj.springProjectmelon.service.VideoService;

@Controller
public class VideoController {
	
	@Autowired
	private VideoService videoService;
 
	@GetMapping("/video")
	public String music() {
		videoService.videoSave();
		return "/music/melonChart";
	}

}
