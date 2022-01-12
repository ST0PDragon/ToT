<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>화면 설계</title>
<script>
	function checkLogin() {
		var form = document.loginForm;
		if(form.id.value=="") {
			alert("아이디를 입력해주세요");
			form.id.focus();
			return false;
		} else if (form.passwd.value == "") {
			alert("비밀번호를 입력해주세요");
			form.passwd.focus();
			return false;
		}else if (form.passwdcheck.value == "" || form.passwdcheck.value != form.passwd.value){
			alert("비밀번호 동일하지 않습니다.");
			form.passwdcheck.focus();
			return false;
		}
		else if (form.myname.value == "") {
			alert("이름을 입력해주세요.");
			form.passwd.focus();
			return false;
		}
		alert("등록 성공.");
	}
</script>
</head>
<body>
   <form name="loginForm" action="validation02_process.jsp" method="post">
		<input type="text" name = "id" placeholder="ID 입력"><br>
		<input type="password" name = "passwd" placeholder="비밀번호 입력"><br>
		<input type="password" name = "passwdcheck" placeholder="비밀번호 확인"><br>
		<input type = "text" name = "myname" placeholder="이름 입력"><br>
		<input type="button" value="등록" onclick="checkLogin()">
	</form>   
    

</body>
</html>
