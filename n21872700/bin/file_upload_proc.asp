<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->

<!-- #include file="../include/admin_check.asp" -->


<%
	set dx=server.createobject("DEXT.FileUpload")
	dx.AutoMakeFolder=true
	dx.defaultpath=upload_real
	dx.codepage=65001


	upload_folder=upload_real & "\" & gb & "\"







	file_max_mb=10		'10MB

	thumb_width=267
	thumb_height=90


		file_max_size=1024*1024*file_max_mb

			file_current_size=dx("file").filelen

			if file_current_size>file_max_size then
				response.write "파일 크기 오류"
				response.end
			end if


			if gb="product" then
				if dx("file").imagewidth < 1 then
					response.write "파일 형식 오류"
					response.end
				end if
			end if


			dim x_file
			dim x_file_name
			dim x_file_size
			dim x_file_width
			dim x_file_height


						if dx("file").filelen > 0 then
							'---파일저장-------------------------------
							x_file_name=dx("file").filename
							x_file=display_num(session.sessionid,10) & code_date() & file_extension(x_file_name)
							x_file_thumb=display_num(session.sessionid,10) & code_date() & "_thumb.jpg"
							x_file_size=dx("file").filelen
							x_file_width=dx("file").imagewidth
							x_file_height=dx("file").imageheight


							file_path=upload_folder & x_file
							save_path=dx("file").saveas(file_path)

							if x_file_width>0 and x_file_height>0 then
								thumb_path=upload_folder & x_file_thumb
								call save_thumb(save_path,thumb_path,x_file_width,x_file_height,thumb_width,thumb_height)
							end if
							'------------------------------------------
						end if




'							response.write "<br>" & x_file_name
'							response.write "<br>" & x_file
'							response.write "<br>" & x_file_thumb
'							response.write "<br>" & x_file_size
'							response.write "<br>" & x_file_width
'							response.write "<br>" & x_file_height

'							response.write "<br>" & x_id
'							response.write "<br>" & x_ip
'							response.end


						sql="insert nc_file (x_id,x_div,x_file,x_file_name,x_file_size,x_file_width,x_file_height,x_ip) value (?,?,?,?,?,?,?,?)"

						set cmd=server.createobject("adodb.command")
						cmd.activeconnection=lo_DbCon
						cmd.commandtext=sql
						cmd.commandtype=adCmdText
						cmd.prepared=true
						cmd.parameters.append cmd.createparameter("@x_id",adVarWChar,adParamInput,12,current_id)
						cmd.parameters.append cmd.createparameter("@x_div",adVarWChar,adParamInput,255,gb)
						cmd.parameters.append cmd.createparameter("@x_file",adVarWChar,adParamInput,255,x_file)
						cmd.parameters.append cmd.createparameter("@x_file_name",adVarWChar,adParamInput,255,x_file_name)
						cmd.parameters.append cmd.createparameter("@x_file_size",adInteger,adParamInput,4,x_file_size)
						cmd.parameters.append cmd.createparameter("@x_file_width",adInteger,adParamInput,4,x_file_width)
						cmd.parameters.append cmd.createparameter("@x_file_height",adInteger,adParamInput,4,x_file_height)
						cmd.parameters.append cmd.createparameter("@x_ip",adVarWChar,adParamInput,15,current_ip)
						cmd.execute ,,adExecuteNoRecords
						set cmd=nothing


						sql="select idx, x_file_name from nc_file where x_display=1 order by idx desc limit 1"

						set cmd=server.createobject("adodb.command")
						cmd.activeconnection=lo_DbCon
						cmd.commandtext=sql
						cmd.commandtype=adCmdText
						cmd.prepared=true
						set rs=cmd.execute
							if rs.eof or rs.bof then
								'파일 없음
							else
								idx=rs("idx")
								x_file_name=rs("x_file_name")
							end if
						set rs=nothing
						set cmd=nothing


						set dx=nothing

%>


<script language="javascript">
	opener.frmNew.x_idx.value="<%= idx %>";
	opener.frmNew.x_file.value="<%= x_file_name %>";
	self.close();
</script>


<!-- #include file="../../config/db_close.asp" -->
