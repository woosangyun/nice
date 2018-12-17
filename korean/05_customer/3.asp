<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<%
	if s_str<>"" then
		select case s_part
			case "multi"		: s_sql=" and (q_title like ? or q_content like ? )"
			case "title"			: s_sql=" and q_title like ? "
			case "content"	: s_sql=" and q_content like ? "
		end select
	end if
%>


<%
	sql="select count(*) from nc_faq where q_display>0" & s_sql

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
<title>NICE정보통신 고객지원-FAQ</title>
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
	
	var m0 = 4;
	var m1 = 1;
	//var m2 = 1;
	//var s = 9;

</script>
</head>
<body class="customer">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">FAQ</p>
        <p class="kor">질문과 답변</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>FAQ</h2>
            <div class="boardTop">
                <p class="result">현재 : <%= page %>/<%= total_page %>페이지<span>총 <%= total_count %>건</span></p>
            </div>
            <ul class="faq">


				<%
					sql="select"
					sql=sql & "		idx, q_title, q_content"
					sql=sql & " from nc_faq"
					sql=sql & " where q_display>0"
					sql=sql & s_sql
					sql=sql & "	order by idx desc"
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
								q_title=rs("q_title")
								q_content=rs("q_content")

								q_title=html_encode(q_title)
				%>
				<li class="q"><p class="bu">Q</p><p class="text"><%= q_title %></p></li>
                <li class="a"><p class="bu">A</p><p class="text"><%= q_content %></p></li>
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

				<% call search_string_user("3.asp","") %>

            </div>
            <div class="paging">

				<% call page_num_user("3.asp",s_cmd,total_page) %>

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
