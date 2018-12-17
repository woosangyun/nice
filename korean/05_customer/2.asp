<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->

<% gb="agency" %>

<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<%
	if div<>"" then
		d_sql=" and g_div= ? "
	end if
%>


<%
	if s_str<>"" then
		select case s_part
			case "multi"		: s_sql=" and (g_title like ? or g_address1 like ? or g_address2 like ? )"
			case "title"			: s_sql=" and g_title like ? "
			case "address"	: s_sql=" and (g_address1 like ? or g_address2 like ? )"
		end select
	end if
%>


<%
	sql="select count(*) from nc_agency where g_display>0" & d_sql & s_sql

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true

	if div<>"" then
		cmd.parameters.append cmd.createparameter("@div",adVarWChar,adParamInput,2,div)
	end if

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		if s_part="address" then
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
<title>NICE정보통신 고객지원-전국대리점 안내</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
<meta name="format-detection" content="telephone=no" />
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
	//var m2 = 0;
	//var s = 0;

</script>
</head>
<body class="customer">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">national agency</p>
        <p class="kor">전국대리점 안내</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>전국대리점 안내</h2>
            <div class="boardTop">
                <p class="result">현재 : <%= page %>/<%= total_page %>페이지<span>총 <%= total_count %>건</span></p>
                <div id="boardTopSelect">


					<script language="javascript">
						function select_div(on) {
							if (on=="") {
								location.href="2.asp";
							} else {
								location.href="2.asp?div="+on;
							}
						}
					</script>

					<%
						select case div
							case "2"			: area_label="서울특별시"
							case "51"			: area_label="부산광역시"
							case "53"			: area_label="대구광역시"
							case "32"			: area_label="인천광역시"
							case "62"			: area_label="광주광역시"
							case "42"			: area_label="대전광역시"
							case "52"			: area_label="울산광역시"
							case "44"			: area_label="세종특별자치시"
							case "31"			: area_label="경기도"
							case "33"			: area_label="강원도"
							case "43"			: area_label="충청북도"
							case "41"			: area_label="충청남도"
							case "54"			: area_label="경상북도"
							case "55"			: area_label="경상남도"
							case "63"			: area_label="전라북도"
							case "61"			: area_label="전라남도"
							case "64"			: area_label="제주특별자치도"
							case else			: area_label="지역선택"
						end select
					%>

					<label for="area"><%= area_label %></label>
                    <select id="area" name="div" title="지역선택" onchange="select_div(this.value)">
						<option value="">지역선택</option>
						<option value="2" <%If div="2" Then : response.write "selected" End If%>>서울특별시</option>
						<option value="51" <%If div="51" Then : response.write "selected" End If%>>부산광역시</option>
						<option value="53" <%If div="53" Then : response.write "selected" End If%>>대구광역시</option>
						<option value="32" <%If div="32" Then : response.write "selected" End If%>>인천광역시</option>
						<option value="62" <%If div="62" Then : response.write "selected" End If%>>광주광역시</option>
						<option value="42" <%If div="42" Then : response.write "selected" End If%>>대전광역시</option>
						<option value="52" <%If div="52" Then : response.write "selected" End If%>>울산광역시</option>
						<option value="44" <%If div="44" Then : response.write "selected" End If%>>세종특별자치시</option>
						<option value="31" <%If div="31" Then : response.write "selected" End If%>>경기도</option>
						<option value="33" <%If div="33" Then : response.write "selected" End If%>>강원도</option>
						<option value="43" <%If div="43" Then : response.write "selected" End If%>>충청북도</option>
						<option value="41" <%If div="41" Then : response.write "selected" End If%>>충청남도</option>
						<option value="54" <%If div="54" Then : response.write "selected" End If%>>경상북도</option>
						<option value="55" <%If div="55" Then : response.write "selected" End If%>>경상남도</option>
						<option value="63" <%If div="63" Then : response.write "selected" End If%>>전라북도</option>
						<option value="61" <%If div="61" Then : response.write "selected" End If%>>전라남도</option>
						<option value="64" <%If div="64" Then : response.write "selected" End If%>>제주특별자치도</option>
                    </select>


				</div>
            </div>
            <ul class="list">


				<%
					sql="select"
					sql=sql & "		idx, g_area, g_title, g_name, g_address1, g_address2, g_phone"
					sql=sql & " from nc_agency"
					sql=sql & " where g_display>0"
					sql=sql & d_sql
					sql=sql & s_sql
					sql=sql & "	order by g_title asc, idx desc"
					sql=sql & "	limit " & (page-1)*view_count & "," & view_count

					set cmd=server.createobject("adodb.command")
					cmd.activeconnection=lo_DbCon
					cmd.commandtext=sql
					cmd.commandtype=adCmdText
					cmd.prepared=true

						if div<>"" then
							cmd.parameters.append cmd.createparameter("@div",adVarWChar,adParamInput,2,div)
						end if

					if s_str<>"" then
						if s_part="multi" then
							cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
							cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
						end if

						if s_part="address" then
							cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
						end if

						cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
					end if

					set rs=cmd.execute
						if  not (rs.eof or rs.bof) then
							num=total_count-((page-1)*view_count)

							do until rs.eof
								idx=rs("idx")
								g_area=rs("g_area")
								g_title=rs("g_title")
								g_name=rs("g_name")
								g_address1=rs("g_address1")
								g_address2=rs("g_address2")
								g_phone=rs("g_phone")

								g_area=html_encode(g_area)
								g_title=html_encode(g_title)
								g_name=html_encode(g_name)
								g_address=html_encode(g_address1 & " " & g_address2)

								if left(g_phone,3)="000" then
									g_phone=mid(g_phone,5,len(g_phone))										
								end if
				%>
				<li>
                    <ul class="data">
                        <li class="num"><%= num %></li>
                        <li class="add"><%= g_address %></li>
                        <li class="phone"><%= g_phone %></li>
                        <li class="name">대표자 : <%= g_name %></li>
                    </ul>
                    <div class="link">
                    	<a><% if g_area<>"" then %>[<%= g_area %>] <% end if %><%= g_title %></a>
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

				<% call search_string_user("2.asp",d_cmd) %>

            </div>
            <div class="paging">

				<% call page_num_user("2.asp",d_cmd&s_cmd,total_page) %>

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
