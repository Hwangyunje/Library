package com.lib.fin.book;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lib.fin.schedule.ScheduleVO;
@Controller
@RequestMapping("/book/*")
public class BookControl {
	
	@Autowired
	private BookService bookservice;
	
	@GetMapping("booklist")
	public String getBooklist() throws Exception {
		return "book/booklist";
	}
	
	@PostMapping("add")
	public String setBookAdd(HttpServletRequest request, BookVO bookVO)throws Exception{ 
			        
		 int result = bookservice.setBookAdd(bookVO);
		
		 return "redirect:./booklist";
	}
}
