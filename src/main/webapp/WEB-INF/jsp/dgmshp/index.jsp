<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="./inc/header.jsp" %>
<article class="main">
	<div class="main_visual">
		<div class="visual_text">
			<ul>
				<li><img src="<c:url value='/resource/hp/common/images/main/main_visual_text.png'/>" onclick="javascript:location.href='<c:url value='/dgms/main.do'/>'"></li>
			</ul>
		</div>
		
		<div class="visual_img">
			<ul>
				<li><img src="<c:url value='/resource/hp/common/images/main/img_main_visual.jpg'/>"></li>
			</ul>
		</div>
	</div><!-- main_visual -->

	<section class="container">
		<div class="row">
			<div class="br notice">
				<h3 class="ct">공지사항</h3>
				<p>대구노부모 돌보미 웹사이트 오픈</p>
				<span>09.16</span>
			</div>
		</div>

		<div class="row">
			<div class="col">
				<div class="br ban01">
					<h3 class="ct">TOON</h3>
					<div class="ban_btnarea">
						<button class="bbt"><img src="<c:url value='/resource/hp/common/images/main/btn_ban_bf.jpg'/>" alt="이전으로"></button>
						<button class="bbt"><img src="<c:url value='/resource/hp/common/images/main/btn_ban_sp.jpg'/>" alt="정지"></button>
						<button class="bbt"><img src="<c:url value='/resource/hp/common/images/main/btn_ban_af.jpg'/>" alt="다음으로"></button>
					</div><!-- ban_btnarea -->
					<div class="ban_con">
						<ul>
							<li><a href="#"><img src="<c:url value='/resource/hp/common/images/main/img_toon01.jpg'/>"></a></li>
						</ul>
					</div><!-- ban_con -->
				</div><!-- ban01 -->
			</div><!-- col -->

			<div class="col">

				<div class="srow">
					<div class="mban01">
						<a href="#" target="_self">
							<dl>
								<dt>대구 부모 돌보미<br /><span>알아보기</span></dt>
								<dd>대구 부모 돌보미 사업의<br />전반적인 내용을  소개해 드립니다.</dd>
							</dl>
						</a>
					</div><!-- mban01 -->
					<div class="mban02">
						<a href="#" target="_self">
							<dl>
								<dt>대구 부모 돌보미<br /><span>신청서 양식</span></dt>
								<dd>대구 부모 돌보미 사업의<br />전반적인 내용을  소개해 드립니다.</dd>
							</dl>
						</a>
					</div><!-- mban02 -->
					<div class="mban03">
						<a href="#" target="_self">
							<dl>
								<dt>돌보미 소식지<br /></dt>
								<dd>대구 부모 돌보미 사업의<br />전반적인 내용을  소개해 드립니다.</dd>
							</dl>
						</a>
					</div><!-- mban03 -->
				</div><!-- srow-->

				<div class="srow">
					<div class="mcha01 mr20">
						<h3>대한민국 농촌 노인 돌연사 발생빈도</h3>
						<div class="chart_area">
							<img src="<c:url value='/resource/hp/common/images/main/img_ex.jpg'/>">
						</div>
					</div><!-- mcha01 -->
					<div class="mcha01">
						<h3>대한민국 농촌 노인 돌연사 발생빈도</h3>
						<div class="chart_area">
							<img src="<c:url value='/resource/hp/common/images/main/img_ex.jpg'/>">
						</div>
					</div><!-- mcha01 --> 
				</div><!-- srow -->

			</div><!-- col -->
		</div><!-- row -->
	</section>
</article>
        
<%@ include file="./inc/footer.jsp" %>