package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.playList.dto.ReqListPopUpDto;
import com.nhj.springProjectmelon.service.PlayListService;

@Controller
public class PlayListController {
	@Autowired
	private PlayListService playListService;

	@GetMapping("/playList")
	public String popUp(Model model) {
		model.addAttribute("playLists", playListService.findAll());
		return "/playList/addListPopUp";
	}

	@GetMapping("/newPlayList")
	public String newPlaylist(Model model) {
		return "/playList/newListPopUp";
	}

	@PostMapping("/playList/addList")
	public ResponseEntity<?> addPlayList(@RequestBody ReqListPopUpDto reqListPopUpDto) {
		int result = playListService.save(reqListPopUpDto);
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("/playList/myPlayList")
	public String myPlayList(Model model) {
		model.addAttribute("playLists", playListService.findAll());
		return "/playList/myPlayList";
	}

	@GetMapping("/playList/myPlayListDetail/{listName}")
	public String myPlayListDetail(@PathVariable String listName, Model model) {
		model.addAttribute("myPlayLists", playListService.findByListName(listName));
		return "/playList/myPlayListDetail";
	}

	@DeleteMapping("/playList/delete/{listName}")
	public ResponseEntity<?> playListDelete(@PathVariable String listName, Model model) {
		int result = playListService.delete(listName);

		if (result >0)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else 
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@DeleteMapping("/playList/myPlayListDelete/{id}")
	public ResponseEntity<?> myPlayListDelete(@PathVariable int id, Model model) {
		int result = playListService.myPlayListDelete(id);

		if (result >0)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else 
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	
	}
}
