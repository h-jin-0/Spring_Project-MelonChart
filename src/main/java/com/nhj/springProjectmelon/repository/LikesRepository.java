package com.nhj.springProjectmelon.repository;

import com.nhj.springProjectmelon.model.likes.dto.ReqSaveDto;

public interface LikesRepository {
	int save(ReqSaveDto reqSaveDto);
	int delete(int musicId);
}
