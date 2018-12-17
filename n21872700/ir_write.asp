<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->
<!-- #include file="include/admin_layout.asp" -->


<%
	cd=request("cd")

	if cd="edit" then
		idx=request("idx")

		if idx="" or isnumeric(idx)=false then
			response.write "파라미터 오류"
			response.end
		else
			idx=int(idx)
		end if


		sql="select"
		sql=sql & "		i_title, i_regdate, i_file_idx, i_file_name, i_content"
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

				i_title=replace(i_title,chr(34),"&quot;")
			end if
		set rs=nothing
	else
		i_regdate=date()
	end if
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
<!--ir자료_write 테이블 시작 ################################################-->


	<script language="javascript">
		function fileAttach(){
			var open_url = "./bin/file_upload.asp<%= p_cmd %><%= g_cmd %>";
			window.open(open_url,"","width=437,height=279");
			return;
		}

		function sendit(on) {
			if (on.i_title.value=="") {
				alert("제목을 입력하세요.");
				on.i_title.focus();
				return false;
			}
			if (on.i_regdate.value=="") {
				alert("등록일을 입력하세요.");
				on.i_regdate.focus();
				return false;
			}

			var reg=new RegExp("(^[0-9]{4}-[0-9]{2}-[0-9]{2}$)");

			if (reg.test(on.i_regdate.value)==false) {
				alert("틀림");
				on.i_regdate.focus();
				return false;
			}
			if (content_field_editor.getHtml()=="") {
				alert("내용을 입력하세요.");
				content_field_editor.focus();
				return false;
			}
			if (content_field_editor.getHtml().length>10000) {
				alert("내용이 너무 깁니다.\n10,000 글자 이내로 작성하세요.");
				content_field_editor.focus();
				return false;
			}

			on.i_content.value=content_field_editor.getHtml();

			on.target="hidden_process";

			<% if cd="edit" then %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit";
			<% else %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %>";
			<% end if %>

			on.submit();

			return false;
		}
	</script>


	<form name="frmNew" method="post" onsubmit="return sendit(this)">
	<input type="hidden" name="x_idx">

	<table width="595" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td><img src="img/n_bar_05.gif" width="595" height="32"></td>
	</tr>
	<tr> 
		<td> 
			<table width="595" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="img/txt_01.gif" width="91" height="14"></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="i_title" name="i_title" value="<%= i_title %>" size="50" maxlength="50" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="img/txt_04.gif" width="91" height="13"></div>
				</td>
				<td height="27" class="space"> 
					<input type="text" id="i_regdate" name="i_regdate" value="<%= i_regdate %>" size="20" maxlength="10" class="inputbox"> 예)<%= date() %>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="img/txt_05.gif" width="91" height="13"></div>
				</td>
				<td height="27" class="space"> 
					<input name='x_file' size=30 readonly class='inputbox'>	
					<img onClick="fileAttach()" style="cursor:hand;" src="img/btn_11.gif" width="79" height="18" align="absmiddle" border="0">

					<%
					IF i_file_idx <1 THEN
						RESPONSE.WRITE "&nbsp;"
					ELSE
						Response.Write "<a href='../inc/nice_download.asp?idx=" & i_file_idx & "'>[" & i_file_name & "]</a>"
					END IF
					%>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td valign="top" height="333"> 
					<div align="center"><img src="img/txt_03.gif" width="91" height="14" vspace="7"></div>
				</td>
				<td class="space"> 
					<textarea id="i_content" name="i_content" style="width:498px; height:200px"><%= i_content %></textarea>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td><img src="img/n_line_01.gif" width="595" height="2"></td>
	</tr>
	<tr> 
		<td height="50"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td>&nbsp; </td>
				<td width="150">
					<input type="image" border="0" src="img/btn_10.gif" width="61" height="21" hspace="5">
					<img style="cursor:hand" border="0" src="img/btn_09.gif" width="61" height="21" onClick="history.back()">
				</td>
			</tr>	
			</table>
		</td>
	</tr>
	</table>
	</form>

<!--ir자료_write 테이블 끝 ##################################################-->
                                        </td>
                                      </tr>
                                    </table>



			<script language="javascript">
				var content_field_editor=new easyEditor("i_content","admin",475,300);
				content_field_editor.init();
			</script>



<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
