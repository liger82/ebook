package kr.purchase.action;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.RecordsDto;

public class SaleRecordDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String admin_id = (String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		
		int records_num = Integer.parseInt(request.getParameter("records_num"));
		
		PurchaseDao dao = PurchaseDao.getInstance();
		List<RecordsDto> list = dao.getRecordsDetail(records_num);
		String buyerId = list.get(0).getMemberId();
		Date purchaseDate = list.get(0).getPurchaseDate();
		int total_price = list.get(0).getTotal_price();
		
		request.setAttribute("list", list);
		request.setAttribute("records_num", records_num);
		request.setAttribute("buyerId", buyerId);
		request.setAttribute("purchaseDate", purchaseDate);
		request.setAttribute("total_price", total_price);
		
		return "/views/records/saleRecordDetail.jsp";
	}

}
