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
		
		Properties pr = new Properties(); //properties ���� �̿��� ���� Ŭ����
		//"/WEB-INF/ActionMap.properties" ��ȯ
		String props = config.getInitParameter("propertyConfig");
		
		//ActionMap.properties ������ ���� ��� ���ϱ�
		String path = config.getServletContext().getRealPath(props);
		FileInputStream fis = null;
		try {
			//���� �б�
			fis = new FileInputStream(path);
			pr.load(fis);
		}catch(IOException e) {
			throw new ServletException(e);
		}finally {
			if(fis!=null) try {fis.close();}catch(IOException e) {}
		}
		//Properties ��ü���� key ���ϱ�
		Iterator keyIter = pr.keySet().iterator();
		while(keyIter.hasNext()) {
			String command = (String)keyIter.next();//key
			String className = pr.getProperty(command);//value
			try {
				//���ڿ��� �̿��� Ŭ������ ã�� class type���� ��ȯ
				Class commandClass = Class.forName(className);
				
				//��ü ����
				Object commandInstance = commandClass.newInstance();
				
				//HashMap(commandMap)�� key�� value�� ���
				//HashMap<String,Action>���� �ؼ� value�� (Action)�� ���δ�.
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
	
	//�۾��� �޼���
	/*doGet, doPost ��� ����Ǿ requestPro�� ����ȴ�.*/
	private void requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null; //jsp path
		Action com = null; //instance implementing Model class
		String command = request.getRequestURI();
		/*System.out.println("��û URI : "+command);
		System.out.println("��û Context Path : "+request.getContextPath());*/
		
		//Context path�� command�� �Ǿտ� ������
		if(command.indexOf(request.getContextPath())==0) {
			//context path���� ������ substring -> �� context path ����
			command = command.substring(request.getContextPath().length());
			/*System.out.println("command : "+command+"\n----------");*/
		}
		
		//put key HashMap to get value(model instance)
		com= commandMap.get(command);
		
		//call working method of Model class
		try {
			/*servletȣ��� ������ request�� response ����
			 * �����͸� ó���ϰ� ������ �����͸� request�� �������� jsp ��� ��ȯ*/
			view = com.execute(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
		//view�� redirect:�� �����ϸ�
		if(view.startsWith("redirect:")) {
			//redirect
			//redirect: ����
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
