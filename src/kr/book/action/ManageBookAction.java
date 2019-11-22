package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class ManageBookAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String admin_id =(String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		BookDao dao = BookDao.getInstance();
		int cnt= dao.getBookCount();
		List<BookDto> list = dao.getBookList(0,cnt,"","");
		request.setAttribute("list", list);
		return "/views/book/manageBook.jsp";
	}

}
