<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	session.invalidate();
	response.sendRedirect("01_main.jsp");
%>