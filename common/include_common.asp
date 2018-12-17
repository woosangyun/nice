<% @language="vbscript" codepage="65001" %>

<%
	response.expires=-1
	response.addheader "Pragma", "no-cache"
	response.addheader "cache-control", "no-store"

	session.lcid=1042	'default 2048
	session.codepage=65001	 '949
	response.charset="UTF-8"	'EUC-KR
	response.contenttype="text/html; charset=UTF-8"
%>
