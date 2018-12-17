<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->

<!-- #include file="../include/admin_check.asp" -->


<html>
<head>
<title>파일첨부</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="inc/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--
function fileSave(){
	var f = document.form1;	
	
	if(!form1.file.value){
		alert("첨부할 파일을 선택 해 주세요");
		return;
	}

<%
	' 이미지 파일만 첨부가능한 경우
	If(flag = BBS_NEWS Or flag = BBS_NOTICE Or flag = BBS_PRODUCT) Then
%>
	if(form1.file.value){
		if(!form1.file.value.match(/(.jpg|.jpeg|.gif|.png)/)) {
//			alert("이미지 파일만 올릴 수 있습니다.");
//			return;
		}
	}
<%
	End If
%>
	
//	form1.encoding	= "multipart/form-data";
//	form1.method		= "post";
	form1.action		= "./file_upload_proc.asp<%= p_cmd %><%= g_cmd %>";
	
	form1.submit();	
}
//-->
</script>
<link href="../../inc/style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="437" border="0" cellspacing="0" cellpadding="0" height="279">

<form name="form1" method="post" enctype="multipart/form-data">
  <tr> 
    <td height="50"><img src="../img/upload_01.gif" width="437" height="50"></td>
  </tr>
  <tr>
    <td>
      <table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>
            <div align="center"><font color="#006699">[찾아보기]</font> 파일을 선택하신 후 
              <font color="#006699">[업로드]</font>를 선택하세요.</div>
          </td>
        </tr>
        <tr>
          <td height="50"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                  <td> 
                    <div align="center">
                      <input type="file" name="file">
                    </div>
                  </td>               
		  <td>                     
                  </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <div align="center"><img onClick="fileSave();" style="cursor:hand" src="../img/upload_bt.gif" width="134" height="31"></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="F1F1F1" height="38">
      <div align="right"><img  onClick="window.close()" style="cursor:hand" src="../img/upload_bt_close.gif" width="53" height="22" border="0"></div>
    </td>
  </tr>
	</form>  

</table>
</body>
</html>
