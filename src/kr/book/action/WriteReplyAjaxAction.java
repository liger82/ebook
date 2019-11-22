package kr.book.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.book.dao.BookDao;
import kr.book.domain.BookReply;
import kr.controller.Action;
import kr.util.StringUtil;

public class WriteReplyAjaxAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//HashMap ���� - haspMap�̿��ؼ� jsonData ���� ����
		HashMap<String, String> map = new HashMap<String,String>();

		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String admin_id = (String)session.getAttribute("admin_id");

		//login id
		String login_id = null;

		if(user_id !=null) login_id=user_id;
		else if(admin_id !=null) login_id=admin_id;
		
		if(login_id == null) {
			return "redirect:/member/loginForm.do";
		}else {
			request.setCharacterEncoding("utf-8");
			BookReply reply = new BookReply();						
			reply.setRe_content(request.getParameter("re_content"));			
			//�θ��(�Խñ�) ��ȣ
			reply.setBook_num(Integer.parseInt(request.getParameter("book_num")));
			reply.setRe_ip(request.getRemoteAddr());
			reply.setRating(Float.parseFloat(request.getParameter("rateyo-value")));
			
			//�ۼ���
			reply.setMemberId(login_id);

			//System.out.println(reply.getMemberId());
			BookDao dao = BookDao.getInstance();
			dao.insertReply(reply);
			//��� ����� �����ϸ� ������ ������ ����
			map.put("result", "success");

			//JSON ������ ����
			ObjectMapper mapper = new ObjectMapper();
			String jsonData = mapper.writeValueAsString(map);

			request.setAttribute("jsonData", jsonData);

		}
		return "/views/common/ajaxView.jsp";
	}

}
