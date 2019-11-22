package kr.purchase.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.BasketDto;

public class CartAction implements Action{

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
		
		PurchaseDao dao = PurchaseDao.getInstance();
		int count = dao.getBookCountInBasket(login_id);
		List<BasketDto> list = dao.getBookListInBasket(1, count, login_id); 
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		
		return "/views/records/basketForm.jsp";
	}
}
