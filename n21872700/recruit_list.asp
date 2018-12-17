<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->
<!-- #include file="include/admin_layout.asp" -->


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
	sql="select count(*) from nc_recruit where c_display>0" & s_sql

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


<% call html_top() %>


									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/m_title_recruit.gif" width="595" height="54"></td>
                                      </tr>
                                      <tr>
                                        <td height="16">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td height="294" valign="top">



<!--ir자료 게시판 시작 ##################################################-->
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
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
															<tr height="30" style="font-size:13px; background:#E6E4E0">
																<th>번호</th>
																<th>제목</th>
																<th>등록일</th>
																<th>종료일</th>
																<th>파일</th>
															</tr>
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
<!------------------------------------------------------------->
<%
						sql="select"
						sql=sql & "		idx, c_title, c_regdate, c_enddate, c_file_idx, c_file_name"
						sql=sql & " from nc_recruit"
						sql=sql & " where c_display>0"
						sql=sql & s_sql
						sql=sql & "	order by c_regdate desc, idx desc"
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
									c_title=rs("c_title")
									c_regdate=rs("c_regdate")
									c_enddate=rs("c_enddate")
									c_file_idx=rs("c_file_idx")
									c_file_name=rs("c_file_name")

									c_title=html_encode(c_title)

									if datediff("d",c_regdate,date()) < 3 then
										new_tag=" <img src='img/icon_new.gif' border=0>"
									else
										new_tag=""
									end if
					%>
	<tr> 
	<td width="55" height="27"> 
		<div align="center"><%= num %></div>
	</td>
	<td width="275" height="27" class="space">
		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= idx %>"><%= c_title %><%= new_tag %></a>
	</td>
	<td width="90" height="27"> 
		<div align="center"><%= c_regdate %></div>
	</td>
	<td width="90" height="27"> 
		<div align="center"><%= c_enddate %></div>
	</td>
	<td width="87" height="27"> 
		<div align="center">
		<%
		IF c_file_idx <1 THEN
		RESPONSE.WRITE "&nbsp;"
		ELSE
		Response.Write "<a href='../inc/nice_download.asp?idx=" & c_file_idx & "'><img src='img/icon_01.gif' width='34' height='20' alt='"& c_file_name &"' border='0'></a>"
		END IF
		%>
		</div>
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
																		<% call page_num(gb&"_list.asp",g_cmd&s_cmd,total_page) %>

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
															<% call search_string(gb&"_list.asp",g_cmd) %>

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
