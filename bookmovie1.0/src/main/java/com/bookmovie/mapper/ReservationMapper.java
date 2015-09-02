package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.ReservationDto;
import com.bookmovie.factory.Command;


public interface ReservationMapper {
	public int insert(ReservationDto dto);

	public int delete(List<Integer> arr);

	public List<ReservationDto> list(Command command);

	public int size(Command command);
	
}
