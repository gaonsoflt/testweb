<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<!-- 내용 -->
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-caret-right"></i>${menu.menu_nm} <small>${menu.menu_desc}</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> ${menu.main_nm}</a></li>
			<li class="active">${menu.menu_nm}</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-body">
						<!-- jQuery Plug-Ins Widget Initialization -->
						<p id="searchArea" style="font-size: 15px; padding: 10px 0px;">
							검색&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="in_search" /> 
							<input id="in_keyword" /> 
							<input id="in_searchDate" />
							<input id="in_user" /> 
							<button id="searchBtn" type="button">조회</button>
						</p>
						<button type="button">글쓰기</button>
						<div id="gridList"></div>
					</div>
				</div> <!-- box -->
			</div> <!-- col-xs-12 -->
		</div> <!-- row -->
	</section>
</div>

<div id="window" style="display:none;">
	<div>
		<button id="delete-btn" data-role="button" data-icon="close" data-bind="click: remove" style="float:right;margin:10px 10px 0 0;">삭제</button>
		<button id="save-btn" data-role="button" data-icon="pencil" data-bind="click: save" style="float:right;margin:10px 10px 0 0;">저장</button>
		<button id="cancel-btn" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">취소</button>
	</div>
	<table style="width:100%;">
		<colgroup>
			<col width="50%">
			<col width="40%">
		</colgroup>
		<tbody>
			<tr>
				<td>
					<div style="width:100%;">
						<div>제목</div>
						<div><input id="title" class="bind_input" name="title" data-bind="value:selected.title" style="width:100%;" required/></div>
						<div>내용</div>
						<div><textarea id="content" name="content" data-bind="value:selected.content" placeholder="내용을 입력하시고 [저장]버튼을 눌러주세요." style="width:100%;height:500px;"></textarea></div>
					</div>
				</td>
				<td valign="top">
					<c:if test="${bbsInfo.use_attach == true}">
						<div>
							<div>첨부파일</div>
							<input type="file" class="file"/>
							<div id="file-list" style="border:2px solid #c9c9c9;min-height:50px"></div>
						</div>
					</c:if>
					<div id="reply" style="width:100%;">
						<div>댓글</div>
						<c:if test="${userStore.username != null}">
							<textarea rows="3" cols="80" id="replyText" name="replyText" placeholder="댓글을 입력하세요."></textarea>
							<button type="button" id="writeReply">댓글 등록</button>
						</c:if>
						<div id="reply-list" style="overflow:scroll;height:350px;"></div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-pager-refresh k-link k-button" id="add-btn" title="Create" onclick="return onClick(this);">등록</a>
	</div>
</script>                
            
<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_";
	var codeModles = "";
	var bbsViewModel;
	var bbsModel;
	var wnd;
	
	var today = kendo.date.today();
	var temp;
	
	$.ajax({
		type : "post",
		url : "<c:url value='/common/getCodeListByCdIDModel.do'/>",
		data : {
			"list" : codelist
		},
		async : false, //동기 방식
		success : function(data, status) {
			//codeModles = $.extend(codeModles, data.rtnList);
			codeModles = data.rtnList;
		},
		fail : function() {
		},
		complete : function() {
		}
	});

	function fnCodeNameByCdID(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].CD_ID == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}
	
	function fnCodeNameByCd(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].CD == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}

	var G_Condition = "ALL";
	var G_Keyword = ""; 
	var G_SEQ = 0;
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "제목", value : "TITLE" }, 
			{ text : "글쓴이", value : "USER_NAME" }, 
			{ text : "접속일", value : "ACCESS_DT" } 
		];
	
		$("#in_search").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : searchData,
			change : function() {
				G_Condition = $("#in_search").val();
				console.log("combobox change: " + G_Condition);
				if (G_Condition == "ALL") {
					$("#in_keyword").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
				} else if (G_Condition == "ACCESS_DT") {
					G_Keyword = "";
					$("#in_searchDate").data("kendoDatePicker").value(new Date());
					$("#searchArea .k-datepicker").css({ "display" : "inline-block" });
					$("#in_keyword").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					G_Keyword = kendo.toString(new Date(), "yyyy-MM-dd");
				} else if (G_Condition == "USER_NAME") {
					G_Keyword = "";
					$("#in_user").val("");
					$("#searchArea .k-autocomplete").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#in_keyword").css({ "display" : "none" });
				} else {
					G_Keyword = "";
					$("#in_keyword").val("");
					$("#in_keyword").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
				}
			},
			index : 0
		});

		/* 키워드 */
		$("#in_keyword").kendoMaskedTextBox({
			change : function(e) {
				G_Keyword = this.value();
			}
		});
		
		/*검색일자*/
		$("#in_searchDate").kendoDatePicker({
			culture : "ko-KR",
			format : "yyyy/MM/dd",
			parseFormats : [ "yyyy-MM-dd" ],
			value : new Date(),
			change : function(e) {
				G_Keyword = kendo.toString(this.value(), "yyyy-MM-dd");
			}
		});
	
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon : "search",
			click : function(e) {
				$("#gridList").data("kendoGrid").dataSource.read();
			}
		});
	
		/* 사용자명 */
		$("#in_user").kendoAutoComplete({
			dataSource : {
				transport : {
					read : {
						url : "<c:url value='/common/getAutoComplete.do'/>",
						dataType : "jsonp"
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						var result = {
							TABLE : "TB_USER_INFO",
							COLUNM : "USER_NAME"
						};
						return { params : kendo.stringify(result) };
					}
				}
			},
			dataTextField : "cd_nm",
			dataBound : function(e) {
			},
			change : function(e) {
				G_Keyword = this.value();
			}
		});
	    
	    $('input.file').MultiFile({
            max: 10, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
//             accept: 'jpg|png|gif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
            maxfile: 2048, //각 파일 최대 업로드 크기
            maxsize: 20480,  //전체 파일 최대 업로드 크기
            STRING: { //Multi-lingual support : 메시지 수정 가능
                remove : "삭제", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
                duplicate : "$file 은 이미 선택된 파일입니다.", 
                denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
                selected:'$file 을 선택했습니다.', 
                toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)", 
                toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
                toobig: "파일($file) 크기가 너무 큽니다. (max $size)"
            },
            list:"#file-list" //파일목록을 출력할 요소 지정가능

            //각각의 이벤트에 따라 스크립 처리를 할수있다.
            /*
            ,onFileRemove: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileRemove - ' + value + '</li>')
            },
            afterFileRemove: function(element, value, master_element) {
              $('#afile3-list').append('<li>afterFileRemove - ' + value + '</li>')
            },
            onFileAppend: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileAppend - ' + value + '</li>')
            },
            afterFileAppend: function(element, value, master_element) {
              $('#afile3-list').append('<li>afterFileAppend - ' + value + '</li>')
            },
            onFileSelect: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileSelect - ' + value + '</li>')
            },
            afterFileSelect: function(element, value, master_element) {
              $('#afile3-list').append('<li>afterFileSelect - ' + value + '</li>')
            },
            onFileInvalid: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileInvalid - ' + value + '</li>')
            },
            onFileDuplicate: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileDuplicate - ' + value + '</li>')
            },
            onFileTooMany: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileTooMany - ' + value + '</li>')
            },
            onFileTooBig: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileTooBig - ' + value + '</li>')
            },
            onFileTooMuch: function(element, value, master_element) {
              $('#afile3-list').append('<li>onFileTooMuch - ' + value + '</li>')
            }
            */

          });
	});

	function addNew(e) {
		// invisible delete button
		$("#delete-btn").css("display", "none");
		$("#reply").css("display", "none");
		// open window
		wnd.center().open();		
		bbsViewModel.set("selected", new bbsModel());
		bbsViewModel.dataSource.insert(0, bbsViewModel.selected);
		return false;
	}
	
	function onClick(e) {
		var id = e.id;
		console.log(id + " is clicked");
		if(id == 'add-btn') {
			console.log("add bbsViewModel");
			addNew(e);
		} 
    }
	
	function closeWindow(e) {
		wnd.close();
		G_SEQ = 0;
		$("#gridList").data("kendoGrid").dataSource.read();
	}
	
	function updateReply(){
		$("#replyText").val("");
        $.ajax({
            type: "get",
            url: "<c:url value='/bbs/board/reply/readList.do'/>",
            data: "buid=" + G_SEQ,
            success: function(result){
            	console.log(result);
            	temp = result;
                $("#reply-list").html(convertJSONToTag(result));
            }
        });
    }
	
	function deleteReply(seq){
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type : "get",
				url : "<c:url value='/bbs/board/reply/delete.do'/>",
				data : {
					"seq" : seq
				},
				success : function(data, status) {
					if(data.success) {
						alert("삭제되었습니다.");
					}
					updateReply();
				}
			});
		}
    }
	
	function convertJSONToTag(item, index) {
		var data = "<table><tbody>";
		item.forEach(function(v, i) {
			data += "<tr><td>";
			data += v.reg_usr + " / " + kendo.toString(new Date(Number(v.mod_dt)), 'yyyy-MM-dd hh:mm:ss');
			if(v.reg_usr == "${userStore.username}") {
				data += " <a href='javascript:deleteReply(" + v.reply_seq + ")'>삭제</a>";
			}
			data += "<br>" + v.reply;
			data += "</td></tr>";
		});
		data += "</tbody></table>";
		return data;
	}
	
	$(document).ready(function() {
		
		$("#writeReply").click(function() {
			console.log("writeReply");
			var replyText = $("#replyText").val();
			if(replyText != '') {
				$.ajax({
					type : "post",
					url : "<c:url value='/bbs/board/reply/create.do'/>",
					data : {
						"text" : replyText,
						"buid" : G_SEQ,
						"pSeq" : 0
					},
					success : function(data, status) {
						if(data.success) {
							alert("댓글이 등록되었습니다.");
						}
						updateReply();
					}
				});
			}
		});
		
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "",
            width: 1000,
            actions: [
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true,
            open: function(e) {
            	updateReply();
            	$('input:file').MultiFile('reset'); 
            }
        }).data("kendoWindow");
		
		var crudServiceBaseUrl = "${contextPath}/bbs/board";
		/*************************/
		/***    gridList     ***/
		/*************************/
		$("#gridList").kendoGrid({
			autoBind : true,
			dataSource : {
				transport : {
					read : { 
						url : crudServiceBaseUrl + "/readList.do", 
						dataType : "jsonp",
						complete: function(e){ 
					    	console.log("gridList:dataSource:read:complete");
					    }
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						if (type == "read") {
							var result = {
								PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
								bbs_seq : "${bbsInfo.bbs_seq}",
								CONDITION : G_Condition,
								KEYWORD : G_Keyword
							};
							return { params : kendo.stringify(result) };
						}

						if (type !== "read"
								&& data.models) {
							return {
								models : kendo.stringify(data.models)
							};
						}
					}
				},//transport end...
				schema : {
					data : function(response) {
						console.log(response.rtnList);
						return response.rtnList; 
					},
					total : function(response) { return response.total; },
					errors : function(response) { return response.error; },
					parse : function(response) { return response; },
					model : {//가져온 값이 있음...
						id : "bbs_uid",
						fields : {
							bbs_uid: { type : "string", editable : false },
							rnum : { type : "number", editable : false },
							title : { type : "string", editable : false },
							content : { type : "string", editable : false },
							recnt: { type : "number", editable : false },
							reg_dt : { type : "string", editable : false },
							reg_usr : { type : "string", editable : false },
							mod_dt : { type : "string", editable : false },
							mod_usr : { type : "string", editable : false }
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
				sync : function(e) {
					console.log("sync complete");
					alert("정상적으로 처리되었습니다.");
				},
				serverPaging : true, // 서버 사이드 페이징 활성화
				serverFiltering : false,
				serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
				//autoSync: true,          //     자동 저장
				batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			navigatable : true,
			pageable : true,
			height : 710,
            toolbar: kendo.template($("#toolbar-template").html()),
			columns : [
				{ field : "bbs_uid", title : "uid", hidden: true },
				{ field : "rnum", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
				// Todo: 제목 길이 제한 
				{ field : "title", title : "제목", attributes : { style : "text-align: left;" },
					template : "#= title # [#= recnt#]"},
				{ field : "reg_usr", title : "글쓴이", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "reg_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (reg_dt == '') ? '' : kendo.toString(new Date(Number(reg_dt)), 'yyyy-MM-dd hh:mm') #" }
				// Todo: 조회수 필드 추가 예정 
				/* 
				{ field : "expose_from", title : "게시시작", attributes : {	style : "text-align: center;" },
					template : "#= (expose_from == '') ? '' : kendo.toString(new Date(Number(expose_from)), 'yyyy-MM-dd HH:mm') #" },
				{ field : "expose_to", title : "게시종료", attributes : {	style : "text-align: center;" },
					template : "#= (expose_to == '') ? '' : kendo.toString(new Date(Number(expose_to)), 'yyyy-MM-dd HH:mm') #" },
				{ command: { 
					text : " ", click: showDetails, className: "fa fa-folder" }, title: "", width: "100px", attributes : {	style : "text-align: center;" } }
				*/
			],
			change: function(e) {
        		// find seq value in selected row  	
				var selectedItem = this.dataItem(this.select());
				G_SEQ = selectedItem.bbs_uid;
				console.log("selected item: " + G_SEQ + "(seq)");
                console.log(selectedItem);
                console.log("showDetails");
        		// read bbsViewModel by G_SEQ 
        		bbsViewModel.dataSource.read();
        		$("#delete-btn").css("display", "inline-block");
        		$("#reply").css("display", "inline-block");
                // open window
        		wnd.center().open();
			},
			sortable : true,
			selectable : "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
			excel : false,
			noRecords : {
				template: "검색된 결과가 없습니다."
			},
			pageable : {
				//refresh: true, //하단의 리프레쉬 아이콘
				pageSizes : true,
				//buttonCount: 1  //paging 갯수
				//input: true //페이지 직접입력
				//info: false //하단의 페이지 정보
				messages : {
					display : "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
					empty : "출력할 항목이 없습니다",
					itemsPerPage : "한 페이지에 출력할 항목 수"
				}
			},
			resizable : true, //컬럼 크기 조절
			reorderable : true //컬럼 위치 이동
		});//gridList end...
		
		/*
		 * view model for window data 
		 */
		bbsModel = kendo.data.Model.define({
			id: "bbs_uid",
			fields: {
				bbs_uid		:{ type: "string" },
				bbs_seq		:{ type: "string", defaultValue: "${bbsInfo.bbs_seq}" },
				title		:{ type: "string" },
				content		:{ type: "string" },
				mod_dt		:{ type: "string" },
				mod_usr		:{ type: "string" },           
				reg_dt		:{ type: "string" },
				reg_usr		:{ type: "string" }           
			}
		});
		
	    /*** dataSource ***/
		bbsViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/read.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("complete /read.do...................");
		    			}
					},
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								bbs_seq : "${bbsInfo.bbs_seq}",
								bbs_uid : G_SEQ
							};
							return { params: kendo.stringify(result) }; 
						}
		               
						if (type !== "read" && data.models) {
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: bbsModel,
					data: function(response) {
						console.log("viewmodel data: ");
						console.log(response);
						return response;
					},
					total: function(response) {
						console.log("viewmodel total: " + 1);
						return 1;
					},
					errors: function(response) {
						console.log("viewmodel error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("viewmodel parse: ");
                    	return response;
					}
				},
		        error : function(e) {
			    	console.log('viewmodel error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("viewmodel change: set selected :");
		            var _data = this.data()[0];
					console.log(_data);
					if(typeof _data != "undefined") {
					} else {
						
					}
					bbsViewModel.set("selected", _data);
		        },
		        requestStart : function(e) {
				},
				requestEnd : function(e) {
					console.log("deployViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");
						closeWindow(e);
		        	} else if(e.type != 'read' && e.response.error != null) {
		        		e.preventDefault();
						this.cancelChanges();
		        		alert("문제가 발생하여 정상적으로 처리되지 않았습니다.");
		        	}
				},
		        sync: function(e) { 
		        	console.log("viewmodel save data: ");
     			    console.log(this.data()[0]);
				},
				dataBound: function(e){ 
					console.log("viewmodel dataBound");
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error" + e.errors);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            save: function (e) {
				console.log("kendo.observable:save");
				bbsViewModel.dataSource.data()[0].set("reg_usr", "${userStore.username}")
	        	bbsViewModel.dataSource.data()[0].set("mod_usr", "${userStore.username}")
	        	// convert tag for editor
	        	if( typeof $("#content").val() != "undefined" ){
	        		var inData = $("#content").val().replace(/\s/gi, '').replace(/&nbsp;|<p>|<\/p>/gi, '');
		        	if(inData.length < 1 || inData == null){
							alert("내용을 입력해주세요.");
				    	   	e.preventDefault();	
			        } else {
		            	this.dataSource.sync();
			        }//if
	        	}//undefined
            },
            remove: function(e) {
            	console.log("kendo.observable:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
					closeWindow();
                }
            },
            cancel: function(e) {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
                closeWindow();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), bbsViewModel);
	    		
		$("#content").kendoEditor({
			resizable: {
	        	content: true,
	        	toolbar: true
	        },
	        encoded: false
		});

		invokeUserAuth($("#add-btn"), 'kendoButton', 'C');
		invokeUserAuth($("#save-btn"), 'kendoButton', 'U');
		invokeUserAuth($("#delete-btn"), 'kendoButton', 'U');

	});//document ready javascript end...
</script>

<style>
#in_keyword, .k-datepicker, .k-autocomplete {
	display: none;
}

#in_keyword, .k-datepicker, #searchBtn {
	margin-left: 9px;
}

.k-grid td {
	white-space: nowrap;
	text-overflow: ellipsis;
}

#dropzone {
    border:2px dotted #3292A2;
    width:100%;
    height:70px;
    color:#92AAB0;
    text-align:center;
    font-size:24px;
    padding-top:12px;
    margin-top:10px;
}
</style>
<%@ include file="../inc/footer.jsp"%>