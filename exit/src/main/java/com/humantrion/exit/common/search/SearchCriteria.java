package com.humantrion.exit.common.search;

import com.humantrion.exit.common.util.Criteria;

public class SearchCriteria extends Criteria{
	public SearchCriteria(int page, int perPageNum) {
		super(page, perPageNum);
	}

	private String searchType ="";
	private String keyword = "";
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
}
