<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>
<%@ page import="user.*, evaluation.*" %>
<!doctype html>
<html>
  <head>
    <title>Tasty Or Tasteless</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 부트스트랩 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <!-- 커스텀 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/custom.css">
  </head>
  <body>
<%
	request.setCharacterEncoding("UTF-8");
	String foodMenu = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("foodMenu") != null) {
		foodMenu = request.getParameter("foodMenu");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}
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
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Tasty Or Tasteless</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbar">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdown"
					data-toggle="dropdown"> 회원 관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> 
						<a class="dropdown-item" href="userRegister.jsp">회원가입</a> 
<%
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요.">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="foodMenu" class="form-control mx-1 mt-2">
				<option value="전체">전 체</option>
				<option value="한식" <%if(foodMenu.equals("한식")) out.println("selected");%>>한 식</option>
				<option value="양식" <%if(foodMenu.equals("양식")) out.println("selected");%>>양 식</option>
				<option value="일식" <%if(foodMenu.equals("일식")) out.println("selected");%>>일 식</option>
				<option value="중식" <%if(foodMenu.equals("중식")) out.println("selected");%>>중 식</option>
				<option value="그외" <%if(foodMenu.equals("그외")) out.println("selected");%>>그 외</option>
			</select> 
			<select name="searchType" class="form-control mx-1 mt-2">
     		    <option value="최신순">최신순</option>
     		    <option value="추천순" <%if(searchType.equals("추천순")) out.println("selected");%>>추천순</option>
     		</select>
			<input type="text" name="search" class="form-control mx-1 mt-2"	placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">맛집 추천 하기</a>
			<a class="btn btn-danger ml-1 mt-2"	data-toggle="modal" href="#reportModal">신고</a>
		</form>
<%
	ArrayList<Evaluation> evaluationList = new ArrayList<Evaluation>();
	evaluationList = new EvaluationDAO().getList(foodMenu, searchType, search, pageNumber);
	if(evaluationList != null)
	for(int i = 0; i < evaluationList.size(); i++) {
		if(i == 5) break;
		Evaluation evaluation = evaluationList.get(i);
%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%=evaluation.getRestaurantName()%>&nbsp;<small><%=evaluation.getRefereeName()%></small>
					</div>
					<div class="col-4 text-right">
						종합 <span style="color: red;"><%=evaluation.getTotalScore()%></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%=evaluation.getComment()%>&nbsp;<small><%=evaluation.getAteYear()%>년 <%=evaluation.getAteMonth()%>)</small>
				</h5>
				<p class="card-text"><%=evaluation.getContent()%></p>
				<div class="row">
					<div class="col-9 text-left">
						맛 <span style="color: red;"><%=evaluation.getTasteScore()%></span>
						분위기 <span style="color: red;"><%=evaluation.getVibeScore()%></span>
						서비스 <span style="color: red;"><%=evaluation.getServiceScore()%></span> 
						<span style="color: green;">(추천: <%=evaluation.getLikeCount()%>)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID()%>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<%
	}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	 if(pageNumber <= 0) {
%>
			<a class="page-link disabled">이전</a>
<%		 
	 } else {
%>
	<a class="page-link" href="./index.jsp?foodMenu=<%=URLEncoder.encode(foodMenu, "UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber - 1 %>">이전</a>
<%
	 }
%>
		</li>
		<li>
<%
	 if(evaluationList.size() < 6) {
%>
	<a class="page-link disabled">다음</a>
<%		 
	 } else {
%>
	<a class="page-link" href="./index.jsp?foodMenu=
	<%=URLEncoder.encode(foodMenu, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>
	&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%= pageNumber + 1 %>">다음</a>
<%
	 }
%>		
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>맛집 이름</label> <input type="text" name="restaurantName"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>추천인</label> <input type="text" name="refereeName"
									class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>방문 년</label> <select name="ateYear"
									class="form-control">
									<option value="2023">2018</option>
									<option value="2011">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022" selected>2022</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>방문 월 </label> <select name="ateMonth"
									class="form-control">
									<option value="1월" selected>1 월</option>
									<option value="2월" >2 월</option>
									<option value="3월" >3 월</option>
									<option value="4월" >4 월</option>
									<option value="5월" >5 월</option>
									<option value="6월" >6 월</option>
									<option value="7월" >7 월</option>
									<option value="8월" >8 월</option>
									<option value="9월" >9 월</option>
									<option value="10월" >10 월</option>
									<option value="11월" >11 월</option>
									<option value="12월" >12 월</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>음식 분류</label> <select name="foodMenu"
									class="form-control">
									<option value="한식" selected>한 식</option>
									<option value="양식">양 식</option>
									<option value="일식">일 식</option>
									<option value="중식">중 식</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>한줄 평가</label> <input type="text" name="comment"
								class="form-control" maxlength="20">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea type="text" name="content"
								class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label> <select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>맛</label> <select name="tasteScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>분위기</label> <select name="vibeScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>서비스</label> <select name="serviceScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="./reportAction.jsp">
						<div class="form-group">
							<label>신고 제목</label> <input type="text" name="reportTitle"
								class="form-control" maxlength="20">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea type="text" name="reportContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Tasty Or Tasteless 정지용 배장호 </footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- Popper 자바스크립트 추가하기 -->
	<script src="./js/popper.min.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>
