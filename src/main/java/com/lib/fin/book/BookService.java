package com.lib.fin.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class BookService {
	@Autowired
	private BookDAO bookDAO;
	
	public int setBookAdd(BookVO bookVO) throws Exception {
		return bookDAO.setBookAdd(bookVO);
	}
	
	public List<BookVO> getBooklist(BookVO bookVO) throws Exception{
		return bookDAO.getBooklist(bookVO);
	}
}
