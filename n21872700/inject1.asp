<%
    Dim array_split_item
    Dim item
    Dim array_counter
    Dim array_sp_counter
    Dim item_position1
    Dim spStr
    Dim array_special_item
    Dim strPosition
    
    array_split_item = Array("%", "\", "+","--", ";", "/*", "*/", "@@variable", "@variable", "char", "nchar", "varchar", "nvarchar", "alter", "begin", "cast", "create", "cursor", "declare", "delete", "drop", "end", "exec","execute", "fetch", "insert", "kill", "open","select", "sys", "sysobjects", "syscolumns","table", "update", "<script", "</script>", "'", ">", "<", "cookie", "document", "print", "set", "union", "openrowset", "declare", "shutdown", "drop", "xp_", "+", "onmouse", "onchange", "onblur", "onfocus", "prompt")
    
    spStr = Request.ServerVariables("QUERY_STRING")
    
    array_special_item = Array("%", "\", "+")
    
    'request시 문제를 일으키는 특수문자는 따로 처리함
    for array_sp_counter = lbound(array_special_item) to ubound(array_special_item)
        strPosition = Instr(spStr, array_special_item(array_sp_counter))
    
        if strPosition > 0 Then %>

                <script>
                    alert("<%="잘못된 값이 입력되었습니다."%>");
                    history.back();
                </script>

<%
            Response.End()
        
        end if
        
    next

    for each item in Request.QueryString

        for array_counter = lbound(array_split_item) to ubound(array_split_item)

            item_position1 = InStr((lcase(Request(item))), array_split_item(array_counter))

            if item_position1 > 0 then             %>

                <script>
                    alert("<%="잘못된 값(" & array_split_item(array_counter) & ")이(가) 입력되었습니다."%>");
                    history.back();
                </script>

<%              Response.End()
            end if

        next

    next

    for each item in Request.Form

        for array_counter = lbound(array_split_item) to ubound(array_split_item)

            item_position1 = InStr(lcase(Request(item)), array_split_item(array_counter))

            'Response.Write(array_split_item(array_counter) & "<BR>")

            if item_position1 > 0 then             %>

                <script>
                    alert("<%="잘못된 값(" & array_split_item(array_counter) & ")이(가) 입력되었습니다."%>");
                    history.back();
                </script>

<%              Response.End()
            end if

        next

    next

%>
