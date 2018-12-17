<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->


<%
	xml_url=dart_xml & "&page_no=" & page & "&start_dt=" & dart_start

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

				<% call search_string_user("3.asp","") %>

            </div>
			-->
            <div class="paging">

				<% call page_num_user("3.asp",s_cmd,total_page) %>

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<% set xmlDom=nothing %>
