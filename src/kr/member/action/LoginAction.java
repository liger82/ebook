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
		// 전송된 데이터에 대한 인코딩 
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환
		String memberId = request.getParameter("id");
		String pw = request.getParameter("passwd");
		//MemberDao 호출
		MemberDao dao = MemberDao.getInstance();
		//getMember에 id 전달하고 자바빈 변환 
		MemberDto member = dao.getMember(memberId);
		
		// 로그인 처리 시 해당 사용자 여부 체크
		boolean check = false;
		if(member!=null) {
			//비밀번호 일치 여부 체크
			check = member.isCheckedPasswd(pw);
		}
		
		//인증성공
		//로그인 처리 
		HttpSession session = request.getSession();
		if(check) {
			if(member.getLv()==0) {
				request.setAttribute("accessMsg", "탈퇴한 회원 정보입니다.");
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
