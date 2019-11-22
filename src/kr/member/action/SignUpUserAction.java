package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class SignUpUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 전송된 데이터에 대한 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//자바빈 객체 생성
		MemberDto member = new MemberDto();
		//전송된 데이터를 자바빈에 저장 
		member.setMemberId(request.getParameter("memberId"));
		member.setPw(request.getParameter("pw"));
		member.setName(request.getParameter("name"));
		member.setEmail(request.getParameter("email"));
		member.setPhone(request.getParameter("phone"));
		member.setSex(request.getParameter("sex"));
		
		//MemberDao 호출
		MemberDao dao = MemberDao.getInstance();
		
		//insertMember에 자바빈 전달
		dao.insertMember(member);
		
		return "/views/member/signup.jsp";
	}

}
