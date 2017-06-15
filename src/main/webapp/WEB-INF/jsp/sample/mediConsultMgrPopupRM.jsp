<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header_medi.jsp"%>
<%@ include file="../inc/aside_medi.jsp"%>

<!-- chart js --> 
<script src="<c:url value='/resource/js/comm/urtown.js'/>" type="text/javascript"></script>
<style>
.tbl_default table {border-top:2px solid #60B1A3;}
.tbl_default th,
.tbl_default td {padding:2px 2px;background-color:#fff;border-bottom:1px solid #d1d1d1;}
.tbl_default thead th {background-color:#f5f5f5;text-align:center;}
.tbl_default tbody th {background-color:#f5f5f5;}
.tbl_default input[type="radio"],
.tbl_default input[type="checkbox"] {padding:0;margin:0;vertical-align:middle;}
.tbl_default input[type="text"],
.tbl_default input[type="password"],
.tbl_default select {vertical-align:middle;}
.tbl_default table.list tbody td {text-align:center;}
.tbl_default .bdl {border-left:1px solid #d1d1d1;}
.tbl_default tr.type_10 td {background:#e1f5ec;}
.tbl_default tr.type_30 td {background:#f5eae1;}

.icon-chart {float:right;}
.icon-chart img {width:25px;}

.bind_input {border-width:0px;}
#editor01 .k-editor iframe.k-content{height: 50px !important}
</style>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 내용 -->
			<div class="col-xs-12">
				<!-- table 하나 -->
				<div class="box">
					<div class="box-body">
						<!-- jQuery Plug-Ins Widget Initialization -->
						<div style="font-size:15px;padding:10px 0px;">
							<span>상담요청일:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_req_dt" /></span>&nbsp;&nbsp;&nbsp;
							<span>신청자:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_keyword_user" /></span>&nbsp;&nbsp;&nbsp;
							<span><button id="searchBtn" type="button">조회</button></span>
						<!-- <span style="float:right">차트열림방식 <input id="chart-mouseover-switch"/></span> -->
						</div>
						<div id="horizontal" style="height:730px">
							<div id="left-pane">
								<div id="waitinglist-grid"></div>
							</div>
							<div id="vertical">
								<div id="right-pane">
									<div id="consultnote-view" class="demo-section k-content"></div>
								</div>
							</div>
	                	</div>
                	</div>
               	</div>
			</div>
		</div>
	</section>
</div>
<script id="detail-note-template" type="text/x-kendo-template">
<div id="consultnote-form">
	<div>
	<table class="tbl_default" style="width:100%;">
		<caption><strong>▶ 상담정보</strong></caption>
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="30%">
		</colgroup>
		<tbody id="checkup-info">
			<tr>
				<th>최종수정자</th>
				<td><input id="MOD_USER" class="bind_input" name="MOD_USER" data-bind="value:selected.MOD_USER" required readonly="readonly"/></td>
				<th>최종수정일</th>
				<td><input id="MOD_DT" class="bind_input" name="MOD_DT" data-format="yyyy-MM-dd" data-bind="value:selected.MOD_DT" required readonly="readonly"/></td>
			</tr>
			<tr>
				<th>상담내용</th>
				<td colspan="3"><textarea id="CONSULT_NOTE" name="CONSULT_NOTE" data-bind="value:selected.CONSULT_NOTE" placeholder="상담 내용을 입력하시고 [저장]버튼을 눌러주세요." style="width:100%;height:223px;"></textarea></td>
			</tr>
		</tbody>
	</table>
</div>
</script>
<script> 

	var codelist = "_CHECKUP_RES_";
	var codeModles="";


	$.ajax({
		type: "post",
		url: "<c:url value='/dgms/getCodeListByCdIDModel.do'/>",
		data: {"list" : codelist},
		async: false, //동기 방식
		success: function(data,status){
			codeModles = data.rtnList;
		},
		fail: function(){},
		complete: function(){}
	});
	
	function fnCodeNameByCdID(code){ 
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
	        if (codeModles[i].CD == code) {
	        	rtnVal = codeModles[i].CD_NM;
	        }
	    }
		return rtnVal;
	}



	var G_MEDI_CONSULT_SQ = 0;
	var G_CONSULT_REQ_DT;
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_TOWN_ID = "${userStore.townId}"; 
	var G_Search;
	var G_Keyword;
	
	var chartWindow;
	var chartOpenSwitch = document.getElementById("chart-mouseover-switch");
	var consultViewModel;
	
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
		suggest: false,
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
	
	/* 의료상담일  */
	$("#in_req_dt").kendoDatePicker({
		culture: "ko-KR",
		format: "yyyy/MM/dd",
		parseFormats: ["yyyy-MM-dd"],
		value: new Date(),
		change: function(e) {
			G_CONSULT_REQ_DT = kendo.toString(this.value(), "yyyy-MM-dd");
			console.log("in_req_dt: " + G_CONSULT_REQ_DT);
		}	
	}); 
	
	//초기화
	var datepicker = $("#in_req_dt").data("kendoDatePicker");
	datepicker.value(G_CONSULT_REQ_DT);
	datepicker.trigger("change");
	
	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: doSearch
	});
	
	function doSearch(e) {
		$("#waitinglist-grid").data("kendoGrid").dataSource.read();
		G_MEDI_CONSULT_SQ = 0;
	};
	
	$(document).ready(function () {
		
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: true, resizable: true, min: "150px",	size: "25%"	}, 
				{ collapsible: false, resizable: true, min: "150px" }      
			]
		});
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false, resizable: false }, 
				{ collapsible: false, resizable: false }
			]
		});
	
		var detailnoteTemplate = kendo.template($("#detail-note-template").html());
	    var crudServiceBaseUrl = "/urtown/mediconsult/mgr";

		/*************************/
		/* waitinglist-grid */
		/*************************/
	    /*** dataSource ***/
		var waitinglistDs = new kendo.data.DataSource({
			transport: {
				read:  {
					url: crudServiceBaseUrl + "/waitingList.do",
	    			dataType: "jsonp",
	    			complete: function(e){ 
	    				console.log("/waitingList...................");
	    			}
				},
				parameterMap: function(data, type) {//type =  read, create, update, destroy
					if (type == "read"){
	                   	var result = {
    						AREA_GB: G_AREA_GB,
    						TOWN_ID: G_TOWN_ID,
							SEARCH: G_Search,
                           	KEYWORD: G_Keyword,
                           	CONSULT_REQ_DT: G_CONSULT_REQ_DT
						};
						return { params: kendo.stringify(result) }; 
					}
	               
					if (type !== "read" && data.models) {	
						return { models: kendo.stringify(data.models) };
					}
				}
			},
			schema: {
				data: function(response) {
					return response.rtnList;
				},
				total: function(response) {
					return response.total;
				},
				errors: function(response) {
					return response.error;
				},
				model:{
					id: "MEDI_CONSULT_SQ",
					fields: { //data type of the field {Number|String|Boolean|Date} default is String
						MEDI_CONSULT_SQ:{ type: "number" },
						STATUS_CD: 		{ type: "string" },
						STATUS_NM: 		{ type: "string" },
						REQUEST_NO:		{ type: "string" },
						USER_NM:		{ type: "string" },
						USER_NO:		{ type: "string" },
						BIRTHDAY: 		{ type: "string" },
						CONSULT_REQ_DT: { type: "string" }
					}  
				}
			},
	        error : function(e) {
		    	console.log('listds error: ' + e.errors);
	        },
	        change : function(e) {
	        	console.log("listds change...........");
	        },  	
	        sync: function(e) {
				console.log("listds sync complete");
				//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
				alert("정상적으로 처리되었습니다.");  
			},  
			serverPaging: true,        // 서버 사이드 페이징 활성화
			serverFiltering: false,
			serverSorting: false,      // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
			page: 1,                   //     반환할 페이지
			pageSize: 10,              //     반환할 항목 수
			skip: 0,                   //     건너뛸 항목 수
			take: 10                   //     반환할 항목 수 (pageSize와 같음)
		});//datasource grid end...
	
		
		/*************************/
		/***   grid waitinglist-grid     ***/
		/*************************/
		var waitinglistGrid = $("#waitinglist-grid").kendoGrid({
			autoBind: true,
			dataSource: waitinglistDs,
			navigatable: true,
			pageable: true,
			height: 713,
			columns: [
				{ field: "STATUS_CD", title: "진행상태코드", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "STATUS_NM", title: "상태", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "USER_NO", title: "신청자번호", width: 80, attributes: {style: "text-align: center;"}, hidden: true },
				{ field: "USER_NM", title: "신청자", width: 90, attributes: {style: "text-align: center;"} },
				{ field: "BIRTHDAY", title: "생년월일", width: 100, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (BIRTHDAY == '') ? '' : kendo.toString(kendo.parseDate(BIRTHDAY, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				},
				{ field: "CONSULT_REQ_DT", title: "상담요청일", width: 150, attributes: {style: "text-align: center;"}, hidden: true,
					template: "#= (CONSULT_REQ_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(CONSULT_REQ_DT))), 'yyyy-MM-dd') #" 
				},
				{ field: "REQUEST_NO", title: "접수번호", width: 150, attributes: {style: "text-align: center;"} }
			],
			sortable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			
			mobile: true,
	        noRecords: {
	           template: "검색된 결과가 없음"
	        },
	        pageable : false,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			save: function(e) {//저장전 이벤트
				console.log("listgd save...............");
			},
			saveChanges: function(e) {//저장버턴 클릭시 이벤트
				console.log("listgd saveChanges...............");
			},
			edit: function(e) {//Fired when the user edits or creates a data item
			},
			dataBound: function(e) {
				console.log("listgd dataBound..............");
				
				var grid = this;
			    $(grid.tbody).on("click", "td", function (e) {
			        var row = $(this).closest("tr");
			        var rowIdx = $("tr", grid.tbody).index(row);
			        var colIdx = $("td", row).index(this);
			        var data = grid.dataItem(row);
			        
			        if(data.MEDI_CONSULT_SQ == null || data.MEDI_CONSULT_SQ == '') {
			        	G_MEDI_CONSULT_SQ = 0;
			        } else {
				        G_MEDI_CONSULT_SQ = data.MEDI_CONSULT_SQ;
			        }		
			        
			        // 상담 노트 로드
			        //consultNoteDs.read(); // template
			        consultViewModel.dataSource.read();
			        $("#consultnote-form textarea[name=CONSULT_NOTE]").val("");  
			        
			        //var strWindowFeatures = "scrollbars=no,toolbar=no,location=no,resizable=yes,status=no,menubar=no,width=675,height=800,left=0,top=0";
					//var winobj = window.open("/urtown/mediConsultMgrPopupR.do", "mediConsultMgrPopupR", strWindowFeatures);
					
					
			    });
			    
				invokeUserAuth($("#waitinglist-grid"), 'kendoGrid');
			}
		});//grid end...


		/*************************/
		/* dataSource consultnote-grid */
		/*************************/
		var consultNoteModel = kendo.data.Model.define({
			id: "NOTE_SQ",
			fields: {
				NOTE_SQ			:{ type: "number" },
				MEDI_CONSULT_SQ	:{ type: "string" },
				CONSULT_NOTE	:{ type: "string" },
				REG_DT			:{ type: "string" },           
				REG_USER		:{ type: "string" },   
				MOD_DT			:{ type: "string" },           
				MOD_USER  		:{ type: "string" }
			}
		});
		var fffff = true;
	    /*** dataSource ***/
		consultViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read:  {
						url: crudServiceBaseUrl + "/consultnotes.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("/consultnotes.do...................");
		    			}
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								MEDI_CONSULT_SQ: G_MEDI_CONSULT_SQ
							};
							return { params: kendo.stringify(result) }; 
						}
		    		}
				},
				batch: true,
				schema: {
					model: consultNoteModel,
					data: function(response) {
						console.log("noteds data");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('noteds error: ' + e.errors);
		        },
		        change : function(e) {
		        	console.log("noteds change");
		            var _data = this.data()[0];
					console.log(_data);
					
					// only once run
					if(fffff) {
						noteEditorInit();
						fffff = false;
					}
					
		            _data.MOD_DT = (_data.MOD_DT.indexOf('-') >= 0) ? _data.MOD_DT : kendo.toString(kendo.parseDate(new Date(Number(_data.MOD_DT))), 'yyyy-MM-dd');
		            _data.CONSULT_NOTE = (_data.CONSULT_NOTE == null) ? '' : _data.CONSULT_NOTE;
					consultViewModel.set("selected", _data);
					
					
		        },
		        requestStart: function(e) {
		        	if(e.type == "update" && e.response) {
		        	}
		        },
		        requestEnd: function(e) {
					if(e.type == "read" && e.response) {
		        	}
		        },
		        sync: function(e) { 
		        	//상담내용 저장
		        	console.log("noteds SYNC");
		    	},
				dataBound: function(e){ 
					console.log("noteds dataBound");
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error" + e.errors);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: function(){},
            hasChanges: false,
            sync: function (e) {
				console.log("kendo.observable:sync");
				consultViewModel.dataSource.data()[0].set("MOD_USER", "${userStore.username}"); 
				this.dataSource.sync();
            },
			close: function(){
				console.log("kendo.observable:close");
				//$("#grid").data("kendoGrid").dataSource.read();
			},
            cancel: function () {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
            },
            remove: function () {
            	console.log("kendo.observable:remove");
            }
		});
	    
	    function noteEditorInit() {
			$("#consultnote-view").html(kendo.render(detailnoteTemplate, consultViewModel.dataSource.view()));
    	    kendo.bind($("#consultnote-form"), consultViewModel);
   	        $("#CONSULT_NOTE").kendoEditor({
   	        	resizable: {
   	        		content: true,
   	        		toolbar: true
   	        	},
   	        	encoded: false
   	        });
	    }
	    
	});//document ready javascript end...
	 
	function onClick(e) {
		consultViewModel.sync();
    }
	
	
	
	
</script>	
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