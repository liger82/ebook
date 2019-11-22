package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class ModifyPasswordFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인여부체크
		HttpSession session = request.getSession();
		String user_id =(String)session.getAttribute("user_id");
		String admin_id =(String)session.getAttribute("admin_id");
		
		if(user_id==null && admin_id==null) {
			return "redirect:/member/loginForm.do";
		}
		
		return "/views/member/modifyPasswordForm.jsp";
	}

}
