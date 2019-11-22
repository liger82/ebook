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
      //session에서 user_id를 통해 값을 반환 
      HttpSession session = request.getSession();
      String user_id = (String)session.getAttribute("user_id");
      String admin_id = (String)session.getAttribute("admin_id");
      
      if(user_id==null && admin_id==null) {
         return "redirect:/member/loginForm.do";
      }
      //전송된 데이터에 대한 인코딩 처리 
      request.setCharacterEncoding("utf-8");
      //자바빈을 생성 
      MemberDto member = new MemberDto();
      
      if(user_id!=null) {
         //전송된 데이터를 자바빈에 저장 
         member.setMemberId(user_id);         
      }else if(admin_id !=null) {
         member.setMemberId(admin_id);
      }
      member.setName(request.getParameter("name"));
      member.setPhone(request.getParameter("phone"));
      member.setEmail(request.getParameter("email"));
      
      //MemberDao 호출 
      MemberDao dao = MemberDao.getInstance();
      
      //updateMember에 자바빈 전달 
      dao.updateMember(member);
      
      return "/views/member/modifyUser.jsp";
   }

}