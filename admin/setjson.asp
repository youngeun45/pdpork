<!-- #include virtual="/pulledpork/inc/common.asp"-->
<%
	act = GLOBAL_txtFilter(Request("act"))
	ids = GLOBAL_txtFilter(Request("ids"))
	pwd = GLOBAL_txtFilter(Request("pwd"))

	ResultCode = "00"

	If act = "login" Then
		If ids = "porkadmin" And pwd = "18944862" Then
			ResultCode = "00"

			Session("ids") = "porkadmin"
			Session("names") = "관리자"
		Else
			ResultCode = "99"
		End If

		Response.Write ResultCode
	ElseIf act = "" Then
		
	End If
%>
