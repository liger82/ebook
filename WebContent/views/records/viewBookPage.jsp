<%-- 2017 11 09 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>ebook | E-Book</title>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Tangerine">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Ultra">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Ribeye">
<link href='https://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
<link href="/ebook/css/slider.css" rel="stylesheet">
<link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
<link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
<link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
<link href="/ebook/css/price-range.css" rel="stylesheet">
<link href="/ebook/css/animate.css" rel="stylesheet">
<link href="/ebook/css/main.css" rel="stylesheet">
<link href="/ebook/css/responsive.css" rel="stylesheet">
<!-- owl carousel -->
<link rel="stylesheet" href="/ebook/css/owl.carousel.min.css">
<link rel="stylesheet" href="/ebook/css/owl.theme.default.min.css">
<!-- owl carousel -->
<style type="text/css">
.item {
    padding-left: 39px;
    padding-right: 31px;
}
body{
  padding:3px 0;
  
  background-attachment:fixed;
  background-size:cover;
  background-position:left;
  background-repeat:no-repeat;
  background-image:url("/ebook/img/viewbook-back.jpg");
}
img{
    height:630px;
}
</style>


</head>
<!--/head-->
<body>
   <%-- <jsp:include page="/views/module/header.jsp" /> --%>
   
	<div class="container">
		<div class="ribeye">E<span>njoy your</span>   Book!</div> 
   		<div class="title">${book.title}</div> 
	</div>
   
   <div class="owl-carousel owl-theme"  style="background-image:url('/ebook/img/book-back.png'); background-size:cover;">            
   <c:forEach begin="0" end="${count}" var="i">
      <div class="item" id="comic${i}" data-hash="${i+1}" ><img src="/ebook/img/${book.highLv}/${book.lowLv}/${book.title}/${book.title}_${i+1}.PNG"></div>
        
   </c:forEach> 
    <c:if test="${count%2 ==0 }">
      <div class=item id="comic${count}"><img src="/ebook/img/fin.png"></div>
      </c:if>   
   </div>
   
    <!-- 범위 -->
     <div class="container container-margin" >
      <div class="slider">Image Slider</div>
      <hr class="slider_hr"></hr>
     
      <div class="row">        
          <div class="range range-warning range-size">
             <form id="rangeform" oninput="rangeWarning.value=parseInt(rangeValue.value)+'/${count+1 }'">
            <input type="range" id="rangeValue" name="range" min="1" max="${count+1}" value="1" step="2" >
            
            <output id="rangeWarning" for="rangeValue" >1/${count+1}</output>
            </form>
          </div>              
      </div>

    </div>



   <script src="/ebook/js/jquery-3.2.1.min.js"></script>
   <script src="/ebook/js/bootstrap.min.js"></script>
   <script src="/ebook/js/jquery.scrollUp.min.js"></script>
   <script src="/ebook/js/price-range.js"></script>
   <script src="/ebook/js/jquery.prettyPhoto.js"></script>
   <script src="/ebook/js/main.js"></script>
   <!-- owl carousel -->
   <script type="text/javascript" src="/ebook/js/owl.carousel.js"></script>
   <!-- owl carousel -->
   <script type="text/javascript">
   $(document).ready(function(){
      var owl = $('.owl-carousel');
      $('.owl-carousel').owlCarousel({
         items:2,
          margin:2,
          nav:false,
          slideBy: 2,          
          dots:false,
          mouseDrag:false,
          URLhashListener:true,         
          startPosition: 'URLHash',
          autoplayHoverPause:true
      })
      var owl = $('.owl-carousel');
      $('.owl-carousel').find('.item').each(function(i, e){
          if(i%2==0){
             $('#comic'+i).click(function() {                          
               $('#rangeValue').val(location.hash.substring(1)-2);    
               $('#rangeWarning').html($('#rangeValue').val()+'/${count+1 }');              
               owl.trigger('prev.owl.carousel', [ 300 ]);
               })
            }else{
               $('#comic'+i).click(function() {        
                  console.log('해쉬값 : ' + location.hash);     
                 if(location.hash){
                    $('#rangeValue').val(parseInt(location.hash.substring(1))+2);
                 }else{
                    $('#rangeValue').val(3);
                 }
                  //$('#rangeValue').val(parseInt(location.hash.substring(1))+2);
                  $('#rangeWarning').html($('#rangeValue').val()+'/${count+1 }');
                  owl.trigger('next.owl.carousel');                  
               })
            }
          });   
      
         $('#rangeValue').on('mouseup',function() {
            var x = $('#rangeValue').val();
            console.log('rangeValue 값은 : ' + document.getElementById("rangeValue").value);
            console.log('1번 펑션 x값은 : ' + x);
            location.href='#'+x;       
          })
                 //keydown 이벤트
         $('html').keydown(function(e){
            console.log('rangeval : ' + $('#rangeValue').val());
           var key = e.which;       
           if(key==37){          
              $('#rangeValue').val(location.hash.substring(1)-2);    
               $('#rangeWarning').html($('#rangeValue').val()+'/${count+1 }');              
               owl.trigger('prev.owl.carousel', [ 300 ]);
           } else if(key==39){
              if(location.hash){
                   $('#rangeValue').val(parseInt(location.hash.substring(1))+2);
                }else{
                   $('#rangeValue').val(3);
                }
                 //$('#rangeValue').val(parseInt(location.hash.substring(1))+2);
                 $('#rangeWarning').html($('#rangeValue').val()+'/${count+1 }');
                 owl.trigger('next.owl.carousel');  
           }
       });
      });   
   
</script>
</body>
</html>