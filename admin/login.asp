<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="ko"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8" lang="ko"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9" lang="ko"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="ko"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<title>풀드포크 프로모션 관리자</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />

	<!-- style -->
	<link rel="stylesheet" href="resources/css/common.css" media="all" />
	<link rel="stylesheet" href="resources/css/contents.css" media="all" />

	<!-- javascript -->
	<script src="resources/js/lib/jquery-1.12.4.min.js"></script>
	<script src="resources/js/lib/jquery-migrate-1.4.1.min.js"></script>
	<script src="resources/js/lib/jquery-ui-1.12.1.min.js"></script>
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
	<![endif]-->
	<script src="./resources/js/plugins.js"></script>
	<script src="./resources/js/ui_script.js"></script>
	<!-- //javascript -->
<script type="text/javascript">
var frmlogin = function(){
	if ($("#ids").val() == "")
	{
		alert("아이디를 입력해 주세요.");
		return;
	}
	if ($("#pwd").val() == "")
	{
		alert("비밀번호를 입력해 주세요.");
		return;
	}
	$.ajax({
		type:'post',
		url:'/pulledpork/admin/setjson.asp',
		data: "act=login&ids="+$("#ids").val()+"&pwd="+$("#pwd").val(),
		dataType:'text',
		error:function(){
			alert('데이터 송수신에 문제가 있습니다.\n잠시 후 다시 이용해주세요.');
		},
		success:function(datas){
			if ( datas == "00" )
			{
				window.location.replace("/pulledpork/admin/status.asp");
			}
			else
			{
				alert("아이디/비밀번호를 확인해 주세요.");
				return;
			}
		}
	});
}
</script>
</head>

<body class="main">
	<!-- skipNavi -->
	<div id="skipNavi">
		<a href="#gnb">주메뉴 바로가기</a>
		<a href="#contents">본문 바로가기</a>
		<a href="#footer">사이트정보 바로가기</a>
	</div>
	<!-- //skipNavi -->

	<!-- wrap -->
	<div id="wrap">
		<div class="login_box">
			<h2><img src="resources/images/logo.png" alt="" /></h2>
			<div class="">
				<p class="input_box"><span class=""><img src="resources/images/common/login_ic01.png" alt="아이디" /></span><input type="text" name="ids" id="ids" title="아이디입력" placeholder="ID" onkeydown="javascript:if(event.keyCode==13){frmlogin();}" /></p>
				<p class="input_box"><span class=""><img src="resources/images/common/login_ic02.png" alt="비밀번호" /></span><input type="password" name="pwd" id="pwd" title="비밀번호입력" placeholder="PASSWORD" onkeydown="javascript:if(event.keyCode==13){frmlogin();}" /></p>
				<!--<p>
					<label>
						<input name="checkbox" type="checkbox" class="checkbox" checked="checked" />
						<span class="lbl">아이디저장</span>
					</label>
				</p>-->
				<div class="btn_box t_center">
					<a href="javascript:frmlogin();" class="button btn_blk h30 full">로그인</a>
				</div>
				<p class="log_text hide" id="log_text">아이디 및 패스워드를 확인해 주세요.</p>
			</div>
		</div>
	</div>
	<!-- //wrap -->
	<!-- footer -->
	<footer id="footer">
		<p>COPYRIGHT 2016 CNTT. ALL RIGHTS RESERVED</p>
	</footer>
	<!-- //footer -->
</body>
</html>
