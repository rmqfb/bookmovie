package com.bookmovie.domain;

import org.springframework.stereotype.Component;

@Component("movieStatMeta")
public class MovieStatMetaDto {
	private int statId;
	private int statTypeCode;
	private String statTypeName;
	
	
	
	public int getStatId() {
		return statId;
	}
	public void setStatId(int statId) {
		this.statId = statId;
	}
	public int getStatTypeCode() {
		return statTypeCode;
	}
	public void setStatTypeCode(int statTypeCode) {
		this.statTypeCode = statTypeCode;
	}
	public String getStatTypeName() {
		return statTypeName;
	}
	public void setStatTypeName(String statTypeName) {
		this.statTypeName = statTypeName;
	}
	
	
}
