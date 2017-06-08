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
<div id="details"></div>
<script type="text/x-kendo-template" id="template"></script>
<script> 
    
    var wnd, detailsTemplate; 
    
    wnd = $("#details")
        .kendoWindow({
            title: "심전도 보기",
            modal: true,
            visible: false,
            resizable: false,
            width: 1000,
            height:800,
            close: function(e) {
                window.close();
            }
        }).data("kendoWindow");
    
    detailsTemplate = kendo.template($("#template").html());
    

	function viewEcg(name, url){
		var msg = '<div id="details-container"><h2>'+name+'님 심전도</h2>';
        var display_el = (url == null || url == 'NOFILE' ? "none" :"block");
        
        if(url != 'NOFILE'){
        	var url2 = url + "?random=" + Math.floor((Math.random() * 100000000000000000000) + 1);
        	msg += '<div id="ecg_caution2">마지막으로 올라온 심전도 이미지를 표시합니다.<br />'
        	+'<input type="button" id="rbtn" onclick="javascript:rotation(90, \'canvas\', \'ecgImg\', \'ecgImg2\', \''+url+'\')" value="90도 회전하기" /></div>'
        	+'<canvas id="canvas" style="transform: translate3d(0px, 0px, 0px) scale3d(1, 1, 1); display: none;" width="332" height="400"></canvas>'
   
			+'<img id="ecgImg" src="' + url2 + '" style="display: '+display_el+'" data-evernote-hover-show="true">'
			+'<div id="imgView" style="display:none;"><img id="ecgImg2" src="'+url2+'" style="display: '+display_el+'" />';
        }else{
        	msg += '<div id="ecg_caution">심전도 이미지가 없습니다.</div>';
        }
        msg += '</div>';
        
        wnd.content(msg);
        wnd.center().open();
        
        rotation(0, 'canvas', 'ecgImg', 'ecgImg2');
	}
	
	viewEcg('${name}','${url}');
	
	
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