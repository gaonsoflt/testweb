<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#mngdataActEcg').parent().parent().addClass('active');
	$('#mngdataActEcg').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>활동용 심전도 조회
            <small>환자의 심전도측정결과를 조회합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 측정결과</a></li>
            <li class="active">활동용 심전도 조회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
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
                  <h3 class="box-title"><i class="fa fa-tag"></i>심전도측정결과조회</h3>
                </div> -->
                <div class="box-body">
<!--                   <table id="example1" class="table table-bordered table-striped">
                  </table> -->
                  
				<!-- jQuery Plug-Ins Widget Initialization -->
				<p>

				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
				발굴대상자: <input id="in_user" />&nbsp;&nbsp;&nbsp;
				시작일자 <input id="fromdate" name="fromdate" value="${fromdate}"/> ~ 종료일자 <input id="todate" name="todate" value="${todate}"/>&nbsp;&nbsp;&nbsp;
				<button id="searchBtn" type="button">조회</button>
				</div>

			
				<script>
				var G_AreaCdVal;//조회조건 : 관리기관코드
				var G_UserNmVal;//조회조건 : 사용자명
				
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
							if (G_UserIdVal=="")
							{
								G_UserIdVal=$("#in_user").val();
							}
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
				var pagesize=1000;
				var G_UserIdVal="";
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
					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectDataActEcgDetailInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateDataActEcgInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteDataActEcgInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertDataActEcgInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										user_id:G_UserIdVal,
										fromdate:$("#fromdate").val(),
										todate:$("#todate").val()
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
								id:"ECG_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									ECG_SEQ: { 
										type: "string" //data type of the field {Number|String|Boolean|Date} default is String
										//defaultValue: 42,
										//validation: { required: true, min: 1 }
									},
									CRE_USR : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
									},
									MOD_USR : { 
										type: "string", 
										editable: false,
										defaultValue: "${userStore.username}"
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
								field: "SMEASURE_DT",
								title: "측정일시",
								attributes: {style: "text-align: left;"},
								width: 200
							},
							{
								field: "PVC_CNT",
								title: "PCV 횟수",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "FREQ_CNT",
								title: "부정맥성 빈맥횟수",
								attributes: {style: "text-align: left;"},
								width: 200
							},
							{
								field: "INFREQ_CNT",
								title: "부정맥성 서맥횟수",
								attributes: {style: "text-align: left;"},
								width: 200
							},
							{
								field: "AVGHEART_RATE",
								title: "평균심박수",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "MAXHEART_RATE",
								title: "최대심박수",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "MINHEART_RATE",
								title: "최소심박수",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "AVGRRINTERVAL",
								title: "평균R-R",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "MINRRINTERVAL",
								title: "최소R-R",
								attributes: {style: "text-align: left;"},
								width: 100
							},
							{
								field: "MAXRRINTERVAL",
								title: "최대R-R",
								attributes: {style: "text-align: left;"},
								width: 100
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
			                fileName: "활동용심전도측정내역.xlsx",
			            },
			            pdf: {
							allPages: true,
							fileName: "활동용심전도측정내역.pdf",
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
						},
						dataBound: function(e) {
							console.log("dataBound..............");
							
							var grid = this;
						    $(grid.tbody).on("click", "tr", function (e) {
						        var row = $(this).closest("tr");
						        var rowIdx = $("tr", grid.tbody).index(row);
						        var colIdx = $("td", row).index(this);
						        //alert(rowIdx + '-' + colIdx);
						        //alert("selected CATGR:"+this.dataSource.get(rowIdx).CATGR);
						        //var data = grid.dataItem(rowIdx);
						        var data = dataSourceDetail.at(rowIdx);
						        seq = data.ECG_SEQ;
						        selSeq = seq;						        
						        if (dataSource!=null)
						        {
						        	pagesize=dataSource.pageSize();
						        }
						        createChart(seq,1,pagesize);
						    });
						}
			            
					});//gridDetail end...
					
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
				    var grid = $("#gridDetail").data("kendoGrid");
					if ("${ecg_seq}" !="")
					{
						createChart("${ecg_seq}",1,pagesize);
					}
					else
					{
						grid.one("dataBound", function (e) {
					        //select the first row
					        setTimeout(function () {
					            
					            var row = e.sender.tbody.find('tr:first');
					            //grid.select(e.sender.tbody.find("tr:first"));
					            row.trigger('click');
					        }, 50)

					    });
					}
					
					/* 발굴대상자 */
					$("#in_user").kendoComboBox({
						index: 0,
						dataTextField: "USER_NM",
						dataValueField: "USER_ID",
						filter: "contains",
						dataSource: {
							transport: {
								read: {
									url: "<c:url value='/dgms/getUserAutoComplete.do'/>",
									dataType: "jsonp"
								},
								parameterMap: function(data, type) {//type =  read, create, update, destroy
									var result = {
											TABLE: "TB_USER_INFO",
											COLUNM: "USER_NM",
											USER_TYPE: "101377",
											USE_YN: "1"
		                            };
									return { params: kendo.stringify(result) }; 
								}
							}
						},
						change: function(e) {
							G_UserIdVal = this.value();
							//G_AreaCdVal = this.value();
						}


					});
					
					$(window).on("resize", function() {
					      kendo.resize($("#chart"));
				    });			
				});//document ready javascript end...
                
            	</script>


                  
                  
                  <div class="demo-section k-content wide">
        <div id="chart"></div>
        <div id="pager"></div>
        
    </div>

    <script>
    	var dataSource;
    	var selSeq;
    	function pager_change() {
        	createChart(selSeq,dataSource.page(),dataSource.pageSize())
      	}

        function createChart(seq,pagenum,pagesize) {
        	$.ajax({
    			type: "get",
    			url: "<c:url value='/dgms/selectActEcgInfoBySeq.do?ecg_seq="+seq+"'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
    			async: false, //동기 방식
    			success: function(data,status){
    	   	    		var calData_ = [];
						var allCalData_ = [];
    	   	    		if (data["rtnList"]["ECG_RAW_CLOB"]!="")
    	   	    		{
    	   	    			var datas=data["rtnList"]["ECG_RAW_CLOB"].split(",");
    	   	    			var maxsize=datas.length;
    	   	    			if ((pagenum*pagesize)<datas.length)
    	   	    			{
    	   	    				maxsize = (pagenum*pagesize)-1;
    	   	    			}

    	   	    			for( var i = (pagenum-1)*pagesize; i < maxsize; i++ ) {//datas.length
    	   	    				var data=0;
    	   	    				if (datas[i]!="")
    	   	    				{
    	   	    					data=parseFloat(datas[i]);
    	   	    				}
    	   	    				calData_.push(data);  
    	   	    			}
    	   	    			
    	   	    			for( var i = 0; i < datas.length; i++ ) {//datas.length
    	   	    				var data=0;
    	   	    				if (datas[i]!="")
    	   	    				{
    	   	    					data=parseFloat(datas[i]);
    	   	    				}
    	   	    				allCalData_.push(data);  
    	   	    			}
    	   	    			
    	   	    			if (dataSource==null)
    	   	    			{
    	   	    				dataSource = new kendo.data.DataSource({
        	   	    		        data: allCalData_,
        	   	    		        pageSize: pagesize
        	   	    		    });

        	   	    		    dataSource.read();
    	    	   	    		var pager = $("#pager").kendoPager({
    	    	   	    			dataSource: dataSource,    	    
        	   	    		        pageSizes: [100,300, 500, 1000, 2000, 3000, 5000, 10000]
    	    	   	    	    }).data("kendoPager");
    	
    	    	   	    	    pager.bind("change", pager_change);
    	   	    			}
    	   	    		}	 
			            $("#chart").kendoChart({
			                title: {
			                    text: "심전도측정결과"
			                },
			                legend: {
			                    visible: false
			                },
			                series: [{
			                    type: "line",
			                    data: calData_,//[20, 1, 18, 3, 15, 5, 10, 6, 9, 6, 10, 5, 13, 3, 16, 1, 19, 1, 20, 2, 18, 5, 12, 7, 10, 8,20, 1, 18, 3, 15, 5, 10, 6, 9, 6, 10, 5, 13, 3, 16, 1, 19, 1, 20, 2, 18, 5, 12, 7, 10, 8, 20, 1, 18, 3, 15, 5, 10, 6, 9, 6, 10, 5, 13, 3, 16, 1, 19, 1, 20, 2, 18, 5, 12, 7, 10, 8,20, 1, 18, 3, 15, 5, 10, 6, 9, 6, 10, 5, 13, 3, 16, 1, 19, 1, 20, 2, 18, 5, 12, 7, 10, 8],
			                    style: "normal",
			                    markers: {
			                        visible: false
			                    }
			                }],
			                categoryAxis: {
			                    title: {
			                        text: "time"
			                    },
			                    majorGridLines: {
			                        visible: true
			                    },
			                    majorTicks: {
			                        visible: true
			                    }
			                },
			                valueAxis: {
			                    title: {
			                        text: ""
			                    },
			                    majorGridLines: {
			                        visible: true
			                    },
			                    visible: true
			                },

			                tooltip: {
			                    visible: true,
			                    format: "{0}"
			                }
			            });
    			},
    			fail: function(){},
    			complete: function(data){
    				
    			}
    		});   
        }

        $(document).ready(createChart);
        $(document).bind("kendo:skinChange", createChart);
    </script>
                  
                  
                  
					        
					      </div>
					    </div><!-- box -->
					    
					    
					    
					    
					    
					  </div><!-- col-xs-12 -->
					</div><!-- row -->
        </section>    
        
      </div>
        
        
<%@ include file="../inc/footer.jsp" %>