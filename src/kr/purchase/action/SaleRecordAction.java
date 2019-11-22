package kr.purchase.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.RecordsDto;
import kr.util.PagingUtil;

public class SaleRecordAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String admin_id = (String)session.getAttribute("admin_id");
		if(admin_id==null) {
			request.setAttribute("accessMsg", "관리자 권한 구역입니다.");
			return "/views/common/notice.jsp";
		}
		
		int rowCount = 20; //한페이지의 게시물 수
		int pageCount = 5;//한 화면의 페이지 수
		PurchaseDao dao = PurchaseDao.getInstance();
		int count = dao.getRecordCount(null, true);//id부분이 null일경우 audio는 몰해도 상관없음.

		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		int currentPage = Integer.parseInt(pageNum);
		
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,pageCount,"saleRecord.do");
		List<RecordsDto> list = null;
		if(count>0) {
			list = dao.getTotalRecordsList(page.getStartCount(), page.getEndCount());
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		return "/views/records/saleRecord.jsp";
	}

}
