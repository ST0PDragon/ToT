<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.Evaluation"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String restaurantName = null;
	String refereeName = null;
	int ateYear = 0;
	String ateMonth = null;
	String foodMenu = null;
	String comment = null;
	String content = null;
	String totalScore = null;
	String tasteScore = null;
	String vibeScore = null;
	String serviceScore = null;
	
	if(request.getParameter("restaurantName") != null) {
		restaurantName = (String) request.getParameter("restaurantName");
	}
	if(request.getParameter("refereeName") != null) {
		refereeName = (String) request.getParameter("refereeName");
	}
	if(request.getParameter("ateYear") != null) {
		try {
			ateYear = Integer.parseInt(request.getParameter("ateYear"));
		} catch (Exception e) {
			System.out.println("방문 연도 데이터 오류");
		}
	}
	if(request.getParameter("ateMonth") != null) {
		ateMonth = (String) request.getParameter("ateMonth");
	}
	if(request.getParameter("foodMenu") != null) {
		foodMenu = (String) request.getParameter("foodMenu");
	}
	if(request.getParameter("comment") != null) {
		comment = (String) request.getParameter("comment");
	}
	if(request.getParameter("content") != null) {
		content = (String) request.getParameter("content");
	}
	if(request.getParameter("totalScore") != null) {
		totalScore = (String) request.getParameter("totalScore");
	}
	if(request.getParameter("tasteScore") != null) {
		tasteScore = (String) request.getParameter("tasteScore");
	}
	if(request.getParameter("vibeScore") != null) {
		vibeScore = (String) request.getParameter("vibeScore");
	}
	if(request.getParameter("serviceScore") != null) {
		serviceScore = (String) request.getParameter("serviceScore");
	}
	if (restaurantName == null || refereeName == null || ateYear == 0 || ateMonth == null ||
			foodMenu == null || comment == null || content == null || totalScore == null ||
					tasteScore == null || vibeScore == null || serviceScore == null ||
							comment.equals("") || content.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new Evaluation(0, userID, restaurantName, refereeName, ateYear,
				ateMonth, foodMenu, comment, content, totalScore, tasteScore, vibeScore, serviceScore, 0));
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('평가 등록에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = './index.jsp';");
			script.println("</script>");
			script.close();
			return;
		}
	}
%>