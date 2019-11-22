<%-- 2017 11 09 --%>
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
    <title>Cart | E-Book</title>
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
<style type="text/css">
/* .table{
   margin-bottom:3px;
}
.table-condensed thead tr td{
   vertical-align:middle;  
}
.table-condensed tbody tr td{
   text-align: center;
   vertical-align:middle;
}
.table-condensed thead tr th{
   border-top:0;
   
}
.table>thead:first-child>tr:first-child>td{
   text-align:center;
} */
</style>
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
              <li class="active">Shopping Cart</li>
            </ol>
         </div>         
      
        <div class="chkId">
         <c:if test="${!empty user_id}">
            <span class="chkIdSt">My Cart [ ID : ${user_id} ]</span> 
         </c:if>
         <c:if test="${!empty admin_id}">
            <span class="chkIdSt">My Cart [ ID : ${admin_id} ]</span> 
         </c:if>
         
         </div>
         
         <c:if test="${count==0}">
         <div class="notFoundItem" >
               저장된 상품이 없습니다
            </div>
         </c:if>
         <c:if test="${count>0}">
            <table id="basketTable" class="table table-condensed">
               <thead>
                  <tr class="cart_menu basket_menu" >
                     <td class="image">Item</td>
                     <td class="check"><input type="checkbox" id="selectall"/></td>
                     <td class="book-name">Book Title</td>
                     <td class="price">Price</td>
                     <td class="author">Author</td>                                          
                     <td class="del">Delete</td>
                  </tr>
               </thead>
               <tbody>
               <!-- foreach 여기서부터 -->
               <c:forEach var="basket" items="${list}">
                  <input type="hidden" name="memberId" id="memberId" value="${basket.memberId}">
                  <tr>
                     <td class="cart_product">
                        <img src="${basket.imgFilename}">
                     </td>
                     <td class="cart_total basket_total">
                        <!-- onclick="check(this)" -->
                        <span class="cart_total_price"><input type="checkbox" data-price="${basket.price}" class="case" name="case" id="chkBox" value="${basket.book_num}"></span>
                     </td>
                     <td class="cart_description">
                        <h4><a href="../book/bookDetail.do?book_num=${basket.book_num}">${basket.title}</a></h4>
                     </td>
                     <td class="cart_price" >
                        <h4><fmt:formatNumber value="${basket.price}" type="number"/></h4>
                     </td>
                     <td class="cart_quantity" >
                        <h4>${basket.author }</h4>
                     </td>
                     <td class="cart_delete" >
                        <a class="cart_quantity_delete" href="deleteBookInCart.do?book_num=${basket.book_num}&memberId=${basket.memberId}"><i class="fa fa-times"></i></a>
                     </td>
                  </tr>
               </c:forEach>                  
               </tbody>
               <!-- foreach 여기까지 -->
            </table>
         </c:if>
         <%--여기에 가격 넣기 --%>
         <div class="total_price">Total Payment :  <span id="total_price">0</span>&nbsp;원
            <input type="hidden" id="forTrans" name="total_price">
         </div>
         
         <div class="buyBook_button" style="">
         <button type="submit" id="buyBook" class="btn btn-default">구매하기</button>         
         </div>
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

<script type="text/javascript" charset="utf-8">
   $('#buyBook').click(function(){
       if($(".case:checked").length == 0){
          alert('상품을 선택하셔야 합니다!')
          return false;
       }
    });
        
        $(document).ready(function() {           

      
         var sum=0;
         
        
            $(".case").on("click",function(){
               //세부 체크박스에 모두 체크되어 있으면 상단의 selectall의 체크도 checked상태로 변환
                if($(".case").length == $(".case:checked").length) {
                    $("#selectall").prop("checked", true);
                } else {
                    $("#selectall").prop("checked", false);
                }
               
               var data_price = Number($(this).attr('data-price'));
               if(this.checked){
                  sum += data_price;
               }else{
                  sum -= data_price;
               }
               
               showPayment();
            });
         
            $("#selectall").click(function () {
                   var checkAll = $("#selectall").prop('checked');
                      <%-- selectall에 체크되어있으면 아래 .case란을 모두 checked상태로 바꿈. --%>
                       if (checkAll) {
                           $(".case").prop("checked", true);  
                     sum=0;                          
                           $('#chkBox:checked').each(function() { 
                              
                              var data_price = Number($(this).attr('data-price'));
                             
                             if(this.checked){
                                sum += data_price;
                             }
                             showPayment();
                           });
                       } else {
                           
                           $('#chkBox:checked').each(function() { 
                              
                              var data_price = Number($(this).attr('data-price'));
                              
                             if(this.checked){
                                sum -= data_price;
                             }
                             showPayment();
                           });
                           $(".case").prop("checked", false);    
                       }
                   });
            function showPayment(){
               $('#total_price').html(sum);
               $('#forTrans').val(sum);
            }
        } );
</script>
</body>
</html>