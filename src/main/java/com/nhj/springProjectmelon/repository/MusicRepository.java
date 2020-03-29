package com.nhj.springProjectmelon.repository;

import java.util.List;

import com.nhj.springProjectmelon.model.music.Music;
import com.nhj.springProjectmelon.model.music.dto.ReqPageDto;
import com.nhj.springProjectmelon.model.music.dto.RespListenListDto;
import com.nhj.springProjectmelon.model.music.dto.RespMelonJoinDto;

public interface MusicRepository {
	List<Music> findAll();
	int save(Music music);
	Music findById(int id);
	int saveById(Music music);
	List<RespMelonJoinDto> findAllWithLikes(ReqPageDto reqPageDto);
	List<String> listAll(String result);
	List<String> listAll2(String result);
	int IdFindByTitle(String searchTitle);
	RespListenListDto listenListfindById(int findId);
}
