package kr.purchase.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;

public class BuyBookAction implements Action{

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
		
		request.setCharacterEncoding("utf-8");
		
		String buyerId= request.getParameter("memberId");
		
		int total_price = Integer.parseInt(request.getParameter("total_price"));
		String[] booknums = request.getParameterValues("case"); 
		BookDao dao2 = BookDao.getInstance();
		BookDto book = null;
		PurchaseDao dao = PurchaseDao.getInstance();
		
		//두번  사거나 장바구니에 있는 상품 못삼.
		if(booknums.length==1) {
			if(dao.checkSellDuplicate(Integer.parseInt(booknums[0]), login_id)) {
				return "/views/records/duplicateMsg.jsp";
			}
		}
		
		int[] booknumList= new int[booknums.length];
		List<BookDto> bookList = new ArrayList<BookDto>();
		for(int i = 0;i<booknums.length;i++) {
			//숫자로 바꿔서 int형 배열에 삽입
			booknumList[i]=Integer.parseInt(booknums[i]);
			//book 객체 생성
			book = dao2.getBook(booknumList[i]);
			//리스트에 담기
			bookList.add(book);
			//구매한 책 장바구니에서 삭제
			dao.deleteBookInBasket(buyerId,booknumList[i]);
			
			if(i==0) {
				dao.buyBook(booknumList[i], buyerId,total_price, true);
			}else {
				dao.buyBook(booknumList[i], buyerId,total_price, false);
			}
		}
		
		request.setAttribute("buyerId", buyerId);
		request.setAttribute("total_price", total_price);
		
		request.setAttribute("bookList", bookList);
		
		return "/views/records/buyBook.jsp";
	}

}
