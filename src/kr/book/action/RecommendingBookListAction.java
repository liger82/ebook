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
		
		//��õ å ��������
		//����¡
		//pageNum ó��(null�̸� 1page�� ó��)
		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}

		int rowCount = 9; //���������� �Խù� ��
		int pageCount = 5;//�� ȭ���� ������ ��
		int currentPage = Integer.parseInt(pageNum);

		BookDao dao2 = BookDao.getInstance();
		//��õ å ����
		int cnt = dao2.getRecBookCount(mtype);
		
		PagingUtil page = new PagingUtil(currentPage, cnt, rowCount, pageCount, "recommendingBookList.do");
		//��õ å ����Ʈ
		List<BookDto> list = null; 
		if(cnt>0) {
			list = dao2.getRecBookList(page.getStartCount(), page.getEndCount(), mtype);
		}
		//request�� ������
		request.setAttribute("mtype", mtype);
		request.setAttribute("count", cnt);
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", page.getPagingHtml());
		return "/views/book/recommendingBookList.jsp";
	}

}
