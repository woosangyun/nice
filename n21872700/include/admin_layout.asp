<% sub html_top() %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<!-- #include file="../../inc/head.inc"-->

	<style type="text/css">
		.board_paging			{font-weight:bold}
		.silver						{color:silver}
		#paging td					{cursor:pointer}
		#hidden_process		{width:100%; height:200px; display:none}
	</style>

	<script language="javascript" src="js/editor.js"></script>

	<script language="javascript">
		function move_location(on) {
			location.href=on;
		}
	</script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('img/sub_navi_04_ov.gif','img/sub_navi_05_ov.gif','img/sub_navi_06_ov.gif','img/sub_navi_07_ov.gif','img/sub_navi_01_ov.gif','img/n_btn_01_ov.gif','img/n_btn_02_ov.gif','img/n_btn_03_ov.gif','img/btn_06_ov.gif','img/sub_navi_02_ov.gif','img/sub_navi_08_ov.gif','img/sub_navi_03_ov.gif','img/sub_navi_09_ov.gif','img/sub_navi_10_ov.gif','img/sub_navi_11_ov.gif','img/sub_navi_12_ov.gif')" bgcolor="#FFFFFF">



<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td height="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr> 
          <td height="107">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="181"><img src="img/main_visual_01.gif" width="181" height="130" usemap="#Map" border="0"></td>
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

							<!-- #include file="./left_menu01.asp"--> 

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
<% end sub %>




<% sub html_bottom() %>
                                  </td>
                                  <td width="13">&nbsp;</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="100%">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                      <td bgcolor="#F9F9F9" valign="top"> 
                        <table width="112" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="6"></td>
                          </tr>
                          <tr> 
                            <td><a href="http://www.nicevan.co.kr/" target="_blank"><img src="img/btn_01.gif" width="112" height="85" border="0"></a></td>
                          </tr>
                          <tr> 
                            <td height="1"></td>
                          </tr>
                          <tr>
                            <td><a href="logout_ok.asp"><img src="img/btn_02.gif" width="112" height="85" border="0"></a></td>
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
  <area shape="rect" coords="9,15,181,49" href="../index.html" target="_blank">
</map>


<iframe id="hidden_process" name="hidden_process"></iframe>


</body>
</html>
<% end sub %>
