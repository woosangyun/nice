<%
function regular_expression(r_data,r_pattern,r_str)
	if isnull(r_data) then
		regular_expression=false
	else
	    set reg=New RegExp
	    reg.Pattern=regular_pattern(r_pattern,r_str)
	    reg.IgnoreCase=true	'대소문자 구분
	    reg.Global=true
		regular_expression=reg.Test(r_data)
	    'verify_email=regEx.Replace(r_data,"영신")	 '-- 치환
	end if
end function


'//##### 정규식 패턴문자열 - #regular_expression()
function regular_pattern(r_pattern,r_str)
	dim return_pattern, return_str

	select case r_pattern
		case "kor"				: return_pattern="^[가-힣]"
		case "eng"				: return_pattern="^[a-zA-Z]"
		case "num"			: return_pattern="^[0-9]"
		case "decimal"		: return_pattern="^[0-9\-.]"
		case "search"		: return_pattern="^[a-zA-Z0-9가-힣]"
		case "char"			: return_pattern="^[a-zA-Z0-9~!@#$%^&*()_+\|`\-=\\{}[\]:" & chr(34) & ";'<>?,.\/]"
		case "all"				: return_pattern="^[a-zA-Z0-9가-힣~!@#$%^&*()_+\|`\-=\\{}[\]:" & chr(34) & ";'<>?,.\/]"

		case "id"				: return_pattern="^[a-zA-Z0-9_]"
		case "tel"				: return_pattern="^02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064"
		case "cell"				: return_pattern="^010|011|016|017|018|019"
		case "phone"			: return_pattern="^02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064|010|011|016|017|018|019"
		case "email"			: return_pattern="^[a-zA-Z0-9_@\-.]"

		case "full_phone"	: return_pattern="^0(1[016789]|2|[34][1-3]|5[1-5]|6[1-4])[-]*[0-9]{3,4}[-]*[0-9]{4}"
		case "full_email"		: return_pattern="^[A-Za-z0-9_-]+([.][A-Za-z0-9_-]+)*[@][A-Za-z0-9_-]+([.][A-Za-z0-9_-]+)+"
	end select

	regular_pattern=return_pattern & r_str & "$"
end function


'경고 메세지
function error_message(r_data)
	dim return_msg

	select case r_data
		case "kor"				: return_msg="한글만 사용할 수 있습니다."
		case "eng"				: return_msg="영문만 사용할 수 있습니다."
		case "num"			: return_msg="숫자만 사용할 수 있습니다."
		case "decimal"		: return_msg="숫자만 사용할 수 있습니다."
		case "search"		: return_msg="사용할 수 없는 문자가 포함되어 있습니다."
		case "char"			: return_msg="한글 또는 사용할 수 없는 문자가 포함되어 있습니다."
		case "all"				: return_msg="사용할 수 없는 문자가 포함되어 있습니다."

		case "id"				: return_msg="영문 또는 숫자만 사용할 수 있습니다."
		case "tel"				: return_msg="올바른 지역번호를 입력하세요."
		case "cell"				: return_msg="올바른 이동통신번호를 입력하세요."
		case "phone"	 		: return_msg="올바른 지역번호 또는 이동통신번호를 입력하세요."
		case "email"			: return_msg="올바른 이메일 주소를 입력하세요."

		case "full_phone"	: return_msg="올바른 전화번호를 입력하세요."
		case "full_email"		: return_msg="올바른 이메일 주소를 입력하세요."

		case "content"		: return_msg="설명 내용은 제한된 길이 이하로 작성하세요."
		case "ssn"				: return_msg="올바른 주민등록번호를 입력하세요."
		case "address"		: return_msg="올바른 주소를 입력하세요."


		'로그인
		case "1"				: return_msg="등록되지 않은 아이디입니다."
		case "2"				: return_msg="비밀번호가 올바르지 않습니다."


		case else				: return_msg="필수 항목이 입력되지 않았습니다."		'//essential
	end select

'	error_message=url_encode(return_msg)
	error_message=return_msg
end function




'//##### 배열값 문자/번호 표시
function restore_div(r_data,r_choice,r_case)
	dim return_data
	return_data=0

	for_item=1
	for each div_str in choice_div(r_choice)
		select case r_case
			case "n"
				for_item_value=div_str
				return_data_value=for_item
			case else	's
				for_item_value=for_item
				return_data_value=div_str
				r_data=zero_data(r_data)
		end select

		if r_data=for_item_value then
			return_data=return_data_value

			exit for
		end if

		for_item=for_item+1
	next

	restore_div=return_data
end function


'//##### 변수값 배열 저장
function choice_div(r_data)
	dim choice_div_item

	select case r_data
		case "admin_list"				: choice_div=array("name","id","nick")
		case "member_list"				: choice_div=array("name","id","nick")
		case "board_list"				: choice_div=array("subject","content","nick")
		case "series_list"				: choice_div=array("series")
		case "mechanic_list"			: choice_div=array("series","code","model")
		case "storage_list"				: choice_div=array("series","name_kr")
		case "episode_list"				: choice_div=array("storage","title_kr")
		case "novel_list"					: choice_div=array("storage","title_kr")
		case "comic_list"				: choice_div=array("storage","title_kr")

		case "choice_display"			: choice_div=array("사용","사용안함")
		case "choice_level"			: choice_div=array("Lv.1","Lv.2","Lv.3","Lv.4","Lv.5","Lv.6","Lv.7","Lv.8","Lv.9")
		case "choice_phone"			: choice_div=array("02","031","032","033","041","042","043","051","052","053","054","055","061","062","063","064","010","011","016","017","018","019")
		case "choice_weekday"		: choice_div=array("일","월","화","수","목","금","토")

		case "member_div"				: choice_div=array("일반회원","테스트용")
		case "member_sex"				: choice_div=array("남자","여자")
		case "member_agree"			: choice_div=array("수신동의","수신안함")

		case "board_div"				: choice_div=array("자유게시판","FAQ","QnA")
		case "board_notice"			: choice_div=array("공지","일반")

		case "pt_program"				: choice_div=array("다이어트 - 슬림바디","다이어트 - 8주","매스업/벌크업","교정","재활")
		case "pt_meal1_time"			: choice_div=array("05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00")
		case "pt_meal2_time"			: choice_div=array("10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30")
		case "pt_meal3_time"			: choice_div=array("17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30","00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30")
		case "pt_sport_time"			: choice_div=array("05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","00:00","01:00","02:00","03:00","04:00")

		case "choice_email"
			choice_div_item="naver.com"
			choice_div_item=choice_div_item & ", hanmail.net"
			choice_div_item=choice_div_item & ", yahoo.co.kr"
			choice_div_item=choice_div_item & ", nate.com"
			choice_div_item=choice_div_item & ", hotmail.com"
			choice_div_item=choice_div_item & ", paran.com"
			choice_div_item=choice_div_item & ", korea.com"
			choice_div_item=choice_div_item & ", empal.com"
			choice_div_item=choice_div_item & ", dreamwiz.com"
			choice_div_item=choice_div_item & ", hanmir.com"
			choice_div_item=choice_div_item & ", lycos.co.kr"
			choice_div_item=choice_div_item & ", sayclub.com"
			choice_div_item=choice_div_item & ", hanafos.com"
			choice_div_item=choice_div_item & ", freechal.com"
			choice_div_item=choice_div_item & ", nexon.com"
			choice_div_item=choice_div_item & ", netian.com"
			choice_div_item=choice_div_item & ", daum.net"
			choice_div_item=choice_div_item & ", gmail.com"
			choice_div_item=choice_div_item & ", msn.com"
			choice_div_item=choice_div_item & ", chol.com"
			choice_div=split(choice_div_item,", ")

		case else							: choice_div=array("-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-")

	end select
end function






'//##### 소문자 처리 : AA → aa
function lcase_data(r_data)
	dim return_data
	return_data=r_data

	if isnull(return_data) or return_data="" then
		return_data=""
	else
		return_data=trim_data(return_data)
		return_data=lcase(return_data)
	end if

	lcase_data=return_data
end function


'//##### 여백 제거 - #lcase_data()
function trim_data(r_data)
	dim return_data
	return_data=r_data

	if isnull(return_data) or return_data="" then
		return_data=""
	else
		return_data=replace(return_data," ","")
		return_data=trim(return_data)
	end if

	trim_data=return_data
end function


'//##### 따옴표 처리 : 글수정시
function quotation_data(r_data)
	dim return_data
	return_data=r_data

	if not (isnull(return_data) or return_data="") then
		return_data=replace(return_data,chr(38),"&#38;")	 '&
		return_data=replace(return_data,chr(34),"&#34;")	 '"
		return_data=replace(return_data,chr(34),"&#39;")	 ''
	end if

	quotation_data=return_data
end function


'//##### 정규식 문자열 변환 : replace 대소문자 구분 안함
function restring(r_data,r_pattern,r_str)
	if isnull(r_data) then
		regular_expression=false
	else
	    set reg=New RegExp
	    reg.Pattern=r_pattern
	    reg.IgnoreCase=true	'대소문자 구분
	    reg.Global=true
	    restring=reg.Replace(r_data,r_str)	 '-- 치환
	end if
end function


'//##### ASCII → HTML
function encode_data(r_data,r_case)
	dim return_data
	return_data=r_data

	'case 0	: 모든 태그 허용 / 줄바꿈 → <br> 변환
	'case 1	: 일부 태그 차단 / 줄바꿈 → <br> 변환
	'case 2	: 모든 태그 차단 / 줄바꿈 → <br> 변환
	'case 3	: 일부 태그 차단
	'case 4	: 모든 태그 차단

	if not (isnull(return_data) or return_data="") then
		select case r_case
			case 1 , 3
				'<applet><embed><form><frame><iframe><pre><script><server><xmp> 태그 차단
				for each for_item in array("ap","emb","for","fr","if","pr","sc","ser","x")
					return_data=restring(return_data,"<"&for_item,"&lt;"&for_item)
					return_data=restring(return_data,"</"&for_item,"&lt;/"&for_item)
				next
			case 2 , 4
				return_data=server.htmlencode(return_data)
		end select

		if r_case<3 then
			return_data=replace(return_data,chr(13)&chr(10),"<br>")
		end if
	end if

	encode_data=return_data
end function


'//##### 라디오 버튼 값 : on → 1
function radio_data(r_data)
	dim return_data
	return_data=r_data

	if return_data="on" then
		return_data=1
	else
		return_data=2
	end if

	radio_data=return_data
end function


'//##### 문자열 바이트 계산
function string_bytes(r_data)
	dim return_data, return_char
	return_data=0

	if isnull(r_data)=false then
		for i=1 to len(r_data)
			return_char=mid(r_data,i,1)

			if not (asc(return_char)>0) and (asc(return_char)<=127) then
				return_data=return_data+1
			end if

			return_data=return_data+1
		next
	end if

	string_bytes=return_data
end function


'//##### 파일 확장자 추출 (파일업로드)
function file_extension(r_data)
	dim return_data
	return_data=r_data

	if instrrev(return_data,".") then
		r_extension_start=instrrev(return_data,".")
		r_extension_end=len(return_data)
		r_extension_length=r_extension_end - r_extension_start +1

		return_data=mid(return_data,r_extension_start,r_extension_length)
		return_data=lcase(return_data)
	end if

	file_extension=return_data
end function


'//##### 값없음 : "" → 0
function zero_data(r_data)
	dim return_data
	return_data=r_data

	if isnull(return_data) or isnumeric(return_data)=false then
		return_data=0
	else
		return_data=int(return_data)
	end if

	zero_data=return_data
end function


'//##### 값없음 : "" → 0
function zero_decimal(r_data)
	dim return_data
	return_data=r_data

	if isnull(return_data) or isnumeric(return_data)=false then
		return_data=0
	else
		return_data=round(return_data,1)
	end if

	zero_decimal=return_data
end function


'//##### 값없음 → ""
function empty_data(r_data)
	dim return_data
	return_data=r_data

	return_data=trim(return_data)

	if isnull(return_data) or return_data="" or return_data="0" then
		return_data=""
	end if

	empty_data=return_data
end function


'//##### 숫자값 픽스 : 5 → 0005
function display_num(r_data,r_floor)
	dim return_data
	return_data=r_data

	if len(return_data)<r_floor then
		for for_count=1 to r_floor - len(return_data)
			return_data="0" & return_data
		next
	end if

	display_num=return_data
end function


'//##### 날짜표시
function display_date(r_data,r_date,r_time)
	dim return_data, return_date, return_time
	return_data=r_data

	if isdate(return_data) then
		r_data_year=year(return_data)

		r_data_month=month(return_data)
		r_data_day=day(return_data)
		r_data_hour=hour(return_data)
		r_data_minute=minute(return_data)
		r_data_second=second(return_data)

		r_data_month=display_num(r_data_month,2)
		r_data_day=display_num(r_data_day,2)
		r_data_hour=display_num(r_data_hour,2)
		r_data_minute=display_num(r_data_minute,2)
		r_data_second=display_num(r_data_second,2)

		select case r_date
			case 1	'// 080707
				return_date=right(r_data_year,2) & r_data_month & r_data_day
			case 2	'// 20080707
				return_date=r_data_year & r_data_month & r_data_day
			case 3	'// 08.07.07
				return_date=right(r_data_year,2) & "." & r_data_month & "." & r_data_day
			case 4	'// 2008.07.07
				return_date=r_data_year & "." & r_data_month & "." & r_data_day
			case 5	'// 08년07월07일
				return_date=right(r_data_year,2) & "년" & r_data_month & "월" & r_data_day & "일"
			case 6	'// 2008년07월07일
				return_date=r_data_year & "년" & r_data_month & "월" & r_data_day & "일"
		end select

		select case r_time
			case 1	'// 17:40
				return_time=r_data_hour & ":" & r_data_minute
			case 2	'// 17:40:27
				return_time=r_data_hour & ":" & r_data_minute & ":" & r_data_second
			case 3	'// (17:40)
				return_time="(" & r_data_hour & ":" & r_data_minute & ")"
			case 4	'// (17:40:27)
				return_time="(" & r_data_hour & ":" & r_data_minute & ":" & r_data_second & ")"
			case 5	'// 17시40분
				return_time=r_data_hour & "시" & r_data_minute & "분"
			case 6	'// 17시40분27초
				return_time=r_data_hour & "시" & r_data_minute & "분" & r_data_second & "초"
		end select
	end if

	return_data=return_date & " " & return_time
	display_date=trim(return_data)
end function


'//##### 날짜 초 환산
function code_date()
	dim return_data

	return_data=datediff("s", 1970-1-1, now())
	return_data=return_data + (9*60*60)

	code_date=return_data
end function


'HTML Encode
function HTML_encode(r_data)
	dim return_data
	return_data=r_data

	if not (isnull(return_data) or return_data="") then
		return_data=server.htmlencode(return_data)
	end if

	HTML_encode=return_data
end function


'HTML Decode
function HTML_decode(r_data)
	dim return_data
	return_data=r_data

	dim I

	return_data=replace(return_data,"&quot;",chr(34))
	return_data=replace(return_data,"&lt;",chr(60))
	return_data=replace(return_data,"&gt;",chr(62))
	return_data=replace(return_data,"&amp;",chr(38))
	return_data=replace(return_data,"&nbsp;",chr(32))

	for I=1 to 255
		return_data=replace(return_data,"&#" & I & ";",chr(I))
	next

	HTML_decode=return_data
end function


'URL Encode
function URL_encode(r_data)
	dim return_data
	return_data=r_data

	if not (isnull(return_data) or return_data="") then
		return_data=server.urlencode(return_data)
	end if

	URL_encode=return_data
end function


'URL Decode
function URL_decode(r_data)
	dim return_data
	return_data=r_data

	dim aSplit
	dim sOutput
	dim I

	if isnull(return_data) then
		URL_decode=""
		exit function
	end if

	sOutput=replace(return_data,"+"," ")

	aSplit=Split(sOutput,"%")

	if isarray(aSplit) then
		sOutput=aSplit(0)

		for I=0 to ubound(aSplit) - 1
			sOutput=sOutput & chr("&H" & left(aSplit(i+1),2)) & right(aSplit(i+1), len(aSplit(i+1))-2)
		next
	end if

	URL_decode=sOutput
end function















' 추가 ------------------------------------------------------------------------------------------------------
'//##### 아이피 문자열
function display_ip(r_data)
	dim return_data
	return_data=""

	if not (isnull(r_data) or r_data="") then
		for each for_item in split(r_data,".")
			return_data=return_data & display_num(for_item,3)
		next
	end if

	display_ip=return_data
end function


'//##### 썸네일 이미지 사이즈
function image_size(r_width,r_height,org_width,org_height)
	dim return_data
	return_data=""

	if not (r_width=0 or r_height=0 or org_width=0 or org_height=0) then
		if org_width/org_height > r_width/r_height then	'너비가 클때 - 높이에 맞춤
			if r_width > org_width then
				return_data=" width=" & org_width
			else
				return_data=" width=" & r_width
			end if
		else																'높이가 클때 - 너비에 맞춤
			if r_height > org_height then
				return_data=" height=" & org_height
			else
				return_data=" height=" & r_height
			end if
		end if
	end if

	image_size=return_data
end function

'//##### 썸네일 이미지 사이즈
function image_position(r_width,r_height,org_width,org_height)
	dim return_data
	return_data=""

	if not (r_width=0 or r_height=0 or org_width=0 or org_height=0) then
		if org_width/org_height > r_width/r_height then	'너비가 클때 - 높이에 맞춤
			if r_width > org_width then
				return_data="top:-" & int((org_width / r_width * r_height - org_height) / 2) & "px;"
			else
				return_data="top:" & int((org_height - r_height) / 2) & "px; left:" & int((org_width - r_width) / 2) & "px;"
			end if
		else																'높이가 클때 - 너비에 맞춤
			if r_height > org_height then
				return_data="left:-" & int((org_height / r_height * r_width - org_width) / 2) & "px;"
			else
				return_data="top:" & int((org_height - r_height) / 2) & "px; left:" & int((org_width - r_width) / 2) & "px;"
			end if
		end if
	end if

	image_position=return_data
end function
%>
