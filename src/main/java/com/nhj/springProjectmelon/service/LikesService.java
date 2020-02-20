package com.nhj.springProjectmelon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.likes.dto.ReqSaveDto;
import com.nhj.springProjectmelon.repository.LikesRepository;

@Service
public class LikesService {
	@Autowired
	private LikesRepository likesRepository;

	@Autowired
	private MyUserDetailService myUserDetailService;

	public int save(int musicId) {
		ReqSaveDto reqSaveDto = new ReqSaveDto();
		reqSaveDto.setMusicId(musicId);
		reqSaveDto.setUserId(myUserDetailService.getPrincipal().getId());

		return likesRepository.save(reqSaveDto);
	}
	public int delete(int musicId) {
		return likesRepository.delete(musicId);
	}

}
