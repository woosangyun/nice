<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


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
	if s_str<>"" then
		select case s_part
			case "multi"		: s_sql=" and (i_title like ? or i_content like ? )"
			case "title"			: s_sql=" and i_title like ? "
			case "content"	: s_sql=" and i_content like ? "
		end select
	end if
%>


<%
	sql="select"
	sql=sql & "		i_title, i_regdate, i_file_idx, i_file_name, i_content"
	sql=sql & "	,	unix_timestamp(i_regdate)+idx as unix_timestamp"
	sql=sql & " from nc_ir"
	sql=sql & " where i_display>0"
	sql=sql & "	and idx= ? "

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
	set rs=cmd.execute
		if rs.eof or rs.bof then
			response.write "데이터 오류"
			response.end
		else
			i_title=rs("i_title")
			i_regdate=rs("i_regdate")
			i_file_idx=rs("i_file_idx")
			i_file_name=rs("i_file_name")
			i_content=rs("i_content")
			unix_timestamp=rs("unix_timestamp")
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, i_title"
	sql=sql & " from nc_ir"
	sql=sql & " where i_display>0"
'	sql=sql & "	and idx> ? "
	sql=sql & "	and unix_timestamp(i_regdate)+idx > ? "
	sql=sql & s_sql
	sql=sql & "	order by i_regdate asc, idx asc"
	sql=sql & "	limit 1"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,unix_timestamp)

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
	end if

	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			next_idx=rs("idx")
			next_title=rs("i_title")
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, i_title"
	sql=sql & " from nc_ir"
	sql=sql & " where i_display>0"
'	sql=sql & "	and idx< ? "
	sql=sql & "	and unix_timestamp(i_regdate)+idx < ? "
	sql=sql & s_sql
	sql=sql & "	order by i_regdate desc, idx desc"
	sql=sql & "	limit 1"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,unix_timestamp)

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
	end if

	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			prev_idx=rs("idx")
			prev_title=rs("i_title")
		end if
	set rs=nothing
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 투자정보-IR자료</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/sub.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<!--[if lt IE 9]>
      <script type="text/javascript" src="../js/respond.js"></script>
      <script type="text/javascript" src="../js/selectivizr.js"></script>
<![endif]-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/sub.js"></script>
<script type="text/javascript">
	
	var m0 = 2;
	var m1 = 3;
	//var m2 = 1;
	//var s = 10;

</script>
</head>
<body class="stock">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">ir</p>
        <p class="kor">IR자료</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>IR자료</h2>
            <ul class="view">
                <li>
                    <ul class="data">
                        <li class="date"><%= i_regdate %></li>
                    </ul>
                    <div class="title"><%= i_title %></div>
                </li>

				<% if i_file_idx>0 then %>
				<li class="file"><a onclick="location.href='../../inc/nice_download.asp?idx=<%= i_file_idx %>'" style="cursor:pointer"><%= i_file_name %></a></li>
				<% end if %>

				<li class="BoardCon"><%= i_content %></li>
                <li class="boardPrev">
					<p>이전글</p>

					<% if prev_idx="" then %>
						<a style="color:silver; text-decoration:none">이전 글이 없습니다.</a>
					<% else %>
						<a href="4_view.asp<%= p_cmd %><%= s_cmd %>&idx=<%= prev_idx %>"><%= prev_title %></a>
					<% end if %>

				</li>
                <li class="boardNext">
					<p>다음글</p>

					<% if next_idx="" then %>
						<a style="color:silver; text-decoration:none">다음 글이 없습니다.</a>
					<% else %>
						<a href="4_view.asp<%= p_cmd %><%= s_cmd %>&idx=<%= next_idx %>"><%= next_title %></a>
					<% end if %>

				</li>
            </ul>
            <a href="4.asp<%= p_cmd %><%= s_cmd %>" class="solidBtn">목록</a>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
