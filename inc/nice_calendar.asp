<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->


<%
	order=request("order")
	curdate=request("curdate")
	current_date=request("current_date")

	target=request("target")


	if current_date="" or isdate(current_date)=false then
		current_date=date()
	else
		current_date=cdate(current_date)
	end if

	select case order
		case "move"			: move_date=curdate
		case "prev_month"	: move_date=dateadd("m",-1,curdate)
		case "next_month"	: move_date=dateadd("m",1,curdate)
		case "prev_year"	: move_date=dateadd("yyyy",-1,curdate)
		case "next_year"	 	: move_date=dateadd("yyyy",1,curdate)
		case else				: move_date=dateserial(year(current_date),month(current_date),1)
	end select

	image_arrow_prev="<img src='../korean/images/common/page_arrow_prev.gif'>"
	image_arrow_next="<img src='../korean/images/common/page_arrow_next.gif'>"
	image_arrow_left="<img src='../korean/images/common/page_arrow_left.gif'>"
	image_arrow_right="<img src='../korean/images/common/page_arrow_right.gif'>"
%>


<%
	'--------------------------------------------------
	function calendar_date(byval r_data)
		do while weekday(r_data) > vbsunday
			r_data=dateadd("d",-1,r_data)
		loop

		calendar_date=r_data
	end function
	'--------------------------------------------------
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<style type="text/css">
		a				{font:9pt dotum; cursor:pointer}
		table			{font:9pt dotum}
		.cursor		{cursor:pointer}
	</style>

	<script language="javascript">
		function insert_date(on) {
			parent.document.getElementById("<%= target %>").focus();
			parent.document.getElementById("<%= target %>").value=on;
			parent.display_calendar(0);
		}

		function move_location(on) {
			location.href=on;
		}
	</script>
</head>
<body>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<!-- 이동메뉴 -->
<tr>
	<td>
		<table border="0" height="20" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td width="45" align="left">
				<a onclick="move_location('nice_calendar.asp?curdate=<%= move_date %>&target=<%= target %>&order=prev_year')"><%= image_arrow_prev %></a>
				<a onclick="move_location('nice_calendar.asp?curdate=<%= move_date %>&target=<%= target %>&order=prev_month')"><%= image_arrow_left %></a>
			</td>
			<td align="center">
				<a onclick="move_location('nice_calendar.asp?target=<%= target %>')"><b><%= year(move_date) %>년 <%= month(move_date) %>월</b></a>
			</td>
			<td width="45" align="right">
				<a onclick="move_location('nice_calendar.asp?curdate=<%= move_date %>&target=<%= target %>&order=next_month')"><%= image_arrow_right %></a>
				<a onclick="move_location('nice_calendar.asp?curdate=<%= move_date %>&target=<%= target %>&order=next_year')"><%= image_arrow_next %></a>
			</td>
		</tr>
		</table>
	</td>
</tr>
<!-- 이동메뉴 -->

<tr>
	<td bgcolor="#B6D0F1">
		<table width="100%" cellpadding="0" cellspacing="1" border="0">

		<!-- 요일 -->
		<tr height="19" align="center" bgcolor="#ECECEC">
			<%
				count_week=0
				for each i in choice_div("choice_weekday")
			        response.write "<td width='14%'><b>"

					select case count_week
						case 0		: response.write "<font color='red'>" & i & "</font>"
						case 6		: response.write "<font color='blue'>" & i & "</font>"
						case else	: response.write i
					end select

					count_week=count_week+1
					response.write "</b></td>"
				next
			%>
		</tr>
		<!-- 요일 -->

		<!-- 날짜 -->
		<%
			choice_date=calendar_date(move_date)

			for count_week=0 to 5
				response.write "<tr height='18' align='center' bgcolor='white'>"
		    
				for count_day=0 to 6
					if month(choice_date)=month(move_date) then
						response.write "<td id=""date_box"" onclick=""insert_date('" & choice_date & "')"" class=""cursor"">"

						if choice_date=current_date then
					        response.write "<font color='red'><b>" & day(choice_date) & "</b></font>"
						elseif choice_date=date() then
					        response.write "<font color='orange'><b>" & day(choice_date) & "</b></font>"
						elseif count_day=0 then
							response.write "<font color='red'>" & day(choice_date) & "</font>"
						elseif count_day=6 then
							response.write "<font color='blue'>" & day(choice_date) & "</font>"
						else
							response.write day(choice_date)
						end if

						response.write "</td>"
					else
						response.write "<td bgcolor='white'></td>"
                    end if
		        
					choice_date=dateadd("d",1,choice_date)
                next
		    
				response.write "</tr>"
			next
		%>
		<!-- 날짜 -->

		</table>
	</td>
</tr>
</table>


</body>
</html>
