package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class SignUpUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// ���۵� �����Ϳ� ���� ���ڵ� ó��
		request.setCharacterEncoding("utf-8");
		
		//�ڹٺ� ��ü ����
		MemberDto member = new MemberDto();
		//���۵� �����͸� �ڹٺ� ���� 
		member.setMemberId(request.getParameter("memberId"));
		member.setPw(request.getParameter("pw"));
		member.setName(request.getParameter("name"));
		member.setEmail(request.getParameter("email"));
		member.setPhone(request.getParameter("phone"));
		member.setSex(request.getParameter("sex"));
		
		//MemberDao ȣ��
		MemberDao dao = MemberDao.getInstance();
		
		//insertMember�� �ڹٺ� ����
		dao.insertMember(member);
		
		return "/views/member/signup.jsp";
	}

}
