package kr.purchase.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.RecordsDto;
import kr.util.PagingUtil4;
import kr.util.PagingUtil5;

public class LibraryAction implements Action{

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
		
		request.setAttribute("login_id", login_id);
		
		int rowCount = 10; //한페이지의 게시물 수
		int pageCount = 5;//한 화면의 페이지 수
		
		//일반 ebook 페이징
		String pageNum1 =request.getParameter("pageNum1");
		if(pageNum1==null) {
			pageNum1="1";
		}
		int currentPage1 = Integer.parseInt(pageNum1);

		PurchaseDao dao = PurchaseDao.getInstance();
		int bookCount = dao.getRecordCount(login_id, false);

		PagingUtil4 page1 = new PagingUtil4(currentPage1, bookCount, rowCount, pageCount, "library.do");
		List<RecordsDto> bookList = null;
		if(bookCount >0) {
			bookList = dao.getRecordsList(page1.getStartCount(), page1.getEndCount(), login_id, false);
		}
		
		request.setAttribute("bookCount", bookCount);
		request.setAttribute("bookList", bookList);
		request.setAttribute("pagingHtml1", page1.getPagingHtml());
		
		request.setAttribute("tab1", request.getParameter("tab1"));
		
		//오디오북 페이징
		//pageNum 처리(null이면 1page로 처리)
		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int audioCount = dao.getRecordCount(login_id, true);

		PagingUtil5 page = new PagingUtil5(currentPage, audioCount, rowCount, pageCount, "library.do");
		List<RecordsDto> audioList = null;
		if(audioCount >0) {
			audioList = dao.getRecordsList(page.getStartCount(), page.getEndCount(), login_id, true);
		}
		request.setAttribute("audioCount", audioCount);
		request.setAttribute("audioList", audioList);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		
		request.setAttribute("tab2", request.getParameter("tab2"));
		
		
		return "/views/records/library.jsp";
	}

}
