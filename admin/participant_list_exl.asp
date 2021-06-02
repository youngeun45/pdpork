<!-- #include virtual="/pulledpork/inc/common.asp"-->
<%
	iv_date = GLOBAL_txtFilter(Request("iv_date"))
	searchtxt = GLOBAL_txtFilter(Request("searchtxt"))
	lk_nansu = GLOBAL_txtFilter(Request("lk_nansu"))

	If iv_date = "" Then
		docstr = ""
	Else
		docstr = "_"&iv_date
		docstrtxt = iv_date
	End If

	sSql = " select" & vbCrlf & _
		"	tqp.idx, tqp.iv_date, tqp.iv_name, tqp.iv_cell, tqp.iv_agree, tqv1.vc_code_nm as vc_code_nm1, tqv2.vc_code_nm as vc_code_nm2, tqp.iv_dttm, tqv.vc_brand_nm, tqv1.vc_brand_nm as vc_brand_nm1, tqv2.vc_brand_nm as vc_brand_nm2, " & vbCrlf & _
		"	tqv.vc_code_nm, tqp.lk_nansu, tqp.lk_make_dttm, tqb.br_code_nm, tqp.lk_use_dttm,Convert(varchar(19),tqp.iv_dttm,120) as join_dttm, IsNull(Convert(varchar(19),tqp.lk_use_dttm,120),'-') as use_dttm" & vbCrlf & _
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

	sSql = sSql & " order by iv_date desc, lk_make_dttm desc "
	Set sRs = execWithRs(sSql)

	Response.Buffer = True
	Response.ContentType = "application/vnd.ms-excel"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition","attachment;filename="&server.urlencode("참여자리스트")&""&docstr&".xls"

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
</head>
<body>
<table border="0">
	<tr>
		<td colspan="8"></td>
	</tr>
	<tr>
		<td colspan="8" style="text-align:center;font-weight:bold;font-size:20px;"><%=docstrtxt%> 참여자리스트</td>
	</tr>
	<tr>
		<td colspan="8"></td>
	</tr>
</table>

<table border="1">
	<colgroup>
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">날짜</th>
			<th scope="col">응모일자</th>
			<th scope="col">이름</th>
			<th scope="col">휴대폰번호</th>
			<th scope="col" colspan="2">희망식사권</th>
			<th scope="col">당첨여부</th>
			<th scope="col">쿠폰번호</th>
			<th scope="col">사용지점</th>
			<th scope="col">사용일자</th>
			<th scope="col">MMS발송용 URL</th>
		</tr>
	</thead>
	<tbody>
<%
	If Not(sRs.Eof) Then
		Do Until sRs.Eof
%>
			<tr>
				<td style="text-align:center;"><%=sRs("iv_date")%></td>
				<td style="text-align:center;"><%=sRs("join_dttm")%></td>
				<td style="text-align:center;"><%=sRs("iv_name")%></td>
				<td style="text-align:center;"><%=sRs("iv_cell")%></td>
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
				<td style="text-align:center;"><%=sRs("lk_nansu")%></td>
				<td style="text-align:center;"><%=sRs("br_code_nm")%></td>
				<td style="text-align:center;"><% if sRs("use_dttm") <> "-" then %><%=sRs("use_dttm")%><% end if%></td>
<% if sRs("iv_date") = "20181231" then %>
				<td>http://porkstory.co.kr/pulledpork/rebirth_vc.asp?cp=<%=sRs("lk_nansu")%></td>
<% else %>
				<td>http://porkstory.co.kr/pulledpork/ticket_customer.asp?cp=<%=sRs("lk_nansu")%></td>
<% end if %>
			</tr>
<%
			sRs.movenext
		Loop
	End If
%>
	</tbody>
</table>
</body>
</html>
