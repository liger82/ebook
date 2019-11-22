package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class BookDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		
		BookDao dao = BookDao.getInstance();
		BookDto book = dao.getBook(book_num);
		float rating = dao.getBookRating(book_num);
		List<BookDto> seriesList = null;
		if(book.getSeriesCode()!=null) {
			seriesList = dao.getSeriesList(book.getSeriesCode());
		}
		request.setAttribute("seriesList", seriesList);
		
		request.setAttribute("book", book);
		request.setAttribute("rating", rating);
		return "/views/book/bookDetail.jsp";
	}

}
