<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->

<%@CODEPAGE="65001" LANGUAGE="VBSCRIPT"%>
<%
	Response.charset = "utf-8"
	Session.Codepage="65001"
	Response.Expires = -1
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control","no-store"
	Response.CacheControl = "no-cache"
	Response.buffer=True
	Session.Timeout=10

Dim DbServer : DbServer = "211.43.203.103" '[DB connecton ip]
Dim DbNm : DbNm = "dbusmefkr1" '[DB initial catalog name]
Dim DbID : DbID = "usmefkr1" '[DB user id]
Dim DbPW : DbPW = "beefpork1895"
Dim CON_IP : CON_IP = Request.ServerVariables("REMOTE_HOST")
Function getConnection()
	If typename(Con)="Connection" Then
		If (Con.state = adStateOpen) Then
			Set getConnection = Con
			Exit Function
		End If
	End If
	Dim conStr
	Set Con = server.createObject("adodb.connection")
	Con.provider = "SQLOLEDB"
	Con.properties("data source") = DbServer
	Con.properties("initial catalog") = DbNm
	Con.properties("user id") = DbID
	Con.properties("password") = DbPW
	Con.commandTimeout = 180
	Con.open 
	If err.number<>0 Then
		response.clear
		response.write "ErrorNumber : " & err.number &"<br>" 
		response.write "ErrorDescription : " & err.description &"<br>":
		response.write "ErrorSource : " & err.source & "<br>":
		err.clear
		response.end
	End If
	Set getConnection = Con
End Function

Function closeConnection(byRef pConn)
	If typename(pConn)="Connection" Then
		If pConn.state=adStateOpen Then
			pConn.close()
		End If
		Set pConn = Nothing
	End If
End Function

Function execWithRs(pQryStr)
	Dim	Con 
	Set Con = getConnection()

	Dim Rs
	Set Rs = server.createObject("Adodb.RecordSet")
	Rs.cursorLocation = adUseClient
	Rs.open pQryStr, Con, adOpenStatic, adLockReadOnly
	If err.number<>0 Then
		response.clear
		response.write "ErrorNumber : " & err.number &"<br>" 
		response.write "ErrorDescription : " & err.description &"<br>":
		response.write "ErrorSource : " & err.source & "<br>":
		response.write "<font color=white>"
'		response.write pQryStr
		response.write "</font>"
		err.clear
		response.end
	End If
	Set Rs.activeConnection = Nothing
	Set execWithRs = Rs
End Function

Function execWithNoRs(pQryStr)
	On Error Resume Next
	Dim	Con 
	Dim affRow
	Set Con = getConnection()
	Con.execute pQryStr, affRow
	execWithNoRs = Err.number
End Function

Function GLOBAL_txtFilter(strString)
	If isNull(strString) Then strString = "" End If
	strString = Replace(strString,"'","''")
	'strString = Replace(strString,"\","\\")
	strString = Replace(strString, "<", "&lt;")
	strString = Replace(strString, ">", "&gt;")
	strString = replace(strString, chr(0), "")

	GLOBAL_txtFilter = strString
	If Err.number <> 0 Then GLOBAL_txtFilter = ""
End Function

Sub pageStop(errMsg, navUrl)
	response.clear
	response.charset="UTF-8"
	response.write "<script type=""text/javascript"">" & vbCrLf
	If errMsg <> "" Then response.write "alert(""" & errMsg & """);" & vbCrLf
	If navUrl <> "" Then response.write navUrl
	response.write "</script>" & vbCrLf
	response.end
End Sub

%>