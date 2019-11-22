<%-- 2017. 12. 8. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
   <div class="col-sm-3">
      <div class="left-sidebar">
         <!-- 왼쪽 Category 메뉴 -->
         <h2>Category</h2>
         <div class="panel-group category-products" id="accordian">
            <!--category-productsr-->
            <div class="panel panel-default">
               <div class="panel-heading">
                  <h4 class="panel-title">
                     <a data-toggle="collapse" data-parent="#accordian"
                        href="#novel"> <span class="badge pull-right"><i
                           class="fa fa-plus"></i></span> 소설
                     </a>
                  </h4>
               </div>
               <div id="novel" class="panel-collapse collapse">
                  <div class="panel-body">
                     <ul>
                        <li><a href="../book/bookList.do?highLv=소설&lowLv=고전">고전 </a></li>
                        <li><a href="../book/bookList.do?highLv=소설&lowLv=추리스릴러">추리&스릴러 </a></li>
                        <li><a href="../book/bookList.do?highLv=소설&lowLv=판타지">판타지 </a></li>
                        <li><a href="../book/bookList.do?highLv=소설&lowLv=SF">SF </a></li>
                     </ul>
                  </div>
               </div>
            </div>
            <div class="panel panel-default">
               <div class="panel-heading">
                  <h4 class="panel-title">
                     <a data-toggle="collapse" data-parent="#accordian" href="#professional">
                        <span class="badge pull-right"><i class="fa fa-plus"></i></span>전문서적
                     </a>
                  </h4>
               </div>
               <div id="professional" class="panel-collapse collapse">
                  <div class="panel-body">
                     <ul>
                        <li><a href="../book/bookList.do?highLv=전문서적&lowLv=인문사회역사">인문 / 사회 / 역사</a></li>
                        <li><a href="../book/bookList.do?highLv=전문서적&lowLv=경영경제">경영 / 경제</a></li>
                        <li><a href="../book/bookList.do?highLv=전문서적&lowLv=교육">교육</a></li>
                        <li><a href="../book/bookList.do?highLv=전문서적&lowLv=과학">과학</a></li>
                        <li><a href="../book/bookList.do?highLv=전문서적&lowLv=컴퓨터IT">컴퓨터 / IT</a></li>
                     </ul>
                  </div>
               </div>
            </div>
            
            <%--에세이 / 시 --%>
            <div class="panel panel-default">
               <div class="panel-heading">
                  <h4 class="panel-title">
                     <a data-toggle="collapse" data-parent="#accordian" href="#essaypeom">
                        <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                        에세이 / 시
                     </a>
                  </h4>
               </div>
               <div id="essaypeom" class="panel-collapse collapse">
                  <div class="panel-body">
                     <ul>
                        <li><a href="../book/bookList.do?highLv=에세이시&lowLv=에세이">에세이</a></li>
                        <li><a href="../book/bookList.do?highLv=에세이시&lowLv=시">시</a></li>
                     </ul>
                  </div>
               </div>
            </div>
            <%--만화  --%>
            <div class="panel panel-default">
               <div class="panel-heading">
                  <h4 class="panel-title">
                     <a data-toggle="collapse" data-parent="#accordian" href="#comics">
                        <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                        만화
                     </a>
                  </h4>
               </div>
               <div id="comics" class="panel-collapse collapse">
                  <div class="panel-body">
                     <ul>
                        <li><a href="../book/bookList.do?highLv=만화&lowLv=액션">액션 </a></li>
                        <li><a href="../book/bookList.do?highLv=만화&lowLv=스포츠">스포츠 </a></li>
                        <li><a href="../book/bookList.do?highLv=만화&lowLv=로맨스">로맨스 </a></li>
                        <li><a href="../book/bookList.do?highLv=만화&lowLv=역사">역사 </a></li>
                     </ul>
                  </div>
               </div>
            </div>

         </div>
         <!--/category-products-->

         <div class="brands_products">
            <!--brands_products-->
            <h2>Author</h2>
            <div class="brands-name">
               <ul class="nav nav-pills nav-stacked">
                  <li><a href="#"> <span class="pull-right">(5)</span>최인호
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(4)</span>오다 에이치로
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(2)</span>조지오웰
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(2)</span>Haruichi Furudate
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(1)</span>한진수
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(1)</span>나태주
                  </a></li>
                  <li><a href="#"> <span class="pull-right">(1)</span>유병재
                  </a></li>
               </ul>
            </div>
         </div>
         <!--/brands_products-->

         <!--price-range-->
         <!-- <div class="price-range">
            <h2>Price Range</h2>
            <div class="well text-center">
               <input type="text" class="span2" value="" data-slider-min="0"
                  data-slider-max="600" data-slider-step="5"
                  data-slider-value="[250,450]" id="sl2"><br /> <b
                  class="pull-left">$ 0</b> <b class="pull-right">$ 600</b>
            </div>
         </div> -->
         <!--/price-range-->

         <div class="shipping text-center">
            <!--shipping-->
            <img id="leftAds" src="../img/leftAds2.png" alt="" />
         </div>
         <!--/shipping-->

      </div>
   </div>
</body>
</html>