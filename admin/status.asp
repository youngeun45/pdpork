<!-- #include virtual="/pulledpork/inc/common.asp"-->
<%
	sSql = " select iv_date, count(iv_date) as cnt from tb_quiz_person with(nolock) where iv_date<>'20180416' And iv_date<>'20180505' And iv_date<>'20180424' And iv_date<>'20181231' group by iv_date order by iv_date "
	Set sRs = execWithRs(sSql)
%>
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
		  <link rel="stylesheet" href="resources/css/ie.css" />
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
<script type="text/javascript">
$(document).ready(function(){
	$("#totcountstr").html("전체 참여건수 : "+vCommaNumber($("#totcount").val())+"건");
});
</script>
</head>

<body>
<!-- #include virtual="/pulledpork/admin/isLogin_check.asp"-->
	<!-- skipNavi -->
	<div id="skipNavi">
		<a href="#gnb">주메뉴 바로가기</a>
		<a href="#contents">본문 바로가기</a>
		<a href="#footer">사이트정보 바로가기</a>
	</div>
	<!-- //skipNavi -->
	<!-- wrap -->
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
						<!--<li class="menu"><a href="#">환경설정</a>
							<div>
								<ul>
									<li><a href="password_change.asp">비밀번호변경</a></li>
								</ul>
							</div>
						</li>-->
					</ul>
				</nav>
			</aside>
		<!-- //left_menu -->

		<!-- container -->
		<div id="container">
			<!-- contents -->
			<section id="contents">
				<h2 id="page_tit">일 참여현황</h2>
				<div class="table_wrap">
				<p class="bold mb10" id="totcountstr">전체 참여건수: 000건</p>
					<table class="table">
						<caption>공지사항</caption>
						<colgroup>
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">날짜</th>
								<th scope="col">참여건수</th>
							</tr>
						</thead>
						<tbody>
				<%
					totcount = 0
					If Not(sRs.Eof) Then
						Do Until sRs.Eof
							totcount = totcount + CDbl(sRs("cnt"))
				%>
							<tr>
								<td><%=sRs("iv_date")%></td>
								<td><%=FormatNumber(sRs("cnt"),0)%></td>
							</tr>
				<%
							sRs.movenext
						Loop
					Else
				%>
						<tr>
							<td colspan="2">응모데이터가 존재하지 않습니다.</td>
						</tr>
				<%
					End If
				%>
						<input type="hidden" id="totcount" value="<%=totcount%>" />
						</tbody>
					</table>
				</div>
			</section>
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
