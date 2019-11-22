<%-- 2017. 12. 22. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Result of Personality test | E-Book</title>
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
</head>
<body>
	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->   
	<div class="main-frm">
		<h2>R E S U L T</h2>
		<div id="cfrm1"> - 당신의 유형은 - </div>
		<div class="typeResult">
			<button class="btn btn-success" onclick="location.href='../main/main.do'">Home</button>
			<button class="btn btn-info" onclick="location.href='../book/recommendingBookList.do'">Recommending Book</button>
		</div>
		<div class="content-frm">
			<div class="row">
				<div class="col-md-5" style="width:30%;">
					<img src="${ptype.image}" id="typeImg"> 
				</div>
				<div class="col-md-5 explanation" style="width:67%;">
					<span id="typeName">TYPE : ${ptype.mtype}</span>
					<div id="typeExplanation">${ptype.explanation}</div>		
				</div>
			</div>
			<div id="recommend">
				<h4><i class="fa fa-book"></i> 책 추천 카테고리</h4>
				<ul>
					<c:forEach var="rec" items="${cgList}">
					<li>${rec.highLv} > <a href="bookList.do?highLv=${rec.highLv}&lowLv=${rec.lowLv}"> ${rec.lowLv}</a></li>
					</c:forEach>	
				</ul>		
			</div>
		</div>
	</div>

	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 -->    
   

<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>        
       
</body>
</html>