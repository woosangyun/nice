<%
'##################################################################################################
'#  Program ID    : db_config.asp
'#  First Writer  : 2004.06.15    김춘수
'#  Change Write  : Modify        changer      info
'#
'##################################################################################################
'#  Module        : 
'##################################################################################################

' Option Explicit
' On Error Resume Next
' Response.CharSet = "UTF-8"


%>
<!-- #include file="../crypt.asp" -->
<%
	DIM ls_str_conn,ls_dir_path,ls_client_ip,lo_DbCon,ls_server_url
	DIM ls_sys_year,ls_sys_month,ls_sys_day,ls_admin_email,ls_image_width_max,ls_image_height_max 

	ls_str_conn = getHString()
	
	ls_image_width_max = 200: ls_image_height_max=200		'이미지 파일 업로드 할 가로:세로 이미지 크기 제한
	ls_dir_path		= server.mappath("/temp")				'임시파일 저장경로
	''ls_server_url	= "http://umjoa.xhtm.net/mail/"			'메일컨텐츠 연결주소
	ls_server_url	= "http://www.nicevan.co.kr/mail/"			'메일컨텐츠 연결주소
	ls_admin_email	= "jin75@nicevan.co.kr"					'관리자 메일 주소
	ls_client_ip	= Request("REMOTE_ADDR")
	ls_sys_year		= YEAR(DATE)
	ls_sys_month	= MONTH(DATE)
	ls_sys_day		= DAY(DATE)
	SET lo_DbCon = Server.CreateObject("ADODB.Connection")
		IF NOT IsObject(lo_DbCon) THEN
		Response.Redirect server.mappath("/temp")&"/config/DBConnectErr.asp"
	END IF
	WITH lo_DbCon
		.ConnectionString = ls_str_conn
		.CursorLocation   = adUseClient
		.Open
	END WITH
%>
