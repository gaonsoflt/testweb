<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="./inc/header.jsp" %>
<div class="visual_area">
	<div class="sub_visual">
		<div class="svisual_text">
			<h2 class="cat01">서비스개요</h2>
			<p>서비스 조건 및 서비스 신청절차를 알려 드립니다.</p>
		</div>

		<div class="msnb">
			<ul>
				<li><a href="#" target="_self" class="on">서비스소개</a></li>
				<li><a href="#" target="_self">돌보미 툰</a></li>
				<li><a href="#" target="_self">복지기동대 자료</a></li>
			</ul>
		</div>
		
		<div class="visual_img">
			<ul>
				<li><img src="<c:url value='/resource/hp/common/images/sub/img_svisual_01.jpg'/>"></li>
			</ul>
		</div>
	</div><!-- sub_visual -->
</div><!-- visual_area -->

<article>
	<section class="scontainer">
		<div class="section_header">
		<div class="shl">
			<h3 class="conti">서비스 소개</h3>
			<div class="navi">
				<p>HOME<span>&gt;</span>서비스 개요<span>&gt;</span>서비스 소개
			</div><!-- navi -->
		</div>
			<div class="scb">
				<ul>
					<li><a href="#"><img src="<c:url value='/resource/hp/common/images/sub/icon_link.gif'/>">공유</a></li>
					<li><a href="#"><img src="<c:url value='/resource/hp/common/images/sub/icon_print.gif'/>">프린트</a></li>
				</ul>
			</div>
		</div><!-- section_header -->

		<div class="section_body">
		<div class="crow">
			<h4 class="dn">서비스소개</h4>
			<dl class="cl02">
				<dt>보다 행복한 가족을 위한 생활안전 서비스&quot;돌보미&quot; 서비스 조건 및 서비스신청 절차</dt>
				<dd class="cdbg01">
					<p>서비스조건</p>
					<ul>
						<li>고령 부모로 고혈압 및 심장질환으로<br />병원에 다니는 대상자 또는 의심자.</li>
						<li>휴대폰(스마트폰, 피처폰)을 활용하는 분으로<br />기본적 신체활동이 가능한 분</li>
					</ul>
				</dd>
				<dd class="cdbg02">
					<p>서비스신청절차</p>
					<ul>
						<li>지원신청서 및 참여동의서 작성 및 접수</li>
						<li>신청자의 건강상태에 대한 문진표 작성</li>
						<li>개인여건을 고려하여 기기사용(혈압기 등)에 대한<br />이용교육을 실시</li>
					</ul>
					<button class="btndw">신청서 내려받기</button>
				</dd>
			</dl>
		</div>
		</div><!-- section_body -->
	</section>
</article>
        
<%@ include file="./inc/footer.jsp" %>