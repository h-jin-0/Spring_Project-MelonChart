package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.service.LikesService;

@Controller
public class LikesController {
	@Autowired
	private LikesService likesService;

	@PostMapping("/likes/save/{musicId}")
	public ResponseEntity<?> save(@PathVariable int musicId) {
		int result = likesService.save(musicId);
		
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(400, "fail"), HttpStatus.BAD_REQUEST);
	}
	@DeleteMapping("/likes/delete/{musicId}")
	public ResponseEntity<?> delete(@PathVariable int musicId) {
		int result = likesService.delete(musicId);
		
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(400, "fail"), HttpStatus.BAD_REQUEST);
	}
}
