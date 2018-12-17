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


<% call html_top() %>


									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/m_title_10.gif" width="595" height="54"></td>
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
																<td valign="top" height="25">
					<select id="div" name="div" class="select_01" onchange="select_div(this.value)">
						<option value="">:::지역분류선택:::</option>
						<option value="2" <%If div="2" Then : response.write "selected" End If%>>→ 서울특별시</option>
						<option value="51" <%If div="51" Then : response.write "selected" End If%>>→ 부산광역시</option>
						<option value="53" <%If div="53" Then : response.write "selected" End If%>>→ 대구광역시</option>
						<option value="32" <%If div="32" Then : response.write "selected" End If%>>→ 인천광역시</option>
						<option value="62" <%If div="62" Then : response.write "selected" End If%>>→ 광주광역시</option>
						<option value="42" <%If div="42" Then : response.write "selected" End If%>>→ 대전광역시</option>
						<option value="52" <%If div="52" Then : response.write "selected" End If%>>→ 울산광역시</option>
						<option value="44" <%If div="44" Then : response.write "selected" End If%>>→ 세종특별자치시</option>
						<option value="31" <%If div="31" Then : response.write "selected" End If%>>→ 경기도</option>
						<option value="33" <%If div="33" Then : response.write "selected" End If%>>→ 강원도</option>
						<option value="43" <%If div="43" Then : response.write "selected" End If%>>→ 충청북도</option>
						<option value="41" <%If div="41" Then : response.write "selected" End If%>>→ 충청남도</option>
						<option value="54" <%If div="54" Then : response.write "selected" End If%>>→ 경상북도</option>
						<option value="55" <%If div="55" Then : response.write "selected" End If%>>→ 경상남도</option>
						<option value="63" <%If div="63" Then : response.write "selected" End If%>>→ 전라북도</option>
						<option value="61" <%If div="61" Then : response.write "selected" End If%>>→ 전라남도</option>
						<option value="64" <%If div="64" Then : response.write "selected" End If%>>→ 제주특별자치도</option>
					</select>
																</td>
															</tr>
													  <tr>
                                                          <td><img src="img/n_bar_13.gif" width="595" height="32"></td>
                                                        </tr>
                                                        <tr> 
                                                          <td> 
															<table width="595" border="0" cellspacing="0" cellpadding="0">
<!------------------------------------------------------------->
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
	<tr> 																															
	<td width='52' height='27'><div align='center'><%=g_area%></div></td>			
	<td width='102' height='27' class='space'><a href="<%= gb %>_write.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit"><%= g_title %></a></td>						
	<td width='50' height='27'><div align='center'><%=g_name%></div></td>		
	<td width='290' class='text_04'><p style='margin-left:10px;margin-right:10px;'><nobr><span style='width:280px;text-overflow : ellipsis; overflow : hidden;'>
	&nbsp;<%=ls_level%>&nbsp;<a href="<%= gb %>_write.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit"><%= g_address %></a></a>
	</span></nobr></td></td>							
	<td height='37'><div align='center'><%=g_phone%></div></td>				
	</tr>																															
	<tr><td bgcolor=#dcdcdc colspan=5 height=1></td></tr>	
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
