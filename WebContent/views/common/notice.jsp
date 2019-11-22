<%-- 2017. 12. 4. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	<title>안내 | eBook</title>    
	<link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
	<link href="/ebook/css/main.css" rel="stylesheet">
	<link href="/ebook/css/responsive.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
<div class="container">
	<div style="border:1px solid #eee;padding:20px;">
		<h2>안내</h2>
		<div class="result-display" style="text-align:center">
			${accessMsg}
			<br><br>
			<input type="button" class="btn btn-info" value="홈으로" onclick="location.href='../main/main.do'">	
		</div>
	</div>

</div>
</body>
</html>