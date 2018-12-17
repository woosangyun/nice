<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->
<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" --><div>
    <div class="first"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/1.html">회사소개</a></li>
            <li><a href="../02_business/1.html">사업영역</a></li>
            <li><a href="../03_stock/1.asp">투자정보</a></li>
            <li><a href="../04_product/11.asp">제품소개</a></li>
            <li><a href="../05_customer/1.html">고객지원</a></li>
            <li><a href="../06_recruit/11.html">채용</a></li>
        </ul>
    </div>

    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/1.html">대표이사 인사말</a></li>
            <li><a href="../01_company/2.html">회사연혁</a></li>
            <li><a href="../01_company/31.html">그룹소개</a></li>
            <li><a href="../01_company/41.html">지급결제관계사</a></li>
            <li><a href="../01_company/5.html">오시는 길</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../02_business/1.html">VAN 서비스</a></li>
            <li><a href="../02_business/2.html">PG 서비스</a></li>
            <li><a href="../02_business/31.html">전자상품권 서비스</a></li>
            <li><a href="../02_business/4.html">모바일 결제서비스</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../03_stock/1.asp">주가정보</a></li>
            <li><a href="../03_stock/2.html">재무정보</a></li>
            <li><a href="../03_stock/3.asp">공시자료</a></li>
            <li><a href="../03_stock/4.asp">IR자료</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../04_product/11.asp?div=1">신용카드조회기(유선)</a></li>
            <li><a href="../04_product/11.asp?div=2">신용카드조회기(무선)</a></li>
            <li><a href="../04_product/11.asp?div=3">POS 장비</a></li>
            <li><a href="../04_product/11.asp?div=4">멀티패드</a></li>
            <li><a href="../04_product/11.asp?div=5">서명패드</a></li>
            <li><a href="../04_product/11.asp?div=6">기타장비</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../05_customer/1.html">신규가입</a></li>
            <!--<li><a href="../05_customer/2.asp">전국대리점 안내</a></li>-->
            <li><a href="../05_customer/3.asp">FAQ</a></li>
        </ul>
    </div>
    <div class="second"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/11.html">인사제도</a></li>
            <li><a href="../06_recruit/21.html">채용정보</a></li>
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
            <li><a href="../01_company/31.html">그룹소개</a></li>
            <li><a href="../01_company/32.html">가치체계</a></li>
            <li><a href="../01_company/33.html">정도경영</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../01_company/41.html">KIS정보통신</a></li>
            <li><a href="../01_company/42.html">한국전자금융</a></li>
            <li><a href="../01_company/43.html">OK POS</a></li>
            <li><a href="../01_company/44.html">NICE데이터</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../02_business/31.html">사업 소개</a></li>
            <li><a href="../02_business/32.html">상품권 종류</a></li>
            <li><a href="../02_business/33.html">제휴처/내역조회/약관</a></li>
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
				sql=sql & " from nc_product"
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


    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/11.html">인재상</a></li>
            <li><a href="../06_recruit/12.html">복리후생</a></li>
        </ul>
    </div>
    <div class="third"><a class="depth" style="cursor:pointer"></a>
        <ul>
            <li><a href="../06_recruit/21.html">채용절차</a></li>
            <li><a href="../06_recruit/22.asp">채용공고</a></li>
        </ul>
    </div>
</div><!-- #include file="../../config/db_close.asp" -->
