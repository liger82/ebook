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
    <title>Book Detail | E-Shopper</title>
    <!-- rate -->
   <link rel="stylesheet" href="/ebook/css/jquery.rateyo.min.css"/>
    <!-- rate -->  
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
.re-modify-btn, .re-reset, .modify-btn, .delete-btn, .paging-pbutton input, .paging-button input{
  background: #f29111;
  background-image: -webkit-linear-gradient(top, #f29111, #fab561);
  background-image: -moz-linear-gradient(top, #f29111, #fab561);
  background-image: -ms-linear-gradient(top, #f29111, #fab561);
  background-image: -o-linear-gradient(top, #f29111, #fab561);
  background-image: linear-gradient(to bottom, #f29111, #fab561);
  -webkit-border-radius: 10;
  -moz-border-radius: 10;
  border-radius: 10px;
  font-family: Arial;
  color: #4d1212;
  font-size: 10px;
  padding: 5px 12px 5px 12px;
  text-decoration: none;
}
.re-modify-btn:hover, .re-reset:hover, .modify-btn:hover, .modify-btn:hover, .delete-btn:hover, .paging-pbutton input:hover, .paging-button input:hover{
  background: #ff5100;
  background-image: -webkit-linear-gradient(top, #ff5100, #fa7705);
  background-image: -moz-linear-gradient(top, #ff5100, #fa7705);
  background-image: -ms-linear-gradient(top, #ff5100, #fa7705);
  background-image: -o-linear-gradient(top, #ff5100, #fa7705);
  background-image: linear-gradient(to bottom, #ff5100, #fa7705);
  text-decoration: none;
}
</style>
</head><!--/head-->

<body>
   <jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
   
   <section> 
      <div class="container">
         <div class="row">
             <jsp:include page="/views/module/leftCategory.jsp"/>  <!-- 왼쪽 카테고리 영역 -->
             <div class="col-sm-9 padding-right"> 
             
             <!-- Detail Page -->
             
             <div class="product-details"><!--product-details-->
                  <div class="col-sm-5">
                     <div class="view-product">
                        <img src="${book.imgFilename}" alt="" />
                        
                     </div>
                     <div id="similar-product" class="carousel slide" data-ride="carousel">
                        
                          <!-- Wrapper for slides -->
                            <div class="carousel-inner">
                              <div class="item active">
                                <a href=""><img src="${book.imgFilename}" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_1.jpg" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_5.jpg" alt=""></a>
                              </div>
                              <div class="item">
                                <a href=""><img src="${book.imgFilename}" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_3.jpg" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_4.jpg" alt=""></a>
                              </div>
                              <div class="item">
                                <a href=""><img src="${book.imgFilename}" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_2.jpg" alt=""></a>
                                <a href=""><img src="/ebook/img/ads_6.jpg" alt=""></a>
                              </div>
                              
                           </div>

                          <!-- Controls -->
                          <a class="left item-control" href="#similar-product" data-slide="prev">
                           <i class="fa fa-angle-left"></i>
                          </a>
                          <a class="right item-control" href="#similar-product" data-slide="next">
                           <i class="fa fa-angle-right"></i>
                          </a>
                     </div>

                  </div>
                  <div class="col-sm-7">
                     <div class="product-information"><!--/product-information-->
                        <img src="images/product-details/new.jpg" class="newarrival" alt="" />
                        <h3>${book.title}</h3>
                        <p>저자 : ${book.author}</p><br>
                        <!-- rating 이부분은 설명 따로 듣는게 낫겠다.-->
                        <input type="hidden" value="${rating }" id="avgRating">
                        <div class="rateyoRead"></div>
                              <div style="margin-left:10px;">평점 : <b class="rateyoread-input"></b> </div>
                        <!--  $rateyoRead.rateYo("rating", rating) 뒤에 rating이 값들어오는 부분
                             평균낸 값을 넘길때 받아온 값을 js로 다시 넘겨서 js변수로 만든다음에 rating으로 넘기면 됨   
                         -->
                        <!-- rating -->
                        <form action="../records/buyBook.do" method="post">
                        <c:if test="${!empty user_id }">
                        <input type="hidden" name="memberId" value="${user_id}">
                        </c:if>
                        <c:if test="${!empty admin_id }">
                        <input type="hidden" name="memberId" value="${admin_id}">
                        </c:if>
                        <input type="hidden" name="total_price" value="${book.price}">
                        <input type="hidden" name="case" value="${book.book_num}">
                        <span>
                           <span style="width: 100%;">KR <fmt:formatNumber value="${book.price}" type="number"/></span>
                           <button type="submit" class="btn btn-fefault cart" >
                              <i class="fa fa-krw"></i>
                              Buy Now
                           </button>                     
                           <button type="button" class="btn btn-fefault cart" onclick="location.href='../records/addToCart.do?book_num=${book.book_num}'">
                              <i class="fa fa-shopping-cart"></i>
                              Add to cart
                           </button>                           
                        
                        </span>
                        </form>
                        <br><br>
                        <p><b>Publication date:</b> ${book.pubDate}</p>
                        <p><b>Audio Book:</b> 
                        <c:if test="${book.audioLink == null}"><span style="color:red;">not support</span></c:if>
                        <c:if test="${book.audioLink != null}"><span style="color:blue;font-weight:bold;">support</span></c:if>
                        </p>
                        <a href=""><img src="images/product-details/share.png" class="share img-responsive"  alt="" /></a>
                     </div><!--/product-information-->
                  </div>
               </div><!--/product-details-->
               
               <div class="category-tab shop-details-tab"><!--category-tab-->
                  <div class="col-sm-12">
                     <ul class="nav nav-tabs">
                        <li><a href="#details" data-toggle="tab">Details</a></li>
                        <li class="active"><a href="#reviews" data-toggle="tab">Reviews (${book.re_cnt})</a></li>
                     </ul>
                  </div>
                  <div class="tab-content">
                     <div class="tab-pane fade" id="details">
                        ${book.introduction}<br><br>
                        <img src="${book.imgFilename}">
                     </div>                  
                     
                     <div class="tab-pane fade active in" id="reviews" >
                        <div id=output class="col-sm-12">
                          
                           <!-- 댓글 이미 적혀있는 걸 로드해와야 함.  -->
                          <!--  <ul>
                              <li><i class="fa fa-user"></i>member.name</li>
                              <li><i class="fa fa-calendar-o"></i>comment.re_date.날짜</li>
                              <li><i class="fa fa-star"></i>평점</li>
                           </ul>
                           <p>(리뷰 content)</p> -->
                           </div>
                           <div class="button-container">
                           <div class="paging-pbutton" style="display: none; text-align:left; height:28px;">
                           <input type="button" value="이전글 보기">                          
                           </div>
                           <div class="paging-button" style="display: none; text-align:right;">
                           <input type="button" value="다음글 보기">                           
                           </div>
                           </div>
                           <!-- 여기 까지 ajax로 댓글 처리해야됨...개빡치는 부분 예상  -->
                        
                           <b style="margin-top:20px;">Write Your Review</b>
                           
                           
                           
                           <!-- 댓글작성form -->
                           
                           
                           <form id="re_form">
                                   
                              <input type="hidden" name="book_num" value="${book.book_num }" id="book_num">
                              <c:if test="${!empty user_id }">
                              <input type="hidden" name="id" value="${user_id}" id="id">
                              </c:if>
                              <c:if test="${!empty admin_id }">
                              <input type="hidden" name="id" value="${admin_id}" id="id">
                              </c:if>
                              <textarea name="re_content" id="re_content"<c:if test="${empty user_id && empty admin_id}">disabled="disabled"</c:if>><c:if test="${empty user_id && empty admin_id}">로그인해야 작성할 수 있습니다.</c:if></textarea>
                              <div id="re_first">
                        <span class="letter-count">300/300</span>
                       </div>
                              <!-- rating -->
                              <b>Rating: </b>
                              <div class="rateyo"></div>                               
                              value : <b class="rateyo-input"></b>
                              <!-- 이걸로 값넘기면 됨  name값은 rateyo-value로 했는데 수정할꺼면 밑에 jquery도 수정해야됨-->
                              <input type="hidden" class="rateyo-value" name="rateyo-value" value="rateyo-value">
                              <!--  rating -->
                              <button type="submit" class="btn btn-default pull-right">
                                 Write
                              </button>
                            </form>
                           <!-- 댓글작성form 끝 -->
                        </div>
                     </div>
                     
                 
               </div><!--/category-tab-->
               
                <%-- 시리즈 추천 부분 시작 --%>
               <c:if test="${!empty seriesList}">
                  <div class="recommended_items"><!--recommended_items-->
                     <h2 class="title text-center">이 책의 다른 시리즈</h2>
                     <div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                           
                           <c:forEach var="sbook" items="${seriesList}" varStatus="status">
                              <%--캐러셀 3개마다 끊어서 적용하고 첫번째 3개에 active 추가하기 --%>   
                              <c:if test="${status.index==1 }">
                              <div class="item active">
                              </c:if>
                              <c:if test="${status.index!=1 && (status.index-1)%3==0 }">
                              <div class="item">   
                              </c:if>
                              
                                 <%--현재 파일일 경우 추천하지 않음. --%>
                                 <c:if test="${sbook.book_num != book.book_num }">
                                 <%--실제 하나의 북 시작 --%>
                                 <div class="col-sm-4" style="cursor: pointer;" onclick="location.href='../book/bookDetail.do?book_num=${sbook.book_num}'">
                                    <div class="product-image-wrapper">
                                       <div class="single-products">
                                          <div class="productinfo text-center">
                                             <img src="${sbook.imgFilename}" alt="" />
                                             <h2><i class="fa fa-star"></i> ${sbook.rating}</h2>
                                             <h4>KR <fmt:formatNumber value="${sbook.price}" type="number"/></h4>
                                             <p>${sbook.title }</p>
                                             <button type="button" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</button>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <%--실제 하나의 북 끝--%>
                                 </c:if>
                              <c:if test="${status.last || (status.index-3)>=0 && (status.index-3)%3==0 }">   
                              </div><!-- item end -->
                              </c:if>
                           </c:forEach> 
                                               
                        </div>
                     <%--왼쪽 버튼 --%>
                     <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
                     <i class="fa fa-angle-left"></i>
                     </a>
                     <%--오른쪽 버튼 --%>
                     <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
                     <i class="fa fa-angle-right"></i>
                     </a>
                     </div>
                  </div><!--/recommended_items-->
                </c:if>
                <%-- 시리즈 추천 부분 끝 --%>
               
             <!-- Detail Page End -->
            </div>
         </div>
      </div>
       </div>
   </section>    
   

   
<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 -->    




<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bookreply.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/jquery.scrollUp.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
 <!-- rate -->
    <script type="text/javascript" src="/ebook/js/jquery.min.js"></script>
    <script type="text/javascript" src="/ebook/js/jquery.rateyo.js"></script>

    <script>

      $(function () {  
         var avgRating = $("#avgRating").val();
         $(".rateyoread-input").text(avgRating);
          var rating = 0;
          var $rateyoRead = $(".rateyoRead").rateYo();
          $rateyoRead.rateYo("rating", avgRating).rateYo("option", "readOnly", true);
            $(".rateyo").rateYo({

              rating: rating,
              numStars: 5,
              precision: 2,
              minValue: 1,
              maxValue: 5,
              halfStar: true
             
            }).on("rateyo.change", function (e, data) {
              
              $(".rateyo-input").text(data.rating);
              $(".rateyo-value").val(data.rating);
              
              var rating = data.rating; //개인이 리뷰에서 등록한 평가점수              
            });
            
            $('.carousel-inner .item a img').click(function(){
              $('.view-product img').attr('src',$(this).attr('src'))
              return false;
           }) 
      });
    </script>
   <!-- rate -->
</body>
</html>