<!-- #include file="../common/include_common.asp" -->
<!-- #include file="../common/include_config.asp" -->
<!-- #include file="../common/include_function.asp" -->
<!-- #include file="../common/include_procedure.asp" -->

<!-- #include file="../config/adovbs.inc" -->
<!-- #include file="../config/db_config.asp" -->

<!-- #include file="include/admin_check.asp" -->
<!-- #include file="include/admin_layout.asp" -->

<% call html_top() %>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
      $('table.admin tbody tr').hover(
        function () {
          this.style.background = '#f7f9fc';
        },
        function () {
          this.style.background = '';
        }
      );
      $('#toggle').click(function () {
        this.checked = true;
        $(':checkbox[name=id]').each(function () {
          this.checked = !this.checked;
        });
      });
    });
	
	function Save(){
		//var s_name = $("#sales_url");
		var corder =  $("input[name=c_order]").length;
		var ccategory =  $("input[name=c_category]").length;

		if(corder == 0 ){
			alert('순번을 입력해주세요.');
			return;
		}else{
			for(i=0;i<corder;i++){
				if($("input[name=c_order]").eq(i).attr("value") == ""){
					alert((i+1) +'번째 순번을 입력해주세요.');
					return;
				}
				if($("input[name=c_category]").eq(i).attr("value") == ""){
					alert((i+1) +'번째 카테고리를 입력해주세요.');
					return;
				}
			}
		}
		//alert($("input[name=c_order]").val());
		$("#cnt").val(corder);
		$("#f1").submit();
	}
	
	function AddRows(act) { 
		var TABLE = $("#stable tbody"), LASTROW = TABLE.find("tr:last-child"); act == "add" ? TABLE.append(LASTROW.clone()) : LASTROW.remove(); 
	}
	
	function AddRows2(){
		var num = Number($("#salsesnum").val());
		var html='';
		
		num++;
		html += '<tr name="salesdata_'+num+'">\n';
		html += '<td align="center" align="center"><input type="text" id="c_order'+num+'" name="c_order" size="5"  /></td>\n';
		html += '	<input type="hidden" id="sales_code'+num+'" name="sales_code" value=""  />\n';
		html += '<td align="center" align="center"><input type="text" id="c_category'+num+'" name="c_category" size="80"  /></td>\n';
		//html += '<td align="center" align="center"><span class="button"><a href="javascript:copy_to_clipboard(\'salesdata\', \''+num+'\');"><img src="/gears/resource/typicons/333/pencil.png" alt=""> 수정</a></span></td>\n';
		html += '<td align="center" align="center"><button type="button" onclick="Remove(\'salesdata\', \''+num+'\');" class="remove">삭제</button>\n';
		html += '</tr>\n';

		$("#salsesnum").val(num);
		//$("#expdata").find("tr[name*='expdata']").remove();
		$("#salesdata").append(html).fadeIn(300);
	}
	
	function Remove(name, num){
		//if(confirm("해당 영역을 삭제하시겠습니까?")) {
			$("#"+name).find("tr[name='"+name+"_"+num+"']").remove();
			if($("#"+name).find("tr[name*='"+name+"']").length ==0) $("#"+name+"num").val('0');
		//} else return;
	}
	
	function makeid(name, num)
	{
		var text = "";
		var url="http://www.sunhada.com?sales=";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		for( var i=0; i < 5; i++ )
			text += possible.charAt(Math.floor(Math.random() * possible.length));

		//return text;
		$("#sales_code"+num).val(text);
		$("#sales_url"+num).val(url+text);
	}
	
	function copy_to_clipboard(name,num) {
	  var copyText = document.getElementById("sales_url"+num);
	  copyText.select();
	  document.execCommand("Copy");
	  alert('복사되었습니다.');
	}
	
	function slist(){
		document.location.href = 'mngr_sales.asp';
	}

</script>
<style>
.myButton {
	box-shadow: 0px 10px 14px -7px #276873;
	background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
	background-color:#599bb3;
	border-radius:8px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:20px;
	font-weight:bold;
	padding:13px 32px;
	text-decoration:none;
	text-shadow:0px 1px 0px #3d768a;
}
.myButton:hover {
	background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
	background-color:#408c99;
}
.myButton:active {
	position:relative;
	top:1px;
}
</style> 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<td height="294" valign="top">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
 <td>
  <h3 class="admin">카테고리 관리</h3>
  <form name="f1" id="f1" action="category_ok.asp" method="post">
  <input type="hidden" id="cnt" name="cnt" />
    <div class="search1">
		<button type="button" class="sort" onclick="AddRows2();">
			카테고리 생성
		</button>
		<button type="button" class="sort" onclick="Save();">
			저장
		</button>
    </div>
    <table id="stable" class="deco admin" width="1000" cellspacing="0" cellpadding="4" style="table-layout:auto;">
      <thead>
      <tr height="30" style="font-size:13px; background:#E6E4E0">
		<th width="100">순서</th>
		<th width="350">카테고리명(국문)</th>
		<th width="350">카테고리명(영문)</th>
        <th width="200">삭제</th>
      </tr>
      </thead>
      <tbody id="salesdata">
	  <%
			Dim num : num = 0
			sql="select"
			sql=sql & "		idx, c_category, c_category_eng, c_order"
			sql=sql & " from nc_category order by c_order asc "

			set cmd=server.createobject("adodb.command")
			cmd.activeconnection=lo_DbCon
			cmd.commandtext=sql
			cmd.commandtype=adCmdText
			cmd.prepared=true

			set rs=cmd.execute
				if not rs.eof or rs.bof then
					do until rs.eof
					idx=rs("idx")
					c_category=rs("c_category")
					c_category_eng=rs("c_category_eng")
					c_order=rs("c_order")
		%>
      <tr name="salesdata_<%=idx%>">      
		<input type="hidden" id="sales_code" name="sales_code" value=""  />
        <td align="center" align="center">
			<input type="text" id="c_order<%= idx %>" name="c_order" size="5" value="<%=c_order%>" />
		</td>
		<td align="center" align="center">
			<input type="text" id="c_category<%= idx %>" name="c_category" size="50" value="<%=c_category%>" />
		</td>
		<td align="center" align="center">
			<input type="text" id="c_category_eng<%= idx %>" name="c_category_eng" size="50" value="<%=c_category_eng%>" />
		</td>
		<!--
		<td align="center" align="center">
			<span class="button"><a href="javascript:copy_to_clipboard('salesdata', '<%= idx %>');"><img src="/gears/resource/typicons/333/pencil.png" alt=""> 수정</a></span>
		</td>
		-->
        <td align="center" align="center">
			<button type="button" class="" onclick="Remove('salesdata', '<%= idx %>');">삭제</button>
        </td>
      </tr>
	 <%
					num=num-1
					rs.movenext
				loop
			end if
		set rs=nothing
		set cmd=nothing
	%>
      </tbody>
    </table>
	<input type="hidden" id="salsesnum" name="salsesnum" value="<%=num%>" />
  </form>
 </td>
 </tr>
</table>
</table>
<% call html_bottom() %>


<!-- #include file="../config/db_close.asp" -->
