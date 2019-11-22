<%-- 2017. 12. 13. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Best Rating ebook | E-Shopper</title>
    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
	<link href="/ebook/css/main.css" rel="stylesheet">
	<link href="/ebook/css/responsive.css" rel="stylesheet">
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

<section id="advertisement">
		<div class="container">
			<a href="../main/main.do"><img src="../img/highAds3.PNG" alt="" /></a> <!-- 광고이미지 -->
		</div>
</section>

<section>
		<div class="container">
			<div class="row">
				<jsp:include page="/views/module/leftCategory.jsp"/>  <!-- 왼쪽 카테고리 영역 -->
				<h3> Best TOP 30 Rating eBook</h3>
				
				<c:if test="${count==0 }">
				<div class="product-information">
					등록된 상품 정보가 없습니다.
				</div>	
				</c:if>
				<c:if test="${count>0 }">
				<div class="col-sm-9 padding-right">
					<div class="features_items"><!--features_items-->
						<h2 class="title text-center">Features Items</h2>
						
						<c:forEach var="book" items="${list}" begin="0" end="${count}" varStatus="status" >
						<div class="col-sm-4" style="cursor: pointer;">
							<div class="product-image-wrapper">
								<div class="single-products" onclick="location.href='bookDetail.do?book_num=${book.book_num}'">
									<div class="productinfo text-center">
										<c:if test="${status.index<=2}">
										<h2 style="text-align:left;padding-left:10px;">TOP ${status.index+1}</h2>
										</c:if>
										<img src="${book.imgFilename}" alt="" />
										<h2><i class="fa fa-star"></i> ${book.rating}</h2>
										<h3><fmt:formatNumber value="${book.price}" type="number"/>원</h3>
										<p>${book.title}</p>
										<a href="../records/addToCart.do?book_num=${book.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
									</div>
									<div class="product-overlay">
										<div class="overlay-content">
											<h2><i class="fa fa-star"></i> ${book.rating}</h2>
											<h3><fmt:formatNumber value="${book.price}" type="number"/>원</h3>
											<p>${book.title}</p>
											<a href="../records/addToCart.do?book_num=${book.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						</c:forEach>
					
					
					<!-- <ul class="pagination">
						<li class="active"><a href="">1</a></li>
						<li><a href="">2</a></li>
						<li><a href="">3</a></li>
						<li><a href="">&raquo;</a></li>
					</ul> -->
				</div>
				</div>
				</c:if>
			</div>
		</div>
	</section>

	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 --> 	
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
</body>
</html>