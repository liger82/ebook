<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${check}">
<script>
	alert('회원 비밀번호 수정 완료되었습니다.');
	location.href='../main/main.do';
</script>
</c:if>
<c:if test="${!check}">
<script>
	alert('기존 비밀번호가 일치하지 않습니다.');
	location.href='modifyPasswordForm.do';
</script>
</c:if>