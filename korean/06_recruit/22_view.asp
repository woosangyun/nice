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
			case "multi"		: s_sql=" and (c_title like ? or c_content like ? )"
			case "title"			: s_sql=" and c_title like ? "
			case "content"	: s_sql=" and c_content like ? "
		end select
	end if
%>


<%
	sql="select"
	sql=sql & "		c_title, c_regdate, c_enddate, c_file_idx, c_file_name, c_content"
	sql=sql & "	,	unix_timestamp(c_regdate)+idx as unix_timestamp"
	sql=sql & " from nc_recruit"
	sql=sql & " where c_display>0"
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
			c_title=rs("c_title")
			c_regdate=rs("c_regdate")
			c_enddate=rs("c_enddate")
			c_file_idx=rs("c_file_idx")
			c_file_name=rs("c_file_name")
			c_content=rs("c_content")
			unix_timestamp=rs("unix_timestamp")

			c_title=html_encode(c_title)
			c_regdate=display_date(c_regdate,4,0)

			if datediff("d",date(),c_enddate) <0 then
				state_str="종료"
				state_class="stateNone"
			else
				state_str="진행중"
				state_class="stateDo"
			end if
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, c_title"
	sql=sql & " from nc_recruit"
	sql=sql & " where c_display>0"
'	sql=sql & "	and idx> ? "
	sql=sql & "	and unix_timestamp(c_regdate)+idx > ? "
	sql=sql & s_sql
	sql=sql & "	order by c_regdate asc, idx asc"
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
			next_title=rs("c_title")
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, c_title"
	sql=sql & " from nc_recruit"
	sql=sql & " where c_display>0"
'	sql=sql & "	and idx< ? "
	sql=sql & "	and unix_timestamp(c_regdate)+idx < ? "
	sql=sql & s_sql
	sql=sql & "	order by c_regdate desc, idx desc"
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
			prev_title=rs("c_title")
		end if
	set rs=nothing
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 채용-채용정보-채용공고 상세보기</title>
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
	
	var m0 = 5;
	var m1 = 1;
	var m2 = 1;
	var s = 9;

</script>
</head>
<body class="recruit">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">recruitment information</p>
        <p class="kor">채용정보</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>채용정보</h2>
            <ul class="view">
                <li>
                    <ul class="data">
                        <li class="date"><%= c_regdate %></li>
                    </ul>
                    <div class="title"><%= c_title %></div>
                    <div class="<%= state_class %>"><%= state_str %></div>
                </li>

				<% if c_file_idx>0 then %>
				<li class="file"><a onclick="location.href='../../inc/nice_download.asp?idx=<%= c_file_idx %>'" style="cursor:pointer"><%= c_file_name %></a></li>
				<% end if %>

				<li class="BoardCon"><%= c_content %></li>
                <li class="boardPrev">
					<p>이전글</p>

					<% if prev_idx="" then %>
						<a style="color:silver; text-decoration:none">이전 글이 없습니다.</a>
					<% else %>
						<a href="22_view.asp<%= p_cmd %><%= s_cmd %>&idx=<%= prev_idx %>"><%= prev_title %></a>
					<% end if %>

				</li>
                <li class="boardNext">
					<p>다음글</p>

					<% if next_idx="" then %>
						<a style="color:silver; text-decoration:none">다음 글이 없습니다.</a>
					<% else %>
						<a href="22_view.asp<%= p_cmd %><%= s_cmd %>&idx=<%= next_idx %>"><%= next_title %></a>
					<% end if %>

				</li>
            </ul>
            <a href="22.asp<%= p_cmd %><%= s_cmd %>" class="solidBtn">목록</a>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
