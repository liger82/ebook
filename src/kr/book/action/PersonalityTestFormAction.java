package kr.book.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class PersonalityTestFormAction implements Action {

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
		
		MemberDao dao = MemberDao.getInstance();
		MemberDto member = dao.getMember(login_id);
		
		if(!member.getMtype().equals("0")) {
			request.setAttribute("accessMsg", "이미 테스트를 실시하였습니다.");
			return "/views/common/notice.jsp";
		}
		
		request.setAttribute("login_id", login_id);
		
		return "/views/book/personalityTestForm.jsp";
	}

}
