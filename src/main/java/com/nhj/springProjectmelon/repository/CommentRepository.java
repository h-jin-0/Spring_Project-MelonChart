package com.nhj.springProjectmelon.repository;

import java.util.List;

import com.nhj.springProjectmelon.model.comment.dto.ReqCommentTypeDto;
import com.nhj.springProjectmelon.model.comment.dto.ReqMusicDetailDto;
import com.nhj.springProjectmelon.model.comment.dto.RespMusicDetailDto;

public interface CommentRepository {

	int Musicsave(ReqMusicDetailDto reqMusicDetailDto);

	RespMusicDetailDto findById(int id);

	int userIdFindById(int id);

	int delete(int id);

	List<RespMusicDetailDto> findAll(ReqCommentTypeDto reqCommentTypeDto);

	int recommendPlus(int id);

	int oppositePlus(int id);

	int recommendMinus(int id);

	int oppositeMinus(int id);
}
