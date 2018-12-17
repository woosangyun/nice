<%
	IF SESSION("NICEMNGID")="" OR ISNULL(SESSION("NICEMNGID")) OR ISEMPTY(SESSION("NICEMNGID")) THEN
		Response.Redirect "./index.asp"
	END IF
%>


<%
	dim gb, g_cmd

	gb=request("gb")
'	response.write instr(current_url,"upload_image")
'	response.end

	if instr(current_url,"upload_image")<1 then		'예외 페이지
		if gb="" then
			response.redirect "./admin_ok.asp?gb=main"
		else
			g_cmd="&gb=" & gb
		end if
	end if
%>
