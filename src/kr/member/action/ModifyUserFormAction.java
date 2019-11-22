package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class ModifyUserFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//HttpSession 구하기 
		HttpSession session = request.getSession();
		//user_id 입력해서 값을 세션에서 반환 
		String user_id = (String)session.getAttribute("user_id");
		
		//admin_id 
		String admin_id = (String)session.getAttribute("admin_id");
		
		
		//로그인이 되어있지 않으면 loginForm으로 redirect
		if(user_id==null && admin_id==null) {
			return "redirect:/member/loginForm.do";
		}
		
		//MemberDao를 호출 
		MemberDao dao = MemberDao.getInstance();
		if(user_id !=null) {
			//getMember에 user_id를 전달해서 자바빈 변환 
			MemberDto member = dao.getMember(user_id);	
			//자바빈을 request에 저장 
			request.setAttribute("member", member);
		}else if(admin_id !=null) {
			MemberDto member = dao.getMember(admin_id);
			request.setAttribute("member", member);
		}
		
		return "/views/member/modifyUserForm.jsp";
	}

}
