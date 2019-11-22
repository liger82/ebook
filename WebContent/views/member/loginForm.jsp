<%-- 2017 11 09 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>signup & login | E-Book</title>
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
<script type="text/javascript">
// $(window).resize(function() {
//   if ($(window).width() <= 600) {
//     $('#prop-type-group').removeClass('btn-group');
//     $('#prop-type-group').addClass('btn-group-vertical');
//   } else {
//     $('#prop-type-group').addClass('btn-group');
//     $('#prop-type-group').removeClass('btn-group-vertical');
//   }
// });


function check_sex(sex) {
	document.signForm.sex.value = sex;
}
</script>
<body>
 	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
	
	
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-sm-offset-1">
					<div class="login-form"><!--login form-->
						<h2>Login to your account</h2>
						<form id="loginForm" name="loginForm" method="post" action="login.do">
							<input type="text" name="id" id="id" placeholder="ID" />
							<input type="password" name="passwd" id="passwd" placeholder="Password" />
							
							<button type="submit" class="btn btn-default">Login</button>
						</form>
					</div><!--/login form-->
				</div>
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-sm-4">
					<div class="signup-form"><!--sign up form-->
						<h2>New User Signup!</h2>
						<form id="signForm" name="signForm" method="post" action="signUpUser.do">
							<input type="text" id="memberId" name="memberId" placeholder="ID" maxlength="12"/>
							ID 중복확인 : <span id="message_id"></span>
							<img src="../images/ajax-loader.gif" width="16" height="16" id="loading" style="display:none;">

							<input type="password" id="pw" name="pw" placeholder="Password"  maxlength="12"/>
							<input type="text" id="name" name="name" placeholder="Name" maxlength="12"/>							
							<input type="email" id="email" name="email" placeholder="Email Address" maxlength="40"/>
							<input type="text" id="phone" name="phone" placeholder="Phone Number" maxlength="13"/>
							<!-- radio -->
														
							 <div class="buying-selling-group" id="buying-selling-group" style="margin: 15px 0 0 48px;" data-toggle="buttons">
								<label class="btn btn-default buying-selling"> 
									<input type="radio" name="sex" id="option1" value="male" autocomplete="off" onclick="javascript:check_sex('M');">
									<span class="radio-dot"></span>
									<span class="buying-selling-word">Male</span>
								</label> <label class="btn btn-default buying-selling"> 
									<input type="radio" name="sex" id="option2" value="female" autocomplete="off" onclick="javascript:check_sex('F');">
									<span class="radio-dot"></span> 
									<span class="buying-selling-word">Female</span>
								</label>
							</div> 
							<!-- radio -->
							<button type="submit" class="btn btn-default" style="margin:15px 0 0 130px;">Signup</button>
						</form>
					</div><!--/sign up form-->
				</div>
			</div>
		</div>
	</section><!--/form-->
	
	
<%-- 	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 --> 	 --%>
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
</body>
</html>