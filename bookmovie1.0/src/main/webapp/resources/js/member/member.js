/**
 * 
 */
var member = {
	nochk : function (url) {
	    alert("동의하지 않으면 가입하실 수 없습니다");
	},
	agreeChk : function() {
	    var req = document.form.req.checked;
	    var num = 0;
	    if (req == true) {
	        num = 1;
	    }
	    if (num == 1) {
	        document.form.submit();
	    } else {
	        alert("개인정보 약관에 동의하셔야 합니다.");
	    }
	},
	
	
	searchId : function(url) {
		window.open(
						url,
						"searchId",
						"scrollbars,toolbar=no,location=no,directories=no," +
						"status=no,menubar=yes,resizable=yes,width=600," +
						"height=500,top=200,left=400");
	
	},
	
	searchPass : function(url) {
		window.open(
						url,
						"searchPass",
						"scrollbars,toolbar=no,location=no,directories=no," +
						"status=no,menubar=yes,resizable=yes,width=600,height=500," +
						"top=200,left=400");
	},
	join : function() {
	
		document.frmJoin.submit();
	},
	joinForm : function() {
		
	},
	
	login : function() {
	
		document.frmLogin.submit();
	},
	checkAdmin : function(url) {
		var isAdmin = confirm('관리자 입니까?');
		if(!isAdmin){
			alert('관리자만 접근 가능합니다.');
		}else{
			var password = prompt('관리자 비번을 입력하세요');
			if (password == 1) {
				location.href = url;
			} else {
				alert('관리자 비번이 다릅니다.');
			}
		}
	}
	
}