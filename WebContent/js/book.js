$(document).ready(function(){
	$('#registerform, #modify_form').submit(function(){
		if($('#title').val()==''){
			alert('책 제목을 입력하세요!');
			$('#title').focus();
			return false;
		}
		if($('#author').val()==''){
			alert('저자를 입력하세요!');
			$('#author').focus();
			return false;
		}
		if($('#price').val()==''){
			alert('가격을 입력하세요!');
			$('#price').focus();
			return false;
		}
		if($('#imgFilename').val()==''){
			alert('이미지경로를 넣어주세요!');
			$('#imgFilename').focus();
			return false;
		}
		if($('#contentFilename').val()==''){
			alert('내용경로를 넣어주세요!');
			$('#contentFilename').focus();
			return false;
		}
		if($('#introduction').val()==''){
			alert('소개를 입력하세요!');
			$('#introduction').focus();
			return false;
		}
		if($('#pubDate').val()==''){
			alert('출간일을 입력하세요!');
			$('#pubDate').focus();
			return false;
		}
	});	
	
	$('#test_form').submit(function(){
		for(var i=1;i<=10;i++){
			if($(':radio[name="q'+i+'"]:checked').length<1){
				alert(i+'번 질문에 답해주세요!');
				return false;
			}
		}
	});
});