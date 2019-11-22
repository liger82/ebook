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
<title>My Library | E-Book</title>
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
<link rel="apple-touch-icon-precomposed" sizes="144x144"
   href="/ebook/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
   href="/ebook/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
   href="/ebook/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
   href="/ebook/images/ico/apple-touch-icon-57-precomposed.png">
<style type="text/css">
.case {
   align: center;
}
</style>
</head>
<!--/head-->
<body>
   <jsp:include page="/views/module/header.jsp" />
   <!-- header 영역 -->

   <section id="cart_items">
      <div class="container">
         <div class="breadcrumbs">
            <ol class="breadcrumb">
               <li><a href="../main/main.do">Home</a></li>
               <li class="active">My Library</li>
            </ol>
         </div>

         <div class="purchase_buyer_id">
            <span>My Library [ ID : ${login_id} ]</span>
         </div>
         <!-- 탭 시작-->
         <div class="category-tab shop-details-tab">
            <!--category-tab-->
            <div class="col-sm-12">
               <ul class="nav nav-tabs">
               <c:if test="${!empty tab2}">
                  <li class="tab"><a href="#library-read" data-toggle="tab">E-Book</a></li>
                  <li class="tab active"><a href="#library-listen" data-toggle="tab">Audio Book</a></li>
               </c:if>
               <c:if test="${empty tab1 && empty tab2 || !empty tab1}">
                  <li class="tab active"><a href="#library-read" data-toggle="tab">E-Book</a></li>
                  <li class="tab"><a href="#library-listen" data-toggle="tab">Audio Book</a></li>
               </c:if>
               </ul>
            </div>
            
            <div class="tab-content">
            <c:if test="${!empty tab2}">
               <div class="tab-pane fade" id="library-read">
            </c:if>
            <c:if test="${empty tab1 && empty tab2 || !empty tab1}">
               <div class="tab-pane fade active in" id="library-read">
            </c:if>
                  <!-- read -->
                  <div class="table-responsive cart_info">
                     <table class="table table-condensed">
                        <thead>
                           <tr class="cart_menu" style="height: 35px;text-align:left">
                              <td class="image">Item</td>
                              <td class="book-name">Title</td>
                              <td class="author">Author</td>                              
                              <td class="price">Price</td>
                              <td class="read">Read</td>
                           </tr>
                        </thead>
                        <tbody>
                        <!-- foreach 여기서부터 -->
                        <c:forEach var="book" items="${bookList}">
                           <tr>
                              <td class="cart_product">
                                 <img src="${book.imgFilename}" style="width:80px;height:130px" alt="">
                              </td>
                              <td class="cart_description">
                                 <h4 style="text-align:left;width:350px;margin:10px;"><a href="../book/bookDetail.do?book_num=${book.book_num}">${book.title}</a></h4>
                              </td>
                              <td class="cart_quantity">
                                 <h4 style="width:150px;">${book.author}</h4>
                              </td>
                              <td class="cart_price">
                                 <h4><fmt:formatNumber value="${book.price}" type="number"/>원</h4>
                              </td>
                              <td class="cart_price">
                                 <button id="readbook" type="button" class="btn btn-default" onclick="window.open('viewBookPage.do?book_num=${book.book_num}','book','width=1200, height=900','location=no,status=no,scrollbars=yes' )">읽기</button>
                              </td>
                              
                           </tr>
                        </c:forEach>   
                        <!-- foreach 여기까지 -->
                        </tbody>
                     </table>
                     <div style="text-align:center;margin:10px;font-size:20px;">
                        ${pagingHtml1}
                     </div>
                  </div>                  
                  <!-- read -->
               </div>
               
               <c:if test="${!empty tab2}">
                  <div class="tab-pane fade active in" id="library-listen">
               </c:if>   
               <c:if test="${empty tab1 && empty tab2 || !empty tab1}">
                  <div class="tab-pane fade" id="library-listen">
               </c:if>   
                  <!-- listen -->
                  <div class="table-responsive cart_info">
                     <table class="table table-condensed">
                        <thead>
                           <tr class="cart_menu" style="height: 35px;text-align:left">
                              <td class="image">Item</td>
                              <td class="book-name">Title</td>
                              <td class="author">Author</td>                              
                              <td class="price">Price</td>
                              <td class="read">Read</td>
                           </tr>
                        </thead>
                        <tbody>
                        <!-- foreach 여기서부터 -->
                        <c:forEach var="book" items="${audioList}">
                           <tr>
                              <td class="cart_product">
                                 <img src="${book.imgFilename}" style="width:80px;height:130px" alt="">
                              </td>
                              <td class="cart_description">
                                 <h4 style="text-align:left;width:350px;margin:10px;">${book.title}</h4>
                              </td>
                              <td class="cart_quantity">
                                 <h4 style="width:150px;">${book.author}</h4>
                              </td>
                              <td class="cart_price">
                                 <h4><fmt:formatNumber value="${book.price}" type="number"/>원</h4>
                              </td>
                              <td class="cart_price">
                                 <input type="button" class="btn btn-default" onclick="window.open('hearAudioBook.do?book_num=${book.book_num}', 'book', 'status=no, height=221, width=834, left=(window.screen.width /2) - (800/2) , top=(window.screen.height /2) - (220/2) , screenX=(window.screen.width /2) - (800/2), screenY=(window.screen.height /2) - (220/2)')" value="듣기">
                              </td>
                           </tr>
                        </c:forEach>   
                        <!-- foreach 여기까지 -->
                        </tbody>
                     </table>
                     <div style="text-align:center;margin:10px;font-size:20px;">
                        ${pagingHtml}
                     </div>
                     
                  </div>            
                  <!-- listen -->
               </div>

            </div>
         </div>
         <!--/category-tab-->
         <!-- 탭 끝 -->
      </div>
   </section>

   <jsp:include page="/views/module/footer.jsp" />
   <!-- footer 영역 -->


   <script src="/ebook/js/jquery.js"></script>
   <script src="/ebook/js/bootstrap.min.js"></script>
   <script src="/ebook/js/jquery.scrollUp.min.js"></script>
   <script src="/ebook/js/price-range.js"></script>
   <script src="/ebook/js/jquery.prettyPhoto.js"></script>
   <script src="/ebook/js/main.js"></script>

   <script type="text/javascript" charset="utf-8">
   //location.href='hearAudioBook.do?book_num=${book.book_num}'
/*    $(function(){      
      $('#hearbook').on('click',function(event){
         var popupX = (window.screen.width /2) - (800/2);      
         
         var popupY= (window.screen.height /2) - (220/2);      
         
         var booknum = ${book.book_num};
         
         window.open('hearAudioBook.do?book_num='+booknum, 'book', 'status=no, height=211, width=784, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
            
      });
   }); */
   
      /* function windowFunction(){
         alert('dd');
         var popupX = (window.screen.width /2) - (800/2);      
         
         var popupY= (window.screen.height /2) - (220/2);   
         
         var booknum = ${book.book_num};
         alert('북넘 : ' + booknum);
         window.open('hearAudioBook.do?book_num=${book.book_num}', 'book', 'status=no, height=211, width=784, left=(window.screen.width /2) - (800/2) , top=(window.screen.height /2) - (220/2) , screenX=(window.screen.width /2) - (800/2), screenY=(window.screen.height /2) - (220/2)');
         
      } */
   
   
   
   </script>
</body>
</html>