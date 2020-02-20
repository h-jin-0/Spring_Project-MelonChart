package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.ReturnCode;
import com.nhj.springProjectmelon.service.LikesService;

@Controller
public class LikesController {
	@Autowired
	private LikesService likesService;

	@GetMapping("/likes/save/{musicId}")
	public ResponseEntity<?> doubleCheck(@PathVariable int musicId) {
		int result = likesService.save(musicId);
		
		if (result == 1) {
			System.out.println("save성공");
			return new ResponseEntity<RespCM>(new RespCM(ReturnCode.아이디중복, "아이디중복"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
	}
	@DeleteMapping("/likes/delete/{musicId}")
	public ResponseEntity<?> delete(@PathVariable int musicId) {
		int result = likesService.delete(musicId);
		
		if (result == 1) {
			System.out.println("delete성공");
			return new ResponseEntity<RespCM>(new RespCM(ReturnCode.아이디중복, "아이디중복"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
	}
}