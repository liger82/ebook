<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>Mgmt | E-Book</title>
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
.r_num:hover{
	font-size:2em;
	font-weight:bold;
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
			<h2>Total Records</h2><br>
			<table class="table table-striped record_table">
				<thead>
					<tr>
						<th class="manageBook">Record Number</th>
						<th class="manageBook">Member ID</th>						
						<th class="manageBook">Total Price</th>						
						<th class="manageBook">Date of Purchase</th>
					</tr>
				</thead>
				<tbody>
					<!-- 여기서부터 foreach로 감싸면 됨 -->
					<c:forEach var="record" items="${list}">
						<tr>
							<td><a class="r_num" href="saleRecordDetail.do?records_num=${record.records_num }">${record.records_num}</a></td>					
							<td>${record.memberId}</td>		
							<td><fmt:formatNumber value="${record.total_price}" type="number"/>원</td>
							<td>${record.purchaseDate}</td>					
						</tr>
					
					</c:forEach>
					<!-- 여기까지 foreach로 감싸면 됨 -->
					
				</tbody>
			</table>
			<div class="paging_util">
				${pagingHtml}
			</div>
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