package com.nhj.springProjectmelon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.ReturnCode;
import com.nhj.springProjectmelon.model.comment.dto.ReqCommentTypeDto;
import com.nhj.springProjectmelon.model.comment.dto.ReqMusicDetailDto;
import com.nhj.springProjectmelon.model.comment.dto.RespMusicDetailDto;
import com.nhj.springProjectmelon.repository.CommentRepository;

@Service
public class CommentService {
	@Autowired
	private CommentRepository commentRepository;

	@Autowired
	private MyUserDetailService myUserDetailService;

	public RespMusicDetailDto commentSave(ReqMusicDetailDto reqMusicDetailDto) {
		reqMusicDetailDto.setUserId(myUserDetailService.getPrincipal().getId());
		int result = commentRepository.Musicsave(reqMusicDetailDto);
		if (result == 1) {
			return commentRepository.findById(reqMusicDetailDto.getId());
		} else {
			return null;
		}
	}

	public int delete(int id) {
		if (myUserDetailService.getPrincipal() != null) {
			if (myUserDetailService.getPrincipal().getId() == commentRepository.userIdFindById(id)) {
				return commentRepository.delete(id);
			} else {
				return ReturnCode.권한없음;
			}
		} else {
			return -1;
		}

	}

	public List<RespMusicDetailDto> findAll(String type, int id) {
		ReqCommentTypeDto reqCommentTypeDto = new ReqCommentTypeDto();
		reqCommentTypeDto.setId(id);
		reqCommentTypeDto.setType(type);
		return commentRepository.findAll(reqCommentTypeDto);
	}

	public int thumbsPlus(String type, int commentId) {
		if (type.equals("recommend")) {
			return commentRepository.recommendPlus(commentId);
		} else if (type.equals("opposite")) {
			return commentRepository.oppositePlus(commentId);
		} else {
			return 0;
		}
	}

	public int thumbsMinus(String type, int commentId) {
		if (type.equals("recommend")) {
			return commentRepository.recommendMinus(commentId);
		} else if (type.equals("opposite")) {
			return commentRepository.oppositeMinus(commentId);
		} else {
			return 0;
		}
	}
}
