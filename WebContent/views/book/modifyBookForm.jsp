<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>Modify Book | E-Book</title>

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
</head><!--/head-->
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/book.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	  $("select[name=highlv]").change(function() {
	   var temp = $("select[name=lowlv]");
	   var a = $(this).val();
	   temp.children().remove();
	   temp.append('<option value="">선택하세요</option>');
	   
	    
	   if(a == '만화'){
	    temp.append('<option value="로맨스">로맨스</option>');
	    temp.append('<option value="액션">액션</option>');
	    temp.append('<option value="스포츠">스포츠</option>');
	    temp.append('<option value="역사">역사</option>');	    
	   }
	   if(a == '소설'){
	    temp.append('<option value="SF">SF</option>');
	    temp.append('<option value="고전">고전</option>');	    
	    temp.append('<option value="추리스릴러">추리&스릴러</option>');
	    temp.append('<option value="판타지">판타지</option>');
	   }
	   if(a == '에세이시'){
	    temp.append('<option value="시">시</option>');
	    temp.append('<option value="에세이">에세이</option>');
	   }
	   if(a == '전문서적'){
	    temp.append('<option value="경영경제">경영&경제</option>');
	    temp.append('<option value="과학">과학</option>');
	    temp.append('<option value="교육">교육</option>');
	    temp.append('<option value="인문사회역사">인문&사회&역사</option>');
	    temp.append('<option value="컴퓨터IT">컴퓨터&IT</option>');
	   }	   
	  });
	 });
</script>

<body>
	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				
					<div class="login-form" style="margin:0 auto; width:50%;"><!--login form-->
						<h2>Modify Book By Admin</h2>
						<form name="modify_form" id="modify_form" action="modifyBook.do" method="post"> <!-- action 집어넣고 name 집어넣을것 -->
						<input type="hidden" name="book_num" value="${book.book_num}">
						<table class="modify_table">
  <tr>
    <th class="tg-031e" colspan="2">
    <select class="selectlv form-control" name="highlv">
									<option value="">대분류</option>
								<option value="만화">만화</option>
								<option value="소설">소설</option>
								<option value="에세이시">에세이&시</option>								
								<option value="전문서적">전문서적</option>
							</select> 
    </th>
  </tr>
  <tr>
    <td class="tg-031e" colspan="2">
    <select class="selectlv form-control" name="lowlv" style="margin: 10px 0 10px 0; background-color:#faebcc;">
								<option selected value="">-선택-</option>														
							</select>
    </td>
  </tr>
  <tr>
    <td class="input_hint">제목</td>
    <td class="tg-yw4l"><input type="text" name="title" id="title" maxlength="33" value="${book.title }" /></td>
  </tr>
  <tr>
    <td class="input_hint">작가</td>
    <td class="tg-yw4l"><input type="text" name="author" id="author" value="${book.author}" /></td>
  </tr>
  <tr>
    <td class="input_hint">가격</td>
    <td class="tg-yw4l"><input type="number" name="price" id="price" min="0" maxlength="9" value="${book.price}" /></td>
  </tr>
  <tr>
    <td class="input_hint">오디오링크</td>
    <td class="tg-yw4l"><input type="text" name="audioLink" id="audioLink" maxlength="200" value="${book.audioLink}" /></td>
  </tr>
  <tr>
    <td class="input_hint">이미지파일</td>
    <td class="tg-yw4l"><input type="text" name="imgFilename" id="imgFilename" maxlength="200" value="${book.imgFilename}" /></td>
  </tr>
  <tr>
    <td class="input_hint">콘텐트파일</td>
    <td class="tg-yw4l"><input type="text" name="contentFilename" id="contentFilename" maxlength="200" value="${book.contentFilename}" /></td>
  </tr>
  <tr>
    <td class="input_hint">시리즈코드</td>
    <td class="tg-yw4l"><input type="text" name="seriesCode" id="seriesCode" maxlength="15" value="${book.seriesCode}" /></td>
  </tr>
  <tr>
    <td class="input_hint">책 소개</td>
    <td class="tg-yw4l"><textarea rows="20" name="introduction" id="introduction" >${book.introduction}</textarea></td>
  </tr>
  <tr>
    <td class="input_hint">출간일</td>
    <td class="tg-yw4l"><input style="margin-top:10px;" type="date" name="pubDate" id="pubDate" value="${book.pubDate}" /></td>
  </tr>
  <tr>
    <td class="tg-yw4l" colspan="2"><button type="submit" class="btn btn-default bookrg">Update</button></td>
  </tr>
</table>
							
							
							
							 								
							
							
							
							
							
						
							
							
							
							
							
																
							
													
							
						</form>
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