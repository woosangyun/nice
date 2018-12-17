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
		sql=sql & "		q_title, q_content"
		sql=sql & " from nc_faq"
		sql=sql & " where q_display>0"
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
				q_title=rs("q_title")
				q_content=rs("q_content")

				q_title=replace(q_title,chr(34),"&quot;")
			end if
		set rs=nothing
	end if
%>


<% call html_top() %>

									
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/m_title_faq.gif" width="595" height="54"></td>
                                      </tr>
                                      <tr>
                                        <td height="16">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td height="294" valign="top">
<!--ir자료_write 테이블 시작 ################################################-->


	<script language="javascript">
		function sendit(on) {
			if (on.q_title.value=="") {
				alert("제목을 입력하세요.");
				on.q_title.focus();
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

			on.q_content.value=content_field_editor.getHtml();

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
					<input type="text" id="q_title" name="q_title" value="<%= q_title %>" size="50" maxlength="50" class="inputbox">
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
					<textarea id="q_content" name="q_content" style="width:498px; height:200px"><%= q_content %></textarea>
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
				var content_field_editor=new easyEditor("q_content","admin",475,300);
				content_field_editor.init();
			</script>



<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
