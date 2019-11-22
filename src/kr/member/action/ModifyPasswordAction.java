package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class ModifyPasswordAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 체크 부분
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String admin_id =(String)session.getAttribute("admin_id");
		
		if(user_id==null && admin_id==null) {
			return "redirect:/member/loginForm.do";
		}
		request.setCharacterEncoding("utf-8");
		
		MemberDao dao = MemberDao.getInstance();
		
		MemberDto member = new MemberDto();
		
		boolean check=false;
		
		if(user_id!=null) {
			member.setMemberId(user_id);
			MemberDto Cmember = dao.getMember(user_id);
			check = Cmember.isCheckedPasswd(request.getParameter("curpw"));
		}else if(admin_id!=null) {
			member.setMemberId(admin_id);
			MemberDto Cmember = dao.getMember(admin_id);
			check = Cmember.isCheckedPasswd(request.getParameter("curpw"));
		}
		
		System.out.println(check);
		if(check) {
			member.setPw(request.getParameter("newpw"));
			
			dao.updatePassword(member);
		}
		
		session.setAttribute("check", check);
		
		return "/views/member/modifyPassword.jsp";
	}

}
