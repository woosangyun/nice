<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->



<%
	idx=request("idx")

	c_order=request("c_order")
	c_category=request("c_category")
	c_category_eng=request("c_category_eng")
	
	corder = Split(c_order,",")	
	ccategory = Split(c_category,",")
	ccategory_eng = Split(c_category_eng,",")

	'Response.Write c_order
	'Response.End
	

	dsql="delete from nc_category; "
	set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=dsql
		cmd.commandtype=adCmdText
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing
	
	dsql2="alter table nc_category auto_increment=1;"
	set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=dsql2
		cmd.commandtype=adCmdText
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing
	
	dsql3="update nc_product a join  nc_category b set a.p_div = b.idx where a.p_div2 = b.c_category; "
	set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=dsql3
		cmd.commandtype=adCmdText
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing	
	
	dsql4="update nc_product2 a join  nc_category b set a.p_div = b.idx where a.p_div2 = b.c_category; "
	set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=dsql4
		cmd.commandtype=adCmdText
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing	
	
	For i = 0 To Ubound(corder)	
		sql=" insert nc_category (c_order, c_category, c_category_eng) value (?,?,?) "

		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@c_order",adInteger,adParamInput,4,Trim(corder(i)))
		cmd.parameters.append cmd.createparameter("@c_category",adVarWChar,adParamInput,255,Trim(ccategory(i)))
		cmd.parameters.append cmd.createparameter("@c_category_eng",adVarWChar,adParamInput,255,Trim(ccategory_eng(i)))
		cmd.execute ,,adExecuteNoRecords
		set cmd=nothing
	Next
%>


<script language="javascript">
	alert("저장되었습니다.");
	//parent.location.href="category_list.asp";
	//ocation.href="category_list.asp";
	history.back(-1);
</script>


<!-- #include file="../config/db_close.asp" -->
