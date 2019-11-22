package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class DeleteUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인여부체크
		HttpSession session = request.getSession();
		String user_id =(String)session.getAttribute("user_id");
		String admin_id =(String)session.getAttribute("admin_id");
				
		if(user_id==null && admin_id==null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("memberId");
		MemberDao dao = MemberDao.getInstance();
		MemberDto member = dao.getMember(id);
		boolean check = false;
		
		if(member!=null) {
			//전송된 데이터 반환 
			String pw = request.getParameter("pw");
			//비밀번호 일치여부 체크
			check = member.isCheckedPasswd(pw);
		}
		
		if(check) {
			//회원정보 삭제 
			dao.deleteMember(id);
			//로그아웃
			session.invalidate();
		}
		
		request.setAttribute("check", check);
		
		return "/views/member/deleteUser.jsp";
	}

}
