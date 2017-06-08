<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngInteg').parent().parent().addClass('active');
	$('#mngInteg').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>기기사용내역통합관리
            <small></small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 운영관리</a></li>
            <li class="active">기기사용내역통합관리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">
        	<div class="row">
          	<!-- 내용 -->
          	<div class="col-xs-12">
            
              <!-- table 하나 -->
              <div class="box">
                <!-- <div class="box-header">
                  <h3 class="box-title"><i class="fa fa-tag"></i>복약내역조회</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div id ="searchArea" style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				관리기관: <input id="in_area" />&nbsp;&nbsp;&nbsp; 
				시작일자 <input id="fromdate" name="fromdate" value="${fromdate}"/> ~ 종료일자 <input id="todate" name="todate" value="${todate}"/>
				&nbsp;&nbsp;&nbsp;<input id="in_item" />&nbsp;&nbsp;&nbsp;<input id="in_percent" />
				&nbsp;&nbsp;&nbsp;<button id="searchBtn" type="button">조회</button>
				</div>

			
				<script>
				var G_AreaCdVal = "${userStore.areaid2}";//조회조건 : 관리기관코드
				var G_UserNmVal;//조회조건 : 사용자명 
				
				
				//관리기관 검색
				$("#in_area").kendoComboBox({
					index: 0,
					dataTextField: "CD_NM",
					dataValueField: "CD",
					filter: "contains",
					dataSource: {
						transport: {
							read: {
								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								var result = {
										//AREA_ID: G_AreaCdVal, 
										CD_ID: "_AREA_ID_",
										USER_ID: "${userStore.username}",
										USE_YN: "1"
								};
								return { params: kendo.stringify(result) }; 
							}
						}
					},
					dataBound: function(e) {
						G_AreaCdVal = this.value();  
					},  
					change: function(e) { 
						G_AreaCdVal = this.value(); 
						//alert("G_AreaCdVal:"+G_AreaCdVal);
					}
				}); 
				
				var combobox = $("#in_area").data("kendoComboBox");
				combobox.value(G_AreaCdVal); 
				combobox.trigger("change");
				
				 var itemData = [
                    { text: "전체", value: "" },
                    { text: "복약률", value: "MEDC" },
                    { text: "혈압측정률", value: "BLDPRS" },
                    { text: "심전도측정률", value: "ECG" }
                ];
				
                var percentData = [ 
                    { text: "100% 이하", value: "100" },
                    { text: "90% 이하", value: "90" },
                    { text: "80% 이하", value: "80" },
                    { text: "70% 이하", value: "70" },
                    { text: "60% 이하", value: "60" },
                    { text: "50% 이하", value: "50" },
                    { text: "40% 이하", value: "40" },
                    { text: "30% 이하", value: "30" },
                    { text: "20% 이하", value: "20" },
                    { text: "10% 이하", value: "10" }
                ];

				$("#in_item").kendoComboBox({ 
					dataTextField: "text",
					dataValueField: "value",
					dataSource: itemData,   
                    change: itemOnChange,
					index: 0,
				});
				
				$("#in_percent").kendoComboBox({ 
					dataTextField: "text",
					dataValueField: "value",
					dataSource: percentData, 
                    //change: percentOnChange,
					index: 0
				}); 
				
                function itemOnChange() {
                    var value = $("#in_item").val(); 
                    
					if(value == null || value.length < 1){ 
						$("#in_percent").closest(".k-widget").hide();
					}else{
						$("#in_percent").closest(".k-widget").show();
					}
                };
				$("#in_percent").closest(".k-widget").hide(); 
				
				
				/* DropDownList Template */
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

				function fnCodeNameByCdID(code){
					var rtnVal = "";
					for (var i = 0; i < codeModles.length; i++) {
			            if (codeModles[i].CD_ID == code) {
			            	rtnVal = codeModles[i].CD_NM;
			            }
			        }
					return rtnVal;
				}
				
				function fnCodeNameByCd(code){
					var rtnVal = "";
					for (var i = 0; i < codeModles.length; i++) {
			            if (codeModles[i].CD == code) {
			            	rtnVal = codeModles[i].CD_NM;
			            }
			        }
					return rtnVal;
				}
				
				$(function() {
					
					
					/* 조회 */
					$("#searchBtn").kendoButton({
						icon: "search",
						click: function(e) {
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
							
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
					
					
					
					

					
					
				});
				
				</script>
				</p>
				
				
				
				<div id="gridDetail"></div>
				
				<script> 
                $(document).ready(function () {
					
					$("#fromdate").kendoDatePicker({
                        
                        culture: "ko-KR",
                        // display month and year in the input
                        format: "yyyy-MM-dd"
                    });
					$("#todate").kendoDatePicker({
                        
                        culture: "ko-KR",
                        // display month and year in the input
                        format: "yyyy-MM-dd"
                    });
					
					

					var nowDay = new Date();
					var firstDay = new Date();
					firstDay.setMonth(firstDay.getMonth()-1); 
					//var Mfirst = firstDay.getFullYear() + "-" + (firstDay.getMonth()+1) + "-01";
					//firstDay = new Date(Mfirst); 
					//Mfirst = kendo.toString(kendo.parseDate(Mfirst), 'yyyy-MM-dd');
					
					$("#fromdate").data("kendoDatePicker").value(firstDay);
					$("#todate").data("kendoDatePicker").value(nowDay);


					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngIntegDetailInfoJsonp.do",
		            			dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										AREA_ID : G_AreaCdVal,
										user_id:"${userStore.username}",
										fromdate:$("#fromdate").val(),
										todate:$("#todate").val(),
										item:$("#in_item").val(),
										percent:$("#in_percent").val()
									};
									return { params: kendo.stringify(result) }; 
								}
                               
								if (type !== "read" && data.models) {	
									return { models: kendo.stringify(data.models) };
								}
							}
						},//transport end...
/* 						aggregate: [
							{ field: "MAJOR_SEQ", aggregate: "sum" },
							{ field: "MAJOR_SEQ", aggregate: "min" }
						], */
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
								id:"MEDC",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									USER_ID: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									MEDC : { 
										type: "Number", 
										editable: false
									},
									MEDC_P : { 
										type: "Number", 
										editable: false
									},
									BLDPRS : { 
										type: "Number", 
										editable: false
									},
									BLDPRS_P : { 
										type: "Number", 
										editable: false
									},
									ECG : { 
										type: "Number", 
										editable: false
									},
									ECG_P : { 
										type: "Number", 
										editable: false
									}
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
					});//datasource gridDetail end...
					
					
					
					/*************************/
					/***    gridDetail     ***/
					/*************************/
					$("#gridDetail").kendoGrid({
						autoBind: true,
						dataSource: dataSourceDetail,
                        //change: cellOnChange,
						navigatable: true,
						pageable: true,
						height: 500,
						toolbar: [
								    /* { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" }, */
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [
							{
								field: "USER_NM",
								title: "사용자",
								attributes: {style: "text-align: center;"},
								width: 200
							},
							{
								field: "MEDC",
								title: "기간별 복약 횟수",
								attributes: {style: "text-align: right;"},
								width: 200
							},
							{
								field: "MEDC_P",
								title: "기간별 복약률",
								attributes: {style: "text-align: right;"},
								template: "#=MEDC_P#%",
								width: 200
							},
							{
								field: "BLDPRS",
								title: "기간별 혈압측정 횟수",
								attributes: {style: "text-align: right;"},
								width: 200
							},
							{
								field: "BLDPRS_P",
								title: "기간별 혈압측정률",
								attributes: {style: "text-align: right;"},
								template: "#=BLDPRS_P#%",
								width: 200
							},
							{
								field: "ECG",
								title: "기간별  심전도측정 횟수",
								attributes: {style: "text-align: right;"},
								width: 200
							},
							{
								field: "ECG_P",
								title: "기간별 심전도측정률",
								attributes: {style: "text-align: right;"},
								template: "#=ECG_P#%",
								width: 200
							}
						],
 						editable: false,
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
			                fileName: "복약내역.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "복약내역.pdf",
							paperSize: "A4",
							landscape: true,
							scale: 0.75
						},      
			            
			            noRecords: {
			                //template: "No data. Current page is: #=this.dataSource.page()#"
							template: "No data"
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
						},
						saveChanges: function(e) {//저장버턴 클릭시 이벤트
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						}
			            
					});//gridDetail end...
					  
					/*				
					function cellOnChange(arg) {
	                    var selected = $.map(this.select(), function(item) {
	                        return $(item).text();
	                    });
						alert(selected);
	                    //kendoConsole.log("Selected: " + selected.length + " item(s), [" + selected.join(", ") + "]");
	                }
					*/
				});//document ready javascript end...

            	</script>


                  
					      </div>
					    </div><!-- box -->
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>