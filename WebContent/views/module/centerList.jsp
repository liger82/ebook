<%-- 2017. 12. 8. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="features_items"><!--features_items--> <!-- 가운데 상품 메뉴 -->
	<h2 class="title text-center">Features Items</h2>
	<c:forEach var="book" items="${centerList}">
		<div class="col-sm-4" style="cursor: pointer;">
			<div class="product-image-wrapper">
				<div class="single-products"
					onclick="location.href='../book/bookDetail.do?book_num=${book.book_num}'">
					<div class="productinfo text-center">
						<img src="${book.imgFilename}" alt="" />
						<!-- 책사진 -->
						<h2><fmt:formatNumber value="${book.price}" type="number"/>원</h2>
						<p>${book.title}</p>
						<a href="../records/addToCart.do?book_num=${book.book_num}" class="btn btn-default add-to-cart"><i
							class="fa fa-shopping-cart"></i>Add to cart</a>
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
</body>
</html>