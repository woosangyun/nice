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

	g_div=request("g_div")
	g_area=request("g_area")
	g_title=request("g_title")
	g_name=request("g_name")
	g_address1=request("g_address1")
	g_address2=request("g_address2")
	g_phone1=request("g_phone1")
	g_phone2=request("g_phone2")
	g_phone3=request("g_phone3")

	g_div=trim(g_div)
	g_area=trim(g_area)
	g_title=trim(g_title)
	g_name=trim(g_name)
	g_address1=trim(g_address1)
	g_address2=trim(g_address2)
	g_phone1=trim(g_phone1)
	g_phone2=trim(g_phone2)
	g_phone3=trim(g_phone3)

	if not (g_phone2="" or g_phone3="") then
		if g_phone1="" then
			g_phone1="000"
		end if

		g_phone=g_phone1 & "-" & g_phone2 & "-" & g_phone3
	end if


	if cd<>"delete" then
		if g_div="" or g_area="" or g_title=""  then
			response.write "<script>alert('파라미터 누락')</script>"
			response.end
		end if

		if isnumeric(g_div)=false then
			response.write "<script>alert('파라미터 오류')</script>"
			response.end
		else
			g_div=int(g_div)
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
		sql="update nc_agency set g_display=0 where idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	elseif cd="edit" then
		sql="update nc_agency set"
		sql=sql & " g_div= ? "
		sql=sql & " , g_area= ? "
		sql=sql & " , g_title= ? "
		sql=sql & " , g_name= ? "
		sql=sql & " , g_address1= ? "
		sql=sql & " , g_address2= ? "
		sql=sql & " , g_phone= ? "
		sql=sql & " where g_display>0"
		sql=sql & " and idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@g_div",adVarWChar,adParamInput,2,g_div)
		cmd.parameters.append cmd.createparameter("@g_area",adVarWChar,adParamInput,10,g_area)
		cmd.parameters.append cmd.createparameter("@g_title",adVarWChar,adParamInput,100,g_title)
		cmd.parameters.append cmd.createparameter("@g_name",adVarWChar,adParamInput,10,g_name)
		cmd.parameters.append cmd.createparameter("@g_address1",adVarWChar,adParamInput,100,g_address1)
		cmd.parameters.append cmd.createparameter("@g_address2",adVarWChar,adParamInput,100,g_address2)
		cmd.parameters.append cmd.createparameter("@g_phone",adVarWChar,adParamInput,13,g_phone)
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	else
		sql="insert nc_agency (g_id,g_div,g_area,g_title,g_name,g_address1,g_address2,g_phone,g_ip) values (?,?,?,?,?,?,?,?,?)"

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@g_id",adVarWChar,adParamInput,12,current_id)
		cmd.parameters.append cmd.createparameter("@g_div",adVarWChar,adParamInput,2,g_div)
		cmd.parameters.append cmd.createparameter("@g_area",adVarWChar,adParamInput,10,g_area)
		cmd.parameters.append cmd.createparameter("@g_title",adVarWChar,adParamInput,100,g_title)
		cmd.parameters.append cmd.createparameter("@g_name",adVarWChar,adParamInput,10,g_name)
		cmd.parameters.append cmd.createparameter("@g_address1",adVarWChar,adParamInput,100,g_address1)
		cmd.parameters.append cmd.createparameter("@g_address2",adVarWChar,adParamInput,100,g_address2)
		cmd.parameters.append cmd.createparameter("@g_phone",adVarWChar,adParamInput,13,g_phone)
		cmd.parameters.append cmd.createparameter("@g_ip",adVarWChar,adParamInput,15,current_ip)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing
	end if
%>


<script language="javascript">
	<% if cd="delete" then %>
		alert("삭제되었습니다.");
		parent.location.href="<%= gb %>_list.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>";
	<% elseif cd="edit" then %>
		alert("수정되었습니다.");
		parent.location.href="<%= gb %>_list.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>";
	<% else %>
		alert("등록되었습니다.");
		parent.location.href="<%= gb %>_list.asp?page=1<%= g_cmd %>";
	<% end if %>
</script>


<!-- #include file="../config/db_close.asp" -->
