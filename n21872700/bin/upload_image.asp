<!-- #include file="../../common/include_common.asp" -->
<!-- #include file="../../common/include_config.asp" -->
<!-- #include file="../../common/include_function.asp" -->
<!-- #include file="../../common/include_procedure.asp" -->

<!-- #include file="../../config/adovbs.inc" -->
<!-- #include file="../../config/db_config.asp" -->

<!-- #include file="../include/admin_check.asp" -->


<%
If request("mode")="up" then	
	set dx=server.createobject("DEXT.FileUpload")	
	dx.AutoMakeFolder=true
	dx.defaultpath=upload_real
	dx.codepage=65001

	img_realpath=upload_real & "\editor"
'	img_virtualpath=upload_virtual & "/editor"
	img_virtualpath="../upload/editor"
	img_localpath=dx("upimage")

	img_name=dx("upimage").filename
	img_size=dx("upimage").filelen

	if img_size>1024*1024*10 then		'10MB
		response.write "<script>"
		response.write "	alert('이미지 크기 오류입니다!');"
		response.write "	history.back();"
		response.write "</script>"
		Response.End
		response.end
	end if

	If img_name<>"" and img_size > 0 then
		'img_alt=img_name
		img_align=dx("align")
		'img_border=dx("border")
		img_border=0
	
		If dx("width")="" or dx("width")="0" then
			img_width=dx("upimage").imagewidth
		else
			img_width=dx("width")
		end If
		
		If dx("height")="" or dx("height")="0" then
			img_height=dx("upimage").imageheight
		else
			img_height=dx("height")
		end If

		img_name=display_ip(current_ip) & code_date() & file_extension(img_name)

		server_name=request.servervariables("SERVER_NAME")
		server_port=request.servervariables("SERVER_PORT")

'		img_path="http://" & server_name & ":" & server_port & img_virtualpath & "/" & img_name
		img_path=img_virtualpath & "/" & img_name

		dx("upimage").saveas img_realpath & "\" & img_name
		
		set dx=nothing 
		
		If err then
			response.write "<script>"
			response.write "	alert('이미지 첨부 오류입니다!');"
			response.write "	history.back();"
			response.write "</script>"
			Response.End
		else
			response.write "<script>"
			response.write "	var str = ""<img src='" & img_path & "' width='" & img_width &"' height='" & img_height & "' border='" & img_border & "' align='" & img_align & "' alt='" & img_alt & "'>"";"
			response.write "	opener.easyUtil._editor.innerHTML(str);"
			response.write "	self.close();"
			response.write "</script>"
		end If
	end If
end If
%>

<html>
<head>
	<title>이미지 업로드</title>

	<style type="text/css">
		body {
		    background: threedface;
		    color: windowtext;
		    margin: 10px;
		    border-style: none;
		    text-align:center;
		}
		body, button, div, input, select, td, legend	{font: 9pt 돋움}
		input, select		{color: highlight}
		button				{width: 80px}
		fieldset				{margin-bottom: 5px; text-align: left; padding: 5px}
	</style>

	<script language="javascript">
        function sendit(on) {
		    var str="";
		    var src=on.upimage.value;

			if (!src.match(/\.(gif|jpg|bmp|png)$/i)) {
				alert("이미지 파일을 첨부해 주세요!");
				return false;
			}

			document.all.btn_submit.disabled=true;

			on.submit();

			return false;
		}

/*
		function viewImage(on,src) {
		    var str = "";
		    var src=on.upimage.value;

			alert(on.upimage.value);

			if (!src.match(/\.(gif|jpg|bmp|png)$/i)) {
				alert("JPG/GIF/BMP/PNG 파일만 첨부 가능합니다!");
				return false;
			}

			if (window.showModalDialog) {
		        var h_str="";
				var height=0;
				var width=0;
                var img = new Image();
				img.src =src;
		        on.width.value = img.width;
		        on.height.value = img.height;

				if (img.height>150) {
					h_str="150";
				}

				if (h_str) {
					h_str = "height='"+h_str+"'";
				}
		        str="<img src='"+src+"' "+h_str+">";
		    } else {
		        str = "미리보기는 IE만 지원됩니다.";
			}
		    document.getElementById("td_img").innerHTML = str;
		}
*/

//		function ImageViewer() {
			var IMAGE_MAX_WIDTH = 150
			var IMAGE_MAX_HEIGHT = 150;
			var IMAGE_EXTENSION_TYPES=["bmp","jpg","gif","png"];
    
     
			// 업로드하는 사용자의 이미지를 미리보기합니다.
			// inputID : form의 input 태그 아이디입니다.
			// imageID : 입력 화면에 미리보기에 이용할 기본 이미지가 있어야합니다.
			//          (기본이미지와 사용자 업로드 이미지 대체를 통해 미리보기)
    
			function preview(inputID, imageID) {
				var inputField = document.getElementById(inputID);
				var source = inputField.value;
				var ext = source.substring( source.lastIndexOf(".") + 1, source.length ).toLowerCase();
    
				for (var i=0; i<IMAGE_EXTENSION_TYPES.length; i++ ) {
					if ( IMAGE_EXTENSION_TYPES[i] == ext )
					break;
				}
      
				if( i == IMAGE_EXTENSION_TYPES.length ) {
					alert( '지원하지 않는 이미지 형식입니다.\n\n지원 형식 : ' + IMAGE_EXTENSION_TYPES.join(', ') );
					return;
				}
     
    
				// 브라우저 검사하여 실제 이미지 경로 찾기
				var ua = window.navigator.userAgent;
            
				var localImagePath;
            
				if (ua.indexOf("MSIE") > -1) {
					if (source.indexOf("\\fakepath\\") < 0) {
						localImagePath = source;
					} else {
						inputField.select();
						localImagePath = document.selection.createRange().text.toString();
						inputField.blur();
					}
				} else {
					if (ua.indexOf("Firefox/3") > -1) {
						localImagePath = inputField.files.item(0).getAsDataURL();
					} else {
						localImagePath = 'file://' + source;
					}
				}
    
    
				// 이미지 사이즈 조정
				var uploadImage = new Image();
				uploadImage.src = localImagePath;
            
				var x = parseInt(uploadImage.width);
				var y = parseInt(uploadImage.height);


//				alert(uploadImage.fileSize);

				//document.getElementById("width").value=x;
				//document.getElementById("height").value=y;

			
				if (x > IMAGE_MAX_WIDTH) {
					y *= IMAGE_MAX_WIDTH / x;
					x = IMAGE_MAX_WIDTH;
				}
            
				if ( y > IMAGE_MAX_HEIGHT ) {
					x *= IMAGE_MAX_HEIGHT / y;
					y = IMAGE_MAX_HEIGHT;
				}
            
				if( x == 0 || y == 0 ) {
					x = IMAGE_MAX_WIDTH;
					y = IMAGE_MAX_HEIGHT;
				}
    
    
				// 이미지 교체
				var targetImage = document.getElementById(imageID);
				targetImage.style.display = ( x < 1 || y < 1 ) ? 'none' : '';
				targetImage.src = uploadImage.src;
				targetImage.width = x;
				targetImage.height = y;

				sendit(document.getElementById("tform"))
//			} this.preview = preview;
		}
     
//		var imageViewer = new ImageViewer();
	</script>
</head>

<body onload="self.focus()">
<form id="tform" name="tform" method="post" action="upload_image.asp?mode=up" enctype="multipart/form-data" onsubmit="return sendit(this)">

<fieldset style="display:none">
    <legend>미리보기</legend>

	<div style="overflow: hidden; width: 100%; height: 150">
        <table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr>
			<td align="center" style="height:150px" id="td_img">
				  <img id="previewImage" name="previewImage" src="../images/blank.gif" border=1>
			</td>
		</tr>
		</table>
	</div>
</fieldset>

<fieldset>
	<legend>이미지 선택</legend>
	<!--<input type="file" name="upimage" style="width:100%" onchange="viewImage(this.form,this.value)">-->
	<input type="file" id="upimage" name="upimage" style="width:100%" onchange="preview('upimage','previewImage')">
</fieldset>

<fieldset style="display:none">
	<legend>옵션</legend>
	<table border=0 cellspacing=6 cellpadding=0>
	<tr>
		<td>정렬</td>
		<td>
			<select name="align">
				<option value="" selected>없음
				<option value="baseline">기준선</option>
				<option value="top">위쪽</option>
				<option value="middle">가운데</option>
				<option value="bottom">아래쪽</option>
				<option value="texttop">문자열 위쪽</option>
				<option value="absmiddle">선택 영역의 가운데</option>
				<option value="absbottom">선택 영역의 아래쪽</option>
				<option value="left">왼쪽</option>
				<option value="right">오른쪽</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>너비*높이</td>
		<td>
			<input type="text" id="width" name="width" value="" size="4" maxlength="4" onfocus="this.select();"> *
			<input type="text" id="height" name="height" value="" size="4" maxlength="4" onfocus="this.select();"> px
		</td>
	</tr>

	<!--
	<tr>
		<td>테두리</td>
		<td><input type="text" name="border" value="0" size="2" maxlength=2 onfocus="this.select();"> px</td>
	</tr>
	-->

	</table>
</fieldset>

<fieldset style="color:gray; font:8pt dotum; text-align:center; line-height:14px">
	이미지 크기는 1MB 이하로 등록하세요.
	<br>지원하는 이미지는 BMP, JPG, GIF, PNG 입니다.
</fieldset>


<input type="submit" name="btn_submit" value="확인" style="width: 60">

</form>
</body>
</html>


<!-- #include file="../../config/db_close.asp" -->
