package kr.book.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class PersonalityTestAction implements Action{

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
			request.setAttribute("accessMsg", "�̹� �׽�Ʈ�� �ǽ��Ͽ����ϴ�.");
			return "/views/common/notice.jsp";
		}
		
		request.setCharacterEncoding("utf-8");
		//���� ���� �˻� �ǽ��� id
		String memberId= request.getParameter("memberId");
		
		//�����͸� ����Ʈ�� �����鼭 sum�ؼ� 
		//���⼭ if�� �ϴ���
		//mtype �ٲٱ�
		//�˻� ��� ���� ��
		int sum = 0;
		for(int i=1;i<=10;i++) {
			sum+= Integer.parseInt(request.getParameter("q"+i));
		}
		String mtype = "";

		if(sum<=20) {
			mtype="HEALER";
		}else if(sum<=30) {
			mtype="INSPECTOR";
		}else if(sum<=40) {
			mtype="SAINT";
		}else if(sum<=50) {
			mtype="SPARK";
		}else if(sum <=60) {
			mtype="INVENTOR";
		}else {
			mtype="LEADER";
		}
		dao.modifyType(memberId, mtype);
		
		request.setAttribute("member", dao.getMember(memberId));
		
		request.setAttribute("ptype", dao.getPtype(mtype));
		request.setAttribute("cgList", dao.getCategory(mtype));
		
		return "/views/book/test-result.jsp";
	}

}
