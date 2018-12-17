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
		sql=sql & "		c_title, c_regdate, c_enddate, c_file_idx, c_file_name, c_content"
		sql=sql & " from nc_recruit"
		sql=sql & " where c_display>0"
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
				c_title=rs("c_title")
				c_regdate=rs("c_regdate")
				c_enddate=rs("c_enddate")
				c_file_idx=rs("c_file_idx")
				c_file_name=rs("c_file_name")
				c_content=rs("c_content")

				c_title=replace(c_title,chr(34),"&quot;")
			end if
		set rs=nothing
	else
		c_regdate=date()
		c_enddate=date()+7
	end if
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
<!--ir자료_write 테이블 시작 ################################################-->


	<script language="javascript">
		function fileAttach(){
			var open_url = "./bin/file_upload.asp<%= p_cmd %><%= g_cmd %>";
			window.open(open_url,"","width=437,height=279");
			return;
		}

		function sendit(on) {
			if (on.c_title.value=="") {
				alert("제목을 입력하세요.");
				on.c_title.focus();
				return false;
			}
			if (on.c_regdate.value=="") {
				alert("등록일을 입력하세요.");
				on.c_regdate.focus();
				return false;
			}
			if (on.c_enddate.value=="") {
				alert("종료일을 입력하세요.");
				on.c_enddate.focus();
				return false;
			}

			var reg=new RegExp("(^[0-9]{4}-[0-9]{2}-[0-9]{2}$)");

			if (reg.test(on.c_regdate.value)==false) {
				alert("틀림");
				on.c_regdate.focus();
				return false;
			}
			if (reg.test(on.c_enddate.value)==false) {
				alert("틀림");
				on.c_enddate.focus();
				return false;
			}
			if (content_field_editor.getHtml()=="") {
				alert("내용을 입력하세요.");
				content_field_editor.focus();
				return false;
			}
			if (content_field_editor.getHtml().length>20000) {
				alert("내용이 너무 깁니다.\n20,000 글자 이내로 작성하세요.");
				content_field_editor.focus();
				return false;
			}

			on.c_content.value=content_field_editor.getHtml();

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
					<div align="center"><img src="./img/icon_plus.gif"> <b>제 목</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="c_title" name="c_title" value="<%= c_title %>" size="50" maxlength="50" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>등록일</b></div>
				</td>
				<td height="27" class="space"> 
					<input type="text" id="c_regdate" name="c_regdate" value="<%= c_regdate %>" size="20" maxlength="10" class="inputbox"> 예)<%= date() %>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>종료일</b></div>
				</td>
				<td height="27" class="space"> 
					<input type="text" id="c_enddate" name="c_enddate" value="<%= c_enddate %>" size="20" maxlength="10" class="inputbox"> 예)<%= date()+7 %>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>파일첨부</b></div>
				</td>
				<td height="27" class="space"> 
					<input name='x_file' size=30 readonly class='inputbox'>	
					<img onClick="fileAttach()" style="cursor:hand;" src="img/btn_11.gif" width="79" height="18" align="absmiddle" border="0">

					<%
					IF c_file_idx <1 THEN
						RESPONSE.WRITE "&nbsp;"
					ELSE
						Response.Write "<a href='../inc/nice_download.asp?idx=" & c_file_idx & "'>[" & c_file_name & "]</a>"
					END IF
					%>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="333"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>내 용</b></div>
				</td>
				<td class="space"> 
					<textarea id="c_content" name="c_content" style="width:498px; height:200px"><%= c_content %></textarea>
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
				var content_field_editor=new easyEditor("c_content","admin",475,300);
				content_field_editor.init();
			</script>



<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
