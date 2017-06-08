<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngCode').parent().parent().addClass('active');
	$('#mngCode').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            기준관리
            <small>기준코드를 관리합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">기준관리</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        	<div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>Hover Data Table</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>
				Animal: <input id="animal" />
				<input id="datePicker" size="12" maxlength="10" />
				<!-- <input id="datePicker" name="datePicker" value="31/10/2011" size="12" maxlength="10" /> -->
				            
				<button>Foo</button> | <button>Bar</button>
				<select id="selectBox">
					<option>Item 1</option>
					<option>Item 2</option>
					<option>Item 3</option>
				</select>
				<input id="comboBox" />
				<button id="searchBtn" type="button">조회</button>
										
				<script>
				$(function() {
					$("#animal").kendoAutoComplete({ dataSource: [ "Ant", "Antilope", "Badger", "Beaver", "Bird" ] });
				});
				$(document).ready(function(){
					$("#datePicker").kendoDatePicker({
						value: new Date(),
						min: new Date(1950, 0, 1),
						max: new Date(2049, 11, 31),
						format: "yyyy/MM/dd"
					})
				});
				$(function() {
					$("button").kendoButton();
					//$("button").kendoButton().css("color", "blue");
				});
				
				$(document).ready(function() {
					$("#searchBtn").kendoButton({
						icon: "search",
						//imageUrl: "/images/edit-icon.gif"
						click: function(e) {
							if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined'){
								console.log("searchBtn aaaaaaaaaaaaa");	
							}
							//var grid = $("#grid").data("kendoGrid");
							$("#grid").data("kendoGrid").dataSource.read();
							$("#grid").data("kendoGrid").autoFitColumn("MAJOR_NM");//자동컬럼크기 조절
							//grid.hideColumn(1);//grid.hideColumn("age");//grid.hideColumn(grid.columns[0].columns[1]);
							//grid.refresh();
							//grid.saveAsExcel();
							                  
							/* grid.select("tr:eq(1)");
							var row = grid.select();
							var data = grid.dataItem(row);
							console.log(data.name); // displays "Jane Doe" */
						}
					});
		
					$("#comboBox").kendoComboBox({
						index: 0,
						dataTextField: "MAJOR_NM",
						dataValueField: "MAJOR_ID",
						filter: "contains",
						dataSource: {
							transport: {
							read: {
								dataType: "json",
								url: "<c:url value='/dgms/selectMngCodeInfoCombo.do'/>"
							}
							},
							schema: {
								data: "rtnList"
							}
						}
					});
				}); 
				</script>
				
				</p>
                  
                  
                  
                  
				<!-- kendo Widget Initialization -->
				<p>
				<div id="container1">
				<input data-role="numerictextbox" data-change="handler.numerictextbox_change" />
				<input data-role="autocomplete" data-source="{data:['One', 'Two']}" />
				<input data-role="autocomplete" data-source="dataSource1" />
				<input data-role="autocomplete"
				    data-source="[{firstName:'John', lastName: 'Doe'}, {firstName:'Jane', lastName: 'Doe'}]"
				    data-text-field="firstName"
				    data-template="template" />
				    <button data-role="button">Mobile button</button>
				</div>
				<script id="template" type="text/x-kendo-template">
					<span>#: firstName # #: lastName #</span>
				</script>

				<script>
					var dataSource1 = new kendo.data.DataSource( {
					    data: [ "One1", "Two1" ]
					});
						function numerictextbox_change(e) {
			        alert("numerictextbox_change");
			    }
					var handler = {
					    numerictextbox_change: function (e) {
					    	alert("handler.numerictextbox_change");
					    }
					};
					
					kendo.bind($("#container1"));
					//kendo.bind($("#container1"), {}, kendo.ui, kendo.mobile.ui);
				</script>
									
				</p>
									

									
				<div id="grid"></div>
				<div id="alert"></div>

				<script>
                $(document).ready(function () {
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSource = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngCodeInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateMngCodeInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngCodeInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngCodeInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined'){
	                                	console.log("---->data.pageSize:"+data.pageSize);
	                                	console.log("---->data.skip:"+data.skip);
	                                	console.log("---->data.page:"+data.page);
	                                	console.log("---->data.take:"+data.take);
	                               	}
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
	                                       SKIP: data.skip,
	                                       PAGE: data.page,
	                                       TAKE: data.take
	                                      };
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
	                               	if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined'){
										console.log("---->update:"+data.models);
										console.log("---->kendo.stringify(data.models):"+kendo.stringify(data.models));
	                               	}
									return { models: kendo.stringify(data.models) };
								}
							}//transport.parameterMap end...
						},//transport end...
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
							model:{//가져온 값이 있음...
								id:"MAJOR_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									MAJOR_SEQ: { type: "string", //data type of the field {Number|String|Boolean|Date} default is String
									            editable: true 
									            //defaultValue: 42,
									            //validation: { required: true, min: 1 }
									},
									MAJOR_ID: { type: "string", 
									           editable: true, 
									           validation: { required: true } 
									},
									MAJOR_NM: { type: "string", editable: true }
								}   
							}
						},
                        error : function(e) {
                        	console.log(e.errors);
                        	alert(e.errors);
                        },
                        change : function(e) {
                        	//alert("change...........");
                        	/* var data = this.data();
                        	console.log(data.length);
                        	alert(data.length+"건 처리하였습니다."); */
                        },  	
                        sync: function(e) {
							console.log("sync complete");
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
					});//datasource end...

					/*** grid ***/
					$("#grid").kendoGrid({
						dataSource: dataSource,
						navigatable: true,
						pageable: true,
						height: 500,
						toolbar: [
								    //name - name of the available commands, text - text to be set on the button
								    /* { name: "pdf", text: "PDF" }, */
								    { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },
								    { name: "excel", text: "엑셀" }
								],
						columns: [
							{
								field: "AREA_ID",
								title: "행정구역ID",
								//hidden: true,
								//attributes
								width: 100
							},
							{
								field: "MAJOR_SEQ",
								title: "대분류SEQ"
							},
							{
								field: "MAJOR_NM",
								title: "대분류명",
								width: 200
							},
							{
								field: "MAJOR_ID",
								title: "대분류ID"
							},   
							{
								field: "REMARK",
								title: "비고"
							},
							{
								field: "INS_SEQ",
								title: "등록자"
							},
							{
								command: { name: "destroy", text: "삭제" },
								width: 80
							}
						],
						editable: true,
						sortable: true,
						selectable: true, //selectable: "multiple cell","multiple row","cell","row",
						scrollable: true,
						
						/* columnMenu: {
						    messages: {
						        sortAscending: "오름차순정렬",
						        sortDescending: "내림차순정렬",
						        filter: "필터",
						        columns: "항목설정"
						    }
						}, */
						mobile: true,
						
						//excel, pdf
						excel: {
			                allPages: true,
			                fileName: "기준관리.xlsx",
			            },
			            pdf: {
			            	        allPages: true,
			                      fileName: "기준관리.pdf",
			                      paperSize: "A4",
			                      landscape: true,
			                      scale: 0.75
			                 },      
			            
			            noRecords: {
			               template: "No data. Current page is: #=this.dataSource.page()#"
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
			            },
			            
						resizable: true,  //컬럼 크기 조절
						reorderable: true, //컬럼 위치 이동
						save: function(e) {//저장전 이벤트
							console.log("save...............");
/* 	           			             if (e.values.MAJOR_NM !== "") {
         			               // the user changed the MAJOR_NM field
         			               if (e.values.MAJOR_NM !== e.model.MAJOR_NM) {
         			            	   console.log("e.values.MAJOR_NM:"+e.values.MAJOR_NM);
         			            	   console.log("e.model.MAJOR_NM:"+e.model.MAJOR_NM);
         			            	console.log("e.model.id:"+e.model.id);
         			                 console.log("MAJOR_NM is modified");
         			               }
         			             } else {
         			                 e.preventDefault();
         			                 console.log("MAJOR_NM cannot be empty");
         			             } */
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						}
			            
			            
					});
				});
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>