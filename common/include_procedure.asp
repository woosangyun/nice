<%
sub redirect_message(r_data)
	dim return_msg
	return_msg=trim_data(r_data)

	if return_msg<>"" then
		return_msg=error_message(return_msg)
		response.write "<script>alert('" & return_msg & "')</script>"
		response.end
'		response.redirect page_alert & s_page & "&code=0&msg=" & return_msg
	end if
end sub
%>


<%
'//##### 폼값 확인 ###################################
sub request_verify(r_data,r_pattern,r_str)
	if regular_expression(r_data,r_pattern,r_str)=false then
		call redirect_message(r_pattern)
	end if
end sub
%>


<%
'//##### 폼값 확인 - 텍스트 길이 제한 ###################################
sub content_verify(r_data,r_num)
	if string_bytes(r_data) > r_num then
		call redirect_message("content")
	end if
end sub
%>


<%
'//##### 페이지(ADMIN) ###################################
sub page_num(r_data,r_query,r_total)
	dim return_data, return_query, return_total_page
	dim return_total_chapter, return_chapter, chapter_count

	dim layout_table_top, layout_table_middle, layout_table_bottom

	chapter_count=10	'-- 챕터당 페이지 개수

	return_data=r_data
	return_query=r_query
	return_total_page=r_total

	return_total_chapter=int(return_total_page / chapter_count)
	return_chapter=int((page-1) / chapter_count) +1
	result_page=return_total_page mod chapter_count

	if result_page>0 then
		return_total_chapter=return_total_chapter+1
	end if

	layout_table_top="<table id=""paging""><tr>"
	layout_table_middle=""
	layout_table_bottom="</table></tr>"

	image_arrow_start1=" <span>◀◀</span>"
	image_arrow_end1=" <span>▶▶</span>"
	image_arrow_prev1=" <span>◀</span>"
	image_arrow_next1=" <span>▶</span>"

	image_arrow_start2=" <span style='color:silver'>◀◀</span>"
	image_arrow_end2=" <span style='color:silver'>▶▶</span>"
	image_arrow_prev2=" <span style='color:silver'>◀</span>"
	image_arrow_next2=" <span style='color:silver'>▶</span>"

	response.write layout_table_top

	'---- ◀◀ ----
	if page > 1 then
		response.write "<td><a onclick=""move_location('" & r_data & "?page=1" & return_query & "')"" onfocus=""this.blur()"">" & image_arrow_start1 & "</a></td>" & vbcrlf
	else
		response.write "<td>" & image_arrow_start2 & "</td>" & vbcrlf
	end if

	'---- ◀ ----
	if return_chapter > 1 then
		response.write "<td><a onclick=""move_location('" & r_data & "?page=" & ((return_chapter-1)*chapter_count) & return_query & "')"" onfocus=""this.blur()"">" & image_arrow_prev1 & "</a></td>" & vbcrlf
	else
		response.write "<td>" & image_arrow_prev2 & "</td>" & vbcrlf
	end if

	response.write layout_table_middle

	'---- 1 2 3 4 5 6 7 8 9 ----
	if return_total_page=0 then
		response.write "<td>[" & return_total_page & "]</td>" & vbcrlf
	else
		page_start_num=((return_chapter-1)*chapter_count)+1
		page_end_num=page_start_num+chapter_count-1

		if page_end_num>return_total_page then
			page_end_num=return_total_page
		end if

		for i=page_start_num to page_end_num
			if i>page_start_num then
				'response.write " | "
			end if

			if i=int(page) then
				response.write "<td class=""board_paging"" onclick=""move_location('" & r_data & "?page=" & i & return_query & "')"">[" & i & "]</td>" & vbcrlf
			else
				response.write "<td onclick=""move_location('" & r_data & "?page=" & i & return_query & "')"">[" & i & "]</td>" & vbcrlf
			end if
		next
	end if

	response.write layout_table_middle

	'---- ▶▶ ----
	if return_chapter< return_total_chapter then
		response.write "<td><a onclick=""move_location('" & r_data & "?page=" & (return_chapter*chapter_count)+1 & return_query & "')"" onfocus=""this.blur()"">" & image_arrow_next1 & "</a></td>" & vbcrlf
	else
		response.write "<td>" & image_arrow_next2 & "</td>" & vbcrlf
	end if

	'---- ▶ ----
	if cint(page) < return_total_page then
		response.write "<td><a onclick=""move_location('" & r_data & "?page=" & return_total_page & return_query & "')"" onfocus=""this.blur()"">" & image_arrow_end1 & "</a></td>" & vbcrlf
	else
		response.write "<td>" & image_arrow_end2 & "</td>" & vbcrlf
	end if

	response.write layout_table_bottom
end sub
%>


<%
'//##### 페이지(USER) ###################################
sub page_num_user(r_data,r_query,r_total)
	dim return_data, return_query, return_total_page
	dim return_total_chapter, return_chapter, chapter_count

	dim layout_table_top, layout_table_middle, layout_table_bottom

	chapter_count=10	'-- 챕터당 페이지 개수

	return_data=r_data
	return_query=r_query
	return_total_page=r_total

	return_total_chapter=int(return_total_page / chapter_count)
	return_chapter=int((page-1) / chapter_count) +1
	result_page=return_total_page mod chapter_count

	if result_page>0 then
		return_total_chapter=return_total_chapter+1
	end if

	layout_table_top=""
	layout_table_middle=""
	layout_table_bottom=""

	response.write layout_table_top

	'---- ◀◀ ----
	if page > 1 then
		response.write "<a href=""" & r_data & "?page=1" & return_query & """ class=""ll""></a>"
	else
		response.write "<a class=""ll""></a>"
	end if

	'---- ◀ ----
	if return_chapter > 1 then
		response.write "<a href=""" & r_data & "?page=" & ((return_chapter-1)*chapter_count) & return_query & """ class=""l""></a>"
	else
		response.write "<a class=""l""></a>"
	end if

	response.write layout_table_middle

	'---- 1 2 3 4 5 6 7 8 9 ----
	if return_total_page=0 then
		response.write "<a>" & return_total_page & "</a>"
	else
		page_start_num=((return_chapter-1)*chapter_count)+1
		page_end_num=page_start_num+chapter_count-1

		if page_end_num>return_total_page then
			page_end_num=return_total_page
		end if

		for i=page_start_num to page_end_num
			if i>page_start_num then
				'response.write " | "
			end if

			if i=int(page) then
				response.write "<a href=""" & r_data & "?page=" & i & return_query & """ class=""on"">" & i & "</a>"
			else
				response.write "<a href=""" & r_data & "?page=" & i & return_query & """>" & i & "</a>"
			end if
		next
	end if

	response.write layout_table_middle

	'---- ▶ ----
	if return_chapter< return_total_chapter then
		response.write "<a style=""width:0""></a><a href=""" & r_data & "?page=" & (return_chapter*chapter_count)+1 & return_query & """ class=""r""></a>"
	else
		response.write "<a style=""width:0""></a><a class=""r""></a>"
	end if

	'---- ▶▶ ----
	if cint(page) < return_total_page then
		response.write "<a href=""" & r_data & "?page=" & return_total_page & return_query & """ class=""rr""></a>"
	else
		response.write "<a class=""rr""></a>"
	end if

	response.write layout_table_bottom
end sub
%>


<%
'//##### 검색바(ADMIN) ###################################
sub search_string(r_data,r_query)
%>
					<script language="javascript">
						function searchit(on) {
							if (on.s_str.value=="") {
								location="<%= r_data %>?page=1<%= r_query %>";
							} else {
								if (on.s_str.value=="") {
									alert("검색어를 입력하세요.");
									on.s_str.focus();
									return false;
								} else {
									text_string="&s_str="+encodeURI(on.s_str.value);
								}

								if (on.s_part.value=="") {
									part_string="";
								} else {
									part_string="&s_part="+on.s_part.value;
								}

								location="<%= r_data %>?page=1<%= r_query %>"+part_string+text_string;
							}

							return false;
						}
					</script>


					<form method="post" onsubmit="return searchit(this)">
					<table>
					<tr>
						<td>
							<select id="search_select" name="s_part" class="select_01">
								<!--<option value="">선택</option>-->

								<% if gb="agency" then %>
								<option value="multi"<% if s_part="multi" then %> selected<% end if %>>대리점명+주소</option>
								<option value="title"<% if s_part="title" then %> selected<% end if %>>대리점명</option>
								<option value="address"<% if s_part="address" then %> selected<% end if %>>주소</option>
								<% else %>
								<option value="multi"<% if s_part="multi" then %> selected<% end if %>>제목+내용</option>
								<option value="title"<% if s_part="title" then %> selected<% end if %>>제목</option>
								<option value="content"<% if s_part="content" then %> selected<% end if %>>내용</option>
								<% end if %>

							</select>
						</td>
						<td>
							<input type="text" id="search_input" name="s_str" maxlength="10" value="<%= s_str %>" class="inputbox" style="width:100px; height:19px">
						</td>
						<td>
							<input type="image" src="img/n_btn_01.gif" align="absmiddle">
						</td>
					</tr>
					</table>
					</form>
<%
end sub
%>


<%
'//##### 검색바(USER) ###################################
sub search_string_user(r_data,r_query)
%>
				<script language="javascript">
					function searchit(on) {
						if (on.s_str.value=="") {
							location="<%= r_data %>?page=1<%= r_query %>";
						} else {
							if (on.s_str.value=="") {
								alert("검색어를 입력하세요.");
								on.s_str.focus();
								return false;
							} else {
								text_string="&s_str="+encodeURI(on.s_str.value);
							}

							if (on.s_part.value=="") {
								part_string="";
							} else {
								part_string="&s_part="+on.s_part.value;
							}

							location="<%= r_data %>?page=1<%= r_query %>"+part_string+text_string;
						}

						return false;
					}
				</script>

				<%
					if gb="agency" then
						select case s_part
							case "title"			: search_label="대리점명"
							case "address"	: search_label="주소"
							case else			: search_label="대리점명+주소"
						end select
					else
						select case s_part
							case "title"			: search_label="제목"
							case "content"	: search_label="내용"
							case else			: search_label="제목+내용"
						end select
					end if

					if s_str="" then
						input_label="검색어를 입력해 주세요"
					else
						input_label=s_str
					end if
				%>


				<form method="post" onsubmit="return searchit(this)">

				<div id="select">
					<label for="search"><%= search_label %></label>
					<select id="search" name="s_part" title="검색옵션">

						<% if gb="agency" then %>
						<option value="multi"<% if s_part="multi" then %> selected<% end if %>>대리점명+주소</option>
						<option value="title"<% if s_part="title" then %> selected<% end if %>>대리점명</option>
						<option value="address"<% if s_part="address" then %> selected<% end if %>>주소</option>
						<% else %>
						<option value="multi"<% if s_part="multi" then %> selected<% end if %>>제목+내용</option>
						<option value="title"<% if s_part="title" then %> selected<% end if %>>제목</option>
						<option value="content"<% if s_part="content" then %> selected<% end if %>>내용</option>
						<% end if %>

					</select>
				</div>

				<div class="textbox">
					<label for="ex_input"><%= input_label %></label>
					<input type="text" id="ex_input" name="s_str" maxlength="10">
				</div>

				<input alt="검색" src="../images/common/btn_search.png" type="image" class="btnSearch">

				</form>
<%
end sub
%>


<%
'//##### 썸네일 이미지 ###################################
sub save_thumb(r_path,org_path,r_width,r_height,org_width,org_height)
	dim return_width, return_height

	set dximg=server.createobject("DEXT.ImageProc")

		if not (r_width=0 or r_height=0 or org_width=0 or org_height=0) then
			if org_width/org_height > r_width/r_height then	'너비가 클때 - 높이에 맞춤
				if r_width > org_width then
					return_width=org_width
					return_height=int(org_width / r_width * r_height)
				else
					return_width=r_width
					return_height=r_height
				end if
			else																'높이가 클때 - 너비에 맞춤
				if r_height > org_height then
					return_width=int(org_height / r_height * r_width)
					return_height=org_height
				else
					return_width=r_width
					return_height=r_height
				end if
			end if
		end if

'		response.write "<br>" & r_width
'		response.write "<br>" & r_height
'		response.write "<br>" & org_width
'		response.write "<br>" & org_height
'		response.write "<br>" & return_width
'		response.write "<br>" & return_height
'		response.end

		dximg.setsourcefile(r_path)
		dximg.saveasthumbnail org_path,return_width,return_height,true
	set dximg=nothing
end sub
%>
