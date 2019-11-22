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
<div class="recommended_items"><!--recommended_items-->
	<h2 class="title text-center">AUDIO BOOK</h2>
		<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">

				<c:forEach var="sbook" items="${ABList}" varStatus="status">
					<%--캐러셀 3개마다 끊어서 적용하고 첫번째 3개에 active 추가하기 --%>
					<c:if test="${status.index==0 }">
						<div class="item active">
					</c:if>
					<c:if test="${status.index!=0 && (status.index)%3==0 }">
						<div class="item">
					</c:if>

					<%--현재 파일일 경우 추천하지 않음. --%>
					<c:if test="${sbook.book_num != book.book_num }">
						<%--실제 하나의 북 시작 --%>
						<div class="col-sm-4" style="cursor: pointer;" onclick="location.href='../book/bookDetail.do?book_num=${sbook.book_num}'">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img src="${sbook.imgFilename}" alt="" />
										<h2>KR <fmt:formatNumber value="${sbook.price}" type="number" /></h2>
										<p>${sbook.title }</p>
										<button type="button" class="btn btn-default add-to-cart" onclick="location.href='../records/addToCart.do?book_num=${sbook.book_num}'">
											<i class="fa fa-shopping-cart"></i>Add to cart
										</button>
									</div>
								</div>
							</div>
						</div>
						<%--실제 하나의 북 끝--%>
					</c:if>
					<c:if test="${status.last || (status.index-2)>=0 && (status.index-2)%3==0 }">
			</div>
			<!-- item end -->
			</c:if>
			</c:forEach>
				
			</div>
			<a class="left recommended-item-control"
				href="#recommended-item-carousel" data-slide="prev"> <i
				class="fa fa-angle-left"></i>
			</a> <a class="right recommended-item-control"
				href="#recommended-item-carousel" data-slide="next"> <i
				class="fa fa-angle-right"></i>
			</a>
		</div>
	</div><!--/recommended_items-->
</body>
</html>