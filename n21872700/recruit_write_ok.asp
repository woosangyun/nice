<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->


<%
	cd=request("cd")
	idx=request("idx")

	c_title=request("c_title")
	c_regdate=request("c_regdate")
	c_enddate=request("c_enddate")
	c_content=request("c_content")

	x_idx=request("x_idx")
	x_file=request("x_file")


	c_title=trim(c_title)
	c_regdate=trim(c_regdate)
	c_enddate=trim(c_enddate)
	c_content=trim(c_content)


	if x_idx="" or isnumeric(x_idx)=false then
		x_idx=0
		x_file=""
	else
		x_idx=int(x_idx)
		x_file=trim(x_file)
	end if


	if cd<>"delete" then
		if c_title="" or c_regdate="" or c_enddate="" or c_content=""  then
			response.write "<script>alert('파라미터 누락')</script>"
			response.end
		end if

		if isdate(c_regdate)=false or isdate(c_enddate)=false then
			response.write "<script>alert('날짜형식 오류')</script>"
			response.end
		end if
	end if


	if cd<>"" then
		idx=request("idx")

		if idx="" or isnumeric(idx)=false then
			response.write "<script>alert('파라미터 오류')</script>"
			response.end
		else
			idx=int(idx)
		end if
	end if


	if cd="delete" then
		sql="update nc_recruit set c_display=0 where idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	elseif cd="edit" then
		sql="update nc_recruit set"
		sql=sql & " c_title= ? "
		sql=sql & " , c_regdate= ? "
		sql=sql & " , c_enddate= ? "
		sql=sql & " , c_content= ? "

		if x_idx>0 then
			sql=sql & " , c_file_idx= ? "
			sql=sql & " , c_file_name= ? "
		end if

		sql=sql & " where c_display>0"
		sql=sql & " and idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@c_title",adVarWChar,adParamInput,100,c_title)
		cmd.parameters.append cmd.createparameter("@c_regdate",adVarWChar,adParamInput,10,c_regdate)
		cmd.parameters.append cmd.createparameter("@c_enddate",adVarWChar,adParamInput,10,c_enddate)
		cmd.parameters.append cmd.createparameter("@c_content",adVarWChar,adParamInput,20000,c_content)

		if x_idx>0 then
			cmd.parameters.append cmd.createparameter("@x_idx",adInteger,adParamInput,4,x_idx)
			cmd.parameters.append cmd.createparameter("@x_file",adVarWChar,adParamInput,255,x_file)
		end if

		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	else
		sql="insert nc_recruit (c_id,c_title,c_regdate,c_enddate,c_file_idx,c_file_name,c_content,c_ip) value (?,?,?,?,?,?,?,?)"

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@c_id",adVarWChar,adParamInput,12,current_id)
		cmd.parameters.append cmd.createparameter("@c_title",adVarWChar,adParamInput,100,c_title)
		cmd.parameters.append cmd.createparameter("@c_regdate",adVarWChar,adParamInput,10,c_regdate)
		cmd.parameters.append cmd.createparameter("@c_enddate",adVarWChar,adParamInput,10,c_enddate)
		cmd.parameters.append cmd.createparameter("@x_idx",adInteger,adParamInput,4,x_idx)
		cmd.parameters.append cmd.createparameter("@x_file",adVarWChar,adParamInput,255,x_file)
		cmd.parameters.append cmd.createparameter("@c_content",adVarWChar,adParamInput,20000,c_content)
		cmd.parameters.append cmd.createparameter("@c_ip",adVarWChar,adParamInput,15,current_ip)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing
	end if
%>


<script language="javascript">
	<% if cd="delete" then %>
		alert("삭제되었습니다.");
		parent.location.href="<%= gb %>_list.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>";
	<% elseif cd="edit" then %>
		alert("수정되었습니다.");
		parent.location.href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= idx %>";
	<% else %>
		alert("등록되었습니다.");
		parent.location.href="<%= gb %>_list.asp?page=1<%= g_cmd %>";
	<% end if %>
</script>


<!-- #include file="../config/db_close.asp" -->
