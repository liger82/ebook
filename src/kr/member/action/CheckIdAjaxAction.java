package kr.member.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.member.dao.MemberDao;
import kr.member.domain.MemberDto;

public class CheckIdAjaxAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//전송된 데이터에 대한 인코딩
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환 
		String memberId = request.getParameter("memberId");
		
		MemberDao dao = MemberDao.getInstance();
		MemberDto member = dao.checkId(memberId);
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		if(member == null) {
			//아이디 미중복
			map.put("result", "idNotFound");
		}else {
			//아이디 중복
			map.put("result","idDuplicated");
		}
		/*
		 * JSON 형식으로 변환하기를 원하는 문자열을 key와 value 형태로 HashMap에 저장하고 
		 * ObjectMapper를 생성해서 writeValueAsString메서드에 전달해서 
		 * 일반 문자열 데이터를 JSON 형식의 문자열 데이터로 변환 
		 */
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonData = mapper.writeValueAsString(map);
		
		request.setAttribute("jsonData", jsonData);
		
		return "/views/common/ajaxView.jsp";
	}

}
