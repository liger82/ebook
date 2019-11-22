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
    <title>Personality Test | E-Book</title>

    <link href="/ebook/css/bootstrap.min.css" rel="stylesheet">
    <link href="/ebook/css/font-awesome.min.css" rel="stylesheet">
    <link href="/ebook/css/prettyPhoto.css" rel="stylesheet">
    <link href="/ebook/css/price-range.css" rel="stylesheet">
    <link href="/ebook/css/animate.css" rel="stylesheet">
	<link href="/ebook/css/main.css" rel="stylesheet">
	<link href="/ebook/css/responsive.css" rel="stylesheet">
	<link href="/ebook/css/radio.css" rel="stylesheet">
	<link href="/ebook/css/personalityTest.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://dl.dropboxusercontent.com/u/86701580/mypersonalcdn/renda/renda-icon-font.css">
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
<script src="/ebook/js/jquery.js"></script>
<script src="/ebook/js/book.js"></script>
<script src="/ebook/js/bootstrap.min.js"></script>
<body>
	<jsp:include page="/views/module/header.jsp"/>  <!-- header 영역 -->
	<section id="form"  style="margin-bottom:100px;"><!--form-->
		<div class="container">
			<div class="row pt">
				<h4 class="test-title">Personality Test For Recommending Books</h4>
				<div class="login-form pt ptfr"><!--login form-->
					<form id="test_form" class="form" action="personalityTest.do" method="post"> <!-- action 집어넣고 name 집어넣을것 -->
						<input type="hidden" name="memberId" value="${login_id}">
						<div class="col-md-6">
							<div class="form-group">
								<div class="question">1. 하루 중 제일 기분이 좋을 때는?</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q1" class="q1" value="2"><span class="label-text"> 아침</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q1" class="q1" value="4"><span class="label-text"> 오후나 이른 저녁</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q1" class="q1" value="6"><span class="label-text"> 늦은 밤</span>
									</label>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">	
								<div class="question"> 2. 나는 걸을 때, 보통... </div>
								<div class="form-check">
									<label>
										<input type="radio" name="q2" class="q2" value="6"><span class="label-text"> 보폭을 넓게, 빨리 걷는다.</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q2" class="q2" value="4"><span class="label-text"> 보폭을 좁게, 빨리 걷는다.</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q2" class="q2" value="7"><span class="label-text"> 머리를 들고 세상을 정면으로 바라보며 조금 빠르게 걷는다.</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q2" class="q2" value="2"><span class="label-text"> 바닥을 보며 조금 빠르게 걷는다.</span>
									</label>
								</div>
								<div class="form-check">
									<label>
										<input type="radio" name="q2" class="q2" value="1"><span class="label-text"> 아주 느리게 걷는다.</span>
									</label>
								</div>
							</div>
						</div>						
	                  
	                  <div class="col-md-6">
	                  	<div class="form-group">   
	                        <div class="question"> 3. 편안히 쉴 때, 나는...</div>
	                        <div class="form-check">
	                           <label>
	                              <input type="radio" name="q3" class="q3" value="4"><span class="label-text"> 다리를 굽힌 채로 나란히 두고 앉는다.</span>
	                           </label>
	                        </div>
	                        <div class="form-check">
	                           <label>
	                              <input type="radio" name="q3" class="q3" value="6"><span class="label-text"> 다리를 꼬고 앉는다.</span>
	                           </label>
	                        </div>
	                        <div class="form-check">
	                           <label>
	                              <input type="radio" name="q3" class="q3" value="2"><span class="label-text"> 다리를 쭉 펴고 앉는다.</span>
	                           </label>
	                        </div>
	                        <div class="form-check">
	                           <label>
	                              <input type="radio" name="q3" class="q3" value="1"><span class="label-text"> 한 쪽 다리를 접어 깔고 앉는다.</span>
	                           </label>
	                    	</div>
	                  	</div>
	                  </div>
	                     
						<div class="col-md-6">
	                    	<div class="form-group">   
		                        <div class="question"> 4. 사람들과 얘기할 때, 나는....</div>
		                        <div class="form-check">
		                           <label>
		                              <input type="radio" name="q4" class="q4" value="4"><span class="label-text"> 내 팔짱을 끼고 서서</span>
		                           </label>
		                        </div>
		                        <div class="form-check">
		                           <label>
		                              <input type="radio" name="q4" class="q4" value="2"><span class="label-text"> 두 손을 마주잡고</span>
		                           </label>
		                        </div>
		                        <div class="form-check">
		                           <label>
		                              <input type="radio" name="q4" class="q4" value="5"><span class="label-text"> 한 손이나 양 손을 힙에 얹고</span>
		                           </label>
		                        </div>
		                        <div class="form-check">
		                           <label>
		                              <input type="radio" name="q4" class="q4" value="7"><span class="label-text"> 얘기 나누는 상대방을 건드리거나 살짝 밀면서</span>
		                           </label>
		                        </div>
		                        <div class="form-check">
		                           <label>
		                              <input type="radio" name="q4" class="q4" value="6"><span class="label-text"> 내 귀나 턱을 만지작거리거나 손가락으로 머리를 빗으면서</span>
		                           </label>
		                        </div>
		                  	</div>
	                  	</div>
	                     
	                     <div class="col-md-6">
	                        <div class="form-group">   
	                           <div class="question"> 5. 파티나 사람들이 많이 모이는 장소에 나는...</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q5" class="q5" value="6" ><span class="label-text"> 사람들이 내 존재를 의식하도록 화려한 등장을 한다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q5" class="q5" value="4"><span class="label-text"> 아는 사람들을 찾을 수 있을까 해서 둘러보며 차분히 들어선다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q5" class="q5" value="2"><span class="label-text"> 시선을 끌지 않기 위해 할 수 있는 한 최대로 조용히 입장한다.</span>
	                              </label>
	                           </div>
	                        
	                        </div>
	                     </div>
	                     
	                     <div class="col-md-6">
	                        <div class="form-group">   
	                           <div class="question"> 6. 뭔가 아주 재미있는 일이 생겼을 때, 나는...</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q6" class="p6" value="6" ><span class="label-text"> 아주 큰 소리로 즐거움을 숨기지 않고 웃는다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q6" class="p6" value="4"><span class="label-text"> 웃지만 그다지 크지 않은 소리로 웃는다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q6" class="p6" value="3"><span class="label-text"> 조용히 소리를 별로 내지 않으며 웃는다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q6" class="p6" value="5"><span class="label-text"> 오히려 쑥스러운 듯한 미소를 짓는다.</span>
	                              </label>
	                           </div>
	                        </div>
	                     </div>
	                     
	                     <div class="col-md-6">
	                        <div class="form-group">   
	                           <div class="question">7.완전히 일에 몰두한 채로 열심히 하다가 방해 받았을 때 나는...</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q7" class="q7" value="6" ><span class="label-text"> 휴식의 기회를 반갑게 맞이한다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q7" class="q7" value="2"><span class="label-text"> 정말 짜증이 난다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q7" class="q7" value="4"><span class="label-text"> 그 중간 어딘가 쯤이다.</span>
	                              </label>
	                           </div>
	                        </div>
	                     </div>
	                     
	                     <div class="col-md-6">
	                        <div class="form-group">   
	                           <div class="question">8.다음 중 제일 좋아하는 색은?</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="6" ><span class="label-text"> 적색이나 주황색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="7"><span class="label-text"> 검은색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="5"><span class="label-text"> 노랑이나 하늘색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="4"><span class="label-text"> 녹색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="3"><span class="label-text"> 파랑이나 보라색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="2"><span class="label-text"> 하얀색</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q8" class="q8" value="1"><span class="label-text"> 갈색이나 회색</span>
	                              </label>
	                           </div>
	                        </div>
	                     </div>
	                     
	                     
	                     
	                     <div class="col-md-6">
	                        <div class="form-group">   
	                           <div class="question">9.잠자리에 들어서 잠들기 바로 직전에, 나는...</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q9" class="q9" value="7" ><span class="label-text"> 몸을 똑바로 펴고 누운 자세이다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q9" class="q9" value="6"><span class="label-text"> 엎드린 채로 몸을 쭉 편 자세이다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q9" class="q9" value="4"><span class="label-text"> 약간 몸을 둥글린 채로 옆으로 누운 자세이다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q9" class="q9" value="2"><span class="label-text"> 한 팔을 베고 있는 자세이다.</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q9" class="q9" value="1"><span class="label-text"> 머리를 이불 밑에 넣고 있는 자세이다.</span>
	                              </label>
	                           </div>
	                        </div>
	                     </div>
	                     
	                     <div class="col-md-6">
	                        <div class="form-group" style="margin-bottom:80px;">   
	                           <div class="question">10.나는 이런 꿈을 자주 꾼다</div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="4" ><span class="label-text"> 낙하하는 꿈</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="2"><span class="label-text"> 싸우거나 애 쓰는 꿈</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="3"><span class="label-text"> 무엇이나 누군가를 찾는 꿈</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="5"><span class="label-text"> 날아오르거나 떠오르는꿈</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="6"><span class="label-text"> 꿈을 잘 꾸지 않는다</span>
	                              </label>
	                           </div>
	                           <div class="form-check">
	                              <label>
	                                 <input type="radio" name="q10" class="q10" value="2"><span class="label-text"> 항상 좋은 느낌의 꿈이다.</span>
	                              </label>
	                           </div>   
	                        </div>
	                     </div>
						
						
						
						<div class="forSubmitBtn">
							<input type="submit" class="btn btn-success" value="submit">
						</div>
					</form>
				</div>			
				
			</div>
		</div>
	</section><!--/form-->
	
	
	<jsp:include page="/views/module/footer.jsp"/>  <!-- footer 영역 --> 	
	

<script src="/ebook/js/price-range.js"></script>
<script src="/ebook/js/jquery.prettyPhoto.js"></script>
<script src="/ebook/js/main.js"></script>
</body>
</html>