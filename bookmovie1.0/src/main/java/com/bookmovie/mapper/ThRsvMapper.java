package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.ThRsvDto;
import com.bookmovie.factory.Command;


public interface ThRsvMapper {
	public int insert(ThRsvDto dto);

	public int delete(List<Integer> arr);

	public List<ThRsvDto> list(Command command);

	public int size(Command command);
	
}
