package kr.book.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;
import kr.util.PagingUtil3;
import kr.util.PagingUtil2;

public class BookListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		String highLv = request.getParameter("highLv");
		String lowLv= request.getParameter("lowLv");
		
		if(keyfield==null) keyfield="";
		if(keyword==null) keyword="";
		
		//pageNum ó��(null�̸� 1page�� ó��)
		String pageNum =request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		
		int rowCount = 9; //���������� �Խù� ��
		int pageCount = 5;//�� ȭ���� ������ ��
		int currentPage = Integer.parseInt(pageNum);

		BookDao dao = BookDao.getInstance();
		int count = dao.getBookCount(keyfield, keyword,highLv,lowLv);
		List<BookDto> list = null;
		
		PagingUtil3 page = null;
		PagingUtil2 page2 = null;
		
		//�˻���
		if(lowLv==null) {
			page = new PagingUtil3(keyfield, keyword, currentPage, count, rowCount, pageCount, "bookList.do");
			if(count>0) {
				list=dao.getBookList(page.getStartCount(), page.getEndCount(), keyfield, keyword);
			}
			request.setAttribute("pagingHtml", page.getPagingHtml());

		}else {
			//���ֺ�(��з�>�Һз�) �з�
			page2 = new PagingUtil2(null, null, currentPage, count, rowCount, pageCount, "bookList.do",null,highLv,lowLv);
			if(count>0) {
				list=dao.getBookList(page2.getStartCount(), page2.getEndCount(), null, null,highLv,lowLv);
			}
			request.setAttribute("pagingHtml", page2.getPagingHtml());

		}
		
		request.setAttribute("highLv", highLv);
		request.setAttribute("lowLv", lowLv);
		request.setAttribute("keyword", keyword);
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);

		return "/views/book/bookList.jsp";
	}

}
