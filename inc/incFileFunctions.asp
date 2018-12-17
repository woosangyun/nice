<%

	'==============================================================================================================
	' 	NAME		: getReadTextFile
	'	Description 	: 텍스트 기반 파일 읽어오기 함수
	'	INPUT		: 로컬 파일 경로(예: C:\sample.txt)
	'	OUTPUT		: 파일 객체
	'--------------------------------------------------------------------------------------------------------------
	
		Function getReadTextFile(paramFilePath)
			Dim fnFSO, fnFilePath, objFile
				
			' 파일 객체 선언
			Set fnFSO = Server.CreateObject("Scripting.FileSystemObject")
		
			' 로컬 파일 경로 설정
			fnFilePath = Server.MapPath(paramFilePath)
			objFile 	= ""
		
			' 로컬 파일이 존재하는 경우
			If fnFSO.FileExists(fnFilePath) Then
				' 파일 내용 전체 읽어오기
				objFile = fnFSO.OpenTextFile(fnFilePath).ReadAll()
				
				' 파일 닫기
				'fnFSO.Close
			End If
		
			getReadTextFile = objFile
		
			Set fnFSO = Nothing
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getFileNo
	'	Description 	: 파일번호 가져오기
	'	INPUT		: 
	'					paramLocalPath
	'					paramFileName
	'	OUTPUT		: 유일한 파일명 스트링
	'--------------------------------------------------------------------------------------------------------------
	
		Function getFileNo()
			Dim strFileNo
	
			strFileNo = ""
	
			strFileNo = strFileNo & YEAR(NOW)
			strFileNo = strFileNo & Right("0" & MONTH(NOW), 2)
			strFileNo = strFileNo & Right("0" & DAY(NOW), 2)
			strFileNo = strFileNo & Right("0" & HOUR(NOW), 2)
			strFileNo = strFileNo & Right("0" & MINUTE(NOW), 2)
			strFileNo = strFileNo & Right("0" & SECOND(NOW), 2)
			strFileNo = strFileNo & Right("0000000000" & Session.SessionID, 10)
			
			' 파일번호 리턴
			getFileNo = strFileNo
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getUniqueFileName
	'	Description 	: 유일한 파일명 가져오기
	'	INPUT		: 
	'					paramLocalPath
	'					paramFileName
	'	OUTPUT		: 유일한 파일명 스트링
	'--------------------------------------------------------------------------------------------------------------
	
		Function getUniqueFileName(paramLocalPath, paramFileName)
			Dim oFSO
			Dim strFileName
			Dim strFileExt
			Dim strFilePath
			Dim bolFileExist
			Dim intFileNo
			Dim newFileName
			
			Set oFSO 		= Server.CreateObject("Scripting.FileSystemObject")
			
			bolFileExist	= True
			intFileNo		= 1
			
			strFilePath	= paramLocalPath & paramFileName
			newFileName	= paramFileName
			
	
			' 파일명 중복시 새로운 파일명 생성
			If oFSO.FileExists(strFilePath) Then
				' 파일 이름과 확장자 분리
			       strFileName 	= Mid(paramFileName, 1, InstrRev(paramFileName, ".") - 1)
			       strFileExt  		= Mid(paramFileName, InstrRev(paramFileName, ".") + 1)

				Do While (bolFileExist)
					strFilePath 	= paramLocalPath & strFileName & "(" & intFileNo & ")." & strFileExt
					
					If Not(oFSO.FileExists(strFilePath)) Then 
						bolFileExist 	= False
						newFileName 	= strFileName & "(" & intFileNo & ")." & strFileExt
						
						Exit Do 
					End If
					
					intFileNo = intFileNo + 1
				Loop 
			End If
			
			' 유일한 파일명 리턴
			getUniqueFileName = newFileName
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getImageSize
	'	Description 	: 최대 이미지 크기 가져오기
	'	INPUT		: 
	'					intMaxWidth
	'					intMaxHeight
	'					intWidth
	'					intHeight
	'	OUTPUT		: 파일 사이즈 정보 스트링
	'--------------------------------------------------------------------------------------------------------------
	
		Function getImageSize(intMaxWidth, intMaxHeight, intWidth, intHeight)
			Dim newWidth
			Dim newHeight
			Dim intRate
			Dim str_ImageSize
			
			intRate			= 0.0
			str_ImageSize		= ""
			
			intMaxWidth		= CInt(intMaxWidth)
			intMaxHeight		= CInt(intMaxHeight)
			intWidth			= CInt(intWidth)
			intHeight			= CInt(intHeight)

			' 이미지 유형 체크
			' 가로형 이미지인 경우
			If(intWidth > intHeight) Then
				' 최대 가로 크기보다 큰 경우
				If(intWidth > intMaxWidth) Then
					intRate 		= intMaxWidth / intWidth
					
					newWidth 	= intMaxWidth
					newHeight 	= CInt(intHeight * intRate)
	
				' 최대 높이보다 큰 경우
				ElseIf(newHeight > intMaxHeight) Then
					intRate 		= intMaxHeight / newHeight
					
					newWidth 	= CInt(newWidth * intRate)
					newHeight 	= intMaxHeight
					
				Else
					newWidth 	= intWidth
					newHeight 	= intHeight
				End If
				
			' 세로형 이미지인 경우
			ElseIf(intHeight > intWidth) Then
				' 최대 높이보다 큰 경우
				If(newHeight > intMaxHeight) Then
					intRate 		= intMaxHeight / newHeight
					
					newWidth 	= CInt(newWidth * intRate)
					newHeight 	= intMaxHeight
					
				' 최대 가로 크기보다 큰 경우
				ElseIf(intWidth > intMaxWidth) Then
					intRate 		= intMaxWidth / intWidth
					
					newWidth 	= intMaxWidth
					newHeight 	= CInt(intHeight * intRate)

				Else
					newWidth 	= intWidth
					newHeight 	= intHeight
				End If
				
			Else
				newWidth 	= intWidth
				newHeight 	= intHeight
			End If
			
			' 이미지 태그 속성 문자열 생성
			str_ImageSize = " width = '" & newWidth & "' height = '" & newHeight & "' "

			' 이미지 사이즈 리턴
			getImageSize = str_ImageSize
		End Function
	
	'==============================================================================================================



%> 
