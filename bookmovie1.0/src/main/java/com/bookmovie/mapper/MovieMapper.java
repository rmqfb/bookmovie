package com.bookmovie.mapper;

import java.util.List;

import com.bookmovie.domain.MovieDto;
import com.bookmovie.factory.Command;


public interface MovieMapper {
	
	
	public MovieDto detail(Command command);

	
	public List<MovieDto> list(Command command);
	
	public MovieDto getElementById(Command command);
	
	public List<MovieDto> getElementsByName(Command command);
	
	public int count(Command command);
	
	public int searchSeq();
	
	public int size(Command command);
	
	

}
