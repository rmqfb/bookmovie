package com.bookmovie.service;

import java.util.List;

import com.bookmovie.domain.ThRsvDto;
import com.bookmovie.factory.Command;

public interface ThRsvService {
	public int thRsv(ThRsvDto dto);

	public int delete(List<Integer> arr);
	
	public List<ThRsvDto> list(Command command);
	
	public int size(Command command);

}

