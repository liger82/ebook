package kr.book.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class BookInsertFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String admin_id =(String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		
		return "/views/book/bookInsertForm.jsp";
	}

}
