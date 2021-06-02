<%
	If Session("ids") = "" Then
		Call pageStop("로그인 후 이용해 주세요.", "window.location.replace('/pulledpork/admin/login.asp');")
	End If
%>