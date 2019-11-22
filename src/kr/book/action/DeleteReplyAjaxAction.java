package kr.book.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.book.dao.BookDao;
import kr.controller.Action;

public class DeleteReplyAjaxAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> map = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String admin_id = (String)session.getAttribute("admin_id");
		
		//login id
		String login_id = null;
		if(user_id !=null) login_id=user_id;
		else if(admin_id !=null) login_id=admin_id;
		
		int re_num = Integer.parseInt(request.getParameter("re_num"));
		String writer_id = request.getParameter("id");
		
		if(login_id == null) {
			map.put("result", "logout");
		}else if(login_id != null && login_id.equals(writer_id)) {
			BookDao dao = BookDao.getInstance();
			dao.deleteBookReply(re_num);
			map.put("result", "success");
		}else {
			map.put("result", "wrongAccess");
		}
		
		//json data·Î º¯È¯
		ObjectMapper mapper = new ObjectMapper();
		String jsonData = mapper.writeValueAsString(map);
		
		request.setAttribute("jsonData", jsonData);
		
		return "/views/common/ajaxView.jsp";
	}

}
