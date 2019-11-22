package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;
import kr.util.PagingUtil3;

public class AudioBookListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//pageNum 처리(null이면 1page로 처리)
		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		
		int rowCount = 9; //한페이지의 게시물 수
		int pageCount = 5;//한 화면의 페이지 수
		int currentPage = Integer.parseInt(pageNum);

		BookDao dao = BookDao.getInstance();
		int count = dao.getAudioBookCount();
		
		PagingUtil3 page = new PagingUtil3(null, null, currentPage, count, rowCount, pageCount, "audioBookList.do");
		List<BookDto> list = null;
		if(count>0) {
			list=dao.getAudioBookList(page.getStartCount(), page.getEndCount());
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		return "/views/book/audioBookList.jsp";
	}

}
