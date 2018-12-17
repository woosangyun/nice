<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->


<%
	idx=request("idx")

	if idx="" or isnumeric(idx)=false then
		response.write "파라미터 오류"
		response.end
	else
		idx=int(idx)
	end if
%>


<%
	sql="select x_div, x_file, x_file_name, x_file_size from nc_file where idx= ? "

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
	set rs=cmd.execute
		if rs.eof or rs.bof then
			'파일 없음
			response.write "<br>없음"
		else
			x_div=rs("x_div")
			x_file=rs("x_file")
			x_file_name=rs("x_file_name")
			x_file_size=rs("x_file_size")

			if instr(current_agent,"msie") or instr(current_agent,"trident") then
				'IE10 / IE11
				encode_name=server.urlpathencode(x_file_name)
			else
				'크롬 / 파이어폭스 / 사파리
				x_file_name=replace(x_file_name," ","_")
				x_file_name=replace(x_file_name,",","_")
				encode_name=x_file_name
			end if

			download_path=upload_real2 & "\" & x_div & "\" & x_file

'			response.write "<br>" & x_div
'			response.write "<br>" & x_file
'			response.write "<br>" & x_file_name
'			response.write "<br>" & x_file_size
'			response.write "<br>" & encode_name
'			response.write "<br>" & download_path
'			response.end
		end if
	set rs=nothing
	set cmd=nothing


'	response.write "<br>" & current_agent
'	response.write "<br>" & encode_name
'	response.write "<br>" & download_path
'	response.end


	Response.Buffer=true
	Response.Clear

	Response.Charset="UTF-8"
	Response.ContentType = "application/x-download; charset=UTF-8"
'	Response.ContentType = "application/unknown; charset=UTF-8"
'	Response.AddHeader "Content-Disposition","inline;filename=" & encode_name
	Response.AddHeader "Content-Disposition","attachment; filename=" & encode_name
'	Response.AddHeader "Content-Length", x_file_size
	Response.AddHeader "Content-Transfer-Encoding","binary"
	Response.CacheControl = "public" 
	
'	set dx=server.createobject("DEXT.FileDownload")
'		dx.DownloadBlob download_path
'		dx.download download_path
'	set dx=nothing

	set objstream=server.createobject("adodb.stream")
		objstream.open
		objstream.type=1
		objstream.loadfromfile download_path
		download=objstream.read
		response.binarywrite download
	set objstream=nothing
%>


<!-- #include file="../config/db_close.asp" -->
