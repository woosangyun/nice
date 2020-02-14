<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->
<!-- #include file="include/admin_layout.asp" -->


<%
	if div<>"" then
		d_sql=" and p_div2= ? "
	end if
%>


<%
	if s_str<>"" then
		select case s_part
			case "multi"		: s_sql=" and (p_title like ? or p_content like ? )"
			case "title"			: s_sql=" and p_title like ? "
			case "content"	: s_sql=" and p_content like ? "
		end select
	end if
%>


<%
	sql="select count(*) from nc_product2 where p_display>0" & d_sql & s_sql

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true

	if div<>"" then
		cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
	end if

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


<% call html_top() %>


									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/img_002.gif" width="595" height="54"></td>
                                      </tr>
                                      <tr>
                                        <td height="16">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td height="294" valign="top">



<!--ir자료 게시판 시작 ##################################################-->


	<script language="javascript">
		function select_div(on) {
			if (on=="") {
				location.href="<%= gb %>_list.asp?page=1<%= g_cmd %>";
			} else {
				location.href="<%= gb %>_list.asp?page=1<%= g_cmd %>&div="+on;
			}
		}
	</script>


										<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td> 
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr> 
                                                    <td> 
                                                      <table width="595" border="0" cellspacing="0" cellpadding="0">
                                                        <tr> 
                                                          <td> 
															<table width="595" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td colspan="5" valign="top" height="25">
					<select id="div" name="div" class="select_01" onchange="select_div(this.value)">
						<option value="">:::제품분류선택:::</option>
						<%
							Dim num : num = 0
							sql="select"
							sql=sql & "		idx, c_category, c_order"
							sql=sql & " from nc_category order by c_order asc "

							set cmd=server.createobject("adodb.command")
							cmd.activeconnection=lo_DbCon
							cmd.commandtext=sql
							cmd.commandtype=adCmdText
							cmd.prepared=true

							set rs=cmd.execute
								if not rs.eof or rs.bof then
									do until rs.eof
									idx=rs("idx")
									c_category=rs("c_category")
									c_order=rs("c_order")
						%>
						<option value="<%=c_category%>" <%If div=c_category Then : response.write "selected" End If%>>→ <%=c_category%></option>
						<!--
						<option value="1" <%If div="1" Then : response.write "selected" End If%>>→ 신용카드조회기(유선)</option>
						<option value="2" <%If div="2" Then : response.write "selected" End If%>>→ 신용카드조회기(무선)</option>
						<option value="3" <%If div="3" Then : response.write "selected" End If%>>→ POS 장비</option>
						<option value="4" <%If div="4" Then : response.write "selected" End If%>>→ 멀티패드</option>
						<option value="5" <%If div="5" Then : response.write "selected" End If%>>→ 서명패드</option>
						<option value="6" <%If div="6" Then : response.write "selected" End If%>>→ 기타장비</option>
						-->
						<%
										num=num-1
										rs.movenext
									loop
								end if
							set rs=nothing
							set cmd=nothing
						%>
					</select>
																</td>
															</tr>
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
															<tr height="30" style="font-size:13px; background:#E6E4E0">
																<th>번호</th>
																<th>이미지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
																<th align="left">제품분류</th>
																<th align="left">모델명</th>
																<th align="left">인증</th>
															</tr>
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
<!------------------------------------------------------------->
<%
						sql="select"
						sql=sql & "		idx, p_div, p_title, p_file_idx, p_file_name, p_certify"
						sql=sql & " ,	(select x_file from nc_file where idx=a.p_file_idx) as x_file, p_div2"
						sql=sql & " from nc_product2 a"
						sql=sql & " where p_display>0"
						sql=sql & d_sql
						sql=sql & s_sql
'						sql=sql & "	order by idx desc"
						sql=sql & "	order by p_order asc"
						sql=sql & "	limit " & (page-1)*view_count & "," & view_count

						set cmd=server.createobject("adodb.command")
						cmd.activeconnection=lo_DbCon
						cmd.commandtext=sql
						cmd.commandtype=adCmdText
						cmd.prepared=true

						if div<>"" then
							cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
						end if

						if s_str<>"" then
							if s_part="multi" then
								cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
							end if

							cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
						end if

						set rs=cmd.execute
							if rs.eof or rs.bof then
					%>
		<tr> 
			<td height="27" colspan="5"> 
			<div align="center">※ 등록된 글이 없습니다.</div>
			</td>																	
		</tr>
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
					<%
							else
								num=total_count-((page-1)*view_count)

								do until rs.eof
									idx=rs("idx")
									p_div=rs("p_div")
									p_title=rs("p_title")
									p_file_idx=rs("p_file_idx")
									p_file_name=rs("p_file_name")
									p_certify=rs("p_certify")
									x_file=rs("x_file")
									p_div2=rs("p_div2")

									select case p_div
										case "1"	: div_str="카드조회(유선)"
										case "2"	: div_str="카드조회(무선)"
										case "3"	: div_str="POS장비"
										case "4"	: div_str="멀티패드"
										case "5"	: div_str="서명패드"
										case "6"	: div_str="기타장비"
										case else	: div_str="&nbsp;"
									end select

									p_title=html_encode(p_title)


									if instr(x_file,".") then
'										thumb_file=split(x_file,".")(0) & "_thumb." & split(x_file,".")(1)
										thumb_file=split(x_file,".")(0) & "_thumb.jpg"
									else
										thumb_file=""
									end if
					%>
	<tr> 
	<td width="55"> 
		<div align="center"><%= num %></div>
	</td>
	<td width="137" height="110"> 
		<div align="center" style="width:108px; height:102px; border:1px solid silver">
		<% IF p_file_idx <1 THEN %>
			<div class="silver" style="margin-top:40px">no image</span>
		<% ELSE %>
			<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>"><img src="<%= upload_virtual2 %>/<%= gb %>/<%= thumb_file %>" width="106" height="100" border="0"></a>
		<% END IF %>
		</div>
	</td>
	<td width="150">
		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>"><%= p_div2 %></a>
	</td>
	<td width="205"> 
		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>"><%= p_title %></a>
	</td>
	<td width="50"> 
		<% if p_certify=1 then %>인증<% end if %>
	</td>
	</tr>
	<tr> 
	<td bgcolor=#dcdcdc colspan=5 height=1></td>
	</tr>
					<%
									num=num-1
									rs.movenext
								loop
							end if
						set rs=nothing
						set cmd=nothing
					%>
<!------------------------------------------------------------->
                                                            </table>
                                                          </td>
                                                        </tr>
                                                        <tr> 
                                                          <td><img src="img/n_line_01.gif" width="595" height="2"></td>
                                                        </tr>
                                                        <tr> 
                                                          <td height="50"> 
<!--페이징 시작 ------------------------------------------------------------>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                              <tr> 
                                                                <td width="100%"><div align="center">

																		<!-- 페이징 -->
																		<% call page_num(gb&"_list.asp",g_cmd&d_cmd&s_cmd,total_page) %>

																</div>
																</td>
                                                              </tr>																															
                                                            </table>
<!--페이징 종료 ------------------------------------------------------------>
                                                          </td>
                                                        </tr>

													  </table>
                                                    </td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
<!--검색 시작----------------------------------------------------------------->
                                            <tr> 
                                              <td> 
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr> 
                                                    <td width="260"> 

															<!-- 검색 -->
															<% call search_string(gb&"_list.asp",g_cmd&d_cmd) %>

													</td>
                                                    <td>&nbsp;</td>
                                                    <td width="80"><a href="<%= gb %>_write.asp<%= p_cmd %><%= g_cmd %>"><img name="Image20" border="0" src="img/btn_06.gif" width="80" height="21"></a></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
<!--검색 종료----------------------------------------------------------------->
                                          </table>
                                        </td>
                                      </tr>
                                    </table>


<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
