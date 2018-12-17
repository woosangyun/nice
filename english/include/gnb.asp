<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<a href="../00_main/index.html" class="mobileHome">홈으로가기</a>
<div class="gnbWrapper">
    <a href="#" class="mobileMenu"></a>
    <h1><a href="../00_main/index.html"></a></h1>
    <ul class="menu">
        <li class="first"><a href="../01_company/1.html">company</a>
            <div class="menuWrap">
                <ul class="m1">
                    <li class="first"><a href="../01_company/1.html">CEO Greeting</a></li>
                    <li><a href="../01_company/2.html">History</a></li>
                    <li class="sub"><a href="../01_company/31.html">About Us</a>
                        <ul>
                            <li><a href="../01_company/31.html">About Us</a></li>
                            <li><a href="../01_company/32.html">Value Chain</a></li>
                            <li><a href="../01_company/33.html">Integrity Management</a></li>
                        </ul>
                    </li>
                    <li class="sub"><a href="../01_company/41.html">Affiliated Companies</a>
                        <ul>
                            <li><a href="../01_company/41.html">KIS I&amp;T</a></li>
                            <li><a href="../01_company/42.html">NICE TCM</a></li>
                            <li><a href="../01_company/43.html">OK POS</a></li>
                            <li><a href="../01_company/44.html">NICE Data</a></li>
                        </ul>
                    </li>
                    <li><a href="../01_company/5.html">Location</a></li>
                </ul>
            </div>
        </li>
        <li><a href="../02_business/1.html">services</a>
            <div class="menuWrap">
                <ul class="m2">
                    <li class="first"><a href="../02_business/1.html">VAN Service</a></li>
                    <li class="sub"><a href="../02_business/2.html">PG Service</a></li>
                    <li class="sub"><a href="../02_business/31.html">Gift Card Service</a>
                    	<ul>
                            <li><a href="../02_business/31.html">Business Overview</a></li>
                            <li><a href="../02_business/32.html">Type Of Gift Card</a></li>
                            <li><a href="../02_business/33.html">Affiliates/Record/Terms</a></li>
                        </ul>
                    </li>
                    <li><a href="../02_business/4.html">Mobile Service</a></li>
                </ul>
            </div>
        </li>
        <li><a href="../03_stock/2.html">investment</a>
            <div class="menuWrap">
                <ul class="m3">
                    
                	<li class="first"><a href="../03_stock/1.asp">Stock Chart</a></li>
                    <li><a href="../03_stock/2.html">Financial Information</a></li>
                    <li><a href="../03_stock/4.asp">IR</a></li>
                    <!--
                    <li><a href="../03_stock/1.html">Stock Information</a></li>                    
                    <li><a href="../03_stock/3.html">Disclosure</a></li>
                    <li><a href="../03_stock/4.html">IR</a></li>
                    181015 -->
                </ul>
            </div>
        </li>


		<li><a href="../04_product/11.asp">products</a>
            <div class="menuWrap">
                <ul class="m4">

					<% for i=1 to 6 %>

					<%
						select case i
							case 1	: product_div="Credit Card Checker(Wired)"
							case 2	: product_div="Credit Card Checker(Wireless)"
							case 3	: product_div="POS"
							case 4	: product_div="MultiPad"
							case 5	: product_div="SignaturePad"
							case 6	: product_div="Others"
						end select
					%>
					<li class="<% if i=1 then %>first sub<% else %>sub<% end if %>"><a href="../04_product/11.asp?div=<%= i %>"><%= product_div %></a>
                        <ul>

							<%
								sql="select"
								sql=sql & "		idx, p_title"
								sql=sql & " from nc_product2"
								sql=sql & " where p_display>0"
								sql=sql & " and p_div= ? "
								sql=sql & "	order by p_order asc"

								set cmd=server.createobject("adodb.command")
								cmd.activeconnection=lo_DbCon
								cmd.commandtext=sql
								cmd.commandtype=adCmdText
								cmd.prepared=true
								cmd.parameters.append cmd.createparameter("@div",adWChar,adParamInput,1,i)
								set rs=cmd.execute
									if rs.eof or rs.bof then
									else
										do until rs.eof
											p_idx=rs("idx")
											p_title=rs("p_title")
											p_title=html_encode(p_title)
							%>
                            <li><a href="../04_product/11.asp?div=<%= i %>&idx=<%= p_idx %>"><%= p_title %></a></li>
							<%
											rs.movenext
										loop
									end if
								set rs=nothing
								set cmd=nothing
							%>

                        </ul>
                    </li>
					<% next %>

				</ul>
            </div>
        </li>


        <li><a href="../05_customer/1.html">Customer Support</a>
            <div class="menuWrap">
                <ul class="m5">
                    <li class="first"><a href="../05_customer/1.html">New Registration</a></li>
                    <!--
                    <li><a href="../05_customer/2.html">Dealership Information</a></li>
                    <li><a href="../05_customer/3.html">FAQ</a></li>
                    -->
                </ul>
            </div>
        </li>
        <!--
        <li><a href="../06_recruit/11.html">careers</a>
            <div class="menuWrap">
                <ul class="m6">
                    <li class="first sub"><a href="../06_recruit/11.html">Careers</a>
                    	<ul>
                            <li><a href="../06_recruit/11.html">인재상</a></li>
                            <li><a href="../06_recruit/12.html">복리후생</a></li>
                        </ul>
                    </li>
                    <li class="sub"><a href="../06_recruit/21.html">Recruiment</a>
                    	<ul>
                            <li><a href="../06_recruit/21.html">채용절차</a></li>
                            <li><a href="../06_recruit/22.html">채용공고</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </li>
        -->
    </ul>
    <ul class="util">
        <li class="first"><a href="../../korean/index.html">KOR</a></li>
        <li><a href="../01_company/5.html">CONTACT US</a></li>
    </ul>
</div>


<!-- #include file="../../config/db_close.asp" -->
