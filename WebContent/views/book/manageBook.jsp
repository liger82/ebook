<%-- 2017 11 09 --%>
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
    <title>Book Mgmt | E-Book</title>
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
<style type="text/css">
.table tbody tr td{
	vertical-align : middle;
}
</style>    
</head><!--/head-->
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script type="text/javascript">

</script>

<body>
	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
	<section id="form"><!--form-->
		<div class="container">
		<div class="row">
		
			<div class="insertButton">
			<button type="button" class="btn btn-default insertB" onclick="location.href='bookInsertForm.do'">책 등록하기</button>
			</div>
			
			<table class="table table-striped manageTable">
				<thead>
					<tr>
						<th class="manageBook" >대분류</th>
						<th class="manageBook" >소분류</th>
						<th class="manageBook" >책번호</th>
						<th class="manageBook" >책제목</th>
						<th class="manageBook" >작가</th>
						<th class="manageBook" >가격</th>
						<th class="manageBook" >오디오북</th>
						<th class="manageBook" >시리즈코드</th>
						<th class="manageBook" >출간일</th>
						<th class="manageBook" >등록일</th>
						<th class="manageBook" >수정</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="book" items="${list}">
					<tr>
						<td>${book.highLv}</td>  	<%--대분류--%>				
						<td>${book.lowLv}</td>		<%--소분류--%>
						<td>${book.book_num}</td>	<%--책번호--%>				
						<td>${book.title}</td>		<%--책제목--%>
						<td>${book.author}</td>		<%--작가--%>			
						<td>${book.price}</td>		<%--가격--%>
						<td>
						<c:if test="${empty book.audioLink}">
						X
						</c:if>
						<c:if test="${!empty book.audioLink}">
						O
						</c:if>
						</td>	<%--Audio링크--%>
						<td>
						<c:if test="${!empty book.seriesCode }">
						${book.seriesCode}
						</c:if>
						<c:if test="${empty book.seriesCode }">
						-
						</c:if>
						</td>	<%--시리즈코드--%>
						<td>${book.pubDate}</td>	<%--출간일--%>
						<td>${book.regDate}</td>	<%--등록일--%>	
						<td>
							<button style="font-size: 10px;"type="button" class="btn btn-default" onclick="location.href='modifyBookForm.do?book_num=${book.book_num}'">수정</button>
						</td>
<%-- 					<td>
							<button style="font-size: 10px;"type="button" class="btn btn-default" onclick="deleteBook.do?book_num=${book_num}">삭제</button>
						</td>
 --%>						
 					
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
	</div>
	</section><!--/form-->
	
	
	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 --> 	
	

<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
</body>
</html>