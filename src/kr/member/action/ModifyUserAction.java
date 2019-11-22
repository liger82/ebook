package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class ModifyUserAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      //session���� user_id�� ���� ���� ��ȯ 
      HttpSession session = request.getSession();
      String user_id = (String)session.getAttribute("user_id");
      String admin_id = (String)session.getAttribute("admin_id");
      
      if(user_id==null && admin_id==null) {
         return "redirect:/member/loginForm.do";
      }
      //���۵� �����Ϳ� ���� ���ڵ� ó�� 
      request.setCharacterEncoding("utf-8");
      //�ڹٺ��� ���� 
      MemberDto member = new MemberDto();
      
      if(user_id!=null) {
         //���۵� �����͸� �ڹٺ� ���� 
         member.setMemberId(user_id);         
      }else if(admin_id !=null) {
         member.setMemberId(admin_id);
      }
      member.setName(request.getParameter("name"));
      member.setPhone(request.getParameter("phone"));
      member.setEmail(request.getParameter("email"));
      
      //MemberDao ȣ�� 
      MemberDao dao = MemberDao.getInstance();
      
      //updateMember�� �ڹٺ� ���� 
      dao.updateMember(member);
      
      return "/views/member/modifyUser.jsp";
   }

}