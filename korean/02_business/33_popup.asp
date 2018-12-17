<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<%
	sql="select"
	sql=sql & "		a_title, a_content"
	sql=sql & " from nc_agreement"
	sql=sql & " where a_display>0"
	sql=sql & "	order by idx desc"
	sql=sql & "	limit 1"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	set rs=cmd.execute
		if rs.eof or rs.bof then
			response.write "준비 중입니다."
			response.end
		else
			a_title=rs("a_title")
			a_content=rs("a_content")
		end if
	set rs=nothing
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 - <%= a_title %></title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
</head>
<body>

	<%= a_content %>

</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
