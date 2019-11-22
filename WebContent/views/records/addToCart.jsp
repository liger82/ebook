<%-- 2017. 12. 18. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	var r = confirm('장바구니에 추가되었습니다.\n\n장바구니로 이동하시겠습니까?');
	if(r){
		location.href='../records/cart.do';
	}else{
		history.go(-1);
	}
</script>