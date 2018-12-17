<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


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
	sql="select count(*) from nc_ir where i_display>0 and lan_type = 1"  & s_sql

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
	end if

	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			total_count=cint(rs(0))
			total_page=int((total_count-1)/view_count)+1
		end if
	set rs=nothing
	set cmd=nothing
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE Information &amp; Telecommunication Investment Information-Financial Information</title>
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
	var m1 = 2;
	//var m2 = 1;
	//var s = 10;

</script>
</head>
<body class="stock">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">ir</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">go main</a>
        	</div>
            <h2>IR Data</h2>
            <div class="boardTop">
                <p class="result">Current : <%= page %>/<%= total_page %>Page<span>Total <%= total_count %></span></p>
            </div>
            <ul class="list">


				<%
					sql="select"
					sql=sql & "		idx, i_title, i_regdate, i_file_idx, i_file_name"
					sql=sql & " from nc_ir"
					sql=sql & " where i_display>0"
					sql=sql & " and lan_type = 1"
					sql=sql & s_sql
					sql=sql & "	order by i_regdate desc, idx desc"
					sql=sql & "	limit " & (page-1)*view_count & "," & view_count

					set cmd=server.createobject("adodb.command")
					cmd.activeconnection=lo_DbCon
					cmd.commandtext=sql
					cmd.commandtype=adCmdText
					cmd.prepared=true

					if s_str<>"" then
						if s_part="multi" then
							cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
						end if

						cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
					end if

					set rs=cmd.execute
						if  not (rs.eof or rs.bof) then
							num=total_count-((page-1)*view_count)

							do until rs.eof
								idx=rs("idx")
								i_title=rs("i_title")
								i_regdate=rs("i_regdate")
								i_file_idx=rs("i_file_idx")
								i_file_name=rs("i_file_name")

								i_title=html_encode(i_title)
								i_regdate=display_date(i_regdate,4,0)
				%>
				<li>
                    <ul class="data">
                        <li class="date"><%= i_regdate %></li>

						<% if i_file_idx>0 then %>
                        <li class="file"></li>
						<% end if %>

                    </ul>
                    <div class="link stockLink">
                    	<a href="4_view.asp<%= p_cmd %><%= s_cmd %>&idx=<%= idx %>"><%= i_title %></a>
                    </div>
                </li>
				<%
								num=num-1
								rs.movenext
							loop
						end if
					set rs=nothing
					set cmd=nothing
				%>


			</ul>
            <div class="search">

				<% call search_string_user("4.asp","") %>

            </div>
            <div class="paging">

				<% call page_num_user("4.asp",s_cmd,total_page) %>

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
