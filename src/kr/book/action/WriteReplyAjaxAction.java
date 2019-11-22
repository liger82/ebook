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
		
		//HashMap 생성 - haspMap이용해서 jsonData 만들 목적
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
			//부모글(게시글) 번호
			reply.setBook_num(Integer.parseInt(request.getParameter("book_num")));
			reply.setRe_ip(request.getRemoteAddr());
			reply.setRating(Float.parseFloat(request.getParameter("rateyo-value")));
			
			//작성자
			reply.setMemberId(login_id);

			//System.out.println(reply.getMemberId());
			BookDao dao = BookDao.getInstance();
			dao.insertReply(reply);
			//댓글 등록이 성공하면 전송할 데이터 세팅
			map.put("result", "success");

			//JSON 데이터 생성
			ObjectMapper mapper = new ObjectMapper();
			String jsonData = mapper.writeValueAsString(map);

			request.setAttribute("jsonData", jsonData);

		}
		return "/views/common/ajaxView.jsp";
	}

}
