package com.nhj.springProjectmelon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.likes.dto.ReqMelonChartDto;
import com.nhj.springProjectmelon.repository.LikesRepository;

@Service
public class LikesService {
	@Autowired
	private LikesRepository likesRepository;
	
	@Autowired
	private MyUserDetailService myUserDetailService;

	public int save(int musicId) {
		ReqMelonChartDto reqMelonChartDto = new ReqMelonChartDto();
		reqMelonChartDto.setMusicId(musicId);
		reqMelonChartDto.setUserId(myUserDetailService.getPrincipal().getId());

		return likesRepository.save(reqMelonChartDto);
	}

	public int delete(int musicId) {
		ReqMelonChartDto reqMelonChartDto = new ReqMelonChartDto();
		reqMelonChartDto.setMusicId(musicId);
		reqMelonChartDto.setUserId(myUserDetailService.getPrincipal().getId());

		return likesRepository.delete(reqMelonChartDto);
	}

}
