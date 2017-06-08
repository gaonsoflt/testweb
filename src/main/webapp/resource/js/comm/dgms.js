	function fnStrToDateFormat(str){
		if(typeof str != "undefined" && str != null && str.length >=6 ){
			var year = str.substr(0,2);
			var month = str.substr(2,2);
			var day = str.substr(4,2);
			return year+"/"+month+"/"+day;
		}else{
			return str;
		}
	}