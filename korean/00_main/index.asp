<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>NICE정보통신 메인페이지</title>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta http-equiv="keywords" content="" />
<meta http-equiv="description" content="" />
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<!--[if lt IE 9]>
      <script type="text/javascript" src="../js/respond.js"></script>
      <script type="text/javascript" src="../js/selectivizr.js"></script>
<![endif]-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<!-- 레이어팝 스크립트 start-->
<script language="JavaScript">
  <!--
  function setCookie( name, value, expiredays ) { 
   var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
   }
  function closePop() { 
   if ( document.pop_form.chkbox.checked ){ 
    setCookie( "maindiv", "done" , 1 ); 
   } 
   document.all['layer_popup'].style.visibility = "hidden";
  }
  //-->  
</script>
<!-- 레이어팝업 스크립트 end -->
</head>
<body>
<div id="quick">
    <a href="#" class="btn">퀵메뉴열기</a>
    <div class="wrap">
        <dl>
            <dt><a href="" class="q1">VAN서비스</a></dt>
            <div class="qWrap qw1">
                <dd><a href="../05_customer/1.html" target="_blank">가맹점 신규 가입</a></dd>
                <dd><a href="https://newnibs.nicevan.co.kr" target="_blank">거래조회시스템(NIBS)</a></dd>
            </div>
        </dl>
        <dl>
            <dt><a href="#" class="q2">PG가맹점서비스</a></dt>
            <div class="qWrap qw2 q2bg">
                <dd>
                	<span>PG홈페이지</span>
                    <ul class="qLi">
                    	<li><a href="https://www.nicepay.co.kr">NICEPAY</a></li>
                    	<li><a href="http://www.allthegate.com/ags/index.jsp">alltheGate</a></li>
                    </ul>
                </dd>
                <dd class="q2Border">
                	<span>PG가맹점<br/>관리자페이지</span>
                    <ul class="qLi">
                    	<li><a href="http://pg.nicepay.co.kr/home/Login.jsp">NICEPAY</a></li>
                    	<li><a href="http://admin7.allthegate.com/chaMng/login/login.jsp">alltheGate</a></li>
                    </ul>
                </dd>
            </div>
        </dl>
        <!--        
        <ul>
            <li class="m1"><a href="#" onclick="alertPop()">ERP</a></li>
            <script>
				function alertPop(){
					window.alert("본사에서만 접근할 수 있습니다.")
				}
			</script>
            <li class="m2"><a href="https://nibs.nicevan.co.kr" target="_blank">NIBS</a></li>
            <li class="m3"><a href="http://www.nicedata.co.kr">신세무</a></li>
        </ul>  
        -->
        <dl>
            <dt><a href="#" class="q3">PG거래내역조회</a></dt>
            <div class="qWrap qw3">
                <dd><a href="https://www.nicepay.co.kr/cs/transInfo/cardList.do" target="_blank">NICEPAY</a></dd>
                <dd><a href="http://www.allthegate.com/ags/support/support_01.jsp" target="_blank">alltheGate</a></dd>
            </div>
        </dl>               
        <p><a href="https://www.credit.co.kr" target="_blank">개인신용 정보조회</a></p>
       
       	<div class="quickCenter">
        	<span>고객센터</span>
        	<ul class="centerTel">
            	<li>02-2187-2700(가맹점용)</li>
            	<li>02-2187-2800(대리점용)</li>
            </ul>
        </div>
        
    </div>
</div>
<div id="wrapper">
    <div id="gnb"></div>
    <div id="visual">
        <div class="imageWrap">
            <div class="v1">
                <p class="subCopy">정보산업에서 무한가치를 창조하는 고도의 지식전문가 그룹</p>
                <p class="mainCopy">NETWORKING ‘I’ FOR CREATING EVERY VALUE</p>
            </div>
            <div class="v2">
            	<p class="subCopy">정보산업에서 무한가치를 창조하는 고도의 지식전문가 그룹</p>
                <p class="mainCopy">NETWORKING ‘I’ FOR CREATING EVERY VALUE</p>
            </div>
            <div class="v3">
            	<p class="subCopy">정보산업에서 무한가치를 창조하는 고도의 지식전문가 그룹</p>
                <p class="mainCopy">NETWORKING ‘I’ FOR CREATING EVERY VALUE</p>
            </div>
        </div>
        <div class="ui">
            <a href="#" class="left">이전이미지 보기</a>
            <a href="#" class="right">다음이미지 보기</a>
        </div>
        <ul class="indi">
            <li class="on"></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <div id="con1">
        <h2>SERVICE</h2>
        <span class="split"></span>
        <div class="conWrap">
            <ul>
                <li class="one">
                    <a href="../02_business/1.html">
                        <span class="title">금융 VAN 서비스</span>
                        <span class="text">안정적이고 차별화 된 고품격 서비스</span>
                    </a>
                </li>
                <li class="two">
                    <a href="../02_business/2.html">
                        <span class="title">PG(Payment Gateway)</span>
                        <span class="text mobileBlind">온라인/오프라인/모바일 어디서든 적용 가능한 전자상거래용 통합지불(payment)서비스</span>
                        <span class="text mobileView">인터넷상 가상의 신용카드 조회 단말기</span>
                    </a>
                </li>
                <li class="three">
                    <a href="../02_business/4.html">
                        <span class="title">모바일결제(삼성페이)</span>
                        <span class="text mobileBlind">휴대폰 번호만 알면 경품, 선물 등을 손쉽게 구매 및 발송할 수 있는 바코드 타입의 모바일 상품권입니다.</span>
                        <span class="text mobileView">바코드 타입의 모바일 상품권입니다.</span>
                    </a>
                </li>
                <li class="four">
                    <a href="../02_business/31.html">
                        <span class="title">전자상품권</span>
                        <span class="text mobileBlind">플라스틱 카드 형태를 가진 실물상품권으로 발행, 판매, 회수, 정산, 폐기 등의 일련의 과정을 전산적인 방법으로 관리하는 상품권</span>
                        <span class="text mobileView">플라스틱 카드 형태를 가진 실물상품권</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div id="con2">
   		<h2>PRODUCT</h2>
        <span class="split"></span>
        <ul>
            <li class="one">
                <p class="title">POS</p>
                <p class="text mt20 mobileBlind">BALANCE</p>
                <p class="text mt10">15”터티모니터 일체형</p>
                <p class="text mt10">보안인증멀티리더기(MR-1000) 장착</p>
                <a href="../04_product/11.asp?div=3">더보기</a>
            </li>
            <li class="two">
                <p class="title">멀티패드</p>
                <p class="text mt20">NS-1000</p>
                <p class="text mt10">서명패드기능 + RF & NFC 인식</p>
                <p class="text mt10 mobileBlind">4.5" 컬러LCD + 정전식터치</p>
                <p class="text mt10 mobileBlind">삼성페이 결제기능(MST)</p>
                <a href="../04_product/11.asp?div=4">더보기</a>
            </li>
            <li class="three">
                <p class="title">유선단말기</p>
                <p class="text mt20">K-1000</p>
                <p class="text mt10">3”써멀 프린터</p>
                <p class="text mt10 mobileBlind">3.8” 모노LCD + 키버튼</p>
                <a href="../04_product/11.asp?div=1">더보기</a>
            </li>
            <li class="four">
                <p class="title">무선단말기</p>
                <p class="text mt20">J-7000</p>
                <p class="text mt10 mobileBlind">WCDMA 모뎀 장착(SKT, KT)</p>
                <p class="text mt10 mobileBlind">탈착식 배터리 포함</p>
                <a href="../04_product/11.asp?div=2">더보기</a>
            </li>
        </ul>
    </div>
    <div id="con3">
        <h2>STOCK INFO &amp; NEWS</h2>
        <span class="split"></span>
        <div class="conWrap">


			<%
				set xmlDom=server.createobject("Microsoft.XMLDOM")
					xmlDom.async=false
					xmlDom.setproperty "ServerHTTPRequest", true
					xmlDom.load krx_xml


					if xmlDom.parseError.ErrorCode=0 then

						set root_node=xmlDom.getElementsByTagName("TBL_StockInfo")
							set item_node=root_node(0)
								JongName	= item_node.attributes.getNamedItem("JongName").value
								CurJuka		= item_node.attributes.getNamedItem("CurJuka").value
								PrevJuka	= item_node.attributes.getNamedItem("PrevJuka").value
								DungRak	= item_node.attributes.getNamedItem("DungRak").value
								Debi			= item_node.attributes.getNamedItem("Debi").value
    
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
							set item_node=nothing
						set root_node=nothing
    
						set root_node=xmlDom.getElementsByTagName("stockprice")
							set item_node=root_node(0)
								querytime	= item_node.attributes.getNamedItem("querytime").value
    
								if isdate(querytime) then
									querytime=display_date(querytime,4,1)
								end if
							set item_node=nothing
						set root_node=nothing
					set xmlDom=nothing

				else
					JongName="NICE정보통신"
					CurJuka="<span style='color:red; margin-left:20px'>최신정보로 갱신중입니다. &nbsp; <a href='http://marketdata.krx.co.kr/' target='_blank' style='color:red'>▶ KRX</a></span>"
					querytime=display_date(now(),4,1)
				end if
			%>

			<div class="left">
                <p class="title">STOCK INFO</p>
                <a href="../03_stock/1.asp" class="more">STOCK 더보기</a>
                <p class="name"><%= JongName %></p>
                <p class="point"><%= CurJuka %></p>
                <p class="updown" style="background:none"><%= DungRakRate %></p>
                <p class="number"><%= DungRakDebi %></p>
                <p class="date"><%= querytime %></p>
            </div>


			<div class="right">
            	<p class="title">채용</p>
                <a href="../06_recruit/22.asp" class="more">채용더보기</a>


				<%
					sql="select"
					sql=sql & "		idx, c_title, c_regdate"
					sql=sql & " from nc_recruit"
					sql=sql & " where c_display>0"
					sql=sql & "	order by c_regdate desc"
					sql=sql & "	limit 5"

					set cmd=server.createobject("adodb.command")
					cmd.activeconnection=lo_DbCon
					cmd.commandtext=sql
					cmd.commandtype=adCmdText
					cmd.prepared=true
					set rs=cmd.execute
						if not (rs.eof or rs.bof) then
							i=1
							do until rs.eof
								c_idx=rs("idx")
								c_title=rs("c_title")
								c_regdate=rs("c_regdate")

								c_title=html_encode(c_title)
								c_regdate=display_date(c_regdate,4,0)
				%>
				<dl<% if i=1 then %> class="first"<% end if %>>
                    <dt><a href="../06_recruit/22_view.asp?idx=<%= c_idx %>"><%= c_title %></a></dt>
                    <dd><%= c_regdate %></dd>
                </dl>
				<%
								i=i+1
								rs.movenext
							loop
						end if
					set rs=nothing
					set cmd=nothing
				%>


			</div>
        </div>
    </div>
</div>
<div id="footer"></div>
            
<!-- 레이어팝업 내용 start--->
<div id="layer_popup">
    <div class="wrapper">
        <div class="conWrap">
            <img src="../images/popup/popup_181218.png" alt="나이스정보통신(주)는 전기통신사업법 위반을 이유로 시정명을 받은 사실이 있음">
			<div class="close">
				<form name="pop_form">
					<div id="check"><input type="checkbox" name="chkbox" value="checkbox"> 오늘하루 보지 않기</div>
					<div id="close"><a href="javascript:closePop();"><img src="../images/etc/btn_close.png" alt="닫기"></a></div>
				</form>	
			</div>
			
        </div>
    </div>
</div>
<!-- 레이어팝업 내용 end -->
    
<!--레이어팝업 닫기 스크립트 start-->
<script language="Javascript">
    
    cookiedata = document.cookie;
    
    var sdate= new Date("2018/12/21 00:00:00");//시작날짜
    var edate= new Date("2018/12/25 00:00:00");//종료날짜
    
    if ( cookiedata.indexOf("maindiv=done") < 0 ){
        if(Date.now() >= sdate && Date.now() <= edate){
            document.all['layer_popup'].style.visibility = "visible";
        }else{
            document.all['layer_popup'].style.visibility = "hidden"; 
        }
    } 
    else {
        document.all['layer_popup'].style.visibility = "hidden"; 
    }
</script>
<!--레이어팝업 닫기 스크립트 end-->


</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
