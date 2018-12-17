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

				g_area=replace(g_area,chr(34),"&quot;")
				g_title=replace(g_title,chr(34),"&quot;")
				g_name=replace(g_name,chr(34),"&quot;")
				g_address1=replace(g_address1,chr(34),"&quot;")
				g_address2=replace(g_address2,chr(34),"&quot;")

				if instr(g_phone,"-") then
					g_phone1=split(g_phone,"-")(0)
					g_phone2=split(g_phone,"-")(1)
					g_phone3=split(g_phone,"-")(2)

					if g_phone1="000" then
						g_phone1=""
					end if
				end if
			end if
		set rs=nothing
	end if
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
<!--ir자료_write 테이블 시작 ################################################-->


	<script language="javascript">
		function sendit(on) {
			if (on.g_div.value=="") {
				alert("지역분류를 선택하세요.");
				on.g_div.focus();
				return false;
			}
			if (on.g_area.value=="") {
				alert("지역을 입력하세요.");
				on.g_area.focus();
				return false;
			}
			if (on.g_title.value=="") {
				alert("대리점명을 입력하세요.");
				on.g_title.focus();
				return false;
			}

			on.target="hidden_process";

			<% if cd="edit" then %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx=<%= idx %>&cd=edit";
			<% else %>
				on.action="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %>";
			<% end if %>

			on.submit();

			return false;
		}

		function deleteit(on) {
			if (confirm("삭제 후 복구할 수 없습니다.\n삭제하겠습니까?")) {
				document.getElementById("hidden_process").src="<%= gb %>_write_ok.asp<%= p_cmd %><%= g_cmd %><%= d_cmd %><%= s_cmd %>&idx="+on+"&cd=delete";
			}
		}
	</script>


	<form name="frmNew" method="post" onsubmit="return sendit(this)">
	<input type="hidden" name="x_idx">

	<table width="595" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td><img src="img/n_bar_01.gif" width="595" height="32"></td>
	</tr>
	<tr> 
		<td> 
			<table width="595" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>지역분류</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<select id="g_div" name="g_div" class="select_01">
						<option value="">:::지역분류선택:::</option>
						<option value="2" <%If g_div="2" Then : response.write "selected" End If%>>→ 서울특별시</option>
						<option value="51" <%If g_div="51" Then : response.write "selected" End If%>>→ 부산광역시</option>
						<option value="53" <%If g_div="53" Then : response.write "selected" End If%>>→ 대구광역시</option>
						<option value="32" <%If g_div="32" Then : response.write "selected" End If%>>→ 인천광역시</option>
						<option value="62" <%If g_div="62" Then : response.write "selected" End If%>>→ 광주광역시</option>
						<option value="42" <%If g_div="42" Then : response.write "selected" End If%>>→ 대전광역시</option>
						<option value="52" <%If g_div="52" Then : response.write "selected" End If%>>→ 울산광역시</option>
						<option value="44" <%If g_div="44" Then : response.write "selected" End If%>>→ 세종특별자치시</option>
						<option value="31" <%If g_div="31" Then : response.write "selected" End If%>>→ 경기도</option>
						<option value="33" <%If g_div="33" Then : response.write "selected" End If%>>→ 강원도</option>
						<option value="43" <%If g_div="43" Then : response.write "selected" End If%>>→ 충청북도</option>
						<option value="41" <%If g_div="41" Then : response.write "selected" End If%>>→ 충청남도</option>
						<option value="54" <%If g_div="54" Then : response.write "selected" End If%>>→ 경상북도</option>
						<option value="55" <%If g_div="55" Then : response.write "selected" End If%>>→ 경상남도</option>
						<option value="63" <%If g_div="63" Then : response.write "selected" End If%>>→ 전라북도</option>
						<option value="61" <%If g_div="61" Then : response.write "selected" End If%>>→ 전라남도</option>
						<option value="64" <%If g_div="64" Then : response.write "selected" End If%>>→ 제주특별자치도</option>
					</select>
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>지역</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="g_area" name="g_area" value="<%= g_area %>" size="10" maxlength="5" class="inputbox">
					예) 춘천, 수원, 김해, 순천, 부여
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>대리점명</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="g_title" name="g_title" value="<%= g_title %>" size="20" maxlength="10" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>대표자</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="g_name" name="g_name" value="<%= g_name %>" size="20" maxlength="5" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="50"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>주소</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="g_address1" name="g_address1" value="<%= g_address1 %>" size="50" maxlength="50" class="inputbox">
					<input type="text" id="g_address2" name="g_address2" value="<%= g_address2 %>" size="50" maxlength="50" class="inputbox">
				</td>
			</tr>
			<tr> 
				<td bgcolor=#dcdcdc colspan=2 height=1></td>
			</tr>
			<tr> 
				<td width="91" height="27"> 
					<div align="center"><img src="./img/icon_plus.gif"> <b>전화번호</b></div>
				</td>
				<td width="504" height="27" class="space"> 
					<input type="text" id="g_phone1" name="g_phone1" value="<%= g_phone1 %>" size="5" maxlength="3" class="inputbox">
					-
					<input type="text" id="g_phone2" name="g_phone2" value="<%= g_phone2 %>" size="5" maxlength="4" class="inputbox">
					-
					<input type="text" id="g_phone3" name="g_phone3" value="<%= g_phone3 %>" size="5" maxlength="4" class="inputbox">
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
				<td>
					<a onclick="deleteit(<%= idx %>)" style="cursor:pointer"><img name="Image211"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image211','','img/btn_08_ov.gif',1)" border="0" src="img/btn_08.gif" width="61" height="21" hspace="5"></a>
				</td>
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



<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
