package kr.controller;
//2017 11 27

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet{
	private Map<String,Action> commandMap = new HashMap<String,Action>();
	
	@Override
	public void init(ServletConfig config) throws ServletException{
		
		Properties pr = new Properties(); //properties 파일 이용을 위한 클래스
		//"/WEB-INF/ActionMap.properties" 반환
		String props = config.getInitParameter("propertyConfig");
		
		//ActionMap.properties 파일의 절대 경로 구하기
		String path = config.getServletContext().getRealPath(props);
		FileInputStream fis = null;
		try {
			//파일 읽기
			fis = new FileInputStream(path);
			pr.load(fis);
		}catch(IOException e) {
			throw new ServletException(e);
		}finally {
			if(fis!=null) try {fis.close();}catch(IOException e) {}
		}
		//Properties 객체에서 key 구하기
		Iterator keyIter = pr.keySet().iterator();
		while(keyIter.hasNext()) {
			String command = (String)keyIter.next();//key
			String className = pr.getProperty(command);//value
			try {
				//문자열을 이용해 클래스를 찾아 class type으로 반환
				Class commandClass = Class.forName(className);
				
				//객체 생성
				Object commandInstance = commandClass.newInstance();
				
				//HashMap(commandMap)에 key와 value로 등록
				//HashMap<String,Action>으로 해서 value는 (Action)을 붙인다.
				commandMap.put(command, (Action)commandInstance);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request,response);
		
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request,response);
		
	}
	
	//작업용 메서드
	/*doGet, doPost 어디가 실행되어도 requestPro가 실행된다.*/
	private void requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null; //jsp path
		Action com = null; //instance implementing Model class
		String command = request.getRequestURI();
		/*System.out.println("요청 URI : "+command);
		System.out.println("요청 Context Path : "+request.getContextPath());*/
		
		//Context path가 command의 맨앞에 있으면
		if(command.indexOf(request.getContextPath())==0) {
			//context path부터 끝까지 substring -> 즉 context path 제외
			command = command.substring(request.getContextPath().length());
			/*System.out.println("command : "+command+"\n----------");*/
		}
		
		//put key HashMap to get value(model instance)
		com= commandMap.get(command);
		
		//call working method of Model class
		try {
			/*servlet호출시 생성된 request와 response 공유
			 * 데이터를 처리하고 생성된 데이터를 request에 저장한후 jsp 경로 반환*/
			view = com.execute(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
		//view가 redirect:로 시작하면
		if(view.startsWith("redirect:")) {
			//redirect
			//redirect: 제외
			view = view.substring("redirect:".length());
			response.sendRedirect(request.getContextPath()+view);

		}else {
			//forward
			//call view(jsp) in the way of forward
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);		
		}
		
	}
}
