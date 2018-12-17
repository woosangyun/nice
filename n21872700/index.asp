<!--#include file="./inject1.asp"-->

<%
'----------------------------------------------------------------------------------------------------
' SSL 보안 프로토콜 체크
	Dim nowprotocol
	nowprotocol = Request.ServerVariables("HTTPS")
	
	If nowprotocol = "off" Then
'		Response.Redirect "https://" & Request.ServerVariables("SERVER_NAME") & ":443" & Request.ServerVariables("URL")
	End If
'----------------------------------------------------------------------------------------------------

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="../inc/style.css" type="text/css">
<script language="javascript" src="./js/Admin_Logon_Check.js"></script>
</head>
<body onLoad="Default_Focus()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td height="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr> 
          <td height="107">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="181"><img src="img/main_visual_01.gif" width="181" height="130" usemap="#Map2" border="0"></td>
                <td width="269"><img src="img/main_visual_03.gif" width="269" height="130"></td>
                <td background="img/main_bg_01.gif" width="351">&nbsp;</td>
                <td background="img/main_bg_02.gif">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td height="100%">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                    <tr> 
                      <td width="181" valign="top"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                          <tr> 
                            <td><img src="img/main_visual_02.gif" width="181" height="76"></td>
                          </tr>
                          <tr> 
                            <td height="19" bgcolor="#38393A">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td bgcolor="#FFFFFF" height="100%" valign="top"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                                <tr> 
                                  <td height="100%" background="img/main_bg_03.gif">&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td valign="top" width="620"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                          <tr>
                            <td height="15">&nbsp;</td>
                          </tr>
                          <tr>
                            <td valign="top"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="12">&nbsp;</td>
                                  <td valign="top"> 
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="img/m_title_01.gif" width="595" height="54"></td>
                                      </tr>
                                      <tr>
                                        <td height="16">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td height="294" valign="top">
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td rowspan="2" width="55">&nbsp;</td>
                                              <td height="30">&nbsp;</td>
                                              <td rowspan="2" width="55">&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td>
                                               <!--로그인 테이블 시작-->
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" height="181">
                                                  <tr> 
                                                    <td width="8"><img src="img/loginleft.gif" width="8" height="181"></td>
                                                    <td background="img/loginbg_01.gif" height="181"> 
                                                      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                                                        <tr> 
                                                          <td rowspan="3" width="55">&nbsp;</td>
                                                          <td height="22">&nbsp;</td>
                                                          <td width="109">&nbsp;</td>
                                                          <td rowspan="3" width="57">&nbsp;</td>
                                                        </tr>
                                                        <tr> 
                                                          <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                              <tr> 
                                                                <td width="68"><img src="img/img_08.gif" width="68" height="95"></td>
                                                                <td>
                                                                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
																  <form name="frmAdminLogon">
                                                                    <tr> 
                                                                      <td height="7"></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td height="37">
                                                                        <input type="text" name="id"  onKeyPress = "if(event.keyCode==13) AdminLoginCheck();" class="inputbox" size="18" maxlength="10">
                                                                      </td>
                                                                    </tr>
                                                                    <tr> 
                                                                      <td height="44"> 
                                                                        <input type="password" name="pwd" onKeyPress = "if(event.keyCode==13) AdminLoginCheck();" class="inputbox" size="18" maxlength="10">
                                                                      </td>
                                                                    </tr>
                                                                    <tr> 
                                                                      <td height="7"></td>
                                                                    </tr>
																	</form>
                                                                  </table>
                                                                </td>
                                                              </tr>
                                                            </table>
                                                          </td>
                                                          <td rowspan="2" valign="top"><img onClick="AdminLoginCheck()" style="cursor:hand" src="img/btn_login.gif" width="109" height="109" border="0" alt="관리자로 로그인합니다."></td>
                                                        </tr>
                                                        <tr> 
                                                          <td height="64" valign="top"><img src="img/logiin_text_01.gif" width="190" height="29"></td>
                                                        </tr>
                                                      </table>
                                                    </td>
                                                    <td width="8"><img src="img/loginright.gif" width="8" height="181"></td>
                                                  </tr>
                                                </table>
                                               <!--로그인 테이블 끝-->
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td width="13">&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="15">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                      <td bgcolor="#F9F9F9" valign="top"> 
                        <table width="112" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="6"></td>
                          </tr>
                          <tr> 
                            <td><a href="http://www.nicevan.co.kr/"><img src="img/btn_01.gif" width="112" height="85" border="0"></a></td>
                          </tr>
                          <tr> 
                            <td height="1"></td>
                          </tr>
                          <tr>
                            <td><a href="#"><img src="img/btn_02.gif" width="112" height="85" border="0"></a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="106" background="img/foot_bg.gif" align="right" width="100%">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="100%">&nbsp;</td>
                <td align="right"><img src="img/foot_copy.gif" width="492" height="28" vspace="12" hspace="18"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<map name="Map"> 
  <area shape="circle" coords="75,62,46" href="#">
</map>
<map name="Map2"> 
  <area shape="rect" coords="9,15,181,49" href="../index.html" target="_blank">
</map>
</body>
</html>
