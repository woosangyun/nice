<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->
<!-- #include file="include/admin_layout.asp" -->


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
	if div<>"" then
		d_sql=" and g_div= ? "
	end if
%>


<%
	if s_str<>"" then
		select case s_part
			case "multi"		: s_sql=" and (g_title like ? or g_address1 like ? )"
			case "title"			: s_sql=" and g_title like ? "
			case "content"	: s_sql=" and g_address1 like ? "
		end select
	end if
%>


<%
	sql="select"
	sql=sql & "		g_div, g_area, g_title, g_name, g_address1, g_address2, g_phone"
	sql=sql & " from nc_agency"
	sql=sql & " where g_display>0"
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
			g_div=rs("g_div")
			g_area=rs("g_area")
			g_title=rs("g_title")
			g_name=rs("g_name")
			g_address1=rs("g_address1")
			g_address2=rs("g_address2")
			g_phone=rs("g_phone")

			temp_title=g_title

			g_area=html_encode(g_area)
			g_title=html_encode(g_title)
			g_name=html_encode(g_name)
			g_address1=html_encode(g_address1)
			g_address2=html_encode(g_address2)

			select case g_div
				case "2"	: div_str="서울특별시"
				case "51"	: div_str="부산광역시"
				case "53"	: div_str="대구광역시"
				case "32"	: div_str="인천광역시"
				case "62"	: div_str="광주광역시"
				case "42"	: div_str="대전광역시"
				case "52"	: div_str="울산광역시"
				case "44"	: div_str="세종특별자치시"
				case "31"	: div_str="경기도"
				case "33"	: div_str="강원도"
				case "43"	: div_str="충청북도"
				case "41"	: div_str="충청남도"
				case "54"	: div_str="경상북도"
				case "55"	: div_str="경상남도"
				case "63"	: div_str="전라북도"
				case "61"	: div_str="전라남도"
				case "64"	: div_str="제주특별자치도"
				case else	: div_str="&nbsp;"
			end select
		end if

		if left(g_phone,3)="000" then
			g_phone=mid(g_phone,5,len(g_phone))										
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, g_title"
	sql=sql & " from nc_agency"
	sql=sql & " where g_display>0"
	sql=sql & "	and g_title> ? "
	sql=sql & d_sql
	sql=sql & s_sql
	sql=sql & "	order by g_title asc, idx asc"
	sql=sql & "	limit 1"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
'	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
	cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,100,temp_title)

	if div<>"" then
		cmd.parameters.append cmd.createparameter("@div",adVarWChar,adParamInput,2,div)
	end if

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
	end if

	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			next_idx=rs("idx")
			next_title=rs("g_title")
		end if
	set rs=nothing


	sql="select"
	sql=sql & "		idx, g_title"
	sql=sql & " from nc_agency"
	sql=sql & " where g_display>0"
	sql=sql & "	and g_title< ? "
	sql=sql & d_sql
	sql=sql & s_sql
	sql=sql & "	order by g_title desc, idx desc"
	sql=sql & "	limit 1"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
'	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
	cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,100,temp_title)

	if div<>"" then
		cmd.parameters.append cmd.createparameter("@div",adVarWChar,adParamInput,2,div)
	end if

	if s_str<>"" then
		if s_part="multi" then
			cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
		end if

		cmd.parameters.append cmd.createparameter("@s_str",adVarWChar,adParamInput,255,"%"&s_str&"%")
	end if

	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			prev_idx=rs("idx")
			prev_title=rs("g_title")
		end if
	set rs=nothing
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
<!--ir자료_view 테이블 시작 ###########################################-->

	<script language="javascript">
		function deleteit(on) {
			if (confirm("삭제 후 복구할 수 없습니다.\n삭제하겠습니까?")) {
				document.getElementById("hidden_process").src="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx="+on+"&cd=delete";
			}
		}
	</script>


		<table width="595" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td> 
                                                <table width="595" border="0" cellspacing="0" cellpadding="0">
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
															<tr height="30" style="font-size:13px; background:#E6E4E0">
																<th>대리점명</th>
																<th>지역분류</th>
																<th>지역</th>
																<th>대표자</th>
																<th>전화번호</th>
															</tr>
		<tr> 
			<td bgcolor=#dcdcdc colspan=5 height=1></td>
		</tr>
                                                  <tr> 
                                                    <td width="200" height="27" class="space"> 
                                                      <div align="left"><strong><%= g_title %></strong></div>
                                                    </td>
                                                    <td width="98" height="27" > 
                                                      <div align="center"><%= div_str %></div>
                                                    </td>
                                                    <td width="50" height="27" > 
                                                      <div align="center"><%= g_area %></div>
                                                    </td>
                                                    <td width="138" height="27" > 
                                                      <div align="center"><%= g_name %></div>
                                                    </td>
                                                    <td width="109" height="27"> 
                                                    <div align="center"><%= g_phone %></div>
                                                    </td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td><img src="img/n_line_01.gif" width="595" height="2"></td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td> 
                                                <table width="100%" border="0" cellspacing="0" cellpadding="10">
                                                  <tr> 
                                                    <td>
														<div style="overflow:auto; overflow-y:hidden; width:575px">
														<%=g_address1%>&nbsp;<%=g_address2%>
														</div>
                                                    </td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td>&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td> 
                                                <table width="595" height="70" border="0" cellpadding="0" cellspacing="0">
                                                  <tr> 
                                                    <td background="img/n_bg_01.gif"> 
                                                      <table width="595" height="70" border="0" cellpadding="0" cellspacing="0">
                                                        <tr> 
                                                          <td background="img/n_bg_01.gif"> 
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                              <tr> 
                                                                <td width="20">&nbsp;</td>
                                                                <td width="50"><img src="img/n_icon_01.gif" width="41" height="11"></td>
                                                                <td>
																	<% if prev_idx="" then %>
																		<span class="silver">이전 글이 없습니다.</span>
																	<% else %>
																		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= prev_idx %>"><%= prev_title %></a>
																	<% end if %>
																</td>
                                                              </tr>
                                                              <tr> 
                                                                <td height="10" colspan="3"></td>
                                                              </tr>
                                                              <tr> 
                                                                <td width="20">&nbsp;</td>
                                                                <td width="50"><img src="img/n_icon_02.gif" width="41" height="11"></td>
                                                                <td>
																	<% if next_idx="" then %>
																		<span class="silver">다음 글이 없습니다.</span>
																	<% else %>
																		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= next_idx %>"><%= next_title %></a>
																	<% end if %>
																</td>
                                                              </tr>
                                                            </table>
                                                          </td>
                                                        </tr>
                                                      </table>
                                                    </td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
		<tr><td height="40"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td width="150">
					<a href="<%= gb %>_write.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit"><img name="Image20" border="0"   onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','img/btn_07_ov.gif',1)" src="img/btn_07.gif" width="61" height="21"></a>
					<a onclick="deleteit(<%= idx %>)" style="cursor:pointer"><img name="Image211"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image211','','img/btn_08_ov.gif',1)" border="0" src="img/btn_08.gif" width="61" height="21" hspace="5"></a>
					</td>
					<td>&nbsp;</td>
					<td width="80"><a href="<%= gb %>_list.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>"><img src="img/n_btn_05.gif" style="cursor:hand"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','img/n_btn_05_ov.gif',1)" name="Image5" width="80" height="21" border="0"></a></td>
				</tr>
			</table>
			</td>
		</tr>
                                          </table>
<!--ir자료_view 테이블 끝 ##############################################-->
                                        </td>
                                      </tr>
                                    </table>


<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
