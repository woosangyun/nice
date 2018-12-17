<!-- #include file="./crypt.asp" -->
<%
	a="Driver={MySQL ODBC 5.3 Unicode Driver}; Server=ysjeon.sytes.net; Port=33060; Database=nice_int_db; uid=niceuser; pwd=niceuser#; stmt=set names utf8;"
	b=Encrypt(a)

	response.write b
%>
