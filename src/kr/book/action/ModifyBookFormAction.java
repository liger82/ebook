package kr.book.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class ModifyBookFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String admin_id =(String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		
		BookDao dao =BookDao.getInstance();
		BookDto book =dao.getBook(book_num);
		request.setAttribute("book", book);
		
		return "/views/book/modifyBookForm.jsp";
	}

}
