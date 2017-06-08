<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script>
var authMap;
$.ajax({
	type: "post",
	url: "<c:url value='/urtown/admin/userauth/getUserAuth.do'/>",
	data: {
		'AREA_GB': "${userStore.areaId}",
		'USER_NO': "${userStore.userseq}",
		'MENU_ID': "${menuId}"
	},
	async: false, //동기 방식
	success: function(data, status){
		console.log('/urtown/admin/userauth/getUserAuth.do');
		authMap = data.result;
	},
	fail: function(e){
		console.log(e);
	},
	complete: function(){}
});


var userType = "${userStore.userType}";
var elderUrl;
var userId = "${userStore.username}";
var userNm  = "${userStore.fullname}";
var userGrd = "${userStore.userType}";
var userArea  = "${userStore.townId}";
var temp;

userArea = userArea.substring(5);

if(userGrd == "5100000000"){ 
	userGrd = "07";		//사무장
}else if(userGrd == "5111000000"){
	userGrd = "04";		//마을이장
}else if(userGrd == "5112000000"){ 
	userGrd = "06";		//추진위원장
	
}

function invokeUserAuth(e, eType, authType) {
	console.log('auth: ' + authMap);
	console.log('menuId: ' + "${menuId}");
	console.log('etype: ' + eType);
	console.log('authType: ' + authType);
	
	
	switch(eType) {
		case 'kendoEditor':
			if(authMap.AUTH_C == 'false' && authType.toUpperCase() == 'C') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			if(authMap.AUTH_U == 'false' && authType.toUpperCase() == 'U') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			if(authMap.AUTH_D == 'false' && authType.toUpperCase() == 'D') {
				$(e.data().kendoEditor.body).attr('contenteditable', false);
			}
			break;
		case 'kendoButton':
			if(typeof authMap != "undefined" && authMap.AUTH_C == 'false' && authType.toUpperCase() == 'C') {
				e.remove();
			}
			if(typeof authMap != "undefined" && authMap.AUTH_U == 'false' && authType.toUpperCase() == 'U') {
				e.remove();
			}
			if(typeof authMap != "undefined" && authMap.AUTH_D == 'false' && authType.toUpperCase() == 'D') {
				e.remove();
			}
			break;
		case 'kendoGrid':
			setTimeout(function() {
				if(authMap.AUTH_C == 'false') {
					e.find(".k-grid-add").remove();
				}
				if(authMap.AUTH_U == 'false') {
					e.find(".k-grid-edit").remove();
					e.find(".k-grid-save-changes").remove();
					e.find(".k-grid-cancel-changes").remove();
				}
				if(authMap.AUTH_D == 'false') {
					e.find(".k-grid-delete").remove();
				}
			}, 500);

			break;
				
	}
}


</script>      
