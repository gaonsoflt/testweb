<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i> 원격상담FAQ <small>의료상담에 관한 궁금증을 관리합니다.</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 원격상담관리</a></li>
			<li class="active">원격상담FAQ</li>
		</ol>
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 내용 -->
			<div class="col-xs-12">
				<!-- table 하나 -->
				<div class="box">
					<div class="box-body">
						<p style="font-size: 15px;padding:10px 0px;">
							검색:&nbsp;&nbsp;&nbsp;
							<input id="in_search" />
						    <input id="in_keyword" />
							<button id="searchBtn" type="button">검색</button>
						</p>
						<div id="splitter" style="height:800px">
							<!-- <div id="gridMaster"></div> -->
							<div id="grid">  
							</div>
								<div class="toolbartest bttb">  
		                			<button class="k-button btnNew"><span class="k-icon k-add"></span>글쓰기</button>  
								</div> 
							<div id="editForm"> 
								<div style="margin :60px auto auto auto; width:80%;">
									<div class="row" style="margin-top:10px;margin-left:10px;">
										<div class="col-xs-11" >
											<label for="FAQ_SQ" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">번호</label> 
											<input type="text" id="FAQ_SQ" class="k-textbox col-xs-2" name="FAQ_SQ" data-bind="value: selected.FAQ_SQ" readonly />
											<span class="k-invalid-msg" data-for="FAQ_SQ"></span>
										</div>
									</div> 
									<div class="row" style="margin-top:10px;margin-left:10px;">
										<div class="col-xs-11" >
											<label for="REG_USER" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">작성자</label> 
											<input type="text" id="REG_USER" class="k-textbox col-xs-2" name="REG_USER" data-bind="value: selected.REG_USER" readonly />
										</div>
									</div>
									<div class="row" style="margin-top:10px;margin-left:10px;">
										<div class="col-xs-11">    
											<label for="ORDER_NO" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">노출순서</label>
								            <input type="text" id="ORDER_NO" class="k-textbox col-xs-2" name="ORDER_NO" data-bind="value: selected.ORDER_NO"/> 
										</div> 
									</div>
									<div class="row" style="margin-top:10px;margin-left:10px;">
										<div class="col-xs-11" >     
											<label for="QUESTION" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">질문</label>
											<textarea class="k-textbox" rows="5" style="width: 100%" name="QUESTION" data-bind="value: selected.QUESTION" required></textarea>
										</div>
									</div>
									<div class="row" style="margin-top:10px;margin-left:10px;">
										<div class="col-xs-11" >     
											<label for="ANSWER" class="col-xs-1 control-label" style="min-width:100px; padding-right:5px;">답변</label>
											<textarea class="k-textbox" rows="10" style="width: 100%" name="ANSWER" data-bind="value: selected.ANSWER" required></textarea>
										</div>
									</div>
								</div>
								<div class="toolbartest bttb2">  
									<button class="k-button btnSave" data-bind="events: { click: sync }"><span class="k-icon k-update"></span>저장</button>
									<button class="k-button btnRemove" data-bind="events: { click: remove }"><span class="k-icon k-delete"></span>삭제</button>
									<button class="k-button btnclose" data-bind="events: { click: close }"><span class="k-icon k-delete"></span>닫기</button> 
								</div> 
							</div>
		                </div>
<script> 
	/*기본 데이터****************************************************************************************************/
	var G_AREA_GB = "${userStore.areaId}"; 
	var G_Admin = "${userStore.username}";  
	var G_UserNm = "${userStore.fullname}";
	var G_Search = "";
	var G_Keyword = "";
					

	/*검색 셋팅****************************************************************************************************/
	var searchData = [ 
		{ text: "전체", value: "ALL" },
		{ text: "질문", value: "QUESTION" },
		{ text: "답변", value: "ANSWER" },	
		{ text: "작성자", value: "REG_USER" }
	];

	$("#in_search").kendoComboBox({ 
		dataTextField: "text",
		dataValueField: "value",
		dataSource: searchData,   
		change: function(e){
			G_Search = this.value();
		},
		index: 0
	}); 
	
	/* 키워드 */
	$("#in_keyword").kendoMaskedTextBox({ 
		change: function(e) {
			G_Keyword = this.value();
		}
	});

	/* 조회 */
	$("#searchBtn").kendoButton({
		icon: "search",
		click: function(e) {
			var gridDetail = $("#grid").data("kendoGrid");
			gridDetail.dataSource.read();
		}
	});

	/*툴바 셋팅    ***************************************************************************************************/
	$("#toolbartest").kendoToolBar({});
	$(document).ready(function () { 
		var validator;
                
		/*모델  ***************************************************************************************************/
		var noticeModel = kendo.data.Model.define({
			id: "FAQ_SQ",
			fields: { 
				FAQ_SQ		:{ type: "number" },
				AREA_GB		:{ type: "string", defaultValue: "${userStore.areaId}" },
				ORDER_NO	:{ type: "number" },
				ANSWER		:{ type: "string" },
				QUESTION	:{ type: "string" },
				REG_DT		:{ type: "string" },           
				REG_USER	:{ type: "string", defaultValue: "${userStore.username}"  },   
				MOD_DT		:{ type: "string" },           
				MOD_USER	:{ type: "string", defaultValue: "${userStore.username}" }
			}
		});
                
		/*그리드 데이터   ***************************************************************************************************/
		var crudServiceBaseUrl = "<c:url value='/urtown/mediconsult/faq'/>";
		var viewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read:  {
						url: crudServiceBaseUrl + "/list.do",
           				dataType: "jsonp",
           				complete: function(e){ 
           					console.log("list.do...................");
						}
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
      					dataType: "jsonp",
						complete: function(e){   
           					console.log("create...................");
           					$("#grid").data("kendoGrid").dataSource.read();
 							setTimeout(function(){editorInit("close")}, 100);
 						}
					},
					parameterMap: function(options, operation) {
						if (operation == "read"){
							console.log("read>>>");
							var result = {
								PAGESIZE: options.pageSize,
								SKIP: options.skip,
								PAGE: options.page,
								TAKE: options.take,
								AREA_GB: G_AREA_GB, 
								SEARCH: G_Search,
								KEYWORD: G_Keyword
							}; 
							return { params: kendo.stringify(result) }; 
						}

						if (operation !== "read" && options.models) {
							console.log("not read>>>");
							return {models: kendo.stringify(options.models)};
						}
					}
				},
				batch: true,               //     true: 쿼리를 한줄로,  false : row 단위로
	    		page: 1,                   //     반환할 페이지
	    		pageSize: 15,              //     반환할 항목 수
	    		skip: 0,                   //     건너뛸 항목 수
	    		take: 15,                  //     반환할 항목 수 (pageSize와 같음)
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
					model: noticeModel,
					parse: function(response) { 
						return response
					}  
				},
				change: function () {
					viewModel.set("hasChanges", this.hasChanges());
				}
			}),
			error : function(e) {
				console.log(e.errors);
			},
			batch: true,
			selected: function(){},
			hasChanges: false,
			sync: function () {
				//this.dataSource.add(this.selected);
                console.log("validator.validate():"+validator.validate());
				if(validator.validate()) {
					this.dataSource.sync();
					alert("정상적으로 작성되었습니다."); 
					$("#grid").data("kendoGrid").dataSource.read();
					setTimeout(function(){editorInit("close")}, 100);
				} 
			},
			close: function(){ 
				$("#grid").data("kendoGrid").dataSource.read();
				setTimeout(function(){editorInit("close")}, 100);
			},
            cancel: function () {
                this.dataSource.cancelChanges();
                validator.hideMessages();
            },
            newsync: function () {
            	viewModel.set("selected", new noticeModel());
            	this.dataSource.insert(0, this.selected);
            },
            remove: function () {
            	var key = this.selected.FAQ_SQ;
            	var keyData = this.dataSource.get(key);
            	if(key != null && key != ""){
            		if(confirm("데이터를 삭제하시겠습니까")){ 
            			this.dataSource.remove(keyData);
            			this.dataSource.sync();
            			//grid.select("tr:eq(0)");
	     				$("#grid").data("kendoGrid").dataSource.read(); 
	     				$("#grid").data("kendoGrid").dataSource.read();
						setTimeout(function(){editorInit("close")}, 100);
            		} 
            	}else{
            		alert("삭제 할 데이터가 없습니다.");
            	}
            }
        });
		console.log("viewModel");
		console.log(viewModel);
		kendo.bind($("#editForm"), viewModel);
		validator = $("#editForm").kendoValidator().data("kendoValidator");
            	
					
		/*그리드    ***************************************************************************************************/
		var grid = $("#grid").kendoGrid({
        	dataSource: viewModel.dataSource,
			pageable: true,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			height: 715,
			columns: [
				{ field: "ORDER_NO", title:"순서", width: 50, attributes: {style: "text-align: center;"} },
				{ field: "AREA_GB", title: "지역", hidden:true },
				{ field: "SEQ_SQ", title:"공지번호", hidden:true},
				{ field: "QUESTION", title:"질문", width: 300, attributes: {style: "text-align: left;"} }, 
				{ field: "ANSWER", title:"답변", width: 300, attributes: {style: "text-align: left;"} },
				{ field: "REG_DT", title:"작성일", width: 100, attributes: {style: "text-align: center;"}, 
					template: "#= (REG_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(REG_DT))), 'yyyy-MM-dd') #" },
				{ field: "REG_USER", title:"작성자", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "MOD_DT", title:"수정일", width: 100, attributes: {style: "text-align: center;"},
					template: "#= (MOD_DT == '') ? '' : kendo.toString(kendo.parseDate(new Date(Number(MOD_DT))), 'yyyy-MM-dd') #" },
				{ field: "MOD_USER", title:"수정자", width: 80, attributes: {style: "text-align: center;"} }
			],
			sortable: true,
			selectable: "row",
			scrollable: true,
			dataBound: function(e) { 
				var row = this.tbody.find(">tr[data-uid=" + viewModel.selected.uid + "]");
				if(row) {
					this.select(row);
				}
			},
			mobile: true,
	        noRecords: {
	           //template: "No data. Current page is: #=this.dataSource.page()#"
	           template: "검색된 결과가 없습니다."
	        },
	        pageable: {	
	       		pageSizes: true,
	       		messages: {
	       	      display: "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
	       	      empty: "출력할 항목이 없습니다",
	       	      itemsPerPage: "한 페이지에 출력할 항목 수"
	       	    }
	        },
			change: function (e) {
				var selected = this.select();
				var model = this.dataItem(this.select()); 
				validator.hideMessages();	
                     
				//로우를 선택했을 때
				if(selected.length> 0 && model.FAQ_SQ !="" && model.FAQ_SQ != null){
					editorInit("read"); 
				}
				viewModel.set("selected", model);  
			}
		}).data("kendoGrid");
		
		$("#grid").data("kendoGrid").one("dataBound", function (e) {
		});
                
		/*커스텀 버튼****************************************************************************************************/
		//[추가] 버튼
		$(document).on("click", ".btnNew", function(){ 
			editorInit('write');
            var grid = $("#grid").data("kendoGrid");  
			viewModel.set("selected", new noticeModel());
			viewModel.dataSource.insert(0, viewModel.selected);
		});

		function reloadGrid(){	
			$("#grid").data("kendoGrid").refresh();
			$("#grid").data("kendoGrid").dataSource.read();
		};
	
		//에디터
		function editorInit(viewFlag){   
			$("#grid").data("kendoGrid").dataSource.newsync;  
	
			//1.읽다
			if(viewFlag=="read"){
				//단순출력
				$("#editForm").css({"display":"block"});
				$(".btnRemove").css({"display":"inline-block"});
			} else {			
				//INPUT 초기화
				$("#editForm input[name=ORDER_NO]").val("");
				$("#editForm textarea[name=QUESTION]").val("");
				$("#editForm textarea[name=ANSWER]").val("");
				$("#editForm input[name=REG_USER]").val("");
				$("input[name=REG_USER]").val("${userStore.username}").change();
		
				if(viewFlag=="close"){			//2.닫다
					$("#editForm").css({"display":"none"});
				} else if(viewFlag=="write"){		//3.쓰다
					$("#editForm").css({"display":"block"});
					$(".btnRemove").css({"display":"none"});
				}
			}
		};
		
		invokeUserAuth($(".btnNew"), "kendoButton", "C");
		invokeUserAuth($(".btnSave"), "kendoButton", "U");
		invokeUserAuth($(".btnRemove"), "kendoButton", "D");
	});
</script> 
					      </div>
					    </div><!-- box --> 
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>

		<style>
			.box{min-height:671px;} 
			.bttb{margin:10px 0px 10px 10px; text-align: right;}
			.bttb2{margin-top:10px; text-align:center;} 
			.col-xs-5 label{padding:5px; margin-bottom:0px;}
			.w10{width: 800px !important;}
			#editForm{position:absolute; display:none; top:0; left:0; width:100%; height:100%; min-height:668px; background-color:#fff;}
			#editForm #SUBJECT{min-width:450px;}
		</style>
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
	#in_keyword, #searchBtn{margin-left:9px;}
</style>	
<%@ include file="../inc/footer.jsp"%>