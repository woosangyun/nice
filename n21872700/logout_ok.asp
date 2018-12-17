<%
	session.abandon

	'response.redirect "index.asp"
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="javascript">
	alert('로그아웃 되었습니다.')
	location.href="index.asp";
</script>