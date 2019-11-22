<%-- 2017 11 09 --%>
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
    <title>Home | E-Book</title>    
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
   <section id="slider"><!--slider 대문 캐러셀-->
      <div class="container">
         <div class="row">
            <div class="col-sm-12">
               <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                  <ol class="carousel-indicators">
                     <li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
                     <li data-target="#slider-carousel" data-slide-to="1" ></li>
                     <li data-target="#slider-carousel" data-slide-to="2" ></li>
                  </ol>
                  
                  <div class="carousel-inner">
                     <div class="item active" id="caro1">
                        <div class="col-sm-6">
                           <h1>Don't Eat the Marshmallow... Yet!</h1>
                           
                           <h2>호아킴 데 포사다(Joachim de Posada)</h2>
                           <div class="caro1">
                           <p><span>&nbsp;&nbsp;5&nbsp;&nbsp;</span>주  연속  베스트셀러<span>&nbsp;&nbsp;1&nbsp;&nbsp;</span>위~!</p>
                           <p><span>&nbsp;'성공'</span>&nbsp;에  대한  지혜로운 성찰</p>                           
                           <p>구입시  선착순  500명  무료쿠폰&nbsp;&nbsp;<span>가즈아아아아~~~~!!!</span></p>
                           <button type="button" class="btn btn-default get2">Get   It   Now!</button>
                           </div>
                        </div>
                        <div class="col-sm-6">
                           <img src="/ebook/images/home/book_caro1.png" class="girl img-responsive" alt="" />                           
                        </div>
                     </div>
                     <div class="item" id="caro2">
                        <div class="col-sm-6">
                           <h1><span>꾸뻬</span>  씨의  행복  여행</h1>
                           <h2>François Lelord</h2>
                           <p>Hector is a quirky psychiatrist who has become increasingly tired of his humdrum life. He tells his girlfriend, Clara, that he needs to go on a journey to research happiness. </p>
                           <button type="button" class="btn btn-default get1">지금 바로 만나보세요</button>
                        </div>
                        <div class="col-sm-6">
                           <img src="/ebook/images/home/book_caro2.png" class="girl img-responsive" alt="" />                           
                        </div>
                     </div>
                     
                      <div class="item" id="caro3">
                        <div class="col-sm-6">
                           <h1><span>너</span>도 그렇다</h1>
                           <h1 class="caro3h1"><span>오</span>래 보아야 예쁘다</h1>
                           <h2>나  태  주</h2>
                           <p> 자세히 보아야. 예쁘다. 오래 보아야. 사랑스럽다. 너도 그렇다.</p>
                           <button type="button" class="btn btn-default get">지금 바로 만나보세요</button>
                        </div>
                        <div class="col-sm-6">
                           <img src="/ebook/images/home/book_caro3.png" class="girl img-responsive" alt="" />                           
                        </div>
                     </div>
                     
                  </div>
                  
                  <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                     <i class="fa fa-angle-left"></i>
                  </a>
                  <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                     <i class="fa fa-angle-right"></i>
                  </a>
               </div>
               
            </div>
         </div>
      </div>
   </section><!--/slider-->
   <section> 
      <div class="container">
         <div class="row">
             <jsp:include page="/views/module/leftCategory.jsp"/>  <!-- 왼쪽 카테고리 영역 -->
             <div class="col-sm-9 padding-right"> 
             <jsp:include page="/views/module/centerList.jsp"/>  <!-- 가운데 Featured Item 영역 -->
             <jsp:include page="/views/module/recommendedNew.jsp"/>  <!-- MD추천 영역 -->
             <jsp:include page="/views/module/recommendedAB.jsp"/>  <!-- NEW 영역 -->
            </div>
         </div>
      </div>
   </section>      
   <jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 -->    
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
      /*  */
         /* console.log($('#caro1').hasClass('active')); */
         $('#slider-carousel').on('slid.bs.carousel', function (e) {
            console.log($('.carousel-inner div.active').index());
            if($('.carousel-inner div.active').index()=='0'){            
               $('#slider').css('background-color','#D2EFF7');
            }else if($('.carousel-inner div.active').index()=='1'){
               $('#slider').css('background-color','#F5F5DC');
            }else if($('.carousel-inner div.active').index()=='2'){
               $('#slider').css('background-color','#FCEBF3');
            } 
         });         

      
   });
</script>
</body>
</html>