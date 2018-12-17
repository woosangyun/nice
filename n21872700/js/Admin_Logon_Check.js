<!--

function AdminLoginCheck(){	
	var f = document.frmAdminLogon;
	// 아이디 입력여부 확인
	if(!f.id.value){
		alert("아이디를 입력하세요!");
		f.id.focus();
		return;
	}
	// 비밀번호 입력여부 확인
	if(!f.pwd.value){
		alert("비밀번호를 입력하세요!");
		f.pwd.focus();
		return;
	}

	f.method = "post";
	f.action = "./bin/isAdmin.asp";
	f.submit();
}
function Default_Focus(){
	var f = document.frmAdminLogon;
	f.id.focus();
}
//-->