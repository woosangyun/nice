<%

	'==============================================================================================================
	' 	NAME		: getReadTextFile
	'	Description 	: �ؽ�Ʈ ��� ���� �о���� �Լ�
	'	INPUT		: ���� ���� ���(��: C:\sample.txt)
	'	OUTPUT		: ���� ��ü
	'--------------------------------------------------------------------------------------------------------------
	
		Function getReadTextFile(paramFilePath)
			Dim fnFSO, fnFilePath, objFile
				
			' ���� ��ü ����
			Set fnFSO = Server.CreateObject("Scripting.FileSystemObject")
		
			' ���� ���� ��� ����
			fnFilePath = Server.MapPath(paramFilePath)
			objFile 	= ""
		
			' ���� ������ �����ϴ� ���
			If fnFSO.FileExists(fnFilePath) Then
				' ���� ���� ��ü �о����
				objFile = fnFSO.OpenTextFile(fnFilePath).ReadAll()
				
				' ���� �ݱ�
				'fnFSO.Close
			End If
		
			getReadTextFile = objFile
		
			Set fnFSO = Nothing
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getFileNo
	'	Description 	: ���Ϲ�ȣ ��������
	'	INPUT		: 
	'					paramLocalPath
	'					paramFileName
	'	OUTPUT		: ������ ���ϸ� ��Ʈ��
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
			
			' ���Ϲ�ȣ ����
			getFileNo = strFileNo
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getUniqueFileName
	'	Description 	: ������ ���ϸ� ��������
	'	INPUT		: 
	'					paramLocalPath
	'					paramFileName
	'	OUTPUT		: ������ ���ϸ� ��Ʈ��
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
			
	
			' ���ϸ� �ߺ��� ���ο� ���ϸ� ����
			If oFSO.FileExists(strFilePath) Then
				' ���� �̸��� Ȯ���� �и�
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
			
			' ������ ���ϸ� ����
			getUniqueFileName = newFileName
		End Function
	
	'==============================================================================================================



	'==============================================================================================================
	' 	NAME		: getImageSize
	'	Description 	: �ִ� �̹��� ũ�� ��������
	'	INPUT		: 
	'					intMaxWidth
	'					intMaxHeight
	'					intWidth
	'					intHeight
	'	OUTPUT		: ���� ������ ���� ��Ʈ��
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

			' �̹��� ���� üũ
			' ������ �̹����� ���
			If(intWidth > intHeight) Then
				' �ִ� ���� ũ�⺸�� ū ���
				If(intWidth > intMaxWidth) Then
					intRate 		= intMaxWidth / intWidth
					
					newWidth 	= intMaxWidth
					newHeight 	= CInt(intHeight * intRate)
	
				' �ִ� ���̺��� ū ���
				ElseIf(newHeight > intMaxHeight) Then
					intRate 		= intMaxHeight / newHeight
					
					newWidth 	= CInt(newWidth * intRate)
					newHeight 	= intMaxHeight
					
				Else
					newWidth 	= intWidth
					newHeight 	= intHeight
				End If
				
			' ������ �̹����� ���
			ElseIf(intHeight > intWidth) Then
				' �ִ� ���̺��� ū ���
				If(newHeight > intMaxHeight) Then
					intRate 		= intMaxHeight / newHeight
					
					newWidth 	= CInt(newWidth * intRate)
					newHeight 	= intMaxHeight
					
				' �ִ� ���� ũ�⺸�� ū ���
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
			
			' �̹��� �±� �Ӽ� ���ڿ� ����
			str_ImageSize = " width = '" & newWidth & "' height = '" & newHeight & "' "

			' �̹��� ������ ����
			getImageSize = str_ImageSize
		End Function
	
	'==============================================================================================================



%> 
