package kr.book.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.book.dao.BookDao;
import kr.book.domain.BookReply;
import kr.util.PagingUtil3;

public class ListReplyAjaxAction implements Action{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      Map<String, Object> map = new HashMap<String,Object>();
      
      String pageNum = request.getParameter("pageNum");
      if(pageNum ==null) {
         pageNum = "1";
      }     
      
     
      int num = Integer.parseInt(request.getParameter("num"));
      
      int rowCount = 5; 
      int pageCount = 1; 
      int currentPage = Integer.parseInt(pageNum);
      
      BookDao dao = BookDao.getInstance();
      int count = dao.getBookReplyCount(num);
      
      PagingUtil3 page = new PagingUtil3(currentPage, count, rowCount, pageCount, null);
      
      List<BookReply> list = null;
      if(count>0) {
         list = dao.getReplyList(page.getStartCount(), page.getEndCount(), num);
      }else {
         list = Collections.emptyList();
      }
      
      map.put("count", count);
      map.put("rowCount",rowCount);
      map.put("list", list);
      
      //json data
      ObjectMapper mapper = new ObjectMapper();
      String jsonData = mapper.writeValueAsString(map);
      
      request.setAttribute("jsonData", jsonData);

      return "/views/common/ajaxView.jsp";
   }
}