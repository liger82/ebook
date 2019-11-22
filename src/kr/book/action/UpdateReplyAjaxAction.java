package kr.book.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.util.StringUtil;
import kr.book.dao.BookDao;
import kr.book.domain.BookReply;

public class UpdateReplyAjaxAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, String> map = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		//login id
		String login_id = null;
		String user_id = (String)session.getAttribute("user_id");
		String admin_id = (String)session.getAttribute("admin_id");
		
		if(user_id !=null) login_id=user_id;
		else if(admin_id !=null) login_id=admin_id;
		
		String writer_id = request.getParameter("id");
		
		if(login_id==null) {
			map.put("result", "logout");
		}else if(login_id!=null && login_id.equals(writer_id)) {
			BookReply reply = new BookReply();
			reply.setRe_num(Integer.parseInt(request.getParameter("re_num")));
			reply.setRe_content(StringUtil.useBrNoHtml(request.getParameter("re_content")));	
			reply.setRe_ip(request.getRemoteAddr());
			
			BookDao dao = BookDao.getInstance();
			dao.updateBookReply(reply);
			
			map.put("result", "success");
		}else {
			map.put("result", "wrongAccess");
		}
		
		//JSON 
		ObjectMapper mapper = new ObjectMapper();
		String jsonData = mapper.writeValueAsString(map);
		
		request.setAttribute("jsonData", jsonData);
		
		return "/views/common/ajaxView.jsp";
	}

}
