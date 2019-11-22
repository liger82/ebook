<%-- 2017. 12. 24. --%>
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
    <title>Recommend Book List | E-Shopper</title>
    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
	<link href="/ebook/css/main.css" rel="stylesheet">
	<link href="/ebook/css/responsive.css" rel="stylesheet">
        
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ebook/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ebook/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ebook/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ebook/images/ico/apple-touch-icon-57-precomposed.png">
</head><!--/head-->
<body>
<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->

<section id="advertisement">
		<div class="container">
			<a href="../book/audioBookList.do"><img src="../img/highAds4.png" alt="meet to audiobook" /></a> <!-- 광고이미지 -->
		</div>
</section>

<section>
		<div class="container">
			<div class="row">
				<jsp:include page="/views/module/leftCategory.jsp"/>  <!-- 왼쪽 카테고리 영역 -->
				<h3> Recommending Book for <span class="label label-success">${mtype}</span> type </h3>
				
				<c:if test="${count ==0 }">
				<div class="product-information">
					등록된 상품 정보가 없습니다.
				</div>	
				</c:if>
				<c:if test="${count>0 }">
				<div class="col-sm-9 padding-right">
					<div class="features_items"><!--features_items-->
						<h2 class="title text-center">Features Items</h2>
						
						<c:forEach var="book" items="${list}" >
						<div class="col-sm-4" style="cursor: pointer;">
							<div class="product-image-wrapper">
								<div class="single-products" onclick="location.href='bookDetail.do?book_num=${book.book_num}'">
									<div class="productinfo text-center">
										<img src="${book.imgFilename}" alt="" />
										<h2><fmt:formatNumber value="${book.price}" type="number"/>원</h2>
										<p>${book.title}</p>
										<a href="../records/addToCart.do?book_num=${book.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
									</div>
									<div class="product-overlay">
										<div class="overlay-content">
											<h2><fmt:formatNumber value="${book.price}" type="number"/>원</h2>
											<p>${book.title}</p>
											<a href="../records/addToCart.do?book_num=${book.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						</c:forEach>
					
							
						
					</div><!--features_items-->
					<div class="pagination">
						${pagingHtml }
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