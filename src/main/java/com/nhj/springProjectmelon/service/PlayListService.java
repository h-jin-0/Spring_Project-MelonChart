package com.nhj.springProjectmelon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.PageMaker;
import com.nhj.springProjectmelon.model.ReturnCode;
import com.nhj.springProjectmelon.model.music.dto.ReqPageDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqDeleteListDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListSaveDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListenListAllDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqMyPlayListDto;
import com.nhj.springProjectmelon.model.playList.dto.RespAddListPopUpDto;
import com.nhj.springProjectmelon.model.playList.dto.RespListenListAllDto;
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

	public int myPlayListDeleteAll(ReqDeleteListDto reqDeleteListDto) {
		for (int id : reqDeleteListDto.getDeleteList()) {
			int result = playListRepository.myPlayListDelete(id);
			if (result != 1) {
				return ReturnCode.오류;
			} else {
				return ReturnCode.성공;
			}
		}
		return 0;
	}

	public PageMaker pageMaker(ReqPageDto reqPageDto) {

		int totalCount = playListRepository.totalCount(reqPageDto.getListName());
		PageMaker pageMager = new PageMaker();
		pageMager.setStartPage(reqPageDto.getStartPage());
		pageMager.setPerPageNum(reqPageDto.getPerPageNum());
		pageMager.setTotalCount(totalCount);
		return pageMager;
	}

	public List<RespMyPlayListDetailDto> findByListName(ReqPageDto reqPageDto) {

		if (myUserDetailService.getPrincipal() != null) {
			int principalId = myUserDetailService.getPrincipal().getId();
			ReqMyPlayListDto reqMyPlayListDto = new ReqMyPlayListDto();
			reqMyPlayListDto.setUserId(principalId);
			reqMyPlayListDto.setListName(reqPageDto.getListName());
			reqMyPlayListDto.setStartPage(reqPageDto.getStartPage());
			reqMyPlayListDto.setPerPageNum(reqPageDto.getPerPageNum());
			return playListRepository.findByListName(reqMyPlayListDto);
		} else {
			return null;
		}
	}

	public List<RespListenListAllDto> findIdByListName(String listName) {

		if (myUserDetailService.getPrincipal() != null) {
			ReqListenListAllDto reqListenListAllDto = new ReqListenListAllDto();
			reqListenListAllDto.setListName(listName);
			reqListenListAllDto.setUserId(myUserDetailService.getPrincipal().getId());
			
			return playListRepository.findIdByListName(reqListenListAllDto);
		} else {
			return null;
		}
	}

}
