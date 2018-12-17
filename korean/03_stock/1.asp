<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->


<%
	set xmlDom=server.createobject("Microsoft.XMLDOM")
	xmlDom.async=false
	xmlDom.setproperty "ServerHTTPRequest", true
	xmlDom.load krx_xml


	if xmlDom.parseError.ErrorCode=0 then

		set root_node=xmlDom.getElementsByTagName("TBL_StockInfo")
			set item_node=root_node(0)
				CurJuka		= item_node.attributes.getNamedItem("CurJuka").value
				PrevJuka	= item_node.attributes.getNamedItem("PrevJuka").value
				DungRak	= item_node.attributes.getNamedItem("DungRak").value
				Debi			= item_node.attributes.getNamedItem("Debi").value
    
				StartJuka	= item_node.attributes.getNamedItem("StartJuka").value
				HighJuka	= item_node.attributes.getNamedItem("HighJuka").value
				LowJuka	= item_node.attributes.getNamedItem("LowJuka").value
				Volume		= item_node.attributes.getNamedItem("Volume").value
    
				UpJuka		= item_node.attributes.getNamedItem("UpJuka").value
				DownJuka	= item_node.attributes.getNamedItem("DownJuka").value
				High52		= item_node.attributes.getNamedItem("High52").value
				Low52		= item_node.attributes.getNamedItem("Low52").value
    
				Per			= item_node.attributes.getNamedItem("Per").value
				FaceJuka	= item_node.attributes.getNamedItem("FaceJuka").value
				Amount		= item_node.attributes.getNamedItem("Amount").value

				if isnumeric(CurJuka) and isnumeric(PrevJuka) then
					DungRakRate=(CurJuka-PrevJuka)*100/PrevJuka
					DungRakRate=formatnumber(DungRakRate,2)
    
					if DungRakRate>0 then
						DungRakRate="+" & DungRakRate & "%"
					else
						DungRakRate=DungRakRate & "%"
					end if
				end if
    
				if isnumeric(DungRak) then
					DungRak=int(DungRak)
				else
					DungRak=0
				end if
	
				select case DungRak
					case 1		: DungRakDebi="<font style='color:#ff0000'>↑ " & Debi & "</font>"
					case 2		: DungRakDebi="<font style='color:#ff0000'>▲ " & Debi & "</font>"
					case 3		: DungRakDebi="<font style='color:#000000'>" & Debi & "</font>"
					case 4		: DungRakDebi="<font style='color:#0066FF'>↓ " & Debi & "</font>"
					case 5		: DungRakDebi="<font style='color:#0066FF'>▼ " & Debi & "</font>"
					case else	: DungRakDebi="<font style='color:#0066FF'>-</font>"
				end select

				if isnumeric(CurJuka) and isnumeric(Amount) then
					extra_totalAmount=round(CurJuka*Amount/1000000)
					extra_totalAmount=formatnumber(extra_totalAmount,0)
				end if
			set item_node=nothing

		set root_node=nothing
    
		set root_node=xmlDom.getElementsByTagName("TBL_Hoga")
			set item_node=root_node(0)
				medoJan0		= item_node.attributes.getNamedItem("medoJan0").value
				medoJan1		= item_node.attributes.getNamedItem("medoJan1").value
				medoJan2		= item_node.attributes.getNamedItem("medoJan2").value
				medoJan3		= item_node.attributes.getNamedItem("medoJan3").value
				medoJan4		= item_node.attributes.getNamedItem("medoJan4").value
				medoHoka0	= item_node.attributes.getNamedItem("medoHoka0").value
				medoHoka1	= item_node.attributes.getNamedItem("medoHoka1").value
				medoHoka2	= item_node.attributes.getNamedItem("medoHoka2").value
				medoHoka3	= item_node.attributes.getNamedItem("medoHoka3").value
				medoHoka4	= item_node.attributes.getNamedItem("medoHoka4").value
				mesuJan0		= item_node.attributes.getNamedItem("mesuJan0").value
				mesuJan1		= item_node.attributes.getNamedItem("mesuJan1").value
				mesuJan2		= item_node.attributes.getNamedItem("mesuJan2").value
				mesuJan3		= item_node.attributes.getNamedItem("mesuJan3").value
				mesuJan4		= item_node.attributes.getNamedItem("mesuJan4").value
				mesuHoka0	= item_node.attributes.getNamedItem("mesuHoka0").value
				mesuHoka1	= item_node.attributes.getNamedItem("mesuHoka1").value
				mesuHoka2	= item_node.attributes.getNamedItem("mesuHoka2").value
				mesuHoka3	= item_node.attributes.getNamedItem("mesuHoka3").value
				mesuHoka4	= item_node.attributes.getNamedItem("mesuHoka4").value

				extra_medoHoka=medoHoka4
				extra_mesuHoka=mesuHoka0
    
				medoTotal=1+medoJan0+medoJan1+medoJan2+medoJan3+medoJan4-1
				mesuTotal=1+mesuJan0+mesuJan1+mesuJan2+mesuJan3+mesuJan4-1
			set item_node=nothing
		set root_node=nothing

		temp_field="<span class='extra_field'>###</span>"

	else
'		response.write "<br>" & xmlDom.parseError.ErrorCode
'		response.write "<br>" & xmlDom.parseError.reason
'		response.write "<br>" & xmlDom.parseError.line
'		response.write "<br>" & xmlDom.parseError.srcText
'		response.write "<br>ddd"
'		response.end
	end if
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 투자정보-주가정보</title>
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
	var m1 = 0;
	//var m2 = 0;
	//var s = 0;

</script>
<style type="text/css">
	.extra_field		{color:red; font-weight:900}
</style>
</head>
<body class="stock">
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <p class="eng">STOCK INFORMATION</p>
        <p class="kor">주가정보</p>
    </div>
    <div id="container">
        <div class="contents">
        	<div id="lnb">
                <a href="../00_main/index.html" class="home">메인으로 이동</a>
        	</div>
            <h2>주가정보</h2>
            <div class="stockTop">

				<% if xmlDom.parseError.ErrorCode<>0 then %>
				<div style="color:red; margin-bottom:10px">※ 최신 정보로 갱신 중입니다. 잠시 후 다시 이용해 주세요. &nbsp; <a href="http://marketdata.krx.co.kr/" target="_blank" style="color:red">▶ KRX</a></div>
				<% end if %>

				<div class="stockLeft">
                	<div class="stock1">
                    	<div class="stockPoint">

							<% if DungRak>0 then %>
								<% if DungRak<3 then %>
								<img src="../images/stock/arrow_up_b.png" alt=""/>
								<% elseif DungRak>3 then %>
								<img src="../images/stock/arrow_down_b.png" alt=""/>
								<% end if %>
							<% end if %>

							<%= CurJuka %>
						</div>
                        <div class="stockUpDown">
                            <ul class="stockList">
                                <li class="yesterday">
                                    <ul>
                                        <li class="key" style="width:55px">전일대비</li>
                                        <li class="up" style="background:none"><%= DungRakDebi %></li>
                                    </ul>
                                </li>
                                <li class="fluctuation">
                                    <ul>
                                        <li class="key">등락률</li>
                                        <li class="up" style="width:50px"><%= DungRakRate %></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mt30">
                        <colgroup>
                            <col width="25%" /><col width="25%" /><col width="25%" /><col width="25%" />
                        </colgroup>                
                        <tbody>
                            <tr>
                                <td colspan="4" class="bold">KOSPI / KOSPI 중형주 / 서비스업</td>
                            </tr>
                            <tr>
                                <th class="left">전일가(원)</th>
                                <td><%= PrevJuka %></td>
                                <th class="left">매도호가(원)</th>
                                <td class="extra_field"><%= extra_medoHoka %></td>
                            </tr>
                            <tr>
                                <th class="left">전일거래량㈜</th>
                                <td><span id="extra_PrevValue" class="extra_field"></span></td>
                                <th class="left">매수호가(원)</th>
                                <td class="extra_field"><%= extra_mesuHoka %></td>
                            </tr>
                            <tr>
                                <th class="left">상한가(원)</th>
                                <td><%= UpJuka %></td>
                                <th class="left">52주최고(원)</th>
                                <td><%= High52 %></td>
                            </tr>
                            <tr>
                                <th class="left">하한가(원)</th>
                                <td><%= DownJuka %></td>
                                <th class="left">52주최저(원)</th>
                                <td><%= Low52 %></td>
                            </tr>
                            <tr>                              
                                <th class="left">액면가(원)</th>
                                <td><%= FaceJuka %></td>
                                <th class="left">PER</th>
                                <td><%= Per %></td>
                            </tr>
                            <!--
                            <tr>
                                <th class="left">외국인(%)</th>
                                <td><%= temp_field %></td>
                                <th class="left">업종PER</th>
                                <td><%= temp_field %></td>
                            </tr>
                            <tr>
                                <th class="left">액면가(원)</th>
                                <td><%= FaceJuka %></td>
                                <th class="left">PBR</th>
                                <td><%= temp_field %></td>
                            </tr>-->
                        </tbody>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="50%" /><col width="50%" />
                        </colgroup>                
                        <tbody>
                        <!--
                            <tr>
                                <th class="left">자본금(백만원)</th>
                                <td><%= temp_field %></td>
                            </tr>-->
                            <tr>
                                <th class="left">상장주식수㈜</th>
                                <td><%= Amount %></td>
                            </tr>
                            <tr>
                                <th class="left">시가총액(백만원)</th>
                                <td class="extra_field"><%= extra_totalAmount %></td>
                            </tr>
                            <!--
                            <tr>
                                <th class="left">상장일</th>
                                <td><%= temp_field %></td>
                            </tr>-->
                        </tbody>
                    </table>
                </div>
                <div class="stockRight">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="noMG">
                        <colgroup>
                            <col width="25%" /><col width="25%" /><col width="25%" /><col width="25%" />
                        </colgroup>                
                        <thead>
                        	<tr>
                                <th>시가(원)</th>
                                <th>고가(원)</th>
                                <th>저가(원)</th>
                                <th>거래량㈜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="center"><%= StartJuka %></td>
                                <td class="center"><%= HighJuka %></td>
                                <td class="center"><%= LowJuka %></td>
                                <td class="center"><%= Volume %>&nbsp;</td>
                            </tr>
                        </tbody>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mt30">
                        <colgroup>
                            <col width="33%" /><col width="33%" /><col width="33%" />
                        </colgroup>                
                        <thead>
                        	<tr>
                                <th class="noBG">매도잔량</th>
                                <th class="noBG">호가</th>
                                <th class="noBG">매수잔량</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="center grayBG"><%= medoJan0 %></td>
                                <td class="center grayBG blue"><%= medoHoka0 %></td>
                                <td class="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="center grayBG"><%= medoJan1 %></td>
                                <td class="center grayBG blue"><%= medoHoka1 %></td>
                                <td class="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="center grayBG"><%= medoJan2 %></td>
                                <td class="center grayBG blue"><%= medoHoka2 %></td>
                                <td class="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="center grayBG"><%= medoJan3 %></td>
                                <td class="center grayBG blue"><%= medoHoka3 %></td>
                                <td class="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="center grayBG"><%= medoJan4 %></td>
                                <td class="center grayBG blue"><%= medoHoka4 %></td>
                                <td class="center">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="center">&nbsp;</td>
                                <td class="center orangeBG orange"><%= mesuHoka0 %></td>
                                <td class="center orangeBG"><%= mesuJan0 %></td>
                            </tr>
                            <tr>
                                <td class="center">&nbsp;</td>
                                <td class="center orangeBG orange"><%= mesuHoka1 %></td>
                                <td class="center orangeBG"><%= mesuJan1 %></td>
                            </tr>
                            <tr>
                                <td class="center">&nbsp;</td>
                                <td class="center orangeBG orange"><%= mesuHoka2 %></td>
                                <td class="center orangeBG"><%= mesuJan2 %></td>
                            </tr>
                            <tr>
                                <td class="center">&nbsp;</td>
                                <td class="center orangeBG orange"><%= mesuHoka3 %></td>
                                <td class="center orangeBG"><%= mesuJan3 %></td>
                            </tr>
                            <tr>
                                <td class="center">&nbsp;</td>
                                <td class="center orangeBG orange"><%= mesuHoka4 %></td>
                                <td class="center orangeBG"><%= mesuJan4 %></td>
                            </tr>
                        </tbody>
                        <tfoot>
                        	<tr>
                                <td class="center bold"><%= medoTotal %></td>
                                <td class="center bold">총잔량</td>
                                <td class="center bold"><%= mesuTotal %></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div class="result table_inner scroll">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="mt40">
                <colgroup>
                    <col width="16.6%" /><col width="16.6%" /><col width="16.6%" /><col width="16.6%" /><col width="16.6%" /><col width="16.6%" />
                </colgroup>
                <thead>                
                    <tr>
                        <th>시간</th>
                        <th>체결가</th>
                        <th>전일대비</th>
                        <th>등락률</th>
                        <th>거래량㈜</th>
                        <th>거래대금(원)</th>
                    </tr>
                </thead>
                <tbody>


					<% if xmlDom.parseError.ErrorCode=0 then %>

					<%
						set root_node=xmlDom.getElementsByTagName("TBL_TimeConclude")
							set item_node=root_node(0).childnodes

								for each item_node in root_node(0).childnodes
									time_Time			= item_node.attributes.getNamedItem("time").value
									time_negoprice	= item_node.attributes.getNamedItem("negoprice").value
									time_Dungrak		= item_node.attributes.getNamedItem("Dungrak").value
									time_getDebi		= item_node.attributes.getNamedItem("Debi").value
									time_sellprice		= item_node.attributes.getNamedItem("sellprice").value
									time_buyprice		= item_node.attributes.getNamedItem("buyprice").value
									time_amount		= item_node.attributes.getNamedItem("amount").value

									if isnumeric(time_negoprice) and isnumeric(PrevJuka) then
										time_DungRakRate=(time_negoprice-PrevJuka)*100/PrevJuka
										time_DungRakRate=formatnumber(time_DungRakRate,2)
    
										if time_DungRakRate>0 then
											time_DungRakRate="+" & time_DungRakRate & "%"
										else
											time_DungRakRate=time_DungRakRate & "%"
										end if
									end if

									if isnumeric(time_Dungrak) then
										time_Dungrak=int(time_Dungrak)
									else
										time_Dungrak=0
									end if

									select case time_Dungrak
										case 1		: time_DungRakDebi="<font style='color:#ff0000'>↑ " & time_getDebi & "</font>"
										case 2		: time_DungRakDebi="<font style='color:#ff0000'>▲ " & time_getDebi & "</font>"
										case 3		: time_DungRakDebi="<font style='color:#000000'>" & time_getDebi & "</font>"
										case 4		: time_DungRakDebi="<font style='color:#0066FF'>↓ " & time_getDebi & "</font>"
										case 5		: time_DungRakDebi="<font style='color:#0066FF'>▼ " & time_getDebi & "</font>"
										case else	: time_DungRakDebi="<font style='color:#0066FF'>-</font>"
									end select

									if isnumeric(time_negoprice) and isnumeric(time_amount) then
										time_totalprice=time_negoprice*time_amount
										time_totalprice=formatnumber(time_totalprice,0)
									end if
					%>
					<tr>
                        <td class="center"><%= time_Time %></td>
                        <td class="center"><%= time_negoprice %></td>
                        <td class="center up"><!--<img src="../images/stock/arrow_up.png" alt="상승" class="mr10"/>--><%= time_DungRakDebi %></td>
                        <td class="center up"><!--<img src="../images/stock/arrow_up.png" alt="상승" class="mr10"/>--><span class="extra_field"><%= time_DungRakRate %></span></td>
                        <td class="center"><%= time_amount %></td>
                        <td class="center"><span class="extra_field"><%= time_totalprice %></span></td>
                    </tr>
					<%
								next

							set item_node=nothing
						set root_node=nothing
					%>

					<% else %>
					<tr>
                        <td class="center">&nbsp;</td>
                        <td class="center">&nbsp;</td>
                        <td class="center up">&nbsp;</td>
                        <td class="center up">&nbsp;</td>
                        <td class="center">&nbsp;</td>
                        <td class="center">&nbsp;</td>
                    </tr>
					<% end if %>


                </tbody>
                </table>
            </div>

			<!--
            <div class="paging">
                <a href="#" class="ll"></a><a href="#" class="l"></a><a href="#" class="on">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">5</a><a href="#">6</a><a href="#">7</a><a href="#">8</a><a href="#">9</a><a href="#" class="last">10</a><a href="#" class="r"></a><a href="#" class="rr"></a>
            </div>
			-->

			<!--
            <ul class="tab">
                <li class="on"><a href="#">1주<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
                <li><a href="#">1개월<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
                <li><a href="#">3개월<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
                <li><a href="#">6개월<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
                <li><a href="#">1년<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
                <li><a href="#">3년<img src="../images/common/tab_arrow.gif" width="20" height="17" alt="탭 활성"/></a></li>
            </ul>
			-->


			<% if (instr(current_agent,"iphone") or instr(current_agent,"ipod") or instr(current_agent,"ipad") or instr(current_agent,"android")) < 1 then %>

			<OBJECT id="httpObj" classid="clsid:CDF26594-A9E2-4E41-87F9-6E79DD38CFE3" codebase="http://asp1.krx.co.kr/reference/AutoTrustHTTP.cab#version=1,0,1,1" width=0 height=0 align=center hspace=0 vspace=0>
				<Param name="CheckControl" value="True">
				<Param name="ASync" value="True">
				<Param name="RequestURL" value="http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code=036800">
				<Param name="HTTPMethod" value="GET">
			</OBJECT>

			<script src="http://asp1.krx.co.kr/inc/js/asp_chart.js"></script>
			<script language="javascript">
				function SendRequest() {
					if (httpObj != null){
						onChart(860, 400, "<%= nice_code %>");		// id=gpDisp (너비,높이,코드)
						httpObj.DoRequest();
					}
				}
			</script>

            <div class="graph" style="text-align:center">
				<div id="gpDisp" style="margin-top:50px"></div>
            </div>

			<script language="javascript">
				SendRequest();
			</script>

			<% end if %>


            <div class="mt50">

				<!--
				<div id="dateSelect">
                    <label for="area">기간</label>
                    <select id="area" title="지역선택">
                        <option selected="selected">기간</option>
                        <option>1주</option>
                        <option>1개월</option>
                        <option>3개월</option>
                        <option>6개월</option>
                        <option>1년</option>
                        <option>3년</option>
                    </select>
                </div>
                <div class="dateInput">
                  <input type="text" id="ex_input1"><button></button>
                </div>
                 ~ 
                <div class="dateInput">
                  <input type="text" id="ex_input2"><button></button>
                </div>
                <input value="조회"  type="submit" class="ml10 btnInquiry">
				-->

                <div class="result table_inner scroll">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" /><col width="10%" />
                    </colgroup>
                    <thead>                
                        <tr>
                            <th>일자</th>
                            <th>종가</th>
                            <th>전일대비</th>
                            <th>거래량㈜</th>
                            <th>거래대금(백만)</th>
                            <th>시가(원)</th>
                            <th>고가(원)</th>
                            <th>저가(원)</th>
                            <th>시가총액(백만)</th>
                            <th>상장주식수</th>
                        </tr>
                    </thead>
                    <tbody>


						<% if xmlDom.parseError.ErrorCode=0 then %>

						<%
							set root_node=xmlDom.getElementsByTagName("TBL_DailyStock")
								set item_node=root_node(0).childnodes

									i=1
									for each item_node in root_node(0).childnodes
										day_Date			= item_node.attributes.getNamedItem("day_Date").value
										day_EndPrice		= item_node.attributes.getNamedItem("day_EndPrice").value
										day_Dungrak		= item_node.attributes.getNamedItem("day_Dungrak").value
										day_getDebi		= item_node.attributes.getNamedItem("day_getDebi").value
										day_Start			= item_node.attributes.getNamedItem("day_Start").value
										day_High			= item_node.attributes.getNamedItem("day_High").value
										day_Low			= item_node.attributes.getNamedItem("day_Low").value
										day_Volume		= item_node.attributes.getNamedItem("day_Volume").value
										day_getAmount	= item_node.attributes.getNamedItem("day_getAmount").value

										if isnumeric(day_Dungrak) then
											day_Dungrak=int(day_Dungrak)
										else
											day_Dungrak=0
										end if

										select case day_Dungrak
											case 1	: day_DungRakDebi="<font style='color:#ff0000'>↑ " & day_getDebi & "</font>"
											case 2	: day_DungRakDebi="<font style='color:#ff0000'>▲ " & day_getDebi & "</font>"
											case 3	: day_DungRakDebi="<font style='color:#000000'>" & day_getDebi & "</font>"
											case 4	: day_DungRakDebi="<font style='color:#0066FF'>↓ " & day_getDebi & "</font>"
											case 5	: day_DungRakDebi="<font style='color:#0066FF'>▼ " & day_getDebi & "</font>"
											case else	: time_DungRakDebi="<font style='color:#0066FF'>-</font>"
										end select

										if isnumeric(day_getAmount) then
											day_getAmountBakman=round(day_getAmount/1000000)
											day_getAmountBakman=formatnumber(day_getAmountBakman,0)
										end if

										if isnumeric(day_EndPrice) and isnumeric(Amount) then
											day_totalStart=round(day_EndPrice * Amount/1000000)
											day_totalStart=formatnumber(day_totalStart,0)
										end if

										if i=2 then
											extra_PrevValue=day_Volume
										end if
						%>
						<tr>
                            <td class="center"><%= day_Date %></td>
                            <td class="center"><%= day_EndPrice %></td>
                            <td class="center up"><!--<img src="../images/stock/arrow_up.png" alt="상승" class="mr10"/>--><%= day_DungRakDebi %></td>
                            <td class="center"><%= day_Volume %></td>
                            <td class="center"><%= day_getAmountBakman %></td>
                            <td class="center"><%= day_Start %></td>
                            <td class="center"><%= day_High %></td>
                            <td class="center"><%= day_Low %></td>
                            <td class="center"><span class="extra_field"><%= day_totalStart %></span></td>
                            <td class="center"><span class="extra_field"><%= Amount %></span></td>
                        </tr>
						<%
										i=i+1
									next

								set item_node=nothing
							set root_node=nothing
						%>

						<% else %>
						<tr>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center up">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                            <td class="center">&nbsp;</td>
                        </tr>
						<% end if %>


                    </tbody>
                    </table>
                </div>

				<!--
                <div class="paging">
                    <a href="#" class="ll"></a><a href="#" class="l"></a><a href="#" class="on">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">5</a><a href="#">6</a><a href="#">7</a><a href="#">8</a><a href="#">9</a><a href="#" class="last">10</a><a href="#" class="r"></a><a href="#" class="rr"></a>
                </div>
				-->

            </div>
        </div>
    </div>
</div>
<div id="footer"></div>


<script language="javascript">
	document.getElementById("extra_PrevValue").innerHTML="<%= extra_PrevValue %>";
</script>


</body>
</html>


<% set xmlDom=nothing %>
