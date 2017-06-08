<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngCctv').parent().parent().addClass('active');
	$('#mngCctv').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>CCTV위치관리
            <small>CCTV위치를 관리합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> CCTV관리</a></li>
            <li class="active">CCTV위치관리</li>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>사용자관리</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
                  
                  
                  
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				</div>
				</p>
			
				<script>
				var G_AreaIdVal = "${userStore.areaId}";//조회조건 : 관리기관
				var G_CctvNmVal;//조회조건 : 사용자명
				
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
				</script>
				
                  
				<!-- 위도경도 찾는 사이트  -->
 				<div id="infoImg"><span><span>X</span></span><div></div></div> 
				<div id="msg2"><a href="http://www.geoplaner.com/" target="_blank()">위도, 경도 찾기</a><span id="info" title="사용법"><span>(?)</span></span></div>
				<div id="gridDetail"></div>

				<script>
                $(document).ready(function () {

					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectMngCctvInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateMngCctvInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteMngCctvInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertMngCctvInfoJsonp.do",
								dataType: "jsonp" 
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										//AREA_CD: G_AreaCdVal
										G_AreaIdVal: G_AreaIdVal,
										G_CctvNmVal: G_CctvNmVal
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
								id:"CCTV_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									CCTV_SEQ: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										,editable: false
									},
									RNUM: { 
									type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										,editable: false
										,defaultValue: ""
									},
									AREA_ID: {
										editable: true,
										validation: { required: true },
										defaultValue: G_AreaIdVal 
									},
									CCTV_NM: { 
										editable: true,
										type: "string"
									}, 
									CCTV_URL: {
										type: "string",
										validation: { required: true }  
									},
									CCTV_LATITUDE: {
										type: "number",
										validation: { required: true } 
									},
									LOGIN_LONGITUDE: { 
										type: "number",
										validation: { required: true }
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
							//alert(dataSourceDetail.at(0).Cctv_SEQ);
                            //if(validator.validate()) {
    							console.log("sync complete"); 
								//console.log("model.dirty:"+this.schema.model.dirty);//수정되었는지 여부
								alert("정상적으로 처리되었습니다.");  
	            				$("#gridDetail").data("kendoGrid").dataSource.read();
                         //   }
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
						navigatable: true,
						pageable: true,
						height: 500,
						toolbar: [
								    { name: "create", text: "추가" },
								    { name: "save", text: "저장" },
								    { name: "cancel", text: "취소" },
								    { name: "excel", text: "엑셀" }
								    /* { name: "pdf", text: "PDF" }, */
								],
						columns: [ 
								   {
								field: "CCTV_SEQ",
								title: "SEQ",
								hidden: true,
								attributes: {style: "text-align: center;"},
								width: 80
					    	},
						   {
								field: "RNUM",
								title: "번호",
								attributes: {style: "text-align: center;"},
								width: 80
						    },
							{
								field: "AREA_ID",
								title: "구역",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD_ID",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = { 
			        										USE_YN: "1", 
			    											AREA_ID: G_AreaIdVal
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() {
			                            	options.model.set("AREA_ID", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCdID(AREA_ID)#"
							},
							{
								field: "CCTV_NM",
								title: "CCTV명",
								attributes: {style: "text-align: center;"}, 
								width: 130
							},   
							{
								field: "CCTV_URL",
								title: "URL",
								attributes: {style: "text-align: left;"},
								width: 300
								/*,
								editor: function (container, options) { 
									 $('<input type="password" class="k-textbox" name="' + options.field + '"/>')
				                    .appendTo(container);
								}
								*/
								//,template: "#: LOGIN_PWD == null ? ' ' : '●'.repeat( LOGIN_PWD.length) #"
							},
							{
								field: "LATITUDE",
								title: "위도",
								type: "number",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: editNumberWithoutSpinners 
								//format: "{0:c}"
								//template: kendo.template($("#slotsTemplate").html())
								/*,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD",
			                            //optionLabel: "전체",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_Cctv_TYPE_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						},/* 
			        						requestEnd: function(e) {
			        				              e.response.unshift({ CD:'', CD_NM:'All' });
			          						} * /
			                            },
			                            change: function() {
			                            	options.model.set("Cctv_TYPE", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCd(Cctv_TYPE)#"
								*/
							},  
							{
								field: "LONGITUDE",
								title: "경도",
								type: "number",
								attributes: {style: "text-align: center;"},
								width: 100,
								editor: editNumberWithoutSpinners 
								/*,
								editor: function (container, options) { 
									 $('<input required name="' + options.field + '"/>')
				                    .appendTo(container)
			                        .kendoDropDownList({
			                            autoBind: true,
			                            dataTextField: "CD_NM",
			                            dataValueField: "CD_ID",
			                            dataSource: {
											transport: {
			        							read: {
			        								url: "<c:url value='/dgms/getCodeListByCdID.do'/>",
			        								dataType: "jsonp"
			        							},
			        							parameterMap: function(data, type) {
			        								var result = {
			        										CD_ID: "_SEX_",
			        										USE_YN: "1"
			        	                            };
			        								return { params: kendo.stringify(result) }; 
			        							}
			        						}
			                            },
			                            change: function() {
			                            	options.model.set("SEX", this.value());
			                            } 
									});
								},
								template: "#=fnCodeNameByCdID(SEX)#"
								*/
							}, 
							{
								command: { name: "destroy", text: "삭제" },
								attributes: {style: "text-align: center;"},
								width: 50
							}
						],
 						editable: {
							confirmation: "선택한 행을 삭제하시겠습니까?\n저장 버튼 클릭시 완전히 삭제됩니다."
						},
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
			                fileName: "CCTV관리.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "CCTV관리.pdf",
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
/* 	           			             if (e.values.MAJOR_NM !== "") {
         			               // the Cctv changed the MAJOR_NM field
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
							/*var uid = dataSourceDetail.at(0).Cctv_ID;
							var upw = dataSourceDetail.at(0).LOGIN_PWD;
							if( typeof uid == 'undefined' || uid.replace(/ /gi, '').length < 1 ){
								alert("아이디를 입력해주십시오.");
								e.preventDefault();
							}
							 else if( typeof upw == 'undefined' || upw.replace(/ /gi, '').length < 1 ){
								alert("비밀번호를 입력해주십시오.");
								e.preventDefault();
							}*/
							
							//alert(dataSourceDetail.at(0).Cctv_ID);
							//for(var i=0; i<dataSourceDetail)
/* 							if (!confirm("변경된 데이타를 저장하시겠습니까?")) {  
								e.preventDefault();
							}   */  	
						},
						edit: function(e) {//Fired when the Cctv edits or creates a data item
							/*
							,
	                        edit: function(e){
	                        	alert(dataCctv_SQ);
								//if(data.Cctv_SQ == null || data.Cctv_SQ == ""){
									//alert("처방전 정보가 생성되지 않았습니다. 저장한 후 진행해주세요.");
									//var grid = this;
									//grid.cancelRow();
									//return;
								//}
	                        } 
						
							/*** Key 채번 *** /
			 				if (e.model.isNew() && ( dataSourceDetail.at(0).Cctv_SEQ == null || dataSourceDetail.at(0).Cctv_SEQ == "") ) {
 								var url = "<c:url value='/dgms/getSequence.do'/>";
								var parameters = {'SEQ_NM': "SEQ_Cctv_INFO"};
								$.post(url, parameters, function(data) {
									dataSourceDetail.at(0).set("Cctv_SEQ", data.Sequence);
								}); 
								
								var grid = this;
								grid.select("tr:eq(0)");

							}
			 				else
			 				{
								/* Disable the editor of the "id" column when editing data items * /
								$('input[name=Cctv_SEQ]').parent().html(e.model.Cctv_SEQ);

			 				} 

							*/
							
			
						} 
			            
					});//gridDetail end...
					
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
					
					 
					
				});//document ready javascript end...
                

				
				

				
            	</script>


                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
<script>
	function editNumberWithoutSpinners(container, options) {
	    $('<input data-text-field="' + options.field + '" ' +
	            'data-value-field="' + options.field + '" ' +
	            'data-bind="value:' + options.field + '" ' +
	            'data-format="' + options.format + 
	            '" data-decimals="6" />')
	            .appendTo(container)
	            .kendoNumericTextBox({
	                spinners : false,
	                format: "#.000000"
	            });
	}
	$(document).on("click","#info", function(){
		$("#infoImg").css({"display":"block"});
	});
	$(document).on("click","#infoImg span span", function(){
		$("#infoImg").css({"display":"none"});
	});
</script>
<script id="slotsTemplate" type="text/x-kendo-tmpl"> 
	<input class="numeric" type="number" value="#= LATITUDE #" step="1" />
</script>
<style>
	.k-grid td{
	    white-space: nowrap;
	    text-overflow: ellipsis;
	}
	#msg2{width:100%; height:15px; line-height:15px; text-align:right;}
	#msg2 a{color: red;}
	#infoImg{display:none; width:1100px; height: 660px; position:absolute; left:200px; z-index:500;}
	#infoImg div{width:1100px; height: 652px; background:url("<c:url value='/resource/images/infoImg.png'/>") left top no-repeat;}
	#infoImg span{display:inline-block; background-color:#000; width:100%; font-weight:bold; text-align:right; height:20px; color:#fff; padding:0px 5px 0px 0px; box-sizing:border-box;}
	#info span, #infoImg span span{cursor:pointer; display:inline;}
</style>        
<%@ include file="../inc/footer.jsp" %>