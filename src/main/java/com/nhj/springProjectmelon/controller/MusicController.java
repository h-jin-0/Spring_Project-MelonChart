package com.nhj.springProjectmelon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nhj.springProjectmelon.repository.MusicRepository;
import com.nhj.springProjectmelon.service.CommentService;
import com.nhj.springProjectmelon.service.MusicService;

@Controller
public class MusicController {

	@Autowired
	private MusicService musicService;
	@Autowired
	private MusicRepository musicRepository;
	@Autowired
	private CommentService commentService;

	@GetMapping({ "", "/" })
	public String music(Model model) {
		model.addAttribute("musics", musicService.musicCharts(1));
		return "/music/melonChart";
	}
	@GetMapping("/music/paging/{pageNum}")
	public String musicPaging(Model model,@PathVariable int pageNum) {
		model.addAttribute("musics", musicService.musicCharts(pageNum));
		return "/music/melonChart";
	}
	
	@PostMapping("/autocomplete")
	public @ResponseBody List<String> AutoTest(String term) {
		List<String> list = musicRepository.listAll(term);
		return list;
	}

	@GetMapping("/music/{id}")
	public String musicDetail(@PathVariable int id, Model model) {
		model.addAttribute("comments", commentService.findAll("music", id));
		model.addAttribute("music", musicService.musicDetail(id));
		return "/music/musicDetail";
	}

	@GetMapping("/music/search/{searchTitle}")
	public String searchForm(@PathVariable String searchTitle, Model model) {
		int id = musicService.serarchByTitle(searchTitle);
		if (id != 0) {
			return "redirect:/music/"+id;
		} else {
			return "redirect:/";
		}
	}

	@GetMapping("/music/videoDetail/{id}")
	public String videoDetail(@PathVariable int id, Model model) {
		model.addAttribute("comments", commentService.findAll("video", id));
		model.addAttribute("music", musicService.musicDetail(id));
		return "/music/videoDetail";
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
