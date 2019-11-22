package kr.main.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class MainAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BookDao dao = BookDao.getInstance();
		List<BookDto> centerList = dao.getBestRatingList(1, 6, 0);
		
		List<BookDto> ABList = dao.getAudioBookList(1, 9);
		
		List<BookDto> newNovelList = dao.getNewBookList(1, 4, "소설");
		List<BookDto> newProList = dao.getNewBookList(1, 4, "전문서적");
		List<BookDto> newEPList = dao.getNewBookList(1, 4, "에세이시");
		List<BookDto> newComicsList = dao.getNewBookList(1, 4, "만화");

		request.setAttribute("centerList", centerList);
		request.setAttribute("ABList", ABList);
		request.setAttribute("newNovelList", newNovelList);
		request.setAttribute("newProList", newProList);
		request.setAttribute("newEPList", newEPList);
		request.setAttribute("newComicsList", newComicsList);
		
		return "/views/main/main.jsp";
	}

}
