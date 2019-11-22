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
		// �α��ο���üũ
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
			//���۵� ������ ��ȯ 
			String pw = request.getParameter("pw");
			//��й�ȣ ��ġ���� üũ
			check = member.isCheckedPasswd(pw);
		}
		
		if(check) {
			//ȸ������ ���� 
			dao.deleteMember(id);
			//�α׾ƿ�
			session.invalidate();
		}
		
		request.setAttribute("check", check);
		
		return "/views/member/deleteUser.jsp";
	}

}
