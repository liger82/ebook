package kr.purchase.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.purchase.dao.PurchaseDao;
import kr.purchase.domain.RecordsDto;
import kr.util.PagingUtil5;

public class AudioLibraryAction implements Action{

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
		
		int rowCount = 1; //한페이지의 게시물 수
		int pageCount = 5;//한 화면의 페이지 수
		
		PurchaseDao dao = PurchaseDao.getInstance();

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

		
		return "/views/records/audioLibrary.jsp";
	}

}
