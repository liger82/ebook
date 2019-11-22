package kr.purchase.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;

public class AddToCartAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String admin_id = (String)session.getAttribute("admin_id");
		
		//login id
		String login_id = null;
		if(user_id !=null) login_id=user_id;
		else if(admin_id !=null) login_id=admin_id;
		
		if(login_id==null) {
			return "redirect:/member/loginForm.do";
		}
		
		int book_num = Integer.parseInt(request.getParameter("book_num"));
		
		PurchaseDao dao = PurchaseDao.getInstance();
		
		//중복되었으면 못넣음.
		if(dao.checkBasketDuplicate(book_num, login_id)) {
			return "/views/records/duplicateMsg.jsp";
		}
		
		dao.putInBasket(book_num, login_id);
		
		return "/views/records/addToCart.jsp";
	}

}
