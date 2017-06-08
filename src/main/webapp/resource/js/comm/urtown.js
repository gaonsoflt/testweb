	/*******************************************/
	/* chart */
	/*******************************************/
		
	// chart ajax
	var chartDs; 
	var page = 1;
	var pageSize = 10;

	function ajaxChartDate(userno,chartType) {
	    $.ajax({
	        type:"post",
	        url : "/urtown/chart/user.do",
	        data: {
				'USER_NO': userno,
				'CHART_GBN': chartType,
				'PAGE': page,
				'PAGESIZE': pageSize
			},
			async: false, //동기 방식
			success: function(data, status){
				console.log("/urtown/chart/user.do......................");
				console.log(status);
				console.log(data.rtnList);
				chartDs = data.rtnList;
			},
			fail: function(e){
				console.log(e);
			},
			complete: function(){}
		});
	}
		
	function createChart(type) {
		var plotColor = kendo.parseColor("#ffc0cb");

		console.log('creatChart dataSource');
		console.log(chartDs);
		if(type == 'BLD_PRESS') {
			$("#chart").kendoChart({
				dataSource: { data: chartDs },
				title: { text: "혈압" },
				legend: { position: "top" },
				chartArea: { background: "" },
				seriesDefaults: {
					type: "line",
					labels: {
						visible: true,
						format: "{0}",
						background: "transparent"
					}
				},
				series: [{
					field: "BLOOD_PRES_MIN",
					//axis: "min",
					name: "최저혈압"
				}, {
					field: "BLOOD_PRES_MAX",
					//axis: "max",
					name: "최대혈압"
				}, {
					field: "BLOOD_PRES_PULSE",
					//axis: "pulse",
					name: "맥박수"
				}],
				valueAxis: [{
					labels: { format: "{0}" },
					line: { visible: false },
					majorGridLines: { visible: true }}
				/*{
					name: "min",
				    labels: { format: "{0}C" }
				}, {
				    name: "max",
				    labels: { format: "{0}%" }
			    }, {
			    	name: "pulse",
				    labels: { format: "{0}%" }
			    }*/
			    ],
				categoryAxis: {
					field: "CHECKUP_DT",
					majorGridLines: { visible: false },
					labels: { 
						template: '#: kendo.toString(kendo.parseDate(new Date(Number(value))), "yyyy-MM-dd") #'
//						template: kendo.template("#if(BLOOD_PRES_MIN==0){# #='미사용'# #} else {# #='#: kendo.toString(kendo.parseDate(new Date(Number(value))), 'yyyy-MM-dd') #'# #} #")
					},
					plotBands: [
					    { from: chartDs.length - 1, to: pageSize, color: 'yellow', opacity: 0.05 }
					]
				}
			});
		} else if(type == 'BLD_SUGAR') {
			$("#chart").kendoChart({
				dataSource: { data: chartDs },
				title: { text: "혈중 농도" },
				legend: { position: "top" },
				chartArea: { background: "" },
				seriesDefaults: {
					type: "line",
					labels: {
						visible: true,
						format: "{0}",
						background: "transparent"
					}
				},
				series: [{
					field: "BLOOD_SUGAR",
					name: "혈당"
				}, {
					field: "URIC_ACID",
					name: "요산"
				}, {
					field: "OXGEN",
					name: "산소포화도"
				}],
				valueAxis: {
					labels: { format: "{0}" },
					line: { visible: false },
					majorGridLines: { visible: true },
				},
				categoryAxis: {
					field: "CHECKUP_DT",
					majorGridLines: { visible: false },
					labels: { 
						template: '#: kendo.toString(kendo.parseDate(new Date(Number(value))), "yyyy-MM-dd") #'
					},
					plotBands: [
					    { from: chartDs.length - 1, to: pageSize, color: 'yellow', opacity: 0.05 }
					]
				}
			});
		} 
		
		else if(type == 'CHOLESTEROL') {
			$("#chart").kendoChart({
				dataSource: { data: chartDs },
				title: { text: "콜레스테롤 수치" },
				legend: { position: "top" },
				chartArea: { background: "" },
				seriesDefaults: {
					type: "line",
					labels: {
						visible: true,
						format: "{0}",
						background: "transparent"
					}
				},
				series: [{
					field: "CHOLESTEROL",
					name: "총콜레스테롤"
				}, {
					field: "HDLCHOLESTEROL",
					name: "고밀도콜레스테롤"
				}, {
					field: "LDLCHOLESTEROL",
					name: "저밀도콜레스테롤"
				}, {
					field: "NEUTRAL",
					name: "중성지방"
				}],
				valueAxis: {
					labels: { format: "{0}" },
					line: { visible: false },
					majorGridLines: { visible: true },
				},
				categoryAxis: {
					field: "CHECKUP_DT",
					majorGridLines: { visible: false },
					labels: { 
						template: '#: kendo.toString(kendo.parseDate(new Date(Number(value))), "yyyy-MM-dd") #'
					},
					plotBands: [
					    { from: chartDs.length - 1, to: pageSize, color: 'yellow', opacity: 0.05 }
					]
				}
			});
		}
		else if(type == 'ECG') {
			$("#chart").kendoChart({
				dataSource: { data: chartDs },
				title: { text: "심전도" },
				legend: { position: "top" },
				chartArea: { background: "" },
				seriesDefaults: {
					type: "line",
					labels: {
						visible: true,
						format: "{0}",
						background: "transparent"
					}
				},
				series: [{
					field: "ECG_AVG_HEARTBT",
					name: "평균심박수"
				}, {
					field: "ECG_MIN_HEARTBT",
					name: "최소심박수"
				}, {
					field: "ECG_MAX_HEARTBT",
					name: "최대심박수"
				}, {
					field: "ECG_UNUSUAL_CNT",
					name: "이상심박수"
				}, {
					field: "ECG_BRADY_CNT",
					name: "서맥횟수"
				}, {
					field: "ECG_FREQ_CNT",
					name: "빈맥횟수"
				}],
				valueAxis: {
					labels: { format: "{0}" },
					line: { visible: false },
					majorGridLines: { visible: true },
				},
				categoryAxis: {
					field: "CHECKUP_DT",
					majorGridLines: { visible: false },
					labels: { 
						template: '#: kendo.toString(kendo.parseDate(new Date(Number(value))), "yyyy-MM-dd") #'
					},
					plotBands: [
					    { from: chartDs.length - 1, to: pageSize, color: 'yellow', opacity: 0.05 }
					]
				}
			});
		}
	}
	/*
	function substringAxis(value) {
		//return value.toString().substr(0, 8) + '-' + value.toString().substr(8, 12);
		alert(value);
		return value.toString().substr(0, 8);
	}
	*/
	
	function openChart(type, userno) {
		var _type = [ "BLD_PRESS", "BLD_SUGAR", "CHOLESTEROL", "ECG" ];
		chartWindow.data('kendoWindow').center().open();
		ajaxChartDate(userno,type);
		createChart(_type[type]);
		$("#chart-window").bind("kendo:skinChange", createChart)
	}
	
	function closeChart() {
		chartWindow.data('kendoWindow').close();
	}

	
	
/********************/
/*		이미지회전		*/
/********************/
//p_deg: 앵글각도, canvas: 이미지출력 화면, img: 표시 이미지, img2: 실제이미지

var BTN_ROTATE = 0;
var REAL_ROTATE = 0;
var IMGW = 0, IMGH = 0;

function rotation(p_deg, canvas, img, img2, filePath) {

	var image = document.getElementById(img2);
	var canvasId = "#" + canvas;
	var imgId = "#" + img;
	
	if(document.getElementById(canvas)) {  
		var canvas =document.getElementById(canvas); 
		var ctx = canvas.getContext('2d');  
		
		if(p_deg == 0){
			REAL_ROTATE = 0;
			setTimeout(function(){
				IMGW = image.width;
				IMGH = image.height; 
				if(IMGW > IMGH){ 
					$(imgId).addClass("mh");
				}
				
			}, 500); 
			return;
		}else{
			REAL_ROTATE += p_deg;
		}
		
		if(REAL_ROTATE >= 360){
			REAL_ROTATE = REAL_ROTATE - 360; 
		} 
		
		p_deg = REAL_ROTATE;
		
		$(canvasId).css('display','block');
		$(imgId).css('display','none');

			switch(p_deg) {  
			
			default :  
			
			case 0 :   
				BTN_ROTATE++;
				//$(canvasId).removeClass("mw");
				//$(canvasId).addClass("mh");
				canvas.setAttribute('width', IMGW);  
				canvas.setAttribute('height', IMGH);  
				ctx.rotate(p_deg * Math.PI / 180);  
				ctx.drawImage(image, 0, 0);
				break;  
			
			case 90 :  
				BTN_ROTATE++;
				//$(canvasId).removeClass("mh");
				//$(canvasId).addClass("mw");
				canvas.setAttribute('width', IMGH);
				canvas.setAttribute('height', IMGW); 
				ctx.rotate(p_deg * Math.PI / 180);  
				ctx.drawImage(image, 0, -IMGH);
				break;  
			
			case 180 :  
				BTN_ROTATE++;
				//$(canvasId).removeClass("mw");
				//$(canvasId).addClass("mh");
				canvas.setAttribute('width', IMGW);  
				canvas.setAttribute('height', IMGH);  
				ctx.rotate(p_deg * Math.PI / 180);  
				ctx.drawImage(image, -image.width, -IMGH);  
				break;  
				
			case 270 :  
			case -90 :
				BTN_ROTATE++;
				//$(canvasId).removeClass("mh");
				//$(canvasId).addClass("mw");
				canvas.setAttribute('width', image.height);  
				canvas.setAttribute('height', image.width);  
				ctx.rotate(p_deg * Math.PI / 180);  
				ctx.drawImage(image, -image.width, 0);  
				break;  
		};  
	} else {  
		switch(p_deg) {  
			default :  
			case 0 :  
				image.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation=0)';  
				break;  
			case 90 :  
				image.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation=1)';  
				break;  
			case 180 :  
				image.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation=2)';  
				break;  
			case 270 :  
			case -90 :  
				image.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation=3)';  
				break;  
		};  
	} 

	if($(canvasId).attr("width") < $(canvasId).attr("height")){
		$(canvasId).addClass("mh");
	}else{
		$(canvasId).removeClass("mh");
	}
	
	
	var parameters = {imgUpload: canvas.toDataURL('image/png'), filePath: filePath};
	
	var request = $.ajax({
		type:"POST",
		data: parameters,
		//data: {imgUpload: canvas.toDataURL('image/png')},
		url: "/urtown/saveCanvasImg.do",
		success:function(result){ 
		}
	});
};  
	
	
	
	
	
	
	
	
	
	