package com.nhj.springProjectmelon.repository;

import java.util.List;

import com.nhj.springProjectmelon.model.playList.dto.ReqListSaveDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqMyPlayListDto;
import com.nhj.springProjectmelon.model.playList.dto.RespAddListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.RespMyPlayListDetailDto;

public interface PlayListRepository {

	int save(ReqListSaveDto reqListSaveDto);
	List<RespAddListPopUpDto> findAll(int userId);
	List<RespMyPlayListDetailDto> findByListName(ReqMyPlayListDto reqMyPlayListDto);
	int delete(ReqMyPlayListDto reqMyPlayListDto);
	int myPlayListDelete(int id);
}
