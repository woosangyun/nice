<%
Dim page_gb
page_gb=Request("gb")
Dim off_image1,off_image2,off_image3,off_image4,off_image5,off_image6,off_image7,off_image8,off_image9,off_image10,off_image11,off_image12,off_image13,off_image14,off_image15,off_image16,off_image17,off_image18,off_image19,off_image20,off_image21, off_image22
off_image1="sub_navi_01"
off_image2="sub_navi_02"
off_image3="sub_navi_03"
off_image4="sub_navi_04"
off_image5="sub_navi_05"
off_image6="sub_navi_08"
off_image7="sub_navi_06"
off_image8="sub_navi_07"
off_image9="sub_navi_09"
off_image10="sn_01"
off_image11="sn_02"
off_image12="sn_03"
off_image13="sub_navi_10"
off_image14="sub_navi_11"
off_image15="sub_navi_12"
off_image16="sub_navi_13"
off_image17="sub_navi_14"
off_image18="sub_navi_15"
off_image19="sub_navi_16"
off_image20="sub_navi_17"
off_image21="sub_navi_18"
off_image22="sub_navi_19"


Dim on_image1,on_image2,on_image3,on_image4,on_image5,on_image6,on_image7,on_image8,on_image9,on_image10,on_image11,on_image12,on_image13,on_image14,on_image15,on_image16,on_image17,on_image18,on_image19,on_image20,on_image21,on_image22
on_image1="sub_navi_01_ov"
on_image2="sub_navi_02_ov"
on_image3="sub_navi_03_ov"
on_image4="sub_navi_04_ov"
on_image5="sub_navi_05_ov"
on_image6="sub_navi_08_ov"
on_image7="sub_navi_06_ov"
on_image8="sub_navi_07_ov"
on_image9="sub_navi_09_ov"
on_image10="sn_01_over"
on_image11="sn_02_over"
on_image12="sn_03_over"
on_image13="sub_navi_10_ov"
on_image14="sub_navi_11_ov"
on_image15="sub_navi_12_ov"
on_image16="sub_navi_13_ov"
on_image17="sub_navi_14_ov"
on_image18="sub_navi_15_ov"
on_image19="sub_navi_16_ov"
on_image20="sub_navi_17_ov"
on_image21="sub_navi_18_ov"
on_image22="sub_navi_19_ov"

If page_gb="finan" Then
	off_image1="sub_navi_01_ov"
ElseIf page_gb="notice" Then
	off_image2="sub_navi_02_ov"
ElseIf page_gb="ir" Then
	off_image3="sub_navi_03_ov"
ElseIf page_gb="news_01" Then
	off_image4="sub_navi_04_ov"
ElseIf page_gb="news_02" Then
	off_image5="sub_navi_05_ov"
ElseIf page_gb="agency" Then
	off_image6="sub_navi_08_ov"
ElseIf page_gb="kor_qna" Then
	off_image7="sub_navi_06_ov"
ElseIf page_gb="propose" Then
	off_image8="sub_navi_07_ov"
ElseIf page_gb="pop" Then
	off_image9="sub_navi_09_ov"
ElseIf page_gb="org" Then
	off_image10="sn_01_over"
ElseIf page_gb="product" Then
	off_image11="sn_02_over"
ElseIf page_gb="cal" Then
	off_image12="sn_03_over"
ElseIf page_gb="eng_press" Then
	off_image13="sub_navi_10_ov"
ElseIf page_gb="eng_news" Then
	off_image14="sub_navi_11_ov"
ElseIf page_gb="eng_qna" Then
	off_image15="sub_navi_12_ov"
ElseIf page_gb="product2" Then
	off_image16="sub_navi_13_ov"
ElseIf page_gb="juju" Then
	off_image17="sub_navi_14_ov"
ElseIf page_gb="pds" Then
	off_image18="sub_navi_15_ov"
ElseIf page_gb="agreement" Then
	off_image19="sub_navi_16_ov"
ElseIf page_gb="faq" Then
	off_image20="sub_navi_17_ov"
ElseIf page_gb="recruit" Then
	off_image21="sub_navi_18_ov"
ElseIf page_gb="ir_eng" Then
	off_image22="sub_navi_19_ov"
End If
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
	<tr><td><img src="img/main_visual_02.gif" width="181" height="76"></td>
	</tr>
	<tr><td height="19" bgcolor="#38393A" valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td width="10" height="14">&nbsp;</td>
				<td height="14"><b><font color="#FFFFFF">= Korean =</font></b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td bgcolor="#FFFFFF" height="100%" valign="top"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
			<tr><td><a href="agreement_list.asp?gb=agreement" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','img/<%=on_image19%>.gif',1)"><img name="Image19" border="0" src="img/<%=off_image19%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="ir_list.asp?gb=ir" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','img/<%=on_image3%>.gif',1)"><img name="Image7" border="0" src="img/<%=off_image3%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="product_list.asp?gb=product" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','img/<%=on_image11%>.gif',1)"><img name="Image15" border="0" src="img/<%=off_image11%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="agency_list.asp?gb=agency" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','img/<%=on_image6%>.gif',1)"><img name="Image12" border="0" src="img/<%=off_image6%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="faq_list.asp?gb=faq" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','img/<%=on_image20%>.gif',1)"><img name="Image20" border="0" src="img/<%=off_image20%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="recruit_list.asp?gb=recruit" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','img/<%=on_image21%>.gif',1)"><img name="Image21" border="0" src="img/<%=off_image21%>.gif" width="181" height="30"></a></td>
			</tr>

			<!--
			<tr><td><a href="financial.asp?gb=finan" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','img/<%=on_image1%>.gif',1)"><img name="Image5" border="0" src="img/<%=off_image1%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="notice.asp?gb=notice" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','img/<%=on_image2%>.gif',1)"><img name="Image6" border="0" src="img/<%=off_image2%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="news_01.asp?gb=news_01" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','img/<%=on_image4%>.gif',1)"><img name="Image8" border="0" src="img/<%=off_image4%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="news_02.asp?gb=news_02" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','img/<%=on_image5%>.gif',1)"><img name="Image9" border="0" src="img/<%=off_image5%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="qna.asp?gb=kor_qna" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','img/<%=on_image7%>.gif',1)"><img name="Image10" border="0" src="img/<%=off_image7%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="pds.asp?gb=pds" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image18','','img/<%=on_image18%>.gif',1)"><img name="Image18" border="0" src="img/<%=off_image18%>.gif" width="181" height="30"></a></td>
			</tr>			
			<tr><td><a href="proposal.asp?gb=propose" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','img/<%=on_image8%>.gif',1)"><img name="Image11" border="0" src="img/<%=off_image8%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="popup.asp?gb=pop" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','img/<%=on_image9%>.gif',1)"><img name="Image13" border="0" src="img/<%=off_image9%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="organization_list.asp?gb=org" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','img/<%=on_image10%>.gif',1)"><img name="Image14" border="0" src="img/<%=off_image10%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="callcenter_list.asp?gb=cal" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','img/<%=on_image12%>.gif',1)"><img name="Image16" border="0" src="img/<%=off_image12%>.gif" width="181" height="30"></a></td>
			</tr>
			<tr><td><a href="juju_list.asp?gb=juju" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image17','','img/<%=on_image17%>.gif',1)"><img name="Image17" border="0" src="img/<%=off_image17%>.gif" width="181" height="30"></a></td>
			</tr>
			-->





			<tr><td height="15" background="img/main_bg_03.gif">&nbsp;</td>
			</tr>
			<tr><td background="img/main_bg_03.gif">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr><td bgcolor="#38393A" height="19" valign="bottom"> 
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr><td width="10">&nbsp;</td>
								<td height="15"><b><font color="#FFFFFF">= English =</font></b></td>
							</tr>
						</table>
						</td>
					</tr>

					<!--
					<tr><td><a href="eng_news_01.asp?gb=eng_press" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','img/<%=on_image13%>.gif',1)"><img name="Image21" border="0" src="img/<%=off_image13%>.gif" width="181" height="30"></a></td>
					</tr>
					<tr><td><a href="eng_news_02.asp?gb=eng_news" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','img/<%=on_image14%>.gif',1)"><img name="Image19" border="0" src="img/<%=off_image14%>.gif" width="181" height="30"></a></td>
					</tr>
					<tr><td><a href="eng_qna.asp?gb=eng_qna" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image201','','img/<%=on_image15%>.gif',1)"><img name="Image201" border="0" src="img/<%=off_image15%>.gif" width="181" height="30"></a></td>
					</tr>
					-->

					<tr><td><a href="product2_list.asp?gb=product2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image203','','img/<%=on_image16%>.gif',1)"><img name="Image203" border="0" src="img/<%=off_image16%>.gif" width="181" height="30"></a></td>
					</tr>
					<tr>
						<td>
						<a href="ir_eng_elist.asp?gb=ir_eng" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','img/<%=on_image22%>.gif',1)">
							<img name="Image22" border="0" src="img/<%=off_image22%>.gif" width="181" height="30">
						</a>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr><td height="100%" background="img/main_bg_03.gif">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>