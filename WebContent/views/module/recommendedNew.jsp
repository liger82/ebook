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
<div class="category-tab"><!--category-tab--><!-- MD추천메뉴 -->
						<div class="col-sm-12">
							<h2 class="title text-center">NEW BOOK</h2>
							<ul class="nav nav-tabs">
								<li><a href="#essaypoem" data-toggle="tab">에세이 & 시</a></li>
								<li><a href="#tshirt" data-toggle="tab">소설</a></li>
								<li><a href="#blaze" data-toggle="tab">전문서적</a></li>
								<li><a href="#kids" data-toggle="tab">만화</a></li>
							</ul>
						</div>
						<div class="tab-content">
						
						<%-- 에세이 & 시 essaypoem 탭 --%>
							<div class="tab-pane fade active in" id="essaypoem" >
							<c:forEach var="book1" items="${newEPList}">							
								
								<div class="col-sm-3" style="cursor: pointer;">
									<div class="product-image-wrapper">
										<div class="single-products" onclick="location.href='../book/bookDetail.do?book_num=${book1.book_num}'">
											<div class="productinfo text-center">
												<img src="${book1.imgFilename}" alt="" />
												<h2><fmt:formatNumber value="${book1.price}" type="number"/>원</h2>
						 						<p>${book1.title}</p>
												<a href="../records/addToCart.do?book_num=${book1.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
										</div>
									</div>
								</div>
								
							</c:forEach>	
							</div>
							
							<%-- 소설 novel 탭 --%>
							<div class="tab-pane fade" id="tshirt" >
							<c:forEach var="book2" items="${newNovelList}">							
								
								<div class="col-sm-3" style="cursor: pointer;">
									<div class="product-image-wrapper">
										<div class="single-products" onclick="location.href='../book/bookDetail.do?book_num=${book2.book_num}'">
											<div class="productinfo text-center">
												<img src="${book2.imgFilename}" alt="" />
												<h2><fmt:formatNumber value="${book2.price}" type="number"/>원</h2>
						 						<p>${book2.title}</p>
												<a href="../records/addToCart.do?book_num=${book2.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>	
							</div>
							<%-- 전문서적 professional 탭 --%>
							<div class="tab-pane fade" id="blaze" >
							<c:forEach var="book2" items="${newProList}">							
								
								<div class="col-sm-3" style="cursor: pointer;">
									<div class="product-image-wrapper">
										<div class="single-products" onclick="location.href='../book/bookDetail.do?book_num=${book2.book_num}'">
											<div class="productinfo text-center">
												<img src="${book2.imgFilename}" alt="" />
												<h2><fmt:formatNumber value="${book2.price}" type="number"/>원</h2>
						 						<p>${book2.title}</p>
												<a href="../records/addToCart.do?book_num=${book2.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>	
							</div>
							
							
							<%-- 만화 comics 탭 --%>
							<div class="tab-pane fade" id="kids" >
							<c:forEach var="book2" items="${newComicsList}">							
								
								<div class="col-sm-3" style="cursor: pointer;">
									<div class="product-image-wrapper">
										<div class="single-products" onclick="location.href='../book/bookDetail.do?book_num=${book2.book_num}'">
											<div class="productinfo text-center">
												<img src="${book2.imgFilename}" alt="" />
												<h2><fmt:formatNumber value="${book2.price}" type="number"/>원</h2>
						 						<p>${book2.title}</p>
												<a href="../records/addToCart.do?book_num=${book2.book_num}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>	
							
							
							
							</div>
						</div>
					</div><!--/category-tab-->
</body>
</html>