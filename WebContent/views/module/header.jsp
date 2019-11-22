<%-- 2017. 12. 8. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<header id="header"><!--header-->
		<div class="header_top"><!--header_top 상단메뉴(전화번호,이메일,sns연락처)-->
			<div class="container">
				<div class="row">
					<div class="col-sm-6">
						<div class="contactinfo">
							<ul class="nav nav-pills">
								<li><a href="#"><i class="fa fa-phone"></i>010-1234-5678</a></li>
								<li><a href="#"><i class="fa fa-envelope"></i>http://www.iei.or.kr</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="social-icons pull-right">
							<ul class="nav navbar-nav">
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-twitter"></i></a></li>
								<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
								<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
								<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header_top-->
		
		<div class="header-middle"><!--header-middle(로고,장바구니,로그인)-->
			<div class="container">
				<div class="row">
					<div class="col-sm-4">
						<div class="logo pull-left">
							<a href="../main/main.do"><img src="/ebook/images/home/logo.png" alt="메인페이지로 이동" /></a>
						</div>						
					</div>
					<div class="col-sm-8">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<%-- 로그인 했을시에만 계정 탭 생성 --%>
								<c:if test="${!empty user_id || !empty admin_id}">
									<li ><a href="../records/library.do"><i class="fa fa-book"></i> My Library</a></li>
									<li><a href="../records/cart.do"><i class="fa fa-shopping-cart"></i> Cart</a></li>
									<%--<li><a href="#"><i class="fa fa-user"></i> Account</a></li>--%>
									<li class="dropdown"><a href="#"> Account<i class="fa fa-angle-down"></i></a>
	                                    <ul role="menu" class="sub-menu">
	                                        <li><a href="../member/logout.do"> Logout</a></li>
											<li><a href="../member/modifyUserForm.do"> Account Setting</a></li> 
											<li><a href="../member/modifyPasswordForm.do"> Edit Password</a></li> 
											<li><a href="../member/deleteUserForm.do"> Delete Account</a></li> 
	                                    </ul>
	                                </li>
								</c:if>
								<%-- 관리자 페이지 --%>
								<c:if test="${!empty admin_id }">
									<li class="dropdown"><a href="#"> Mgmt<i class="fa fa-angle-down"></i></a>
	                                    <ul role="menu" class="sub-menu">
	                                        <li><a href="../book/manageBook.do"> manage ebook</a></li>
											<li><a href="../member/manageMember.do"> manage member</a></li> 
											<li><a href="../records/saleRecord.do"> sales records</a></li> 
	                                    </ul>
	                                </li>
								</c:if>
								
								<%-- 회원가입과 로그인 창은 동시에 구현 --%>
								<c:if test="${empty user_id && empty admin_id}">
								<li><a href="../member/loginForm.do"><i class="fa fa-lock"></i> Signup</a></li>
								<li><a href="../member/loginForm.do"><i class="fa fa-lock"></i> Login</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->
	
		<div class="header-bottom"><!--header-bottom-->
			<div class="container">
				<div class="row">
					<div class="col-sm-9" style="width:60%">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<div class="mainmenu pull-left">
							<ul class="nav navbar-nav collapse navbar-collapse">
								<li><a href="../main/main.do" class="active">Home</a></li>
								<li class="dropdown"><a href="#">New<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="../book/newBook.do?highLv=소설">소설</a></li>
										<li><a href="../book/newBook.do?highLv=에세이시">에세시 / 시</a></li>
										<li><a href="../book/newBook.do?highLv=전문서적">전문서적</a></li>
										<li><a href="../book/newBook.do?highLv=만화">만화</a></li>
                                    </ul>
                                </li>
								<li><a href="../book/highRatingBook.do">Best</a></li>
								<li><a href="../book/audioBookList.do">Audio Book</a></li>
								<li><a href="../book/recommendingBookList.do">Recommend</a></li>
								<!-- <li><a href="#">Free</a></li> -->
							</ul>
						</div>
					</div>
					<div class="col-sm-3" style="width:40%"> <!-- 여기 form으로 둘러쌓아야됨 -->
						<form action="../book/bookList.do" method="get" id="search_form" class="search_box pull-right">
							<div class="btn-group">
								<select class="keyfieldoption" name="keyfield">
									<option value="title">Book Title</option>
									<option value="author">Author Name</option>
								</select>
							</div>
							<input type="text" name="keyword" id="keyword" placeholder="Search"/>
							<button type="submit" class="btn btn-default" >검색</button>
						</form>
					</div>
				</div>
			</div>
		</div><!--/header-bottom-->
	</header><!--/header-->
</body>
</html>