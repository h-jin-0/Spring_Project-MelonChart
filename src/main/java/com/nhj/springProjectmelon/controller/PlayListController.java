package com.nhj.springProjectmelon.controller;

import java.util.List;

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
import com.nhj.springProjectmelon.model.music.dto.ReqPageDto;
import com.nhj.springProjectmelon.model.music.dto.RespListenListDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqDeleteListDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListenListDto;
import com.nhj.springProjectmelon.model.playList.dto.RespListenListAllDto;
import com.nhj.springProjectmelon.service.MusicService;
import com.nhj.springProjectmelon.service.PlayListService;

@Controller
public class PlayListController {
	@Autowired
	private PlayListService playListService;

	@Autowired
	private MusicService musicService;

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

	@PostMapping("/playList/listenList")
	public ResponseEntity<?> listenList(@RequestBody ReqListenListDto reqListenListDto) {
		List<RespListenListDto> result = musicService.findById(reqListenListDto);

		if (result != null) {
			result.get(0).setStatus(new RespCM(200, "ok"));
			return new ResponseEntity<List<RespListenListDto>>(result, HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@GetMapping("/playList/listenListAll/{listName}")
	public ResponseEntity<?> listenListAll(@PathVariable String listName) {
		List<RespListenListAllDto> result = playListService.findIdByListName(listName);
		System.out.println(result);
		
		if (result != null) {
			result.get(0).setStatus(new RespCM(200, "ok"));
			return new ResponseEntity<List<RespListenListAllDto>>(result, HttpStatus.OK);
		} else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("/playList/myPlayList")
	public String myPlayList(Model model) {
		model.addAttribute("playLists", playListService.findAll());
		return "/playList/myPlayList";
	}

	@GetMapping("/playList/myPlayListDetail/{listName}/{startPage}")
	public String myPlayListDetail(@PathVariable String listName,@PathVariable int startPage, Model model) {
		ReqPageDto reqPageDto = new ReqPageDto();
		reqPageDto.setPerPageNum(10);
		reqPageDto.setStartPage(startPage);
		reqPageDto.setListName(listName);
		model.addAttribute("pageMaker", playListService.pageMaker(reqPageDto));
		model.addAttribute("myPlayLists", playListService.findByListName(reqPageDto));
		return "/playList/myPlayListDetail";
	}

	@DeleteMapping("/playList/delete/{listName}")
	public ResponseEntity<?> playListDelete(@PathVariable String listName) {
		int result = playListService.delete(listName);

		if (result > 0)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/playList/myPlayListDeleteAll")
	public ResponseEntity<?> playListDeleteAll(@RequestBody ReqDeleteListDto reqDeleteListDto) {
		int result = playListService.myPlayListDeleteAll(reqDeleteListDto);

		if (result > 0)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/playList/myPlayListDelete/{id}")
	public ResponseEntity<?> myPlayListDelete(@PathVariable int id) {
		int result = playListService.myPlayListDelete(id);

		if (result > 0)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else
			return new ResponseEntity<RespCM>(new RespCM(500, "fail"), HttpStatus.INTERNAL_SERVER_ERROR);

	}
}
