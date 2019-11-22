<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	//전송된 데이터에 대한 인코딩 처리
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Edit PW | E-Book</title>
    <script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../js/member.js"></script>
    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
	<link href="/ebook/css/main.css" rel="stylesheet">
	<link href="/ebook/css/responsive.css" rel="stylesheet">
	<link href="/ebook/css/radio.css" rel="stylesheet">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://dl.dropboxusercontent.com/u/86701580/mypersonalcdn/renda/renda-icon-font.css">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ebook/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ebook/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ebook/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ebook/images/ico/apple-touch-icon-57-precomposed.png">
</head><!--/head-->

<body>

<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
	
<section id="form"><!--form-->
	<div class="container">
		<div class="row">
				
			<div class="login-form deleteF"><!--login form-->
			<form id="modifyPasswordForm" method="post" action="modifyPassword.do">
			<c:if test="${!empty admin_id }">
			<h2>[ Administrator : ${admin_id} ] Edit Password</h2>
			</c:if>
			<c:if test="${!empty user_id }">
			<h2>[ ID : ${user_id} ] Edit Password</h2>
			</c:if>
				<%-- <input type="hidden" id="memberId" name="memberId" value="${member.memberId}" /> --%>
				<input type="password" name="curpw" id="curpw" maxlength="12" placeholder="현재 비밀번호" />
				<input type="password" name="newpw" id="newpw" maxlength="12"  placeholder="변경할 비밀번호" />
							
				<!-- radio -->
				<button type="submit" class="formButton btn btn-default" >Update</button>
			</form>
			</div>
		
		</div>
		</div>
	</section><!--/form-->
	
	
	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 --> 	
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
</body>
</html>