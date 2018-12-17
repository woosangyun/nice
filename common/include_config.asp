<%
	dim current_id, current_ip, current_url, current_agent
	current_id=SESSION("NICEMNGID")
	current_ip=request.servervariables("REMOTE_ADDR")
	current_url=request.servervariables("URL")
	current_agent=lcase(request.servervariables("HTTP_USER_AGENT"))

	dim upload_virtual, upload_real, upload_virtual2, upload_real2
	upload_virtual="../../upload"
	upload_real=server.mappath(upload_virtual)
	upload_virtual2="../upload"
	upload_real2=server.mappath(upload_virtual2)

	dim view_count
	view_count=10
%>


<%
	dim nice_code
	nice_code="036800"

	dim dart_auth, dart_start
'	dart_auth="b084a4228edfed98460213a8452e5fcadf450ef7"			'기업용
	dart_auth="5eddd4b77213dcc35cba5159c2a8bc1a6d28d296"		'개인용 (테스트)
	dart_start="19990101"

	dim krx_xml, dart_xml
	krx_xml="http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code=" & nice_code
	dart_xml="http://dart.fss.or.kr/api/search.xml?auth=" & dart_auth & "&crp_cd=" & nice_code & "&page_set=" & view_count
%>


<%
	dim page, p_cmd

	page=request("page")

	if page="" or isnumeric(page)=false then
		page=1
	else
		page=int(page)
	end if

	p_cmd="?page=" & page
%>


<%
	dim div, d_cmd, d_sql

	div=request("div")

	if div="" or isnumeric(div)=false then
		div=""
		d_cmd=""
	else
		div=int(div)
		d_cmd="&div=" & div
	end if
%>


<%
	dim s_part, s_str, s_cmd, s_sql

	s_part=request("s_part")
	s_str=request("s_str")

	s_part=trim(s_part)
	s_str=trim(s_str)

	s_part=left(s_part,20)
	s_str=left(s_str,20)

	if s_str="" then
		s_cmd=""
	else
		if s_part<>"" then
			part_string="&s_part=" & s_part
		end if

		text_string="&s_str=" & server.urlencode(s_str)

		s_cmd=part_string & text_string
	end if
%>
