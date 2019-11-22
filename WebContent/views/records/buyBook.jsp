<%-- 2017 12 19--%>
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
    <title>Confirmation | E-Book</title>
    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
   <link href="/ebook/css/main.css" rel="stylesheet">
   <link href="/ebook/css/responsive.css" rel="stylesheet">
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
<body>
   <jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->   
   <section> 
      <section id="cart_items">
      <!-- form 여기서부터?? -->
      <form action="buyBook.do" id="basket_form" method="post">
      <div class="container">
         <div class="breadcrumbs">
            <ol class="breadcrumb">
              <li><a href="../main/main.do">Home</a></li>
              <li class="active">Confirmation</li>
            </ol>
         </div>         
         <div class="mytab_form">
            <ul>
               <li class="mytab_li">
                <a href="../main/main.do">Home </a>
               </li>
               <li class="mytab_li"> / </li>
               <li class="mytab_li">
                <a class="mytab_li_a" href="library.do"> My Library</a>
               </li>
            </ul>
         </div>  
         <div class="purchase_buyer_id">
            <span>List of Purchase [ ID : ${buyerId} ]</span>            
         </div>
         
         <div class="table-responsive cart_info">      
      
            <table id="buybookTable" class="table table-condensed">
               <thead>
                  <tr class="cart_menu">
                     <td class="image">Item</td>                  
                     <td class="book-name">Book Title</td>
                     <td class="author">Author</td>                                          
                     <td class="price">Price</td>
                  </tr>
               </thead>
               <tbody>
               <!-- foreach 여기서부터 -->
               <c:forEach var="book" items="${bookList}" varStatus="status">                  
                  <tr>
                     <td class="cart_product" style="width:120px;">
                        <img src="${book.imgFilename}" style="width:100px;height:150px;" alt="">
                     </td>                     
                     <td class="cart_description" style="width:380px;">
                        <h4><a href="../book/bookDetail.do?book_num=${book.book_num}">${book.title}</a></h4>
                     </td>
                     <td class="cart_quantity" style="width:300px;">
                        <h4>${book.author }</h4>
                     </td>                  
                     <td class="cart_price" style="width:150px;">
                        <h4><fmt:formatNumber value="${book.price}" type="number"/></h4>
                     </td>
                  </tr>
               </c:forEach>                  
               </tbody>
               <!-- foreach 여기까지 -->
            </table>
            <div style="border:2px solid #eee; height:48px; text-align:center; font-size:2em; margin-bottom: 150px;">Total Payment&nbsp;:&nbsp; <span style="color: #FE980F;" id="total_price">${total_price}</span>&nbsp;원
            </div>
         </div>
         <%--여기에 가격 넣기 --%>
         

      
      
      </div>
      </form>
      <!-- form 여기까지?? -->
   </section> <!--/#cart_items-->
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