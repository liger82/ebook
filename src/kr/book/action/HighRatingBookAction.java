package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class HighRatingBookAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BookDao dao = BookDao.getInstance();
		int count = dao.getHighRatingBookCount(4);

		List<BookDto> list = null;
		if(count>0) {
			list=dao.getBestRatingList(1, 30, 4);
		}

		request.setAttribute("count", count);
		request.setAttribute("list", list);
		
		return "/views/book/highRatingBook.jsp";
	}

}
