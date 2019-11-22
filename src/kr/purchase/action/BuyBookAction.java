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
		
		//�ι�  ��ų� ��ٱ��Ͽ� �ִ� ��ǰ ����.
		if(booknums.length==1) {
			if(dao.checkSellDuplicate(Integer.parseInt(booknums[0]), login_id)) {
				return "/views/records/duplicateMsg.jsp";
			}
		}
		
		int[] booknumList= new int[booknums.length];
		List<BookDto> bookList = new ArrayList<BookDto>();
		for(int i = 0;i<booknums.length;i++) {
			//���ڷ� �ٲ㼭 int�� �迭�� ����
			booknumList[i]=Integer.parseInt(booknums[i]);
			//book ��ü ����
			book = dao2.getBook(booknumList[i]);
			//����Ʈ�� ���
			bookList.add(book);
			//������ å ��ٱ��Ͽ��� ����
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
