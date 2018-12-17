<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->


<%
	s_sday=request("s_sday")
	s_eday=request("s_eday")


	if isdate(s_sday) then
		dart_start=year(s_sday) & display_num(month(s_sday),2) & display_num(day(s_sday),2)
	else
		dart_start=dart_start
		s_sday=left(dart_start,4) & "-" & mid(dart_start,5,2) & "-" & right(dart_start,2)
	end if

	if isdate(s_eday) then
		dart_end=year(s_eday) & display_num(month(s_eday),2) & display_num(day(s_eday),2)
	else
		dart_end=replace(date(),"-","")
		s_eday=date()
	end if


	p_cmd="&s_sday=" & s_sday & "&s_eday=" & s_eday


	xml_url=dart_xml & "&page_no=" & page & "&start_dt=" & dart_start & "&end_dt=" & dart_end

	set xmlDom=server.createobject("Microsoft.XMLDOM")
	xmlDom.async=false
	xmlDom.setproperty "ServerHTTPRequest", true
	xmlDom.load xml_url


	if xmlDom.parseError.ErrorCode=0 then

		set root_node=xmlDom.getElementsByTagName("result")
			set item_node=root_node(0)
				err_code		= root_node(0).getElementsByTagName("err_code")(0).text
				err_msg			= root_node(0).getElementsByTagName("err_msg")(0).text
'				page_no		= root_node(0).getElementsByTagName("page_no")(0).text
'				page_set		= root_node(0).getElementsByTagName("page_set")(0).text
				total_count		= root_node(0).getElementsByTagName("total_count")(0).text
				total_page		= root_node(0).getElementsByTagName("total_page")(0).text
			set item_node=nothing
		set root_node=nothing

	end if


	total_count=cint(total_count)
	total_page=int((total_count-1)/view_count)+1
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 투자정보-채용정보-채용공고</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/sub.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<!--[if lt IE 9]>
      <script type="text/javascript" src="../js/respond.js"></script>
      <script type="text/javascript" src="../js/selectivizr.js"></script>
<![endif]-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/sub.js"></script>
<script type="text/javascript">
	
	var m0 = 2;
	var m1 = 2;
	//var m2 = 1;
	//var s = 10;

</script>
</head>
<body class="stock">


<script language="javascript">
	var calendar_switch=false;

	function display_calendar(on) {
		if (calendar_switch) {
			document.getElementById("calendar").style.display="none";
			document.getElementById("calendar").src="";
			calendar_switch=false;
		} else {
			if (on==1) {
				document.getElementById("calendar").style.right="324px";
			} else {
				document.getElementById("calendar").style.right="123px";
			}

			document.getElementById("calendar").style.display="block";

			var current_date=document.getElementById("ex_input"+on).value;

			if (current_date=="") {
				document.getElementById("calendar").src="../../inc/nice_calendar.asp?target=ex_input"+on;
			} else {
				document.getElementById("calendar").src="../../inc/nice_calendar.asp?current_date="+current_date+"&target=ex_input"+on;
			}

			calendar_switch=true;
		}
	}

	function searchdate(on) {
		var sday=on.s_sday.value;
		var eday=on.s_eday.value;

		if (sday==""&&eday=="") {
			location="3_test.asp?page=1";
		} else {
			if (sday=="") {
				sday="<%= s_sday %>";
			}
			if (eday=="") {
				eday="<%= s_eday %>";
			}

			if (sday>eday) {
				alert("검색 기간이 올바르지 않습니다.");
			} else if (eday>"<%= date() %>") {
				alert("오늘 이후 기간은 검색할 수 없습니다.");
			} else {
				sday_string="&s_sday="+sday;
				eday_string="&s_eday="+eday;

				location="3_test.asp?page=1"+sday_string+eday_string;
			}
		}

		return false;
	}

	function chnage_period(on) {
		if (on.s_period.value=="") {
			on.s_sday.value="";
			on.s_eday.value="";
			on.s_period.focus();
		} else {
			switch(on.s_period.value) {
				case "1"	: div="D"; count=7; break;
				case "2"	: div="M"; count=1; break;
				case "3"	: div="M"; count=3; break;
				case "4"	: div="M"; count=6; break;
				case "5"	: div="D"; count=365; break;
				case "6"	: div="D"; count=1095; break;
			}

			var eday="<%= date() %>";

			eday1=eday.substr(0,4);
			eday2=eday.substr(5,2);
			eday3=eday.substr(8,2);

			eday1=parseInt(eday1);
			eday2=parseInt(eday2)-1;
			eday3=parseInt(eday3);

			var period_day=new Date(eday1,eday2,eday3);

			if (div=="D") {
				period_day.setDate(period_day.getDate()-count);
			} else {
				period_day.setMonth(period_day.getMonth()-count);
			}

			sday1=period_day.getFullYear();
			sday2=period_day.getMonth()+1;
			sday3=period_day.getDate();

			if (sday2<10) {
				sday2="0"+sday2;
			}

			if (sday3<10) {
				sday3="0"+sday3;
			}

			var sday=sday1+"-"+sday2+"-"+sday3;

//			alert(sday+" / "+eday);

			on.s_sday.focus();
			on.s_eday.focus();

			on.s_sday.value=sday;
			on.s_eday.value=eday;

			on.s_period.focus();
		}
	}
</script>


<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">DISCLOSURE</p>
        <p class="kor">공시자료</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>공시자료</h2>
            <div class="boardTop">
                <p class="result">
					현재 : <%= page %>/<%= total_page %>페이지<span>총 <%= total_count %>건</span>

					<% if xmlDom.parseError.ErrorCode<>0 then %>
					<span style="color:red; margin-bottom:10px">※ 최신 정보로 갱신 중입니다. 잠시 후 다시 이용해 주세요. &nbsp; <a href="http://dart.fss.or.kr/" target="_blank" style="color:red">▶ DART</a></span>
					<% end if %>

				</p>


				<form method="post" onsubmit="return searchdate(this)">

				<div style="float:right; position: relative">
					<div id="dateSelect">
                        <label for="area">기간</label>
                        <select id="area" name="s_period" title="지역선택" onchange="chnage_period(this.form)">
                            <option value="" selected="selected">기간</option>
                            <option value="1">1주</option>
                            <option value="2">1개월</option>
                            <option value="3">3개월</option>
                            <option value="4">6개월</option>
                            <option value="5">1년</option>
                            <option value="6">3년</option>
                        </select>
                    </div>

                    <div class="textbox" style="width:182px">
                      <label for="ex_input1" style="position: absolute;top: 1px;left: 1px;color: #999;cursor: text; font-size:16px; line-height:38px; text-indent:12px"><%= s_sday %></label>
                      <input type="text" id="ex_input1" name="s_sday" style="float:left; width:131px; border-color:#454545; border-right:0" readonly>
	                    <div class="dateInput" style="float:right; width:46px">
						  <button onclick="display_calendar(1); return false"></button>
	                    </div>
                    </div>
                     ~ 
                    <div class="textbox" style="width:182px">
                      <label for="ex_input2" style="position: absolute;top: 1px;left: 1px;color: #999;cursor: text; font-size:16px; line-height:38px; text-indent:12px"><%= s_eday %></label>
                      <input type="text" id="ex_input2" name="s_eday" style="float:left; width:131px; border-color:#454545; border-right:0" readonly>
						<div class="dateInput" style="float:right; width:46px">
						  <button onclick="display_calendar(2); return false"></button>
	                    </div>
                    </div>
                    <input value="조회"  type="submit" class="ml10 btnInquiry" style="cursor:pointer">
				</div>

				</form>

 
			 </div>
            <ul class="list">


				<script language="javascript">
					function open_dart(on) {
						open(on,"dart","width=1024, height=768");
					}
				</script>

				<%
					if err_code="000" then
						set root_node=xmlDom.getElementsByTagName("list")
							for each item_node in root_node
								rpt_nm	= item_node.getElementsByTagName("rpt_nm")(0).text
								rcp_no	= item_node.getElementsByTagName("rcp_no")(0).text
								rcp_dt	= item_node.getElementsByTagName("rcp_dt")(0).text
								rmk		= item_node.getElementsByTagName("rmk")(0).text

								if len(rcp_dt)=8 then
									rcp_dt=left(rcp_dt,4) & "." & mid(rcp_dt,5,2) & "." & right(rcp_dt,2)
								end if
				%>
				<li>
                    <ul class="data">
                        <li class="date">공시일자 : <%= rcp_dt %></li>

						<% if rmk<>"" then %>
                        <li class="ko" style="width:100px; background:none"><span style="font-size:12px; border:1px solid black; padding:1px"><%= rmk %></span></li>
						<% end if %>

                    </ul>
                    <div class="link stockLink">
                    	<a onclick="open_dart('http://dart.fss.or.kr/dsaf001/main.do?rcpNo=<%= rcp_no %>')" style="cursor:pointer"><%= rpt_nm %></a>
                    </div>
                </li>
				<%
							next
						set root_node=nothing
					end if
				%>


			</ul>
			<!--
            <div class="search">

				<% call search_string_user("3_test.asp",p_cmd) %>

            </div>
			-->

			<iframe id="calendar" style="position:absolute; right:321px; top:151px; width:180px; height:180px; border:1px solid gray; background:white; display:none"></iframe>
			<!--
			<iframe src="" style="position:absolute; right:123px; top:151px; width:180px; height:180px; border:1px solid gray; background:white"></iframe>
			-->

            <div class="paging">

				<% call page_num_user("3_test.asp",s_cmd&p_cmd,total_page) %>

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<% set xmlDom=nothing %>
