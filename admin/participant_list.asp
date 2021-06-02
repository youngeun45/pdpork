<!-- #include virtual="/pulledpork/inc/common.asp"-->
<%
	iv_date = GLOBAL_txtFilter(Request("iv_date"))
	searchtxt = GLOBAL_txtFilter(Request("searchtxt"))
	lk_nansu = GLOBAL_txtFilter(Request("lk_nansu"))
	actbool = GLOBAL_txtFilter(Request("actbool"))

	If iv_date = "" Then
		iv_date = "20181231"
	End If

	If actbool = "search" Then
		sSql = " select" & vbCrlf & _
			"	tqp.idx, tqp.iv_date, tqp.iv_name, tqp.iv_cell, tqp.iv_agree, tqv1.vc_code_nm as vc_code_nm1, tqv2.vc_code_nm as vc_code_nm2, tqp.iv_dttm, tqv.vc_brand_nm, tqv1.vc_brand_nm as vc_brand_nm1, tqv2.vc_brand_nm as vc_brand_nm2, " & vbCrlf & _
			"	tqv.vc_code_nm, tqp.lk_nansu, tqp.lk_make_dttm, tqb.br_code_nm, tqp.lk_use_dttm, Convert(varchar(19),iv_dttm,120) as join_dttm, IsNull(Convert(varchar(19),lk_use_dttm,120),'-') as use_dttm" & vbCrlf & _
			"from" & vbCrlf & _
			"	tb_quiz_person tqp left join tb_quiz_voucher tqv" & vbCrlf & _
			"	on tqp.lk_voucher = tqv.vc_code" & vbCrlf & _
			"	left join tb_quiz_voucher tqv1" & vbCrlf & _
			"	on tqp.iv_voucher1 = tqv1.vc_code" & vbCrlf & _
			"	left join tb_quiz_voucher tqv2" & vbCrlf & _
			"	on tqp.iv_voucher2 = tqv2.vc_code" & vbCrlf & _
			"	left join tb_quiz_brand tqb" & vbCrlf & _
			"	on tqp.lk_use_store = tqb.br_code" & vbCrlf & _
			"where" & vbCrlf & _
			"	1=1	-- 전체" & vbCrlf
		If iv_date <> "" Then
			sSql = sSql & " and iv_date = '"&iv_date&"' "
		End If

		If searchtxt <> "" Then
			sSql = sSql & " and iv_name+''+iv_cell like '%"&searchtxt&"%' "
		End If

		If lk_nansu = "0" Then
			sSql = sSql & " and lk_nansu is not null "
		End If

		If lk_nansu = "1" Then
			sSql = sSql & " and lk_nansu is null "
		End If
		sSql = sSql & " order by iv_dttm desc, lk_make_dttm desc "
		Set sRs = execWithRs(sSql)

		If iv_date <> "" Then
			sSql = " select xx.vc_code, xx.vc_code_nm, xx.vc_brand, xx.vc_brand_nm, x.vs_wincount from tb_quiz_schedule x left outer join tb_quiz_voucher xx " & vbCrlf & _
				"	on x.vc_code = xx.vc_code where x.vs_viewdt = '"&iv_date&"' "
			Set vRs = execWithRs(sSql)
		End If
	End If

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
	<script src="resources/js/ui_script.js"></script>
	<!-- //javascript -->
<script type="text/javascript">
var loading = false;
var frmsearch = function(){
	var ofrm = document.frm;
	ofrm.actbool.value = "search";
	ofrm.action="/pulledpork/admin/participant_list.asp";
	ofrm.method="get";
	ofrm.submit();
}

var frmexl = function(){
	var ofrm = document.frm;
	ofrm.action="/pulledpork/admin/participant_list_exl.asp";
	ofrm.method="post";
	ofrm.submit();
}

var frmlk = function(vc){
	if (vc == "")
	{
		alert("잘못된 시식권코드입니다.");
		return;
	}
	if ($("#iv_date").val() == "")
	{
		alert("일자를 선택 후 진행해 주세요.");
		return;
	}
	if (loading)
	{
		alert("당첨자 선정중입니다.\n잠시만 기다려 주세요.( 최대 30초 소요됩니다. )");
		return;
	}
	loading = true;
	$.ajax({
		type:'post',
		url:'/pulledpork/prize.asp',
		data: "iv_date="+$("#iv_date").val()+"&vc_code="+vc,
		dataType:'text',
		error:function(){
			alert('데이터 송수신에 문제가 있습니다.\n잠시 후 다시 이용해주세요.');
			window.location.reload();
		},
		success:function(datas){
			alert(datas);
			window.location.reload();
		}
	});
}
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
				<h2 id="page_tit">참여자정보</h2>
				<div class="list_search_wrap">
				<form name="frm">
				<input type="hidden" name="actbool" id="actbool" value="" />
					<table class="table">
						<caption>검색조건</caption>
						<colgroup>
							<col style="width:15%;" />
							<col />
							<col style="width:15%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>일자</th>
								<td colspan="3" class="t_left">
									<select name="iv_date" id="iv_date" class="w200 t">
										<!--<option value="">전체</option>
										<option value="20180326"<%If iv_date = "20180326" Then Response.Write "selected=""selected"" "%>>2018-03-26</option>
										<option value="20180327"<%If iv_date = "20180327" Then Response.Write "selected=""selected"" "%>>2018-03-27</option>
										<option value="20180328"<%If iv_date = "20180328" Then Response.Write "selected=""selected"" "%>>2018-03-28</option>-->
										<option value="20180402"<%If iv_date = "20180402" Then Response.Write "selected=""selected"" "%>>2018-04-02(종료)</option>
										<option value="20180403"<%If iv_date = "20180403" Then Response.Write "selected=""selected"" "%>>2018-04-03(종료)</option>
										<option value="20180404"<%If iv_date = "20180404" Then Response.Write "selected=""selected"" "%>>2018-04-04(종료)</option>
										<option value="20180405"<%If iv_date = "20180405" Then Response.Write "selected=""selected"" "%>>2018-04-05(종료)</option>
										<option value="20180406"<%If iv_date = "20180406" Then Response.Write "selected=""selected"" "%>>2018-04-06(종료)</option>
										<option value="20180407"<%If iv_date = "20180407" Then Response.Write "selected=""selected"" "%>>2018-04-07(종료)</option>
										<option value="20180408"<%If iv_date = "20180408" Then Response.Write "selected=""selected"" "%>>2018-04-08(종료)</option>
										<option value="20180505"<%If iv_date = "20180505" Then Response.Write "selected=""selected"" "%>>=고객감사쿠폰=(종료)</option>
										<option value="20180416"<%If iv_date = "20180416" Then Response.Write "selected=""selected"" "%>>=추가홍보쿠폰I=(종료)</option>
										<option value="20180424"<%If iv_date = "20180424" Then Response.Write "selected=""selected"" "%>>=추가홍보쿠폰II=(종료)</option>
										<option value="20181231"<%If iv_date = "20181231" Then Response.Write "selected=""selected"" "%>>기간연장쿠폰(6/10)</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>당첨자선정</th>
								<td colspan="3" class="t_left">
							<%
								If iv_date <> "" And actbool = "search" And iv_date<>"20180505" Then
									If Not(vRs.Eof) Then
										Do Until vRs.Eof
							%>
									<a href="javascript:frmlk('<%=vRs("vc_brand")%>');" class="button h50 btn_blk w160"><span><%=vRs("vc_brand_nm")%>&nbsp;(&nbsp;<%=vRs("vs_wincount")%>&nbsp;명)<br /><%=vRs("vc_code_nm")%></span></a>
							<%
											vRs.movenext
										Loop
									End If
								Else
							%>
									일자를 선택해 주세요.
							<%
								End If
							%>
								</td>
							</tr>
							<tr>
								<th>검색조건</th>
								<td class="t_left">
									<select name="lk_nansu" id="lk_nansu" class="w75 mr5">
										<option value="">전체</option>
										<option value="0"<%If lk_nansu = "0" Then Response.Write "selected=""selected"" "%>>당첨자</option>
										<option value="1"<%If lk_nansu = "1" Then Response.Write "selected=""selected"" "%>>미당첨자</option>
									</select>
									<input type="text" name="searchtxt" id="searchtxt" class="w200 mr5" placeholder="이름, 휴대폰번호" value="<%=searchtxt%>" />
									<a href="javascript:frmsearch();" class="button h50 btn_gray"><span>검색</span></a>
								</td>
								<td colspan="2" class="t_left">
									<a href="javascript:frmexl();" class="button h50 btn_gray w140 mr5"><span>엑셀다운로드</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				</div>
				<div class="table_wrap">
					<table class="table">
						<caption>응모자리스트</caption>
						<colgroup>
							<col style="width:80px;" />
							<col style="width:150px;" />
							<col style="width:120px;" />
							<col style="width:150px;" />
							<col />
							<col />
							<col />
							<col style="width:170px;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">날짜<br/><span style="font-size:0.8em">(응모시간)</span></th>
								<th scope="col">이름</th>
								<th scope="col">휴대폰번호</th>
								<th scope="col" colspan="2">희망 식사권</th>
								<!--<th scope="col">선택한 식사권 2</th>-->
								<th scope="col">당첨여부</th>
								<th scope="col">쿠폰번호</th>
								<th scope="col">사용지점</th>
							</tr>
						</thead>
						<tbody>
				<%
					If actbool = "search" Then
						If Not(sRs.Eof) Then
							str_rCnt = sRs.RecordCount
							Do Until sRs.Eof
				%>
							<tr>
								<td><%=FormatNumber(str_rCnt,0)%></td>
								<td><%=sRs("iv_date")%><br/><span style="font-size:0.8em">(<%=sRs("join_dttm")%>)</span></td>
								<td><%=sRs("iv_name")%></td>
								<td><%=sRs("iv_cell")%></td>
								<td><%=sRs("vc_brand_nm1")%><br/><span style="font-size:10px;">(<%=sRs("vc_code_nm1")%>)</span></td>
								<td><%=sRs("vc_brand_nm2")%><br/><span style="font-size:10px;">(<%=sRs("vc_code_nm2")%>)</span></td>
								<td>
								<%
									If Not(IsNull(sRs("vc_brand_nm"))) Then
										Response.Write sRs("vc_brand_nm")
								%>
										<br/><span style="font-size:10px;">(<%=sRs("vc_code_nm")%>)</span>
								<%
									Else
										Response.Write "-"
									End If
								%>
								</td>
<% If sRs("iv_date") = "20181231" Then %>
								<td><a href="/pulledpork/rebirth_vc.asp?cp=<%=sRs("lk_nansu")%>" style="font-style:italic;"><%=sRs("lk_nansu")%></a></td>
<% Else %>
								<td><a href="/pulledpork/ticket_customer.asp?cp=<%=sRs("lk_nansu")%>"><%=sRs("lk_nansu")%></a></td>
<% End If %>
								<td><%=sRs("br_code_nm")%><br/><% if sRs("use_dttm") <> "-" then %><span style="font-size:0.8em">(<%=sRs("use_dttm")%>)</span><% end if %></td>
							</tr>
				<%
								str_rCnt = str_rCnt-1
								sRs.movenext
							Loop
				%>
				<%
						Else
				%>
							<tr>
								<td colspan="8">검색된 데이터가 없습니다.</td>
							</tr>
				<%
						End If
					Else
				%>
							<tr>
								<td colspan="8">검색을 진행해 주세요.</td>
							</tr>
				<%
					End If
				%>
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
