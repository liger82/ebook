package kr.purchase.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.BasketDto;

public class DeleteBookInCartAction implements Action{

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

		int book_num = Integer.parseInt(request.getParameter("book_num"));
		PurchaseDao dao = PurchaseDao.getInstance();
		
		String buyerId = request.getParameter("memberId");
		
		
		if(!buyerId.equals(login_id)) {
			request.setAttribute("accessMsg", "타인의 장바구니 내 상품 목록을 삭제할 수 없습니다.");
			return "/views/common/notice.jsp";
		}
		
		dao.deleteBookInBasket(buyerId,book_num);
		
		
		return "redirect:/records/cart.do";
	}

}
