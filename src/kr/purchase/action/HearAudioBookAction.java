package kr.purchase.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class HearAudioBookAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String admin_id = (String)session.getAttribute("admin_id");

		//login id
		String login_id = null;
		if(user_id !=null) login_id=user_id;
		else if(admin_id !=null) login_id=admin_id;

		if(login_id ==null) {
			return "redirect:/member/loginForm.do";
		}
	    
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		BookDao dao = BookDao.getInstance();
		BookDto book = dao.getBook(book_num);
		
		request.setAttribute("book", book);
		
/*		오디오북 링크 아래 이용하면됨. i값은 인덱스 시작위치 고려할것
		"../audio/${book.highLv}/${book.lowLv}/${book.title}/${book.title}"
*/		
		return "/views/records/hearAudioBook.jsp";
	}

}
