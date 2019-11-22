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
    <title>Home | E-Book</title>
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
			<h2>Member Management</h2><br>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">레벨</th>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">성별</th>
						<th style="background-color: #eeeeee; text-align: center;">이메일</th>
						<th style="background-color: #eeeeee; text-align: center;">핸드폰</th>						
						<th style="background-color: #eeeeee; text-align: center;">테스트유형</th>
						<th style="background-color: #eeeeee; text-align: center;">등록일</th>						
						<th style="background-color: #eeeeee; text-align: center;">승격/강등</th>
						<th style="background-color: #eeeeee; text-align: center;">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${list}">
					<tr>
						<td>${member.memberId}</td>		
						<td>${member.lv}</td>
						<td>${member.name}</td>
						<td>${member.sex}</td>
						<td>${member.email}</td>
						<td>${member.phone}</td>
						<td>${member.mtype}</td>
						<td>${member.regDate}</td>
						<%--관리자 승격/ 강등 부분은 수정하지 말아주세요 --%>			
						<c:if test="${member.lv==1 }">												
						<td>
							<button style="font-size: 15px;"type="button" class="btn btn-default" onclick="location.href='promote.do?memberId=${member.memberId}'">승격</button>
						</td>
						</c:if>
						<c:if test="${member.lv==2 }">
						<td>
							<button style="font-size: 15px;"type="button" class="btn btn-default" onclick="location.href='demote.do?memberId=${member.memberId}'">강등</button>
						</td>	
						</c:if>
						<td>
							<button style="font-size: 15px;color:red"type="button" class="btn btn-default" onclick="location.href='deleteMember.do?memberId=${member.memberId}'">삭제</button>
						</td>
											
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