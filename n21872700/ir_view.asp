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

			if datediff("d",i_regdate,date()) < 3 then
				new_tag=" <img src='img/icon_new.gif' border=0>"
			else
				new_tag=""
			end if
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


<% call html_top() %>

									
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/m_title_04.gif" width="595" height="54"></td>
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
				document.getElementById("hidden_process").src="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx="+on+"&cd=delete";
			}
		}
	</script>


		<table width="595" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td><img src="img/n_bar_07.gif" width="595" height="32"></td>
                                            </tr>
                                            <tr> 
                                              <td> 
                                                <table width="595" border="0" cellspacing="0" cellpadding="0">
                                                  <tr> 
                                                    <td width="448" height="27" class="space"> 
                                                      <div align="left"><strong><%= i_title %></strong><%= new_tag %></div>
                                                    </td>
                                                    <td width="88" height="27" > 
                                                      <div align="center"><%= i_regdate %></div>
                                                    </td>
                                                    <td width="59" height="27"> 
                                                    <div align="center">
													<%
													IF i_file_idx <1 THEN
														RESPONSE.WRITE "&nbsp;"
													ELSE
														Response.Write "<a href='../inc/nice_download.asp?idx=" & i_file_idx & "'><img src='img/icon_01.gif' width='34' height='20' alt='"& i_file_name &"' border='0'></a>"
													END IF
													%>
													</div>
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
														<%=i_content%>
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
																		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= prev_idx %>"><%= prev_title %></a>
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
																		<a href="<%= gb %>_view.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= next_idx %>"><%= next_title %></a>
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
					<a href="<%= gb %>_write.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit"><img name="Image20" border="0"   onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','img/btn_07_ov.gif',1)" src="img/btn_07.gif" width="61" height="21"></a>
					<a onclick="deleteit(<%= idx %>)" style="cursor:pointer"><img name="Image211"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image211','','img/btn_08_ov.gif',1)" border="0" src="img/btn_08.gif" width="61" height="21" hspace="5"></a>
					</td>
					<td>&nbsp;</td>
					<td width="80"><a href="<%= gb %>_list.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>"><img src="img/n_btn_05.gif" style="cursor:hand"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','img/n_btn_05_ov.gif',1)" name="Image5" width="80" height="21" border="0"></a></td>
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
