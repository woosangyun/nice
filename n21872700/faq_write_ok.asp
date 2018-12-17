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

	q_title=request("q_title")
	q_content=request("q_content")


	q_title=trim(q_title)
	q_content=trim(q_content)


	if cd<>"delete" then
		if q_title="" or q_content=""  then
			response.write "<script>alert('파라미터 누락')</script>"
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
		sql="update nc_faq set q_display=0 where idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	elseif cd="edit" then
		sql="update nc_faq set"
		sql=sql & " q_title= ? "
		sql=sql & " , q_content= ? "
		sql=sql & " where q_display>0"
		sql=sql & " and idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@q_title",adVarWChar,adParamInput,100,q_title)
		cmd.parameters.append cmd.createparameter("@q_content",adVarWChar,adParamInput,20000,q_content)
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	else
		sql="insert nc_faq (q_id,q_title,q_content,q_ip) value (?,?,?,?)"

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@q_id",adVarWChar,adParamInput,12,current_id)
		cmd.parameters.append cmd.createparameter("@q_title",adVarWChar,adParamInput,100,q_title)
		cmd.parameters.append cmd.createparameter("@q_content",adVarWChar,adParamInput,20000,q_content)
		cmd.parameters.append cmd.createparameter("@q_ip",adVarWChar,adParamInput,15,current_ip)
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
