package com.lib.fin.book;

import com.lib.fin.commons.CommonVO;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter

public class BookVO extends CommonVO {

	private int book_no;
	private String book_name;
	private String book_author;
	private String book_publisher;
}
