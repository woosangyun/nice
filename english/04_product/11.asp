<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->

<% gb="product2" %>

<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<%
	if div="" or isnumeric(div)=false then
		div=1
	end if


	idx=request("idx")

	if idx="" or isnumeric(idx)=false then
		idx=0

		sql="select idx from nc_product2 where p_display>0 and p_div= ? order by p_order asc limit 1"
    
		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
		set rs=cmd.execute
			if not (rs.eof or rs.bof) then
				idx=rs("idx")
			end if
		set rs=nothing
	else
		idx=int(idx)
	end if


	order=-1

	if idx>0 then
		sql="select count(*) from nc_product2"
		sql=sql & " where p_display>0"
		sql=sql & " and p_div= ? "
		sql=sql & " and p_order < (select p_order from nc_product2 where idx= ? )"
    
		set cmd=server.createobject("adodb.command")
		cmd.activeconnection=lo_DbCon
		cmd.commandtext=sql
		cmd.commandtype=adCmdText
		cmd.prepared=true
		cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
		cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
		set rs=cmd.execute
			if not (rs.eof or rs.bof) then
				order=rs(0)
				order=cint(order)
			end if
		set rs=nothing
	end if
%>


<%
	sql="select"
	sql=sql & "		idx, c_category, c_category_eng, c_order "
	sql=sql & " from nc_category where idx = ? "

	set cmd=server.createobject("adodb.command")
	cmd.activeconnection=lo_DbCon
	cmd.commandtext=sql
	cmd.commandtype=adCmdText
	cmd.prepared=true
	cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,1,div)

	set rs=cmd.execute
		if not rs.eof or rs.bof then
			product_en=rs("c_category_eng")
			product_kr=rs("c_category")	
	end if
	set rs=nothing
	
	'elect case div
	'	case 1
	'		product_en="Credit Card Checker(Wired)"
	'		product_kr="신용카드조회기(유선)"
	'	case 2
	'		product_en="Credit Card Checker(Wireless)"
	'		product_kr="신용카드조회기(무선)"
	'	case 3
	'		product_en="POS"
	'		product_kr="POS 장비"
	'	case 4
	'		product_en="MultiPad"
	'		product_kr="멀티패드"
	'	case 5
	'		product_en="SignaturePad"
	'		product_kr="서명패드"
	'	case 6
	'		product_en="Others"
	'		product_kr="기타장비"
	'nd select
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE Information &amp; Telecommunication products</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/sub.css" rel="stylesheet" type="text/css">
<link href="../css/gray.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<!--[if lt IE 9]>
      <script type="text/javascript" src="../js/respond.js"></script>
      <script type="text/javascript" src="../js/selectivizr.js"></script>
<![endif]-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/sub.js"></script>
<script type="text/javascript" src="../js/jquery.gray.js"></script>
<script type="text/javascript">
	
	var m0 = 3;
	var m1 = <%= div-1 %>;

	<% if order>-1 then %>
	var m2 = <%= order %>;		// 인덱스 순서
	var s = <%= div-1+3 %>;
	<% end if %>

</script>
</head>
<body class="product">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng"><%= product_en %></p>
        <!--<p class="kor"><%'= product_kr %></p>-->
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">go Main</a>
        	</div>
            <h2><%= product_en %></h2>
            <div class="productTop">
                <p class="title">With advanced technology and an outstanding sense of design,<span> we will build products for customers.</span></p>
            </div>
            <ul class="productList">

				<%
					sql="select"
					sql=sql & "		idx, p_title, p_file_idx"
					sql=sql & " ,	(select x_file from nc_file where idx=a.p_file_idx) as x_file"
					sql=sql & " from nc_product2 a"
					sql=sql & " where p_display>0"
					sql=sql & "	and p_div= ? "
					sql=sql & "	order by p_order asc"
    	        
	    			set cmd=server.createobject("adodb.command")
					cmd.activeconnection=lo_DbCon
					cmd.commandtext=sql
					cmd.commandtype=adCmdText
					cmd.prepared=true
					cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
					set rs=cmd.execute
						if not (rs.eof or rs.bof) then
							num=0
							do until rs.eof
								p_idx=rs("idx")
								p_title=rs("p_title")
								p_file_idx=rs("p_file_idx")
								x_file=rs("x_file")

								p_title=html_encode(p_title)


								if instr(x_file,".") then
'									thumb_file=split(x_file,".")(0) & "_thumb." & split(x_file,".")(1)
									thumb_file=split(x_file,".")(0) & "_thumb.jpg"
								else
									thumb_file=""
								end if
				%>
				<li<% if order=num then %> class="on"<% end if %>>
                    <p><%= p_title %><img src="../images/product/title_arrow.png" alt="product"/></p>
                    <a href="11.asp?div=<%= div %>&idx=<%= p_idx %>" style="background:url('<%= upload_virtual %>/<%= gb %>/<%= thumb_file %>') no-repeat center center; background-size:cover;"<% if order<>num then %> class="grayscale grayscale-fade"<% end if %>></a>
                </li>
				<%
								num=num+1
								rs.movenext
							loop
						end if
					set rs=nothing
				%>	

            </ul>


			<%
				if idx>0 then

					sql="select"
					sql=sql & "		p_div, p_title, p_file_idx, p_file_name, p_content, p_comment, p_link, p_certify, p_order"
					sql=sql & " ,	(select x_file from nc_file where idx=a.p_file_idx) as x_file"
					sql=sql & " from nc_product2 a"
					sql=sql & " where p_display>0"
					sql=sql & "	and p_div= ? "
					sql=sql & "	and idx= ? "
                
					set cmd=server.createobject("adodb.command")
					cmd.activeconnection=lo_DbCon
					cmd.commandtext=sql
					cmd.commandtype=adCmdText
					cmd.prepared=true
					cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,div)
					cmd.parameters.append cmd.createparameter("@idx",adInteger,adParamInput,4,idx)
					set rs=cmd.execute
						if not (rs.eof or rs.bof) then
							p_title=rs("p_title")
							p_file_idx=rs("p_file_idx")
							p_file_name=rs("p_file_name")
							p_content=rs("p_content")
							p_comment=rs("p_comment")
							p_link=rs("p_link")
							p_certify=rs("p_certify")
							p_order=rs("p_order")
							x_file=rs("x_file")

							p_title=html_encode(p_title)

							if p_link<>"" then
								if left(p_link,7)<>"http://" then
									p_link="http://" & p_link
								end if
							end if
			%>
			<div class="productDetail">
                <div style="background:url('<%= upload_virtual %>/<%= gb %>/<%= x_file %>') no-repeat center center; background-size:cover;" class="img"><% if p_certify=1 then %><p>certify</p><% end if %></div>
                <div class="productText">
                    <p class="title"><%= p_title %></p>
                    <ul>
                 	   <li style="background:none"><%= p_content %></li>
                    </ul>

					<% if p_comment<>"" then %>
                    <dl>
                        <dt>Product Information</dt>
                        <dd style="background:none"><%= p_comment %></dd>
                    </dl>
					<% end if %>

					<% if p_link<>"" then %>
                    <a href="<%= p_link %>" target="_blank">WebSites</a>
					<% end if %>

                </div>
            </div>
			<%
						end if
					set rs=nothing

				end if
			%>


		</div>
    </div>
</div>
<div id="footer"></div>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
