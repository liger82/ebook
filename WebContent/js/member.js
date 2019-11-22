$(document).ready(function(){
	var count = 0;
	//아이디 중복 안내 메시지 초기화 및
	//아이디 중복 값 초기화
	$('#signForm #memberId').keypress(function(){
		count = 0;
		$('#message_id').text('');
	});
	
	$('#signForm #memberId').keyup(function(){
		$('#message_id').text('');//메시지 초기화
		 
		$('#loading').show();//로딩 이미지 노출
		
		$.ajax({
			url:'checkId.do',
			type:'post',
			data:{memberId:$('#memberId').val()},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				//로딩 이미지 감추기
				$('#loading').hide();
				
				if(data.result == 'idNotFound'){
					//id 미중복
					$('#message_id').css('color','#000')
					                .text('등록가능 ID');
					//아이디 중복 체크를 실행해서 중복
					//되지 않으면 count 값을 1로
					count = 1;
				}else if(data.result == 'idDuplicated'){
					$('#message_id').css('color','red')
					                .text('중복된 ID');
					$('#memberId').focus();
					count = 0;
				}else{
					count = 0;
					alert('아이디 중복 체크 오류 발생');
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				count = 0;
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//회원정보등록 유효성 체크
	$('#signForm').submit(function(){
		if($('#memberId').val()==''){
			alert('아이디를 입력하세요!');
			$('#memberId').focus();
			return false;
		}
		if(count==0){
			alert('id를 확인해주세요!');
			$('#memberId').focus();
			return false;
		}
		
		if($('#pw').val()==''){
			alert('비밀번호를 입력하세요!');
			$('#pw').focus();
			return false;
		}
		if($('#name').val()==''){
			alert('이름을 입력하세요!');
			$('#name').focus();
			return false;
		}
		if($('#email').val()==''){
			alert('이메일을 입력하세요!');
			$('#email').focus();
			return false;
		}
		if($('#phone').val()==''){
			alert('전화번호를 입력하세요!');
			$('#phone').focus();
			return false;
		}
		//성별 선택 확인하기
		if(!$(':input:radio[name=sex]:checked').val()){
			alert('성별을 선택해주세요!');
			return false;
		}
	});
	//로그인 유효성 체크
	$('#loginForm').submit(function(){
		if($('#id').val()==''){
			alert('아이디를 입력하세요!');
			$('#id').focus();
			return false;
		}
		if($('#passwd').val()==''){
			alert('비밀번호를 입력하세요!');
			$('#passwd').focus();
			return false;
		}
	});
	
	//회원정보수정 유효성 체크
	$('#modifyForm').submit(function(){
		if($('#name').val()==''){
			alert('이름을 입력하세요!');
			$('#name').focus();
			return false;
		}
		if($('#phone').val()==''){
			alert('전화번호를 입력하세요!');
			$('#phone').focus();
			return false;
		}
		if($('#email').val()==''){
			alert('이메일을 입력하세요!');
			$('#email').focus();
			return false;
		}
	});
	
	//비빌번호 수정
	$('#modifyPasswordForm').submit(function(){
		if($('#curpw').val()==''){
			alert('기존 비밀번호를 입력하세요');
			$('#curpw').focus();
			return false;
		}
		if($('#newpw').val()==''){
			alert('새로운 비밀번호를 입력하세요');
			$('#newpw').focus();
			return false;
		}
		if($('#newpw').val()==$('#curpw').val()){
			alert('기존 비밀번호와 새로운 비밀번호는 달라야 합니다.');
			$('#newpw').focus();
			return false;
		}
	});
	
	//회원탈퇴 유효성 체크
	$('#deletUserForm').submit(function(){
		if($('#pw').val()==''){
			alert('비밀번호를 입력하세요');
			$('#pw').focus();
			return false;
		}
		
	});
	
});











