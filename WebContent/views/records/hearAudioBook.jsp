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
    <title>Audio Book | E-Book</title>
    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
    <link href="/ebook/css/main.css" rel="stylesheet">
    <link href="/ebook/css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ebook/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ebook/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ebook/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ebook/images/ico/apple-touch-icon-57-precomposed.png">
<style type="text/css">
.table tbody tr td{
   vertical-align:middle;
}
</style>
</head><!--/head-->
<body>
   <section id="cart_items" class="item_margin">
      <table id="hear_table" class="table table-condensed">

         <tr class="cart_menu hear_tr">
            <td rowspan="3" class="hear_tr_td"><img src="${book.imgFilename}"></td>
            <td class="author">Author</td>
            <td class="book-name">Book Title</td>
         </tr>

         <tr>
            <td class="tg-yw4l">${book.author }</td>
            <td class="tg-yw4ll">${book.title }</td>
         </tr>


         <tr>
            <td class="cart_product hear_audio" colspan="2">
               <audio controls>
                  <source src="../audio/${book.highLv}/${book.lowLv}/${book.title}/${book.title}.mp3"   type="audio/mp3">
               </audio>
            </td>
         </tr>

      </table>   
</section>
   <script src="/ebook/js/jquery.js"></script>
   <script src="/ebook/js/bootstrap.min.js"></script>
   <script src="/ebook/js/jquery.scrollUp.min.js"></script>
   <script src="/ebook/js/price-range.js"></script>
   <script src="/ebook/js/jquery.prettyPhoto.js"></script>
   <script src="/ebook/js/main.js"></script>
</body>
</html>