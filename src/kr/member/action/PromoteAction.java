package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;

public class PromoteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String admin_id = (String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자만 접근 가능한 페이지입니다.");
			return "/views/common/notice.jsp";
		}
		String memberId = request.getParameter("memberId");
		MemberDao dao = MemberDao.getInstance();
		
		dao.promoteLv(memberId);
		
		request.setAttribute("memberId", memberId);
		
		return "/views/member/promote.jsp";
	}

}
