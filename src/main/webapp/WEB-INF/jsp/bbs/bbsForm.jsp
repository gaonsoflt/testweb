<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='${menu.menu_url}'/>">${menu.menu_nm}</a>
				</li>
				<li class="crumb-link">
					<a href="#">${menu.main_nm}</a>
				</li>
				<li class="crumb-trail">${menu.menu_nm}</li>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted">${menu.menu_desc}</label>
			</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="row">
			<div class="col-md-12">
				<form id="bbs_form" action="${contextPath}/bbs/board/save.do" method="post" enctype="multipart/form-data" onsubmit="return fn_onsubmit(this);">
					<div>
						<c:if test="${boardInfo != null }">
							<button type="submit" name="action" value="delete" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.delete" text="delete" /></button>
						</c:if>
						<button type="submit" name="action" value="save" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.save" text="save" /></button>
						<button type="button" id="list-btn" onclick="fn_list();" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.list" text="list" /></button>
					</div>
					<input type="hidden" name="bbs" value="${bbsInfo.bbs_seq}"/>
					<c:if test="${boardInfo != null }">
						<input type="hidden" name="board" value="${boardInfo.board_id }"/>
					</c:if>
					<table style="width:100%;">
						<colgroup>
							<col width="50%">
							<col width="40%">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<div style="width:100%;">
										<div>
											<label for="title" class="col-lg-12 control-label">제목</label>
											<div class="col-lg-12">
                                          		<input type="text" id="title" name="title" class="form-control" value="<c:if test='${boardInfo != null}'>${boardInfo.title}</c:if>" required/>
                                     		</div>
										</div>
										<div>
											<label for="bbs-content" class="col-lg-12 control-label">내용</label>
											<div class="col-lg-12">
												<textarea id="bbs-content" name="bbs-content" class="form-control" style="height:600px;"></textarea>
											</div>
										</div>
									</div>
								</td>
								<c:if test="${bbsInfo.use_attach == true}">
									<td valign="top">
										<div>
											<label class="col-log-12 control-label">첨부파일</label>
											<div class="col-lg-12">
												<input type="file" id="files" class="file"/>
												<div id="file-list" style="border:2px solid #c9c9c9;min-height:200px"></div>
											</div>
										</div>
									</td>
								</c:if>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
	function fn_list() {
		location.href='${contextPath}/bbs/board.do?bbs=${bbsInfo.bbs_seq}';	
	}
	
	function fn_onsubmit(e) {
		var msg; 
		if(e.action.value == "save") {
			msg = "<spring:message code='msg.save'/>";
		} else if (e.action.value == "delete") {
			msg = "<spring:message code='msg.del'/>";
		}
		
		if(confirm(msg)) {
			return true;
		}
		return false;
	}
	
	$(function() {
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
	
	$(document).ready(function() {
		$("#bbs-content").kendoEditor({
			resizable: {
	        	content: false,
	        	toolbar: true
	        },
	        encoded: false
		});
		
		$("#bbs-content").data("kendoEditor").value("${boardInfo.content}");
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