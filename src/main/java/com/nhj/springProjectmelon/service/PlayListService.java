package com.nhj.springProjectmelon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.ReturnCode;
import com.nhj.springProjectmelon.model.playList.dto.ReqListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListSaveDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqMyPlayListDto;
import com.nhj.springProjectmelon.model.playList.dto.RespAddListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.RespMyPlayListDetailDto;
import com.nhj.springProjectmelon.repository.PlayListRepository;

@Service
public class PlayListService {
	@Autowired
	private PlayListRepository playListRepository;

	@Autowired
	private MyUserDetailService myUserDetailService;

	public int save(ReqListPopUpDto reqListPopUpDto) {
		int result = 0;
		if (myUserDetailService.getPrincipal() != null) {
			ReqListSaveDto reqListSaveDto = new ReqListSaveDto();
			reqListSaveDto.setUserId(myUserDetailService.getPrincipal().getId());
			reqListSaveDto.setListName(reqListPopUpDto.getListName());
			for (int checkedId : reqListPopUpDto.getCheckedIds()) {
				reqListSaveDto.setCheckedId(checkedId);
				result = playListRepository.save(reqListSaveDto);
				if (result != 1) {
					return ReturnCode.오류;
				}
			}
			return result;
		} else {
			return ReturnCode.오류;
		}
	}

	public List<RespAddListPopUpDto> findAll() {

		if (myUserDetailService.getPrincipal() != null) {
			int principalId = myUserDetailService.getPrincipal().getId();
			return playListRepository.findAll(principalId);
		} else {
			return null;
		}
	}

	public List<RespMyPlayListDetailDto> findByListName(String listName) {

		if (myUserDetailService.getPrincipal() != null) {
			int principalId = myUserDetailService.getPrincipal().getId();
			ReqMyPlayListDto reqMyPlayListDto = new ReqMyPlayListDto();
			reqMyPlayListDto.setUserId(principalId);
			reqMyPlayListDto.setListName(listName);

			return playListRepository.findByListName(reqMyPlayListDto);
		} else {
			return null;
		}
	}

	public int delete(String listName) {

		if (myUserDetailService.getPrincipal() != null) {
			int principalId = myUserDetailService.getPrincipal().getId();
			ReqMyPlayListDto reqMyPlayListDto = new ReqMyPlayListDto();
			reqMyPlayListDto.setUserId(principalId);
			reqMyPlayListDto.setListName(listName);
			return playListRepository.delete(reqMyPlayListDto);
		} else {
			return ReturnCode.오류;
		}
	}

	public int myPlayListDelete(int id) {
		return playListRepository.myPlayListDelete(id);
	}

}
