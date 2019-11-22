$(function(){
	var currentPage;
	var count;
	var rowCount;
	
	//댓글목록
	function selectData(pageNum,num){
		currentPage = pageNum;
		
		//if(pageNum ==1){
			//처음 호출 시는 해당 id의 div의 내부 내용물을 제거
			$('#output').empty();
		//}
		//로딩이미지 호출
		$('#loading').show();
		
		$.ajax({
			type:'post',
			data:{pageNum:pageNum,num:num},
			url:'listReply.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				//로딩 이미지 감추기
				$('#loading').hide()
				count = data.count;
				rowCount = data.rowCount;
				var list = data.list; 
				
				if(count<0 || list==null){
					alert('목록 호출 시 오류 발생');
				}else{
					$(list).each(function(index,item){
						var output = '<div class=reitem>'
						output += '<ul>';
						output += '<li><a href=""><i class="fa fa-user"></i>'+item.memberId+'</a></li>';						
						output += '<li><a href=""><i class="fa fa-calendar-o"></i>'+item.re_date+'</a></li>';
						output += '<li><a href=""><i class="fa fa-star"></i>'+item.rating+'</a></li>';
						output += '<div class=resubitem>'
						output += '<p class="recontent" style="width:600px;">'+item.re_content+'</p>';
						output +=' <p style="text-align:right;">'
						
						if($('#id').val() && $('#id').val()==item.memberId){
							//로그인한 아이디가 댓글 작성자 아이디와 같으면
							output +=' <input type="button" value="수정" data-num="'+ item.re_num +'" data-id="'+ item.memberId +'" class="modify-btn">';
							output +=' <input type="button" value="삭제" data-num="'+ item.re_num +'" data-id="'+ item.memberId +'" class="delete-btn">';
						}else{
							//로그인하지 않거나 작성자 id와 다를 경우							
							output +=' <input type="button" value="수정" disabled="disabled" class="modify-btn">';
							output +=' <input type="button" value="삭제" disabled="disabled" class="delete-btn">';
						}
						output += '<hr size="1" noshade>';	
						output +=' </p>';
						output += '</ul>';
						output += '</div>';
						output += '</div>';
						
						//문서 객체에 추가
						$('#output').append(output);
						
					});
					//paging button 처리
					if(currentPage >= Math.ceil(count/rowCount)){
						// 다음 페이지 없음
						//page 넘기는 버튼 숨기기
						$('.paging-button').hide();
					}else{//다음페이지 있음
						$('.paging-button').show();
					}
					//이전페이지
					if(currentPage <= 1){
						$('.paging-pbutton').hide();
					}else{
						$('.paging-pbutton').show();
					}
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide()
				alert('목록 호출시 네트워크 오류!');
			}
		});		
	}
	//이전 댓글
	$('.paging-pbutton input').click(function(){
		var pageNum = currentPage -1;
		selectData(pageNum,$('#book_num').val());
	});
	//다음 댓글 보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		var pageNum = currentPage +1;
		selectData(pageNum,$('#book_num').val());
	});
	
	//댓글 등록
	$('#re_form').submit(function(event){		
		if($('#re_content').val()==''){
			alert('내용을 입력하세요!');
			$('#re_content').focus();
			return false;
		}
		console.log($(".rateYo").rateYo("rating").val());
		if($(".rateYo").rateYo("rating").val()==''){
	         alert('평점을 입력하세요!');         
	         return false;
	      }
		//폼에 입력한 데이터를 key=value형태로 반환
		var data = $(this).serialize();
		
		//등록
		$.ajax({
			type:'post',
			data:data, //key:variable(위에 선언한 data)
			url:'writeReply.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				//data는 매개변수,지역변수, ajax가 가져옴.
				if(data.result=='logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(data.result=='success'){
					//폼 초기화
					initForm();
					
					/*댓글 작성이 성공하면 새로 삽입한 글을
					 * 포함해서 첫번재 페이지의 게시글들을 다시 호출함*/
					//num은 form 태그 내의 부모글 num을 hidden 값으로 해놓은 것을 가져온것
					selectData(1,$('#book_num').val());
					//1은 pageNum임.
					//reload
					window.location.reload();
				}else{
					alert('write ajax등록시 오류 발생!');
				}
			},
			error:function(){
				alert('등록시 네트워크 오류 발생!');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	//댓글 작성 폼 초기화
	function initForm(){
		$('#re_first .letter-count').text('300/300');
		$('textarea').val('').focus();
	}
	
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//남은 글자수를 구함
		var inputLength = $(this).val().length;
		//300자를 넘어서면
		if(inputLength>300){
			//0~300자만 계속 짤라냄.
			$(this).val($(this).val().substring(0,300));
		}else{
			var remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id')=='re_content'){
				//등록폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	//댓글 수정 버튼 클릭시 수정 폼 노출
	$(document).on('click','.modify-btn',function(){
		//댓글 글번호
		var num = $(this).attr('data-num');
		//작성자 아이디
		var id = $(this).attr('data-id');
		//댓글 내용
		//버튼(this)의 상위로 가서 p tag를 찾아 그 안의 html을 가져온다.
		var content = $(this).parent().parent().find('.recontent').html();
		console.log(content);
		//댓글 수정폼 UI
		var modifyUI = '<form id="mre_form">';
			modifyUI += '	<input type="hidden" name="re_num" id="mre_num" value="'+num+'">';
			modifyUI += '	<input type="hidden" name="id" id="muser_id" value="'+id+'">';
			modifyUI += '	<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'+content+'</textarea>';
			modifyUI += '	<div id="mre_first"><span class="letter-count">300/300</span></div>';
			modifyUI += '	<div id="mre_second" class="align-right">';
			modifyUI += '   <p style="text-align:right;">'
			modifyUI += '	<input type="submit" value="수정" class="re-modify-btn">';
			modifyUI += '	<input type="button" value="취소" class="re-reset">';
			modifyUI += '   </p>'
			modifyUI += '	</div>';
			modifyUI += '	<hr size="1" noshade width="96%">';
			modifyUI += '</form>';
			
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면 숨김 sub-item을 환원
		//수정폼 초기화
		initModifyForm();
		//수정 폼을 수정하고자하는 데이터가 있는 div에 노출
		$(this).parents('.reitem').append(modifyUI);
		
		//입력한 글자수 세팅
		var inputLength = $('#mre_content').val().length;
		var remain = 300- inputLength;
		remain += '/300';
		
		//문서객체에 반영
		$('#mre_first .letter-count').text(remain);
		
		/*지금 클릭해서 수정하고자 하는 데이터는 감추기
		* 수정버튼을 감싸고 있는 div*/
		$(this).parent().hide();		
	});
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.resubitem').show();
		//수정 폼 삭제
		$('#mre_form').remove();
	}
	
	//댓글 수정 
	$(document).on('submit','#mre_form',function(event){
		//내용 입력안하고 submit하면 
		if($('#mre_content').val()==''){
			alert('내용을 입력하세요!');
			$('#mre_content').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		var data = $(this).serialize();
		
		//수정
		$.ajax({
			type:'post',
			data:data,
			url:'updateReply.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				if(data.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(data.result == 'success'){
					$('#mre_form').parent().find('.recontent').html($('#mre_content').val());
					$('#mre_form').parent().find('p').show();
					alert('수정 완료!')
					//수정폼 초기화
					initModifyForm();
				}else if(data.result=='wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('수정시 오류발생');
				}
			},
			error:function(){
				alert('댓글 수정시 네트워크 오류!');				
			}
		});
		//기본이벤트 제거
		event.preventDefault();
	});
	
	//댓글 삭제 - 삭제버튼은 js 파일에서 만든 미래의 태그이므로 on을 사용해야한다.
	$(document).on('click','.delete-btn',function(){
		//댓글번호 - this는 event가 발생한 버튼
		var data_num = $(this).attr('data-num');
		//작성자 아이디
		var id = $(this).attr('data-id');
		
		$.ajax({
			type:'post',
			data:{re_num:data_num, id:id},
			url:'deleteReply.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				if(data.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(data.result=='success'){
					alert('삭제 완료!');
					//목록 갱신
					selectData(1,$('#book_num').val());
					//reload
					window.location.reload();
				}else if(data.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{alert('삭제오류');}
			},
			error:function(){
				alert('삭제시 네트워크 오류 발생!');
			}
			
		});
	});
	
	//초기 데이터(목록) 호출 / num은 부모글 번호
	selectData(1,$('#book_num').val());
	
});