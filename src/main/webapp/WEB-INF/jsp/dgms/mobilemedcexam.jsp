<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="keywords" content="Jiransecurity">
	  <title>문진표</title>
	<style type="text/css">
		/* reset */
		*{margin: 0;padding: 0;}
		body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,textarea,p,blockquote,th,td,input,select,textarea,button {margin:0;padding:0}
		img {border:0 none}
		dl,ul,ol,menu,li {list-style:none}
		blockquote, q {quotes: none}
		blockquote:before, blockquote:after,q:before, q:after {content:'';content:none}
		input,select,textarea,button {vertical-align:middle}
		button {border:0 none;background-color:transparent;cursor:pointer}
		body {background:#fff}
		body,th,td,input,select,textarea,button {font-size:12px;line-height:1.5;font-family:'Nanum Gothic','맑은 고딕',Malgun Gothic,'돋움',dotum,sans-serif;, sans-serif;}
		a {color:#333;text-decoration:none}
		a:active, a:hover {text-decoration:underline}
		address,caption,cite,code,dfn,em,var {font-style:normal;font-weight:normal}
		caption{display: block;overflow: hidden;visibility: hidden;width: 0 !important;height: 0 !important;line-height: 0 !important;font-size: 0 !important}
		hr{display: none;}
		
		article{margin:10px;}
		fieldset{padding:30px 0; border-left:0; border-right:0; border-bottom:0;}
		legend{font-size:24px; margin:0 0 0 30px;}
		.container{margin:10px; border-bottom:solid 1px #acacac; padding:10px 0 10px 0;}
		p.qtitle{font-size:18px; font-weight:bold; color:#000000; margin:0 0 10px 0;}
		.container>ul>li{font-size:16px; padding:5px 0 5px 20px;}
		.container>ul>li>ul{padding:0 0 0 27px;}
		input[type=radio]{width:20px; height:20px;}
		input[type=text]{outline:none; border:0; font-size:16px;}
		textarea{font-size:16px;}
		input.ck02{width:40px; border-bottom:solid 1px #acacac; text-align:center; }
		input.ck03{width:60px; padding:0 0 0 10px;}
		input.ck04{width:100px; border-bottom:solid 1px #acacac; text-align:center; }
		.bn{border:0;}
		.dh{}
		.mh{display:none;}
		.ta01{width:98%; height:100px;}
		<!--#sendData{border:0; padding:10px; width:100%; background-color:#eee;}-->
		#sendData{clear:both; border:solid 1px #c1c1c1; font-size:16px; width:100%; width:100%; padding:10px 0;
				  background-color:transparent; cursor:pointer}
		
		@media all and (min-width:0px) and (max-width:1278px){
			legend{font-size:1.1em;}
			p.qtitle{font-size:14px;}
			.container>ul>li{font-size:14px;}
			input[type=radio]{width:14px; height:14px;}
			.container>ul>li>ul>li{padding:5px 0;}
			.dh{display:none;}
			.mh{display:block;}
		}
	</style>	
	<script src="<c:url value='/resource/plugins/jQuery/jQuery-2.1.3.min.js'/>"></script>
	<script>
	var mAnswer, sAnswer, userId="${user_id}", count=${count}, SAnswerIndex=[-1,-1,-1,-1,-1,-1]<c:if test="${list[0].MANSWER_SEQ != null}">,ManswerSEQ=${list[0].MANSWER_SEQ}</c:if>;
	var selectClass = "mh";
	var unSelectClass = "dh";

	$(document).ready(function () {
		var windowWidth = $( window ).width();
		var getMAnswer, getSAnswer; 

		//화면별 클래스 선택 
		if( $( window ).width() > 1278){
			selectClass = "dh";
			unSelectClass = "mh";
		}else{
			selectClass = "mh";
			unSelectClass = "dh";
		}

		//저장된 환자의 데이터 불러오기
		if(count > 0){ 
			getMAnswer = "${list[0].MAIN_ANSWER}".split(','); 
			getSAnswer = [null,null,null,null,null,null]; 

			<c:if test="${list[0].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[0].MQUESTION_NUMBER-1}] = ${list[0].MQUESTION_NUMBER};
				getSAnswer[${list[0].MQUESTION_NUMBER-1}] = "${list[0].SUB_ANSWER}".split(',');
			</c:if>
			<c:if test="${list[1].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[1].MQUESTION_NUMBER-1}] = ${list[1].MQUESTION_NUMBER};
				getSAnswer[${list[1].MQUESTION_NUMBER-1}] = "${list[1].SUB_ANSWER}".split(',');
			</c:if>
			<c:if test="${list[2].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[2].MQUESTION_NUMBER-1}] = ${list[2].MQUESTION_NUMBER};
				getSAnswer[${list[2].MQUESTION_NUMBER-1}] ="${list[2].SUB_ANSWER}".split(',');
			</c:if>
			<c:if test="${list[3].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[3].MQUESTION_NUMBER-1}] = ${list[3].MQUESTION_NUMBER};
				getSAnswer[${list[3].MQUESTION_NUMBER-1}] = "${list[3].SUB_ANSWER}".split(',');
			</c:if>
			<c:if test="${list[4].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[4].MQUESTION_NUMBER-1}] = ${list[4].MQUESTION_NUMBER};
				getSAnswer[${list[4].MQUESTION_NUMBER-1}] = "${list[4].SUB_ANSWER}".split(',');
			</c:if>
			<c:if test="${list[5].MQUESTION_NUMBER != null}">
				SAnswerIndex[${list[5].MQUESTION_NUMBER-1}] = ${list[5].MQUESTION_NUMBER};
				getSAnswer[${list[5].MQUESTION_NUMBER-1}] = "${list[5].SUB_ANSWER}".split(',');
			</c:if>

			$("input[name=q001]:checked").prop('checked', false); 
			$("input[name=q002]:checked").prop('checked', false); 
			$("input[name=q003]:checked").prop('checked', false); 
			$("input[name=q004]:checked").prop('checked', false); 
			$("input[name=q005]:checked").prop('checked', false); 

			$("input[name=q001]").each(function(index, data){ inputValue(getMAnswer, data, $(this), 0, 1); }); 
			$("input[name=q002]").each(function(index, data){ inputValue(getMAnswer, data, $(this), 1, 2); }); 
			$("input[name=q003]").each(function(index, data){ inputValue(getMAnswer, data, $(this), 2, 2); });
			$("input[name=q004]").each(function(index, data){ inputValue(getMAnswer, data, $(this), 3, 3); });
			$("input[name=q005]").each(function(index, data){ inputValue(getMAnswer, data, $(this), 4, 1); }); 

			var tdata = (getSAnswer[5] == null || getSAnswer[5] == "") ? getSAnswer[5] : changeStr( String(getSAnswer[5]) , 1 ); 
			$("textarea[name=q006]").val(tdata);
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//저장된 데이터 입력 함수	
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 function inputValue(getMAnswer, data, obj, index ,st){    
			if(obj.val() == getMAnswer[index]){   
				if( obj.parent().hasClass(selectClass)==true ){
					data.checked = true;	
				}else if( obj.parent().hasClass(unSelectClass)==false ){
					data.checked = true;	
				}//if 
				if(SAnswerIndex[index] != -1){
					if(st == 1){
						inputSValue1(obj, SAnswerIndex[index]-1);
					}if(st == 2){
						inputSValue2(obj, SAnswerIndex[index]-1);
					}if(st == 3){
						inputSValue3(obj, SAnswerIndex[index]-1);
					}
				}
			}//if 
		}
		
		function inputSValue1(obj, index){
			obj.parent().children("input[type=text]").each(function(index2, data2){
				data2.value = getSAnswer[index][index2];
			});	
		}
 
		function inputSValue2(obj, index){ 
			var subIndex=0; 
			
			obj.parent().children("ul").each(function(index2, data2){			//ul
				$(this).children("li").each(function(index3, data3){			//li
					if( $(this).hasClass(selectClass)==true ){
						$(this).children("input[type=text]").each(function(){	//input
							$(this).val(getSAnswer[index][subIndex]);
							subIndex++;
						});
					}else if($(this).hasClass(unSelectClass)==false ){
						$(this).children("input[type=text]").each(function(){	//input
							$(this).val(getSAnswer[index][subIndex]);
							subIndex++;
						});
					}//if 
				});
			});
		} 

		function inputSValue3(obj, index){ 
			var subIndex = 0;
			
			obj.parent().children("input[type=text]").each(function(index2, data2){
				data2.value = getSAnswer[index][subIndex];
				subIndex++;
			});	
			
			obj.parent().children("ul").each(function(index2, data2){			//ul
				$(this).children("li").each(function(index3, data3){			//li
					if( $(this).hasClass(selectClass)==true ){
						$(this).children("input[type=radio]").each(function(){	//input
							if((this).val() == getSAnswer[index][subIndex]){
								$(this).prop('checked', true); 
								return;								
							}
						});
					}else if($(this).hasClass(unSelectClass)==false ){
						$(this).children("input[type=radio]").each(function(){	//input
							if($(this).val() == getSAnswer[index][subIndex]){
								$(this).prop('checked', true); 
								return;								
							}							
						});
					}//if 
				});
			});
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//전송버튼-동작-메인/서브 응답 데이터 추출
		$("#sendData").on("click", function(){ 
			mAnswer = [];
			sAnswer = []; 

			//문항 1~5번까지
			mAnswer.push($("input[name=q001]:checked").val());
			mAnswer.push($("input[name=q002]:checked").val());
			mAnswer.push($("input[name=q003]:checked").val());
			mAnswer.push($("input[name=q004]:checked").val());
			mAnswer.push($("input[name=q005]:checked").val());
						
			//sAnswer
			//문항1
			var qdata = "";
			arrayData(sAnswer, $("input[name=q001]:checked"), 0);  
			arrayData(sAnswer, $("input[name=q002]:checked"), 1);
			arrayData(sAnswer, $("input[name=q003]:checked"), 2);
			arrayData(sAnswer, $("input[name=q004]:checked"), 3);
			arrayData(sAnswer, $("input[name=q005]:checked"), 4);
			arrayData(sAnswer, $("textarea[name=q006]"), 5);
			createInquiry();
		});//sendData
			 

		//문진표 작성 함수
		function createInquiry(){
			var main = new Array(); 
			var inquiryName = "firstInquiry";
			
			for(var i=0; i<sAnswer.length; i++){
				var data = new Object();
				data.index = i+1;
				data.value = sAnswer[i];
				main.push(data);
			}
			var json = main; 

			params = {"SAnswerIndex":SAnswerIndex, <c:if test="${list[0].MANSWER_SEQ != null}">"ManswerSEQ": ManswerSEQ,</c:if> "userId": userId, "InquiryName" : inquiryName, "mAnswer" : "{"+mAnswer+"}", "sAnswer" : json };
			params ="list="+JSON.stringify(params);

			 //params = {"t":"1" ,"a":"3"};
			$.ajax({
				url: ((count>0) ? "<c:url value='/appinf/updateMedcInquiry.do'/>" : "<c:url value='/appinf/setMedcInquiry.do'/>"),
				type: "post",
				//dataType: "json",
				data: params,
				//datatype:,
				success: function(data){ 
					if(data.result=="complete"){
						alert("문진표가 정상적으로 작성되었습니다.");
						//이동할 주소
						location.href = location.href;
					}else{
						alert("문제가 발생했습니다.");
					}
				},
				fail: function(e){ 
					
				}
			});
		} //createInquiry
			 

		//서브응답 추출 함수
		function arrayData(sAnswer, data, index){
			var qdata="", cdata;  
			var cObj=data.parent().children();
	  
			cObj.each(function(i, e){ 
				if($(e).is("ul")){																	//1. ul

					var obj = $(e).children("li");  
						obj.each(function(j, f){  
							var cObj2 = $(f).children();	//li 내부의 elements

						if( !$(f).hasClass(unSelectClass) ){  
							if(cObj2.is("input[type=radio]") && cObj2.is(":checked")){		//1-2. input-radio   
									qdata += cObj2.val() + ",";	
							}else if(cObj2.is("input[type=text]")){								//1-2. input-text 
								var lidata = $(f).children("input[type=text]");
								lidata.each(function(k, g){
									var redata = $(g).val();
									qdata += redata + ",";
								});  
							}else if(cObj2.is("ul")){												//1-2. ul
								cObj2.children("li").each(function(l, h){ 
									if($(h).children().is(":checked")){	qdata += redata + ",";		}
								});
							} 
						} 
					});   
				}else if($(e).is("input[type=text]")){												//1. input 
					qdata += $(e).val() + ",";												 
				}else if($(e).is("textarea")){														//1. textarea
					qdata += changeStr( $(e).val(), 0 )+' ';    
				}
			});

			qdata = qdata.substring(0, qdata.length-1);  
			if(qdata != "" && qdata != null){  
				sAnswer[index] = qdata; 
			}
		} //arrayData

		//특문변환
		function changeStr(str, id){ 
			//변환기호 : < > \ / @ " ' ; | &
			if(id==0){
				str = str.replace(/;/gi, '#59;').replace(/>/gi,"#62;").replace(/</gi,"#60;").replace(/\n/gi, "<br>").replace(/\|/gi, "#124;").replace(/&/gi, "#38;")
				.replace(/"/gi, '#34;').replace(/'/gi, '#39;').replace(/\//gi, '#47;').replace(/@/gi, "#64;").replace(/\\/gi, "#92;");
			}else{ 
				str = str.replace(/<br>/gi, "\n").replace(/#34;/gi, '"').replace(/#39;/gi, "'").replace(/#62;/gi,">").replace(/#60;/gi,"<").replace(/#38;/gi, "&")
				.replace(/#64;/gi, "@").replace(/#124;/gi, "\|").replace(/#47;/gi, '/').replace(/#59;/gi, ';').replace(/#92;/gi, "\\");
			}  
			return str;
		}//changeStr 

	});	//jquery.ready
 
	</script> 
</head>
<body>
		<div class="wrap">
			<article>
				<section>
					<fieldset>
						<legend>해당하는 항목에 체크 및 기재해 주십시요
						
						
						
						
						</legend>
						<div class="container">
							<p class="qtitle">1) 흡연을 하십니까?</p>
							<ul>
								<li><input type="radio" name="q001" value='N' class="ck01"  checked="checked" /> 아니요</li>
								<li class="dh"><input type="radio" value='M' name="q001" class="ck01" /> 과거에 피웠으나 현재는 비흡연 - 금연기간 <input type="text" name="q001_01" class="ck02 q001 q001_in" />년</li>
								<li class="mh"><input type="radio" value='M' name="q001" class="ck01" /> 과거에 피웠으나 현재는 비흡연<br />&nbsp;&nbsp;&nbsp;&nbsp;- 금연기간 <input type="text" name="q001_01" class="ck02 q001 q001_in" />년</li>
								<li class="dh"><input type="radio" value='Y' name="q001" class="ck01" /> 예 - 흡연기간 <input type="text" name="q001_02" class="ck02 q001 q001_in2" />년 하루 흡연량(<input type="text" name="q001_03" class="ck03 q001 q001_in2" />)</li>
								<li class="mh"><input type="radio" value='Y' name="q001" class="ck01" /> 예 - 흡연기간 <input type="text" name="q001_02" class="ck02 q001 q001_in2" />년<br />&nbsp;&nbsp;&nbsp;&nbsp;하루 흡연량(<input type="text" name="q001_03" class="ck03 q001 q001_in2" />)</li>
							</ul>
						</div>
		
						<div class="container">
							<p class="qtitle">2) 음주를 하십니까?</p>
							<ul>
								<li><input type="radio" name="q002" value="N" class="ck01"  checked="checked" /> 아니요</li>
								<li><input type="radio" name="q002" value="Y" class="ck01" /> 예 - 
									<ul id="da02">
										<li>1주일에 평균 (<input type="text" name="" class="ck03 q002 q002_in" />)회</li>								
										<li class="dh">1회 음주 시 술의 종류 (<input type="text" name="" class="ck03 q002 q002_in" />), 음주량(<input type="text" name="" class="ck03 q002 q002_in" />)병, (<input type="text" name="" class="ck03 q002 q002_in" />)잔</li>
										<li  class="mh">1회 음주 시 술의 종류 (<input type="text" name="" class="ck03 q002 q002_in" />),<br />
										음주량(<input type="text" name="" class="ck03 q002 q002_in" />)병,<br />
										(<input type="text" name="" class="ck03 q002 q002_in" />)잔</li>
									</ul>
								</li>
							</ul>
						</div>
		
						<div class="container">
							<p class="qtitle">3) 규칙적인 운동을 하십니까?</p>
							<ul>
								<li><input type="radio" name="q003" value='N' class="ck01" checked="checked" /> 아니요</li>
								<li><input type="radio" name="q003" value="Y" class="ck01" /> 예 - 
									<ul>
										<li class="dh">1주일에 (<input type="text" name="" class="ck03 q003 q003_in" />)회, 1회 운동시간 (<input type="text" name="" class="ck03 q003 q003_in" />시간 <input type="text" name="" class="ck03 q003 q003_in" />분)</li>
										<li class="mh">1주일에 (<input type="text" name="" class="ck03 q003 q003_in" />)회,<br />1회 운동시간<br />(<input type="text" name="" class="ck03 q003 q003_in" />시간 <input type="text" name="" class="ck03 q003 q003_in" />분)</li>	
										<li>주로하는 운동의 종류 (<input type="text" name="" class="ck03 q003 q003_in" />)</li>
									</ul>
								</li>
							</ul>
						</div>
		
						<div class="container">
							<p class="qtitle">4) 최근 3개월 동안 갑작스런 체중변화가 있었습니까?</p>
							<ul>
								<li><input type="radio" name="q004" value='N' class="ck01" checked="checked" /> 아니요</li>
								<li><input type="radio" name="q004" value="Y" class="ck01" /> 예 - <input type="text" name="" class="ck02 q004 q004_in" />kg
									<ul id="da03">
										<li><input type="radio" name="q004_in2" class="ck01 q004 q004_in2" value="증가" /> 증가</li>								
										<li><input type="radio" name="q004_in2" class="ck01 q004 q004_in2" value="감소" /> 감소</li>
									</ul>
								</li>
							</ul>
						</div>
		
						<div class="container">
							<p class="qtitle">5) 현재 복용중인 약이 있으면 체크를 해 주십시오</p>
							<ul>
								<li><input type="radio" name="q005" value="아스피린" class="ck01" checked="checked" /> 아스피린 (항혈소판제)</li>
								<li><input type="radio" name="q005" value="당뇨약" class="ck01" /> 당뇨약</li>
								<li><input type="radio" name="q005" value="고혈압약" class="ck01" /> 고혈압약</li>
								<li><input type="radio" name="q005" value="기타" class="ck01" /> 기타 <input type="text" name="" class="ck04 q005 q005_in" /></li>
							</ul>
						</div>
		
						<div class="container bn"><!-- bn -->
							<p class="qtitle">6) 과거력(의사로부터 진단 받은 적이 있는 질병에 모두 기재해 주십시오)</p>
							<ul>
								<li>
									<textarea class='ta01 q006' name='q006'></textarea>
								<!-- table view area  -->
								</li>
							</ul>
						</div>
						<div class="container bn">
							<c:choose> 
								<c:when test="${count} > 0">
									<input type="button" id="sendData" value="수정하기" />
								</c:when>
								<c:otherwise>
									<input type="button" id="sendData" value="전송하기" />
								</c:otherwise>
							</c:choose>							
						</div>
				</fieldset>
			</section>
		</article> 
	</div>
</body>
</html>