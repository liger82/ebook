package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;
import kr.util.PagingUtil;

public class RecommendingBookListAction implements Action {

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
		
		MemberDao dao = MemberDao.getInstance();
		MemberDto member = dao.getMember(login_id);
		String mtype = member.getMtype();
		if(mtype.equals("0")) {
			return "/views/book/goToPersonalityTest.jsp";
		}
		
		//추천 책 가져오기
		//페이징
		//pageNum 처리(null이면 1page로 처리)
		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}

		int rowCount = 9; //한페이지의 게시물 수
		int pageCount = 5;//한 화면의 페이지 수
		int currentPage = Integer.parseInt(pageNum);

		BookDao dao2 = BookDao.getInstance();
		//추천 책 개수
		int cnt = dao2.getRecBookCount(mtype);
		
		PagingUtil page = new PagingUtil(currentPage, cnt, rowCount, pageCount, "recommendingBookList.do");
		//추천 책 리스트
		List<BookDto> list = null; 
		if(cnt>0) {
			list = dao2.getRecBookList(page.getStartCount(), page.getEndCount(), mtype);
		}
		//request로 보내기
		request.setAttribute("mtype", mtype);
		request.setAttribute("count", cnt);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		return "/views/book/recommendingBookList.jsp";
	}

}
