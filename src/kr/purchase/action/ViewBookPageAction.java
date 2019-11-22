package kr.purchase.action;



import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.book.dao.BookDao;
import kr.book.domain.BookDto;
import kr.controller.Action;

public class ViewBookPageAction implements Action{

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
      BookDao dao = BookDao.getInstance();
      BookDto book = dao.getBook(book_num);
      
      String path = "D:\\STUDY\\Web\\workspace\\ebook\\WebContent\\img\\"+book.getHighLv()+"\\"+book.getLowLv()+"\\"+book.getTitle();
      File f = new File( path );
      File[] files = f.listFiles();
     
      // files
      int count = 0;
      for (int i = 0; i < files.length; i++) {

	      if ( files[i].isFile() ) {
	    	  count++;
	      } /*else {
	    	  System.out.println( "디렉토리명 : " + files[i].getName() );
	      }*/
      } // end of for

      
      request.setAttribute("book", book);
      request.setAttribute("count", count-2);
      
      return "/views/records/viewBookPage.jsp";
   }

}