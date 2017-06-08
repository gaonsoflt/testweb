<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<style>
.notReadyRow {color:#ff1919;}
</style>

<script>
	var userInfoMap;
	$.ajax({
		type: "post",
		url: "<c:url value='/dgms/getUserInfo.do'/>",
		data: {
			'AREA_GB': "${userStore.areaId}"
		},
		async: false, //동기 방식
		success: function(data, status){
			console.log(data.rtnList);
			userInfoMap = data.rtnList;
		},
		fail: function(e){
			console.log(e);
		},
		complete: function(){}
	});
		
	function fnUserSeqByName(name){
		var rtnVal = "";
		console.log('fnUserSqByName param: ' + name);
		for (var i = 0; i < userInfoMap.length; i++) {
            if (userInfoMap[i].USER_NM == name) {
            	console.log('fnUserSqByName result: ' + userInfoMap[i].USER_SEQ);
            	return rtnVal = userInfoMap[i].USER_SEQ;
            }
        }
		return null;
	}
</script>


<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 건강측정관리 <small>혈압, 심전도, 혈당, 요산 , 산소포화도, 콜레스테롤 수치 등의 건강측정 정보를 관리합니다. </small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격의료상담관리</a></li>
			<li class="active">건강측정관리 </li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 내용 -->
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<div style="font-size:15px;padding:10px 0px;">
						    <span>상담일:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_keyword_date" /></span>&nbsp;&nbsp;&nbsp;
							<span>이름:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_keyword_user" /></span>&nbsp;&nbsp;&nbsp;
							<button id="searchBtn" type="button">검색</button>
						</div>
						<div id="gridDetail"></div>
<script>
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_TOWN_ID = "${userStore.townId}"; 
	var G_Admin = "${userStore.username}";  
	var G_UserNm = "${userStore.fullname}";
	var G_CHECKUP_DT;
	var G_Search = "";
	var G_Keyword = "";
	
	var searchData = [ 
   		{ text: "전체", value: "ALL"},
   		{ text: "이름", value: "USER_NO", ui: $("#in_kw_user") },
   		{ text: "측정일", value: "CHECKUP_DT", ui: $("#in_kw_date") }
   	];
	
	/* 키워드 */
	$("#in_keyword_user").kendoAutoComplete({
		dataSource: {
	    	transport: {
				read: {
					url: "<c:url value='/dgms/getAutoCompleteNew.do'/>",
					dataType: "jsonp"
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					var result = {
						AREA_GB: G_AREA_GB,
						TOWN_ID: G_TOWN_ID,
						TABLE: "TB_USER_INFO",
						TEXT: "USER_NM",
						VALUE: "USER_SEQ",
						USER_TYPE: '5113000000' // 마을주민
	            	};
					return { params: kendo.stringify(result) }; 
				}
			}	
	    },
	    suggest: true,
		dataTextField: "TEXT",
		dataBound: function(e) {
		},
		select: function(e) {
			G_Search = 'USER_NO';
			G_Keyword = this.dataItem(e.item.index()).VALUE;
			// 무조건 USER_NM으로 검색 됨 
			console.log('in_keyword_user select: ' + G_Keyword);
		},
		change: function(e) {
			G_Search = 'USER_NM';
			G_Keyword = this.value();
			console.log('in_keyword_user change: '  + G_Keyword);
		}
	});
	$("#in_keyword_user").keydown(function (e) {
        if (e.which == kendo.keys.ENTER) {
        	doSearch();
        }
    });
	
	$("#in_keyword_date").kendoDatePicker({
        culture: "ko-KR",
        format: "yyyy/MM/dd",
		parseFormats: ["yyyy-MM-dd"],
		value: new Date(),
		change: function(e) {
			G_CHECKUP_DT = kendo.toString(this.value(), "yyyy-MM-dd");
			console.log("consult_req_dt change: " + G_CHECKUP_DT);
		} 
	});
	
	var datepicker = $("#in_keyword_date").data("kendoDatePicker");
	datepicker.value(G_CHECKUP_DT);
	datepicker.trigger("change");
	

	var codelist = "_CHECKUP_RES_";
	var codeModles="";
	

		$.ajax({
			type: "post",
			url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
			data: {"list" : codelist},
			async: false, //동기 방식
			success: function(data,status){
				//codeModles = $.extend(codeModles, data.rtnList);
				codeModles = data.rtnList;
			},
			fail: function(){},
			complete: function(){}
		});
	/*
	var codeModles;
	$.ajax({
		type: "post",
		url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
		async: false, //동기 방식
		success: function(data,status){
			codeModles = data.rtnList;
		},
		fail: function(){},
		complete: function(){}
	});
	*/
	
	function fnCodeNameByCdID(code){ 
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
            if (codeModles[i].CD == code) {
            	rtnVal = codeModles[i].CD_NM;
            }
        }
		return rtnVal;
	}

	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: doSearch
	});
	
	function doSearch(e) {
		var gridDetail = $("#gridDetail").data("kendoGrid");
		gridDetail.dataSource.read();
	};
	
	$(document).ready(function () {
		var cc = 0;
		var crudServiceBaseUrl = "/urtown/checkupres";
	    /*** dataSource ***/
		var dataSource = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/list.do",
	       			dataType: "jsonp"
				},
				update: {
					url: crudServiceBaseUrl + "/update.do",
					dataType: "jsonp"
				},
				destroy: {
					url: crudServiceBaseUrl + "/delete.do",
					dataType: "jsonp"
				},
				create: {
					url: crudServiceBaseUrl + "/create.do",
					dataType: "jsonp"
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                	var result = {
			            	PAGESIZE: data.pageSize,
							SKIP: data.skip,
							PAGE: data.page,
							TAKE: data.take,
							AREA_GB: G_AREA_GB,
							TOWN_ID: G_TOWN_ID,
							CHECKUP_DT: G_CHECKUP_DT,
							SEARCH: G_Search,
							KEYWORD: G_Keyword
						};
						return { params: kendo.stringify(result) };
					} else if (type !== "read" && data.models) {	
						return { models: kendo.stringify(data.models) };
					}
				}
			},
			schema: {
				data: function(response) {
					console.log(response.rtnList);
					return response.rtnList;
				},
				total: function(response) {	
					console.log(response.total);
					return response.total;
				},
				errors: function(response) {
					return response.error;RNUM
				},
				model:{//가져온 값이 있음...
					id: "CHECKUP_SQ",//id 로 insert할건지 update 할건지 판단함.
					fields: {//data type of the field {Number|String|Boolean|Date} default is String
						CHECKUP_SQ			: { type: "number" },
						STATUS_CD			: { type: "string" },
						MEDI_CONSULT_SQ		: { type: "number" },
						RNUM				: { type: "number" },
						AREA_GB				: { type: "string", defaultValue: "${userStore.areaId}" },
						CHECKUP_NO			: { type: "number", editable: false },
						USER_NM				: { type: "string", editable: false },
						USER_NO				: { type: "string", editable: true },
						BIRTHDAY			: { type: "string", editable: false },
						CHECKUP_DT			: { type: "string", editable: false },
						FILE_PATH			: { type: "string", editable: false },
						BLOOD_PRES_MIN		: { type: "string", defaultValue: '0' },
						BLOOD_PRES_MAX		: { type: "string", defaultValue: '0' },
						BLOOD_PRES_PULSE	: { type: "string", defaultValue: '0' },	
						BLOOD_SUGAR			: { type: "string", defaultValue: '0' },
						CHOLESTEROL			: { type: "string", defaultValue: '0' },
						HDLCHOLESTEROL		: { type: "string", defaultValue: '0' },
						LDLCHOLESTEROL		: { type: "string", defaultValue: '0' },
						NEUTRAL				: { type: "string", defaultValue: '0' },
						URIC_ACID			: { type: "string", defaultValue: '0' },
						OXGEN				: { type: "string", defaultValue: '0' },
						ECG_AVG_HEARTBT		: { type: "string", defaultValue: '0' },
						ECG_MIN_HEARTBT		: { type: "string", defaultValue: '0' },
						ECG_MAX_HEARTBT		: { type: "string", defaultValue: '0' },
						ECG_UNUSUAL_CNT		: { type: "string", defaultValue: '0' },
						ECG_BRADY_CNT		: { type: "string", defaultValue: '0' },
						ECG_FREQ_CNT		: { type: "string", defaultValue: '0' },
						REG_DT				: { type: "string", editable: false },
						REG_USER			: { type: "string", editable: false, defaultValue: "${userStore.username}" },
						MOD_DT				: { type: "string", editable: false },
						MOD_USER			: { type: "string", editable: false, defaultValue: "${userStore.username}" },
						CHECK_TIME			: { type: "string", editable: true }
					}   
				},
	            parse: function(response) {
	            	/*
	            	var list = response.rtnList;
                	if(typeof list != "undefined"){
                        $.each(list,function(idx,elem) {
                        	if(typeof elem.FILE_PATH != "undefined"){
                        		elem.FILE_PATH = '<button id="button" type="button" class="kbt" onclick="javascript:viewData(\'"'+elem.FILE_PATH+'"\')">Edit</button>';
                        	}                 	
                        });
                	} 
                	*/
                    return response
	            }
			},
		    error : function(e) {
		    	console.log('error: ' + e.errors);
		    },
		    change : function(e) {
		    	console.log('change...');
		    },  	
		    sync: function(e) {
				console.log("sync complete");
				//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
				this.read();				
				alert("정상적으로 처리되었습니다.");
// 				alert(1);
// 				cc++;
// 				alert(cc);
			},   
			//serverPaging: true,        // 서버 사이드 페이징 활성화
			//serverFiltering: false,
			//serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 15,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 15                   //     반환할 항목 수 (pageSize와 같음)
		});
					
					
					
		/*************************/
		/***    gridDetail     ***/
		/*************************/
		
		var cData, fData, uData="${userStore.userseq}";		//파일 저장
        var wnd, detailsTemplate;							//심전도 출력
        
		
		var grid = $("#gridDetail").kendoGrid({
			dataSource: dataSource,
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			pageable: true,
			autoBind: true,
			navigatable: true,
			toolbar: [ 
			    //{ name: "create", text: "측정결과등록" },
			    { name: "excel", text: "엑셀출력" }
			],
			messages: {
				commands: {
					canceledit: "취소",
					update: "저장"
				}
			},
			columns: [
				{ title: "관리", width: 100, 
					command: [ 
            		{ name: "edit", text: "수정" }
            		], 
            		attributes: { style: "text-align: center;" } 
				},
				{ field: "RNUM", title: "RNUM", hidden:true, width: 110, attributes: {style: "text-align: center;"} },
				{ field: "STATUS_CD", title: "진행상태코드", hidden: true },
				{ field: "CHECKUP_SQ", title: "체크Seq", hidden: true }, 
				{ field: "CHECKUP_NO", title: "측정번호", width: 110, attributes: {style: "text-align: center;"} },
				{ field: "CHECKUP_DT", title: "측정일", width: 140, attributes: {style: "text-align: center;"},
					template: "#= (CHECKUP_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CHECKUP_DT))), 'yyyy-MM-dd') #",
					editor: function (container, options) { 
						$('<input required name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
						.kendoDatePicker({
	                        culture: "ko-KR",
							format: "yyyy/MM/dd",
							parseFormats: ["yyyy-MM-dd"],
							value: new Date(),
							change: function(e) {
                           		options.model.set("CHECKUP_DT", kendo.toString(this.value(), "yyyy-MM-dd"));
                            } 
						});
					}
				},
				{ field: "CHECK_TIME", 
					  title: "측정시간", 
					  width: 150, 
					  attributes: {style: "text-align: center;"},
					  editor: function (container, options){ 
							 $('<input required name="' + options.field + '"/>')
		                    .appendTo(container)
	                        .kendoDropDownList({
	                            autoBind: true,
	                            dataTextField: "CD_NM",
	                            dataValueField: "CD",
	                            filter: "contains",
	                            dataSource: {
									transport: {
	        							read: {
	        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
	        								dataType: "jsonp"
	        							},
	        							parameterMap: function(data, type) {
	        								var result = {
	        										CD_ID: "_CHECKUP_RES_",
	        										USE_YN: "1"
	        	                            };
	        								return { params: kendo.stringify(result) }; 
	        							}
	        						}
	                            },
	                            change: function() {
	                            	options.model.set("CHECK_TIME", this.value());
	                            } 
							});
						},
					  template: "#= fnCodeNameByCdID(CHECK_TIME)#" 
					},
				{ title: "측정자 정보",
					columns: [
						{ field: "USER_NO", title: "번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
						{ field: "USER_NM", title: "이름", width: 120, attributes: {style: "text-align: center;"} },
						{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"},
							template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #", }
					]
				},
				{ title: "혈압",
					columns: [
						{ field: "BLOOD_PRES_MAX", title: "최고혈압", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "BLOOD_PRES_MIN", title: "최저혈압", width: 80, attributes: {style: "text-align: center;"} }, 
						{ field: "BLOOD_PRES_PULSE", title: "맥박", width: 80, attributes: {style: "text-align: center;"} }
					]
				},
				{ title: "혈중 농도",
					columns: [
						{ field: "BLOOD_SUGAR", title: "혈당", width: 80, attributes: {style: "text-align: center;"} }, 
						{ field: "URIC_ACID", title: "요산", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "OXGEN", title: "산소포화도", width: 120, attributes: {style: "text-align: center;"} }
					]
				},
				{ title: "콜레스테롤 수치",
					columns: [
						{ field: "CHOLESTEROL", title: "총콜레스테롤", width: 140, attributes: {style: "text-align: center;"} },
						{ field: "HDLCHOLESTEROL", title: "고밀도콜레스테롤", width: 140, attributes: {style: "text-align: center;"} },
						{ field: "LDLCHOLESTEROL", title: "저밀도콜레스테롤", width: 140, attributes: {style: "text-align: center;"} },
						{ field: "NEUTRAL", title: "중성지방", width: 80, attributes: {style: "text-align: center;"} }
					]
				},
				{ field: "FILE_PATH", title: "심전도", hidden: true, width: 500, attributes: {style: "text-align: center;"} }, 

                { command: { text: "심전도 보기", width: 300,
                click: function(e){
                    e.preventDefault();

                    var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
                    wnd.content(detailsTemplate(dataItem));
                    wnd.center().open();
                    rotation(0, 'canvas', 'ecgImg', 'ecgImg2');
                } }, 
                title: "심전도", 
                width: 200,
                attributes: {style: "text-align: center;"}
                },
				{ field: "ECG_FILE", 
				  title: "심전도 업로드",
				  width: 300, 
				  hidden: false,
				  attributes: {style: "text-align: center;"},
					editor: function (container, options) { 
						$('<input type="file" name="' + options.field + '" id="' + options.field + '"/>')
	                    .appendTo(container)
	                    .kendoUpload({
	                        async:{
	                            saveUrl: "/file/create.do",
	                            //saveUrl: "http://rces-web/rcesonly/oandt/OandtWebService.asmx/UploadFile",
	                            autoUpload: true
	                        },
	                        upload: function(e){ 
	    						var parameters = {'SEQ_NM': "SEQ_TB_FILE_INFO"};

	    						$.ajax({
	    						    url: "<c:url value='/dgms/getSequence.do'/>",	// 요청 할 주소
	    						    async: false, 									// false 일 경우 동기 요청으로 변경
	    						    type: 'POST',									// GET, PUT
	    						    data: parameters,								// 전송할 데이터
	    						    success: function(data) {
	    								fData = data.Sequence;	
	    						    }
	    						});

	                			data = { 
	                					FILE_SQ		: fData,
	                					NOTICE_SQ	: cData,
	                					REG_USER_SQ	: uData
	                			};
	                			e.data = { params: kendo.stringify(data) };
	                			//alert( e.data );
	                		}
	                    });
					}
				
				/*
					columns: [
						{ field: "ECG_AVG_HEARTBT", title: "평균심박수", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "ECG_MIN_HEARTBT", title: "최저심박수", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "ECG_MAX_HEARTBT", title: "최고심박수", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "ECG_UNUSUAL_CNT", title: "이상심박수", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "ECG_BRADY_CNT", title: "서맥횟수", width: 80, attributes: {style: "text-align: center;"} },
						{ field: "ECG_FREQ_CNT", title: "빈맥횟수", width: 80, attributes: {style: "text-align: center;"} }
					]
				*/
				}
			],
			dataBound: function(e) {
				// if no checkup, add class "notReadyRow" for change color
				$('tr').each(function() {
					if($(this).text().indexOf('500001') >= 0) { // 접수
						$(this).addClass('notReadyRow');
					}
					if($(this).text().indexOf('500090') >= 0) { // 완료
						$(this).children().each(function() {
							$(this).children(".k-grid-edit").remove();
						})
					}
				});
				invokeUserAuth($("#gridDetail"), 'kendoGrid');
			},
			change: function(e){ 
			},
			editable: "inline",
			edit: function(e) {
				//측정번호 CHECKUP_NO			/ 			시퀀스 MEDI_CONSULT_SQ		/	CHECKUP_SQ
				var grid= $("#gridDetail").data("kendoGrid");
				var dataItem = grid.dataItem(grid.current().closest("tr"));
				cData = dataItem.CHECKUP_SQ;
				dataItem.CHECKUP_SQ;
				//grid.showColumn("ECG_FILE");
				
				//console.log("edit...");
				//var grid= $("#gridDetail").data("kendoGrid");
            	//var sData = grid.dataItem(grid.select());
            	//alert(sData);
            	//alert(gridData.select());
            	//var sRow = grid.dataItem(grid.select());
            	
            	
            	
				//var uiCheckupDt= e.container.find("input[name=CHECKUP_DT]").data("kendoDatePicker");
				//uiCheckupDt.value(kendo.toString(kendo.parseDate(new Date(Number(e.model.get("CHECKUP_DT")))), 'yyyy-MM-dd'));
				//e.model.set("CHECKUP_DT", kendo.toString(uiCheckupDt.value(), "yyyy-MM-dd"));
			},
			cancel: function(e) {
				var grid= $("#gridDetail").data("kendoGrid");
				//grid.hideColumn("ECG_FILE");
				
			},
            save: function(e) {//저장전 이벤트
				console.log("save..."); 
				var grid= $("#gridDetail").data("kendoGrid");
				//grid.hideColumn("ECG_FILE");
            },
            saveChanges: function(e) {//저장버턴 클릭시 이벤트
            	console.log("saveChanges...");
			},
			mobile: true,
            excel: {
                allPages: true,
                fileName: "원격의료상담신청내역.xlsx",
            },
			noRecords: {
				template: "검색된 결과가 없습니다."
            },
            pageable: {	
				//refresh: true, //하단의 리프레쉬 아이콘
           		pageSizes: true,
           		//buttonCount: 1  //paging 갯수
           		//input: true //페이지 직접입력
           		//info: false //하단의 페이지 정보
           		messages: {
					display: "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
           	      	empty: "출력할 항목이 없습니다",
           	      	itemsPerPage: "한 페이지에 출력할 항목 수"
				}
            }
		});
		
		
		function onUpload(e){
			e.data = { TEST: "TEST" };
			alert( e.data );
		}

		
        wnd = $("#details")
            .kendoWindow({
                title: "심전도 보기",
                modal: true,
                visible: false,
                resizable: false,
                width: 1000,
                height:800
            }).data("kendoWindow");
        
        detailsTemplate = kendo.template($("#template").html());
        
	});//document ready javascript end...
	

    $(".kbt").kendoButton();
</script>

<script src="<c:url value='/resource/js/comm/urtown.js'/>" type="text/javascript"></script>
<script type="text/x-kendo-template" id="template">
	<div id="details-container">
		<h2>#= USER_NM #님 심전도</h2>
		 #= FILE_PATH == null ? '<div id="ecg_caution">심전도 이미지가 없습니다.</div>' : '<div id="ecg_caution2">마지막으로 올라온 심전도 이미지를 표시합니다.<br /><input type="button" id="rbtn" onclick="javascript:rotation(90, \'canvas\', \'ecgImg\', \'ecgImg2\', \''+FILE_PATH+'\')" value="90도 회전하기" /></div>' #
		<canvas id="canvas" style="transform: translate3d(0px, 0px, 0px) scale3d(1, 1, 1); display: none;" width="332" height="400"></canvas>
		<img id="ecgImg" src="<c:url value='#= FILE_PATH + "?random=" + Math.floor((Math.random() * 100000000000000000000) + 1) #'/>" style="display: #= FILE_PATH == null ? 'none' : 'block' #" /> 
		 <div id="imgView" style="display:none;"><img id="ecgImg2" class="mh" src="<c:url value='#= FILE_PATH + "?random=" + Math.floor((Math.random() * 100000000000000000000) + 1) #'/>" style="display: #= FILE_PATH == null ? 'none' : 'block' #" />  </div>
	</div>
</script>
                  
                  <div id="details"></div>
                  
                  		
					</div>
				</div>
				<!-- box -->
			</div>
			<!-- col-xs-12 -->
		</div>
		<!-- row -->
	</section>
</div>
<style>
	#details-container{ text-align: center; overflow-x:auto; overflow-y:auto; padding: 10px; }
	#details-container h2{ font-size:25px; margin-top:20px !important; }
	#details-container img{ display:none; border:1px solid #999; /*max-width:900px; max-height:600px;*/  height:auto; margin:0px auto 20px auto; }
	#ecg_caution{ margin-top: 10px; font-size: 15px; color:red; }
	#ecg_caution2{ margin-top: 10px; color:#ccc; }
	#details-container h2{		margin: 0;						}
	#details-container em{		color: #8c8c8c;					}
	#details-container dt{		margin:0; display: inline;		}
	#rbtn{border:1px solid #999; color:#000; margin:10px auto 30px auto;}
	.mw{max-width:550px}
	.mh{max-height:550px}
	
	.k-autocomplete, #in_kw_date, #searchBtn{margin-left:9px;}
	#gridDetail table th{text-align:center;}
</style>							
<%@ include file="../inc/footer.jsp"%>