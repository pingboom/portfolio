<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
	<% 
	session.removeAttribute("log");
	session.removeAttribute("name");
	response.sendRedirect("01_main.jsp");
	%>