package kr.book.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class ModifyBookAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String admin_id =(String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		request.setCharacterEncoding("utf-8");
		
		BookDto book = new BookDto();
		book.setBook_num(Integer.parseInt(request.getParameter("book_num")));
		book.setHighLv(request.getParameter("highlv"));
		book.setLowLv(request.getParameter("lowlv"));
		book.setTitle(request.getParameter("title"));
		book.setAuthor(request.getParameter("author"));
		book.setPrice(Integer.parseInt(request.getParameter("price")));
		book.setAudioLink(request.getParameter("audioLink"));
		book.setImgFilename(request.getParameter("imgFilename"));
		book.setContentFilename(request.getParameter("contentFilename"));
		book.setSeriesCode(request.getParameter("seriesCode"));
		book.setIntroduction(request.getParameter("introduction"));
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date pubDate = sf.parse(request.getParameter("pubDate"));
		java.sql.Date pubdate = new java.sql.Date(pubDate.getTime());
		book.setPubDate(pubdate);
		BookDao dao = BookDao.getInstance();
		dao.updateBookInfo(book);
		return "/views/book/modifyBook.jsp";
	}

}
