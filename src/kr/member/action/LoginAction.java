package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class LoginAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ���۵� �����Ϳ� ���� ���ڵ� 
		request.setCharacterEncoding("utf-8");
		//���۵� ������ ��ȯ
		String memberId = request.getParameter("id");
		String pw = request.getParameter("passwd");
		//MemberDao ȣ��
		MemberDao dao = MemberDao.getInstance();
		//getMember�� id �����ϰ� �ڹٺ� ��ȯ 
		MemberDto member = dao.getMember(memberId);
		
		// �α��� ó�� �� �ش� ����� ���� üũ
		boolean check = false;
		if(member!=null) {
			//��й�ȣ ��ġ ���� üũ
			check = member.isCheckedPasswd(pw);
		}
		
		//��������
		//�α��� ó�� 
		HttpSession session = request.getSession();
		if(check) {
			if(member.getLv()==0) {
				request.setAttribute("accessMsg", "Ż���� ȸ�� �����Դϴ�.");
				return "/views/common/notice.jsp";
			}else if(member.getLv()==2) {
				session.setAttribute("admin_id", memberId);				
			}else if(member.getLv()==1) {
				session.setAttribute("user_id", memberId);				
			}
		}
		session.setAttribute("check", check);
		
		return "/views/member/login.jsp";
	}

}
