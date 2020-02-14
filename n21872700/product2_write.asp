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


	sql="select count(*) from nc_product2 where p_display>0"

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	set rs=cmd.execute
		if not (rs.eof or rs.bof) then
			total_count=cint(rs(0))
		end if
	set rs=nothing
	set cmd=nothing


	if cd="edit" then
		idx=request("idx")

		if idx="" or isnumeric(idx)=false then
			response.write "파라미터 오류"
			response.end
		else
			idx=int(idx)
		end if


		sql="select"
		sql=sql & "		p_div, p_title, p_file_idx, p_file_name, p_content, p_comment, p_link, p_certify, p_order"
		sql=sql & " from nc_product2"
		sql=sql & " where p_display>0"
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
				p_div=rs("p_div")
				p_title=rs("p_title")
				p_file_idx=rs("p_file_idx")
				p_file_name=rs("p_file_name")
				p_content=rs("p_content")
				p_comment=rs("p_comment")
				p_link=rs("p_link")
				p_certify=rs("p_certify")
				p_order=rs("p_order")

				p_title=replace(p_title,chr(34),"&quot;")
			end if
		set rs=nothing

		order_count=total_count

	else
		p_certify=1
		p_order=1

		order_count=total_count+1
	end if
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
<!--ir자료_write 테이블 시작 ################################################-->


	<script language="javascript">
		function fileAttach(){
			var open_url = "./bin/file_upload.asp<%= p_cmd %><%= g_cmd %>";
			window.open(open_url,"","width=437,height=279");
			return;
		}

		function sendit(on) {
			if (on.p_div.value=="") {
				alert("제품분류를 선택하세요.");
				on.p_div.focus();
				return false;
			}
			if (on.p_title.value=="") {
				alert("제목을 입력하세요.");
				on.p_title.focus();
				return false;
			}
			if (content_field_editor.getHtml()=="") {
				alert("제품특징을 입력하세요.");
				content_field_editor.focus();
				return false;
			}
			if (content_field_editor.getHtml().length>5000) {
				alert("제품특징이 너무 깁니다.\n5,000 글자 이내로 작성하세요.");
				content_field_editor.focus();
				return false;
			}
			if (comment_field_editor.getHtml().length>5000) {
				alert("상세정보가 너무 깁니다.\n5,000 글자 이내로 작성하세요.");
				comment_field_editor.focus();
				return false;
			}

			on.p_content.value=content_field_editor.getHtml();
			on.p_comment.value=comment_field_editor.getHtml();

			on.target="hidden_process";

			<% if cd="edit" then %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit";
			<% else %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %>";
			<% end if %>

			on.submit();

			return false;
		}
	</script>


	<form name="frmNew" method="post" onsubmit="return sendit(this)">
	<input type="hidden" name="x_idx">
	<input type="hidden" name="old_order" value="<%= p_order %>">

	<table width="595" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td><img src="img/n_bar_05.gif" width="595" height="32"></td>
	</tr>
	<tr> 
		<td> 
			<table width="595" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>제품분류</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<select id="p_div" name="p_div" class="select_01">
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
						<option value="<%=c_category%>" <%If p_div2=c_category Then : response.write "selected" End If%>>→ <%=c_category%></option>
						<!--
						<option value="1" <%If p_div="1" Then : response.write "selected" End If%>>→ 신용카드조회기(유선)</option>
						<option value="2" <%If p_div="2" Then : response.write "selected" End If%>>→ 신용카드조회기(무선)</option>
						<option value="3" <%If p_div="3" Then : response.write "selected" End If%>>→ POS 장비</option>
						<option value="4" <%If p_div="4" Then : response.write "selected" End If%>>→ 멀티패드</option>
						<option value="5" <%If p_div="5" Then : response.write "selected" End If%>>→ 서명패드</option>
						<option value="6" <%If p_div="6" Then : response.write "selected" End If%>>→ 기타장비</option>
						-->
						<%
										num=num-1
										rs.movenext
									loop
								end if
						%>
					</select>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>제품모델</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="p_title" name="p_title" value="<%= p_title %>" size="50" maxlength="50" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="180"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>제품특징</b></div>
				</td>
				<td class="space"> 
					<textarea id="p_content" name="p_content" style="width:498px; height:200px"><%= p_content %></textarea>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="180"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>상세정보</b></div>
				</td>
				<td class="space"> 
					<textarea id="p_comment" name="p_comment" style="width:498px; height:200px"><%= p_comment %></textarea>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>사진첨부</b></div>
				</td>
				<td height="27" class="space"> 
					<input name='x_file' size=30 readonly class='inputbox'>	
					<img onClick="fileAttach()" style="cursor:hand;" src="img/btn_11.gif" width="79" height="18" align="absmiddle" border="0">

					<%
					IF p_file_idx <1 THEN
						RESPONSE.WRITE "<span class='silver'>(JPG,GIF,PNG,BMP)</span>"
					ELSE
						Response.Write "<a href='../inc/nice_download.asp?idx=" & p_file_idx & "'>[" & p_file_name & "]</a>"
					END IF
					%>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>홈페이지</b></div>
				</td>
				<td height="27" class="space"> 
					<input type="text" id="p_link" name="p_link" value="<%= p_link %>" size="50" maxlength="50" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>보안인증</b></div>
				</td>
				<td height="27" class="space"> 
					<input type="radio" id="p_certify" name="p_certify" value="1"<% if p_certify=1 then %> checked<% end if %>> 인증 됨
					<input type="radio" id="p_certify" name="p_certify" value="0"<% if p_certify=0 then %> checked<% end if %>> 인증 안 됨
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>정렬순서</b></div>
				</td>
				<td height="27" class="space"> 
					<select id="p_order" name="p_order" class="select_01">

						<% for i=1 to order_count %>
						<option value="<%= i %>" <%If p_order=i Then : response.write "selected" End If%>><%= i %></option>
						<% next %>

					</select>
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
				var content_field_editor=new easyEditor("p_content","admin",475,150);
				content_field_editor.init();

				var comment_field_editor=new easyEditor("p_comment","admin",475,150);
				comment_field_editor.init();
			</script>



<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
