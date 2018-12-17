<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->
<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" --><div>
    <div class="first"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/1.html">Company</a></li>
            <li><a href="../02_business/1.html">Services</a></li>
            <li><a href="../03_stock/1.html">Investment Information</a></li>
            <li><a href="../04_product/11.asp">Product Information</a></li>
            <li><a href="../05_customer/1.html">Customer Support</a></li>
            <!--
            <li><a href="../06_recruit/11.html">CAREERS</a></li>
            -->
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/1.html">CEO Greetings</a></li>
            <li><a href="../01_company/2.html">History</a></li>
            <li><a href="../01_company/31.html">About Us</a></li>
            <li><a href="../01_company/41.html">Affiliated Companies</a></li>
            <li><a href="../01_company/5.html">Location</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../02_business/1.html">VAN Service</a></li>
            <li><a href="../02_business/2.html">PG Service</a></li>
            <li><a href="../02_business/31.html">Gift Card Service</a></li>
            <li><a href="../02_business/4.html">Mobile Service</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../03_stock/1.asp">Stock Chart</a></li>
            <li><a href="../03_stock/2.html">Financial Information</a></li>
            <li><a href="../03_stock/4.asp">IR</a></li>
        	<!--
            <li><a href="../03_stock/1.html">Stock Information</a></li>
            <li><a href="../03_stock/3.html">Disclosure</a></li>
            <li><a href="../03_stock/4.html">IR</a></li>
            181015 -->
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../04_product/11.asp?div=1">Credit Card Checker(Wired)</a></li>
            <li><a href="../04_product/11.asp?div=2">Credit Card Checker(Wireless)</a></li>
            <li><a href="../04_product/11.asp?div=3">POS</a></li>
            <li><a href="../04_product/11.asp?div=4">MultiPad</a></li>
            <li><a href="../04_product/11.asp?div=5">SignaturePad</a></li>
            <li><a href="../04_product/11.asp?div=6">Others</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../05_customer/1.html">New Registration</a></li>
            <!--
            <li><a href="../05_customer/2.html">Dealership Information</a></li>
            <li><a href="../05_customer/3.html">FAQ</a></li>
            -->
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/11.html">Careers</a></li>
            <li><a href="../06_recruit/21.html">Recruiment</a></li>
        </ul>
    </div>
    <!--<div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/21.html">2000’s</a></li>
            <li><a href="../01_company/22.html">1990’s</a></li>
            <li><a href="../01_company/23.html">1980’s</a></li>
        </ul>
    </div>-->
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/31.html">About Us</a></li>
            <li><a href="../01_company/32.html">Value Chain</a></li>
            <li><a href="../01_company/33.html">Integrity Management</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/41.html">KIS I&amp;T</a></li>
            <li><a href="../01_company/42.html">NICE TCM</a></li>
            <li><a href="../01_company/43.html">OK POS</a></li>
            <li><a href="../01_company/44.html">NICE Data</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../02_business/31.html">Business Overview</a></li>
            <li><a href="../02_business/32.html">Type Of Gift Card</a></li>
            <li><a href="../02_business/33.html">Affiliates/Record/Terms</a></li>
        </ul>
    </div>
   <!-- <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../03_stock/11.html">실시간 주가정보</a></li>
            <li><a href="../03_stock/12.html">나이스차트</a></li>
        </ul>
    </div>-->


	<% for i=1 to 6 %>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
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
			%>
            <li><a>없음</a></li>
			<%
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
    </div>
	<% next %>


	<!--
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/11.html">인재상</a></li>
            <li><a href="../06_recruit/12.html">복리후생</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/21.html">채용절차</a></li>
            <li><a href="../06_recruit/22.html">채용공고</a></li>
        </ul>
    </div> 
    -->
</div><!-- #include file="../../config/db_close.asp" -->
