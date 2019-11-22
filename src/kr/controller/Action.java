package kr.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	//abstract method
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
}
