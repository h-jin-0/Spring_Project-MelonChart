package com.nhj.springProjectmelon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.nhj.springProjectmelon.model.RespCM;
import com.nhj.springProjectmelon.model.comment.dto.ReqMusicDetailDto;
import com.nhj.springProjectmelon.model.comment.dto.RespMusicDetailDto;
import com.nhj.springProjectmelon.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;

	@PostMapping("/comment/musicSave")
	public ResponseEntity<?> commentMusicSave(@RequestBody ReqMusicDetailDto reqMusicDetailDto) {
		RespMusicDetailDto comment = commentService.commentSave(reqMusicDetailDto);

		if (comment != null) {
			comment.setStatus(new RespCM(200, "ok"));
			return new ResponseEntity<RespMusicDetailDto>(comment, HttpStatus.OK);
		} else {
			RespMusicDetailDto error = new RespMusicDetailDto();
			error.setStatus(new RespCM(400, "fail"));
			return new ResponseEntity<RespMusicDetailDto>(error, HttpStatus.BAD_REQUEST);
		}
	}

	@DeleteMapping("comment/delete/{id}")
	public ResponseEntity<?> write(@PathVariable int id) {
		int result = commentService.delete(id);
		
		if (result == 1)
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		else if (result == 3)
			return new ResponseEntity<RespCM>(new RespCM(403, "permission"), HttpStatus.FORBIDDEN);
		else
			return new ResponseEntity<RespCM>(new RespCM(400, "fail"), HttpStatus.BAD_REQUEST);
	}
	
	@PostMapping("/comment/plus/{type}/{commentId}")
	public ResponseEntity<?> thumbsPlus(@PathVariable String type,@PathVariable int commentId) {
		int result = commentService.thumbsPlus(type,commentId);
		
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(400, "fail"), HttpStatus.BAD_REQUEST);
	}
	@PostMapping("/comment/minus/{type}/{commentId}")
	public ResponseEntity<?> thumbsMinus(@PathVariable String type,@PathVariable int commentId) {		
		int result = commentService.thumbsMinus(type,commentId);
		
		if (result == 1) {
			return new ResponseEntity<RespCM>(new RespCM(200, "ok"), HttpStatus.OK);
		}
		return new ResponseEntity<RespCM>(new RespCM(400, "fail"), HttpStatus.BAD_REQUEST);
	}
}
