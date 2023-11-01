package com.lib.fin.book;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface BookDAO {

	public int setBookAdd(BookVO bookVO) throws Exception;
	
	public List<BookVO> getBooklist(BookVO bookVO) throws Exception;
	
}
