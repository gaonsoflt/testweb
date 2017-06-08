<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/aside.jsp" %>
 
<script>
$(document).ready(function(){
	$('#dataMedc').parent().parent().addClass('active');
	$('#dataMedc').addClass('active');
});	
</script>

      
      <!-- 내용 -->
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <i class="fa fa-caret-right"></i>복약내역조회
            <small>환자의 복약정보를 조회합니다.</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 측정결과</a></li>
            <li class="active">복약내역조회&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
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

				<div style="font-size: 15px;">
				&nbsp;&nbsp;&nbsp;
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
							var gridDetail = $("#gridDetail").data("kendoGrid");
							gridDetail.dataSource.read();
							createChart();
							//alert("G_AreaCdVal:"+G_AreaCdVal);
						}
					});
					
					
					
					

					
					
				});
				
				</script>
				
				</p>
                  
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

					/*************************/
                	/* dataSource gridDetail */
                	/*************************/
                    var crudServiceBaseUrl = "<c:url value='/dgms'/>",
                    /*** dataSource ***/
					dataSourceDetail = new kendo.data.DataSource({
						transport: {
							read:  {
								url: crudServiceBaseUrl + "/selectDataMedcDetailInfoJsonp.do",
		            			dataType: "jsonp"
							},
							update: {
								url: crudServiceBaseUrl + "/updateDataMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							destroy: {
								url: crudServiceBaseUrl + "/deleteDataMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							create: {
								url: crudServiceBaseUrl + "/insertDataMedcInfoJsonp.do",
								dataType: "jsonp"
							},
							parameterMap: function(data, type) {//type =  read, create, update, destroy
								if (type == "read"){
	                               	var result = {
	                               		PAGESIZE: data.pageSize,
										SKIP: data.skip,
										PAGE: data.page,
										TAKE: data.take,
										user_id:"${userStore.username}",
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
								id:"TAKE_MEDC_SEQ",//id 로 insert할건지 update 할건지 판단함.
								fields: {
									TAKE_MEDC_SEQ: { 
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
								field: "STAKE_DT",
								title: "복용일시",
								attributes: {style: "text-align: left;"},
								width: 200
							},
							{
								field: "STAKE_STATE",
								title: "복약상태",
								attributes: {style: "text-align: left;"},
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
			            
					});//gridDetail end...
					
					
/* 					$("#gridMaster").on("click", "table", function(e) {
					    alert("clicked", e.ctrlKey, e.altKey, e.shiftKey);
					});
					 */
					
					 
					
				});//document ready javascript end...

            	</script>


                  
                  
                  <!-- 그래프 -->
    <div class="demo-section k-content wide">
        <div id="chart"></div>
    </div>
    <div id="gridDetail"></div>
    <script>
        function createChart() {
        	
        	$.ajax({
    			type: "get",
    			url: "<c:url value='/dgms/selectChartDataMedcDetailInfo.do?user_id=${userStore.username}&fromdate="+$("#fromdate").val()+"&todate="+$("#todate").val()+"'/>",//<c:url value='/appinf/selectMeasureScheduleInfo.do'/>
    			async: false, //동기 방식
    			success: function(data,status){
    	   	    		var calData1_ = [];
    	   	    		var calData2_ = [];
    	   	    		var calData3_ = [];
						var bCalData_ = [];
						var date = new Date();
						var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
						var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
						var lastDayOfMonth = (lastDay.getDate());
						var thisYM=date.getFullYear()+"-"+ (date.getMonth()+1);
						var daydiff = DateDiff(new Date($("#todate").val()),new Date($("#fromdate").val()));

						for( var i = 0; i <=daydiff; i++ ) {
							date=new Date($("#fromdate").val()).addDays(i);
	   	    				var tdy=("0"+date.getDate());
	   	    				var tmy = ("0"+(date.getMonth()+1));
	   	    				thisYM=date.getFullYear()+"-"+ tmy.slice(-2)+"-"+tdy.slice(-2);
							var chk1=0;
							
   	    					for( var j = 0; j <data["rtnList"].length; j++ )
   	    					{   	
   	    						if (data["rtnList"][j]["SACTION_DATE"]==(thisYM))
   	    						{
   	    							if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) > 0 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <12)
   	    							{
   	    								calData1_.push(parseInt(data["rtnList"][j]["STATE"])); 
   	    								chk1=1;
   	    								break;
   	    							}
   	    						}
   	    					}
   	    				
   	    					if (chk1==0)
   	    					{
   	    						calData1_.push(0); 
   	    					}

	   	    				bCalData_.push(date); 
	   	    			}
						
						for( var i = 0; i <=daydiff; i++ ) {
							date=new Date($("#fromdate").val()).addDays(i);
	   	    				var tdy=("0"+date.getDate());
	   	    				var tmy = ("0"+(date.getMonth()+1));
	   	    				thisYM=date.getFullYear()+"-"+ tmy.slice(-2)+"-"+tdy.slice(-2);
							var chk2=0;
							
   	    					for( var j = 0; j <data["rtnList"].length; j++ )
   	    					{   	
   	    						if (data["rtnList"][j]["SACTION_DATE"]==(thisYM))
   	    						{
   	    							if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) > 12 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <15)
   	    							{
   	    								calData2_.push(parseInt(data["rtnList"][j]["STATE"])); 
   	    								chk2=1;
   	    								break;
   	    							}
   	    						}
   	    					}
   	    				
   	    					if (chk2==0)
   	    					{
   	    						calData2_.push(0); 
   	    					}
	   	    			}
						
						for( var i = 0; i <=daydiff; i++ ) {
							date=new Date($("#fromdate").val()).addDays(i);
	   	    				var tdy=("0"+date.getDate());
	   	    				var tmy = ("0"+(date.getMonth()+1));
	   	    				thisYM=date.getFullYear()+"-"+ tmy.slice(-2)+"-"+tdy.slice(-2);
							var chk3=0;
							
   	    					for( var j = 0; j <data["rtnList"].length; j++ )
   	    					{   	
   	    						if (data["rtnList"][j]["SACTION_DATE"]==(thisYM))
   	    						{
   	    							if (parseInt(data["rtnList"][j]["ACTION_HOUR"]) >=15 && parseInt(data["rtnList"][j]["ACTION_HOUR"]) <=23)
   	    							{
   	    								calData3_.push(parseInt(data["rtnList"][j]["STATE"])); 
   	    								chk3=1;
   	    								break;
   	    							}
   	    						}
   	    					}
   	    				
   	    					if (chk3==0)
   	    					{
   	    						calData3_.push(0); 
   	    					}
	   	    			}

			            $("#chart").kendoChart({
			                title: {
			                    text: "복약내역"
			                },
			                legend: {
			                   position: "top"
			                },
			                seriesDefaults: {
			                    stack: true
			                },
			                series: [{
			                    name: "아침",
			                    data: calData1_,
			                    color: "#f3ac32"
			                }, {
			                    name: "점심",
			                    data: calData2_,
			                    color: "#b8b8b8"
			                }, {
			                    name: "저녁",
			                    data: calData3_,
			                    color: "#bb6e36"
			                }],
			                valueAxis: {
			                    max: 5,
			                    line: {
			                        visible: false
			                    },
			                    minorGridLines: {
			                        visible: true
			                    }
			                },
			                categoryAxis: {
			                    categories: bCalData_,
			                    majorGridLines: {
			                        visible: false
			                    }
			                },
			                tooltip: {
			                    visible: true,
			                    template: "#= series.name #: #= value #"
			                }
			            });
    			},
    			fail: function(){},
    			complete: function(data){
    				
    			}
    		});   
        }

        Date.prototype.addDays = function(days)
        {
            var dat = new Date(this.valueOf());
            dat.setDate(dat.getDate() + days);
            return dat;
        }

        function DateDiff(date1, date2) {
            var datediff = date1.getTime() - date2.getTime(); //store the getTime diff - or +
            return (datediff / (24*60*60*1000)); //Convert values to -/+ days and return value      
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