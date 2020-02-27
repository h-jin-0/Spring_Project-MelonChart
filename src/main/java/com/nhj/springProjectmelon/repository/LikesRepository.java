package com.nhj.springProjectmelon.repository;

import java.util.List;

import com.nhj.springProjectmelon.model.likes.dto.ReqMelonChartDto;
import com.nhj.springProjectmelon.model.likes.dto.RespMelonChartDto;

public interface LikesRepository {
	int save(ReqMelonChartDto reqMelonChartDto);

	int delete(ReqMelonChartDto reqMelonChartDto);

	List<RespMelonChartDto> findByUserId(int useId);
}
