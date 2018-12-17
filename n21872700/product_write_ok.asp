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

	p_div=request("p_div")
	p_title=request("p_title")
	p_content=request("p_content")
	p_comment=request("p_comment")
	p_link=request("p_link")
	p_certify=request("p_certify")
	p_order=request("p_order")

	x_idx=request("x_idx")
	x_file=request("x_file")


	p_div=trim(p_div)
	p_title=trim(p_title)
	p_content=trim(p_content)
	p_comment=trim(p_comment)
	p_link=lcase(trim(p_link))
	p_certify=trim(p_certify)
	p_order=trim(p_order)


	if x_idx="" or isnumeric(x_idx)=false then
		x_idx=0
		x_file=""
	else
		x_idx=int(x_idx)
		x_file=trim(x_file)
	end if


	if cd<>"delete" then
		if p_div="" or p_title="" or p_content="" or p_certify="" or p_order="" then
			response.write "<script>alert('파라미터 누락')</script>"
			response.end
		end if

		if isnumeric(p_div)=false or isnumeric(p_certify)=false or isnumeric(p_order)=false then
			response.write "<script>alert('파라미터 오류')</script>"
			response.end
		else
			p_div=int(p_div)
			p_certify=int(p_certify)
			p_order=int(p_order)
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
'		sql="update nc_product set p_order=p_order-1 where p_display>0 and p_order > (select p_order from nc_product where idx = ? ) "
		sql="update nc_product set p_order=p_order-1 where p_display>0 and p_order > (select * from (select p_order from nc_product a where idx = ? ) as a)"

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing


		sql="update nc_product set p_display=0 where idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	elseif cd="edit" then
		old_order=request("old_order")

		if old_order="" or isnumeric(old_order)=false then
			response.write "<script>alert('파라미터 오류')</script>"
			response.end
		else
			old_order=int(old_order)
		end if


		if old_order-p_order < 0 then
			sql="update nc_product set p_order=p_order-1 where p_display>0 and p_order > ? and p_order <= ? "
		elseif old_order-p_order > 0 then
			sql="update nc_product set p_order=p_order+1 where p_display>0 and p_order < ? and p_order >= ? "
		else
			sql=""
		end if

		if sql<>"" then
			set cmd=server.createobject("adodb.command")
			cmd.activeconnection=lo_DbCon
			cmd.commandtext=sql
			cmd.commandtype=adCmdText
			cmd.prepared=true
			cmd.parameters.append cmd.createparameter("@old_order",adInteger,adParamInput,4,old_order)
			cmd.parameters.append cmd.createparameter("@p_order",adInteger,adParamInput,4,p_order)
			cmd.execute ,,adExecuteNoRecords
			set cmd=nothing
		end if


		sql="update nc_product set"
		sql=sql & " p_div= ? "
		sql=sql & " , p_title= ? "
		sql=sql & " , p_content= ? "
		sql=sql & " , p_comment= ? "
		sql=sql & " , p_link= ? "
		sql=sql & " , p_certify= ? "
		sql=sql & " , p_order= ? "

		if x_idx>0 then
			sql=sql & " , p_file_idx= ? "
			sql=sql & " , p_file_name= ? "
		end if

		sql=sql & " where p_display>0"
		sql=sql & " and idx= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@p_div",adWChar,adParamInput,1,p_div)
		cmd.parameters.append cmd.createparameter("@p_title",adVarWChar,adParamInput,100,p_title)
		cmd.parameters.append cmd.createparameter("@p_content",adVarWChar,adParamInput,20000,p_content)
		cmd.parameters.append cmd.createparameter("@p_comment",adVarWChar,adParamInput,10000,p_comment)
		cmd.parameters.append cmd.createparameter("@p_link",adVarWChar,adParamInput,100,p_link)
		cmd.parameters.append cmd.createparameter("@p_certify",adWChar,adParamInput,1,p_certify)
		cmd.parameters.append cmd.createparameter("@p_order",adInteger,adParamInput,4,p_order)

		if x_idx>0 then
			cmd.parameters.append cmd.createparameter("@x_idx",adInteger,adParamInput,4,x_idx)
			cmd.parameters.append cmd.createparameter("@x_file",adVarWChar,adParamInput,255,x_file)
		end if

		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing

	else
		sql="update nc_product set p_order=p_order+1 where p_display>0 and p_order >= ? "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@p_order",adInteger,adParamInput,4,p_order)
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing


		sql="insert nc_product (p_id,p_div,p_title,p_file_idx,p_file_name,p_content,p_comment,p_link,p_certify,p_order,p_ip) values (?,?,?,?,?,?,?,?,?,?,?)"

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@p_id",adVarWChar,adParamInput,12,current_id)
		cmd.parameters.append cmd.createparameter("@p_div",adWChar,adParamInput,1,p_div)
		cmd.parameters.append cmd.createparameter("@p_title",adVarWChar,adParamInput,100,p_title)
		cmd.parameters.append cmd.createparameter("@x_idx",adInteger,adParamInput,4,x_idx)
		cmd.parameters.append cmd.createparameter("@x_file",adVarWChar,adParamInput,255,x_file)
		cmd.parameters.append cmd.createparameter("@p_content",adVarWChar,adParamInput,10000,p_content)
		cmd.parameters.append cmd.createparameter("@p_comment",adVarWChar,adParamInput,10000,p_comment)
		cmd.parameters.append cmd.createparameter("@p_link",adVarWChar,adParamInput,100,p_link)
		cmd.parameters.append cmd.createparameter("@p_certify",adWChar,adParamInput,1,p_certify)
		cmd.parameters.append cmd.createparameter("@p_order",adInteger,adParamInput,4,p_order)
		cmd.parameters.append cmd.createparameter("@p_ip",adVarWChar,adParamInput,15,current_ip)
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
		parent.location.href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>";
	<% else %>
		alert("등록되었습니다.");
		parent.location.href="<%= gb %>_list.asp?page=1<%= g_cmd %>";
	<% end if %>
</script>


<!-- #include file="../config/db_close.asp" -->
