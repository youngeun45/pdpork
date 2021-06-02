<!DOCTYPE html> 
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>풀드포크 프로모션 관리자</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />

	<!-- style -->
	<link rel="stylesheet" href="resources/css/common.css" media="all" />
	<link rel="stylesheet" href="resources/css/contents.css" media="all" />
	<!--[if lte IE 8]>
		  <link rel="stylesheet" href="../resources/css/ie.css" />
	<![endif]-->
	<!-- //style -->

	<!-- javascript -->
	<script src="resources/js/lib/jquery-1.11.1.min.js"></script>
	<script src="resources/js/lib/jquery-migrate-1.2.1.min.js"></script>
	<script src="resources/js/lib/jquery-ui-1.10.3.custom.min.js"></script>
	<!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
	<![endif]-->
	<script src="resources/js/plugins.js"></script>
	<script src="resources/js/flipclock.js"></script>
	<script src="resources/js/ui_script.js"></script>
	<!-- //javascript -->
</head>

<body>
	<div id="wrap">
		<!-- header -->
		<header id="header">
			<h1 id="logo"><a href="/"><img src="resources/images/common/logo.png" alt="" /></a></h1>
			<a href="#" class="btn_gnb">
				<i></i>
				<i></i>
				<i></i>
				<span class="blind">메뉴</span>
			</a>
			<div>
				<div class="head_timer">
					<div class="date"></div>
					<div class="clock"></div>
				</div>
				<div class="head_info">
					<span><strong>관리자</strong>님 안녕하세요.</span>
					<a href="/pulledpork/admin/logout.asp" class="button h22">로그아웃</a>
				</div>
			</div>
		</header>
		<!-- //header -->	
		
		<!-- gnb -->
		<aside class="left_menu">			
			<nav id="gnb">
				<ul>
					<li class="menu"><a href="#">현황</a>
						<div>
							<ul>
								<li><a href="status.asp">일 참여현황</a></li>
								<li><a href="participant_list.asp">참여자정보</a></li>
							</ul>
						</div>
					</li>
					<li class="menu"><a href="#">환경설정</a>
						<div>
							<ul>
								<li><a href="password_change.asp">비밀번호변경</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</nav>
		</aside>
		<!-- //left_menu -->

		<!-- container -->
		<div id="container">
			<!-- contents -->
			<section id="contents">
				<h2 id="page_tit">비밀번호변경</h2>
				<div class="table_wrap">
					<table class="table left_tbl form_tbl">
						<caption>비밀번호변경 정보</caption>
						<colgroup>
							<col style="width:15%" />
							<col style="width:*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">ID</th>
								<td>
									 ADMIN_TEST
								</td>
							</tr>
							<tr>
								<th scope="row">현재 비밀번호</th>
								<td>
									<input type="password" placeholder="현재 비밀번호" />
								</td>
							</tr>
							<tr>
								<th scope="row">변경될 비밀번호</th>
								<td>
									<input type="password" placeholder="변경될 비밀번호" />
								</td>
							</tr>							
							<tr>
								<th scope="row">변경될 비밀번호 재확인</th>
								<td>
									<input type="password" placeholder="변경될 비밀번호 재확인" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mt30 clear">
					<a href="#" class="button h30 btn_blk">처리 완료</a>
				</div>
			</section>
			<!-- //contents -->
			<div class="bgLayer"></div>
		</div>
		<!-- //container -->
	</div>
	<!-- //wrap -->
	<!-- footer -->
	<footer id="footer">
		<p>COPYRIGHT 2017 CNTT. ALL RIGHTS RESERVED</p>
	</footer>
	<!-- //footer -->
</body>
</html>
