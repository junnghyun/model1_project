<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta property="og:image" content="https://www.tlj.co.kr/static/images/common/sns_tlj_logo.jpg" />
	<meta name="keywords" content="뚜레쥬르, 뚜레쥬르케익, 뚜레쥬르케이크, 맛있는케익, 케익추천, 케이크추천, 케이크배송, 케이크구매, 치즈케이크" />
	<meta name="description" content="뚜레쥬르의 달콤한 케이크를 디저트 타임과 생일, 기념일 등에 만나보세요. 모바일 구매 및 당일 배송 가능" />
	<title>뚜레쥬르의 달콤한 케이크를 디저트 타임과 생일, 기념일 등에 만나보세요. 모바일 구매 및 당일 배송 가능</title>
	<link rel="alternate" href="http://m.tlj.co.kr/">
	<link rel="canonical" href="http://www.tlj.co.kr/">
	<link rel="SHORTCUT ICON" href="/favicon.ico" />

	<link rel="stylesheet" type="text/css" href="../common/css/brand.css" />


	<script type="text/javascript" src="../common/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="../common/js/menu.js?v852692403"></script>
    <script type="text/javascript">
//		showMenuInfo("020300", "T"); // 페이지 타이틀
		$(document).ready(function(){
			showMenuInfo("020300", "L"); // 라인맵s
		});
	</script>

	<script type="text/javascript">
		setTimeout(function(){var a=document.createElement("script");
		var b=document.getElementsByTagName("script")[0];
		a.src=document.location.protocol+"//script.crazyegg.com/pages/scripts/0036/4517.js?"+Math.floor(new Date().getTime()/3600000);
		a.async=true;a.type="text/javascript";b.parentNode.insertBefore(a,b)}, 1);
	</script>
</head>

<body class="sub reform"><!-- 201607 BI 변경 class="reform" 추가 -->



<!-- wrap -->
<div id="wrap">
	<!-- skiplist-->
	<ul class="skiplist">
		<li class="skip"><a href="#skip_cnt">본문내용으로 바로가기</a></li>
		<li class="skip"><a href="#skip_gnb">주메뉴 바로가기</a></li>		
	</ul>
	<!-- //skiplist-->
	<!-- header -->
	<div id="header" >
		<div class="gnb_dim"></div>
		<div class="gnb_dim2"></div>
		<div class="headerWrap">
			<h1 class="logo"><a href="https://www.tlj.co.kr"><img src="../common/images/logo.png" alt="뚜레쥬르 로고" /></a></h1><!-- 201607 -->

			<!-- 검색영역 -->
			<ul class="top_search">
				<li>

					<fieldset>
						<legend>제품검색</legend>
						<form name="srch" method="get" action="/product/result.asp" onsubmit="return srchCheck(srch);">
							<label for="prod_name">
								<input type="text" id="prod_name" name="prod_name" value="" style="width:0;" class="ipt02" autocomplete="off" title="제품명 입력" placeholder="제품명을 입력해 주세요." />
							</label>
							<a href="#prod_name" id="btnSearch" class="btn_search" onclick="prodSrch(srch); return false"><img src="../common/images/btn_search1.png" title="검색" alt="검색" /></a>
							<span class="btn_close"><a href="#btnSearch" title="닫기">닫기</a></span>
						</form>
					</fieldset>
					<script type="text/javascript">
						var txtTopSearchBar = false;

						function srchCheck(srch){
							if($(".top_search .ipt02").width() >= 100){
								if (srch.prod_name.value == '') {
									alert("검색할 제품명을 입력해 주세요.");
									srch.prod_name.focus();
									return false;
								}
								return true;
							} else {
								return false;
							}
						}

						function prodSrch(srch) {
							if(!srchCheck(srch))
								return;

							if ($(".top_search .ipt02").width() < 100)
								return;

							srch.submit();
						}

						$(function(){
							
						});
					</script>
				</li>
			</ul>
			<!-- //검색영역 -->
			<!-- TopNavigationBar -->
			<ul class="tnb">
				<li style="/*display:none;*/">
					<a href="javascript:showMenuInfo('080000', 'U');" class="tnb_store">매장안내</a>
					
					<a href="/CJFVSite/login.html" class="tnb_login">로그인</a>
					
				</li>
			</ul>
			<!-- //TopNavigationBar -->
			<!-- GNB -->
						<div class="gnb">
				<ul>
					<li class="gnb_brand">
						<a id="skip_gnb" class="depth1" MENU_CODE="010000" depth="1">브랜드 소식</a>
						<ul class="depth2">
							<li><a MENU_CODE="010100" depth="2">브랜드 스토리</a></li>
							<li><a MENU_CODE="010200" depth="2">뚜레쥬르 광고</a></li>
							<li><a MENU_CODE="010800" depth="2">뚜레쥬르 재료 이야기</a></li>
							<li><a MENU_CODE="010500" depth="2">글로벌 뚜레쥬르</a></li>
							<li><a MENU_CODE="010400" depth="2">뚜레쥬르 라뜰리에</a></li>
							<li><a MENU_CODE="010700" depth="2">뚜레쥬르 착한빵</a></li>
							<li><a MENU_CODE="010600" depth="2">뉴스 &amp; 공지사항</a></li>
						</ul>
					</li>
					<li class="gnb_product">
						<a class="depth1" MENU_CODE="020000" depth="1">제품</a>
						<ul class="depth2">
							<li><a MENU_CODE="020200" depth="2">빵</a></li>
							<li><a MENU_CODE="020300" depth="2">케이크</a></li>
						</ul>
					</li>
					<!-- 2023-03-27 수정 S //-->
					<li class="gnb_shop">
						<a class="depth1" MENU_CODE="990000" depth="1">장바구니</a>
						<ul class="depth2">
							<li><a MENU_CODE="990100" depth="2">뚜레쥬르 앱</a></li>
							<li><a MENU_CODE="990200" depth="2">홈페이지 전용 예약 배송</a></li>
							<li><a MENU_CODE="990300" depth="2">꽃&amp;케이크 택배 배송</a></li>
							<li><a class="last" MENU_CODE="990400" depth="2">대량 구매 문의</a></li>
						</ul>
					</li>
					<!--// 2023-03-27 수정 E -->
				</ul>
			</div>
			
			<script type="text/javascript">
			$(document).ready(function() {
				var $gnb = $(".gnb ");
				
				$gnb.find("a[MENU_CODE]").each(function() {
					$(this).attr("href", "javascript:showMenuInfo('" + $(this).attr('MENU_CODE') + "', 'U');");
				});
				
				var	MENU_CODE = "020300";
				var sMCode1 = MENU_CODE.substr(0, 2);//대메뉴코드(0~> 2자리)
				var sMCode2 = MENU_CODE.substr(2, 2);//중메뉴코드(2~> 2자리)
				var sMCode3 = MENU_CODE.substr(4, 2);//중메뉴코드(4~> 2자리) - GNB에서는 2depth까지만 표시되므로, 실제로 여기서 쓸일은 없지만
				$gnb.find("a[MENU_CODE='" + sMCode1 + "0000'][depth=1]").addClass("on");//대메뉴 on
				$gnb.find("a[MENU_CODE='" + sMCode1 + sMCode2 + "00'][depth=2]").addClass("on");//중메뉴 on
			});
			</script>

			<!-- //GNB -->
		</div>

	<div class="page_top">
		<div class="path"></div>
		<h2 class="page_title"><span class="tit_cake">케이크</span></h2>
	</div>
</div>
<!-- //header -->
<script type="text/javascript">
	$('#header').addClass('cake');
	$(document).ready(function(){
		showMenuInfo("020300", "T"); // 타이틀
		showMenuInfo("020300", "L"); // 라인맵
		/*
		var gnbOnNumber = parseInt("020300".substring(3,4)) - 1;
		$(".gnb_product ul.depth2 li:eq("+gnbOnNumber+") a").addClass("on");
		*/
	});
</script>
<!-- container -->
<div class="container">
	<div id="content">
		<div class="cnt_wrap product" id="skip_cnt">
			<div class="top_area">
				<!-- 홈페이지 플로팅 -->

<div id="dogs" style="display:none;">

</div>


				<!-- sort -->
				<div class="sort">
					<span class="lb_cake">Cake</span>
					<ul>
						<li><a href="list.asp?ref=3" class='on' title='선택됨'><span>전체</span></a></li><!-- 201607 -->
				
						<li><a href="list.asp?ref=3&cg_num=22" ><span>생크림케이크</span></a></li><!-- 201607 -->
				
						<li><a href="list.asp?ref=3&cg_num=20" ><span>캐릭터케이크</span></a></li><!-- 201607 -->
				
						<li><a href="list.asp?ref=3&cg_num=23" ><span>조각케이크</span></a></li><!-- 201607 -->
				
				
					</ul>
				</div>
				<!-- //sort -->

				<!-- 20160808 배너링크 수정 -->
				<div class="img_mobile_gift">
				

					<a href="/shop/shopping/goodsList.asp?cate=13&ordType=B" target="_blank" title="새창 열림"><img src="../common/images/shopping_basket.png" alt="장바구니" /></a>
				</div>
				<!-- //20160808 배너링크 수정 -->

				<!-- 추천제품 -->
				<!-- <div class="recomm product_list2"> -->

				<div class="recomm product_list2" style="overflow:visible;"><!-- 2015-06-11 스타일추가 -->

					<span class="lb_recomm"><img src="../common/images/lb_recomm.png" alt="추천제품"></span>
					<ul class="left_area">
		
						<li class="item_wrap">
							<a href="#">
								<span class="img">
									<img src="../common/images/cake/2024-9-12_event(2).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="백설공주_애플&망고케이크" />

								
									<span class="lb_new2">New</span>
								

								</span>
								<span class="info">
									<span class="name">백설공주_애플&망고케이크</span>
									<span class="txt_shape">1000원</span>
								</span>
							</a>
							<!-- Over -->
							<span class="over">
								<span class="desc">
							
								<a href="javascript:viewDetail('5128');">화이트 시트에 달콤한 애플 다이스와
애플 크림을 샌드하고 망고 크림으로 마무리해
드레스를 입은 백설공주를 표현한 ...</a>
								</span>
								<span class="btn_more2">
									<a href="javascript:viewDetail('5128');" class="btn st1" title="백설공주_애플&망고케이크">MORE</a><!-- 20160818 -->
								</span>
							</span>
							<!-- //Over -->
						</li>
					</ul>
					<ul class="right_area">
				
						<li class="item_wrap">
							<a href="#">
								<span class="img">
									<img src="../common/images/cake/2024-9-9_event(15).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="해피모먼트 생크림 케이크" width="160" height="160" />
								
									<span class="lb_new">New</span>
								
								</span>
								<span class="info">
									<span class="name">해피모먼트 생크림 케이크</span>
									<span class="txt_shape">1000원</span>
								</span>
							</a>
							<!-- Over -->
							<span class="over">
								<span class="desc">
							
								<a href="javascript:viewDetail('5104');">촉촉한 쌀 함유 시트 사이에 단맛을 줄여
부담없이 즐기는 딸기 생크림과 새콤달콤한
라즈...</a>
								</span>
								<span class="btn_more2">
									<a href="javascript:viewDetail('5104');" class="btn st1" title="해피모먼트 생크림 케이크">MORE</a><!-- 20160818 -->
								</span>
							</span>
							<!-- //Over -->
						</li>
		
						<li class="item_wrap">
							<a href="#">
								<span class="img">
									<img src="../common/images/cake/2024-9-26_event(45).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="더 고소한 호두 아몬드 케이크" width="160" height="160" />
								
									<span class="lb_new">New</span>
								
								</span>
								<span class="info">
									<span class="name">더 고소한 호두 아몬드 ...</span>
									<span class="txt_shape">1000원</span>
								</span>
							</a>
							<!-- Over -->
							<span class="over">
								<span class="desc">
							
								<a href="javascript:viewDetail('5103');">가을과 잘 어울리는 호두&아몬드
견과류 풍미를 담아 더 고소하게 즐기는
가을 신제품 케...</a>
								</span>
								<span class="btn_more2">
									<a href="javascript:viewDetail('5103');" class="btn st1" title="더 고소한 호두 아몬드 ...">MORE</a><!-- 20160818 -->
								</span>
							</span>
							<!-- //Over -->
						</li>
		
						<li class="item_wrap">
							<a href="#">
								<span class="img">
									<img src="../common/images/cake/2024-9-10_event(65).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="말차에 퐁당 딸기케이크" width="160" height="160" />
								
									<span class="lb_new">New</span>
								
								</span>
								<span class="info">
									<span class="name">말차에 퐁당 딸기케이크</span>
									<span class="txt_shape">1000원</span>
								</span>
							</a>
							<!-- Over -->
							<span class="over">
								<span class="desc">
							
								<a href="javascript:viewDetail('4988');">산뜻하고 달콤한 딸기 크림에
봄의 싱그러움을 듬뿍 머금은 말차 크림을 더한
그린 & 핑...</a>
								</span>
								<span class="btn_more2">
									<a href="javascript:viewDetail('4988');" class="btn st1" title="말차에 퐁당 딸기케이크">MORE</a><!-- 20160818 -->
								</span>
							</span>
							<!-- //Over -->
						</li>
		
						<li class="item_wrap">
							<a href="#">
								<span class="img">
									<img src="../common/images/cake/2024-9-10_event(24).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="스트로베리 리치 생크림" width="160" height="160" />
								
									<span class="lb_best2">Best</span>
								
								</span>
								<span class="info">
									<span class="name">스트로베리 리치 생크림</span>
									<span class="txt_shape">1000원</span>
								</span>
							</a>
							<!-- Over -->
							<span class="over">
								<span class="desc">
							
								<a href="javascript:viewDetail('4572');">상큼한 딸기에 풍부하고 달콤한 리치 과육을
더한 새콤달콤한 두 가지 과일 맛 생크림 케이...</a>
								</span>
								<span class="btn_more2">
									<a href="javascript:viewDetail('4572');" class="btn st1" title="스트로베리 리치 생크림">MORE</a><!-- 20160818 -->
								</span>
							</span>
							<!-- //Over -->
						</li>
		
					</ul>
				</div>
				<!-- //추천제품 -->
			</div>
			
			<!-- product_list -->
			<div class="product_list2">
				<ul id="product_list">
		
					<li class="item_wrap" id="p5128">
						<a href="#o5128">
							<span class="info">
								<span class="name">백설공주_애플&망고케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-12_event(2).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="백설공주_애플&망고케이크" width="160" height="160" />
							
								<span class="lb_new">New</span>
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o5128">
							<span class="info">
								<span class="name">백설공주_애플&망고케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('5128');">화이트 시트에 달콤한 애플 다이스와
애플 크림을 샌드하고 망고 크림으로 마무리해
드레스...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('5128');" class="btn st1" title="백설공주_애플&망고케이크">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p5104">
						<a href="#o5104">
							<span class="info">
								<span class="name">해피모먼트 생크림 케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-9_event(15).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="해피모먼트 생크림 케이크" width="160" height="160" />
							
								<span class="lb_new">New</span>
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o5104">
							<span class="info">
								<span class="name">해피모먼트 생크림 케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('5104');">촉촉한 쌀 함유 시트 사이에 단맛을 줄여
부담없이 즐기는 딸기 생크림과 새콤달콤한
라즈...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('5104');" class="btn st1" title="해피모먼트 생크림 케이크">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p5119">
						<a href="#o5119">
							<span class="info">
								<span class="name">해피모먼트 생크림 케이크(...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-9_event(18).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="해피모먼트 생크림 케이크(시즌)" width="160" height="160" />
							
								<span class="lb_new">New</span>
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o5119">
							<span class="info">
								<span class="name">해피모먼트 생크림 케이크(...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('5119');">촉촉한 쌀 함유 시트 사이에 단맛을 줄여
부담없이 즐기는 딸기 생크림과 새콤달콤한
라즈...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('5119');" class="btn st1" title="해피모먼트 생크림 케이크(...">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p5103">
						<a href="#o5103">
							<span class="info">
								<span class="name">더 고소한 호두 아몬드 케...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-26_event(45).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="더 고소한 호두 아몬드 케이크" width="160" height="160" />
							
								<span class="lb_new">New</span>
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o5103">
							<span class="info">
								<span class="name">더 고소한 호두 아몬드 케...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('5103');">가을과 잘 어울리는 호두&아몬드
견과류 풍미를 담아 더 고소하게 즐기는
가을 신제품 케...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('5103');" class="btn st1" title="더 고소한 호두 아몬드 케...">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p4376">
						<a href="#o4376">
							<span class="info">
								<span class="name">사르르 티라미수 생크림 쉬...</span>
								<span class="txt_shape">Cake</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-19_event(12).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="사르르 티라미수 생크림 쉬폰" width="160" height="160" />
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o4376">
							<span class="info">
								<span class="name">사르르 티라미수 생크림 쉬...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('4376');">풍미 좋은 커피시럽을 더한 폭신한 모카 쉬폰에
마스카포네 생크림을 샌드하고 연유 생크림으...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('4376');" class="btn st1" title="사르르 티라미수 생크림 쉬...">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p3828">
						<a href="#o3828">
							<span class="info">
								<span class="name">사르르 생크림 쉬폰</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-19_event(9).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="사르르 생크림 쉬폰" width="160" height="160" />
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o3828">
							<span class="info">
								<span class="name">사르르 생크림 쉬폰</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('3828');">폭신폭신한 쉬폰과 입안에서 사르르 녹는 
우유 생크림이 어우러진 케이크

* 상기 이...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('3828');" class="btn st1" title="사르르 생크림 쉬폰">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p3914">
						<a href="#o3914">
							<span class="info">
								<span class="name">사르르 초코 생크림 쉬폰</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-19_event(6).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="사르르 초코 생크림 쉬폰" width="160" height="160" />
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o3914">
							<span class="info">
								<span class="name">사르르 초코 생크림 쉬폰</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('3914');">폭신폭신 쉬폰과 사르르 녹는 달콤한
초코 생크림이 어우러진 쁘띠 케이크

* 상기 이...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('3914');" class="btn st1" title="사르르 초코 생크림 쉬폰">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p4671">
						<a href="#o4671">
							<span class="info">
								<span class="name">마담 얼그레이 케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-10_event(21).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="마담 얼그레이 케이크" width="160" height="160" />
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o4671">
							<span class="info">
								<span class="name">마담 얼그레이 케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('4671');">묵직한 바디감의 시트에 둘세 카라멜 가나슈와
얼그레이 풍미의 연유 생크림으로
그 맛을 ...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('4671');" class="btn st1" title="마담 얼그레이 케이크">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p4988">
						<a href="#o4988">
							<span class="info">
								<span class="name">말차에 퐁당 딸기케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-10_event(65).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="말차에 퐁당 딸기케이크" width="160" height="160" />
							
								<span class="lb_new">New</span>
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o4988">
							<span class="info">
								<span class="name">말차에 퐁당 딸기케이크</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('4988');">산뜻하고 달콤한 딸기 크림에
봄의 싱그러움을 듬뿍 머금은 말차 크림을 더한
그린 & 핑...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('4988');" class="btn st1" title="말차에 퐁당 딸기케이크">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
					<li class="item_wrap" id="p5081">
						<a href="#o5081">
							<span class="info">
								<span class="name">말차에 퐁당 딸기 케이크(...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="img">
								<img src="../common/images/cake/2024-9-10_event(60).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="말차에 퐁당 딸기 케이크(체리&거봉)" width="160" height="160" />
							
							</span>
						</a>
						<!-- Over -->
						<span class="over" id="o5081">
							<span class="info">
								<span class="name">말차에 퐁당 딸기 케이크(...</span>
								<span class="txt_shape">1000원</span>
							</span>
							<span class="desc">
							
								<a href="javascript:viewDetail('5081');">산뜻하고 달콤한 딸기 크림에
싱그러움을 듬뿍 머금은 말차 크림을 더한
그린&핑크빛의 사...</a>
							</span>
							<span class="btn_more2">
								<a href="javascript:viewDetail('5081');" class="btn st1" title="말차에 퐁당 딸기 케이크(...">MORE</a><!-- 20160818 -->
							</span>
						</span>
						<!-- //Over -->
					</li>
		
				</ul>
			</div>
			<!-- //product_list -->
		</div>
	</div>
</div>
<!-- //container -->



<form name="dform" id="dform" method="get" action="detail.asp">
<input type="hidden" name="gubun" value="list" />
<input type="hidden" name="ref" value="3" />
<input type="hidden" name="cg_num" value="" />
<input type="hidden" name="prod_num" id="prod_num" value="" />
<input type="hidden" name="page" id="page" value="" />
</form>

<script type="text/javascript">
	var endPage = false;
	var loadYn = false;
	var addListNum = 0;
	//scroll event
	$(window).scroll(function(){
		var callPoint = $(document).height() - $(window).height() - 400;
		if($(window).scrollTop() >= callPoint){
			if (!endPage && !loadYn) {
				loadYn = true;
				pdtList();
			}
		}
	});

	var pageNo = 1;
	function pdtList(){
		pageNo ++;
		$.ajax({
			url: 'list_ajax.asp'
			, data : {
				ref : '3',
				cg_num : '',
				page : pageNo
			}
			, dataType : 'html'
			, success : function(data){
				if ($.trim(data) != 'x') {
					addListNum = (pageNo - 1) * 10
					$('#product_list').append(data);
					loadYn = false;
				} else {
					endPage = true;
					pageNo --;
				}
			}
		});
	}

	function viewDetail(prodNum){
		$('#page').val(pageNo);
		$('#prod_num').val(prodNum);
		$('#dform').submit();
	}
</script>


	<p id="back-top">
		<a href="#top"><span></span>상위로 이동하기</a>
	</p>
	<!-- footer -->
	<div id="footer">
		<!-- Family Site -->
		<div class="family_site">
			<div class="buttonWrap">
				<!--button type="button" title="패밀리사이트 이전 목록 으로" class="prev">이전으로</button-->
				<div class="wrapList">
					<ul>
						<li>
							
			<li>
				<a href="https://www.cjfoodville.co.kr" target="_blank" title="CJ푸드빌 새창으로 열기" class="cj_foodville">CJ푸드빌</a>
				<a href="https://www.ivips.co.kr" target="_blank" title="빕스 새창으로 열기" class="vips">빕스</a>
				<a href="https://www.italiantheplace.co.kr:7022" target="_blank" title="더플레이스 새창으로 열기" class="the_place">더플레이스</a>
				<a href="https://www.cheiljemyunso.co.kr:7014" target="_blank" title="제일제면소 새창으로 열기" class="cheil">제일제면소</a>
				<!-- <a href="https://www.seasonstable.co.kr:7017" target="_blank" title="계절밥상 새창으로 열기" class="seasons_table">계절밥상</a> -->
				<a href="https://www.nseoultower.co.kr/visit/restaurant.asp" target="_blank" title="엔그릴 새창으로 열기" class="ngrill">엔그릴</a>
				<a href="http://www.nseoultower.co.kr" target="_blank" title="N SEOUL TOWER 새창으로 열기" class="ntower">N SEOUL TOWER</a>
			</li>

						</li>
					</ul>
				</div>
				<!--button type="button" title="패밀리사이트 이후 목록 으로" class="next">이후로</button-->
			</div>
			<!--script type="text/javascript">
			$(document).ready(function() {
				$(".family_site button.prev").click(function() {
					$('.wrapList ul').animate({'margin-left':'0'});
					return false;
				});

				$(".family_site button.next").click(function() {
					$('.wrapList ul').animate({'margin-left':'-1000'});
					return false;
				});
			});
			</script-->
		</div>
		<!-- //Family Site -->
		<div class="footerWrap">
			<ul>
				<li>
					<!-- Footer Menu -->
					
					<ul class="fnb">
						<!--li><a href="javascript:showMenuInfo('010101','U');" class="company">회사소개</a></li-->
						<li><a href="http://www.cjfoodville.co.kr/story/foodvilleintro.html" target="_blank" class="company"><img src="../common/images/footer_menu_01.png" alt="회사소개"></a></li>
						<li><a href="javascript:showMenuInfo('050000','U');" class="recruit"><img src="../common/images/footer_menu_02.png" alt="기사 채용안내"></a></li>
						<li><a href="https://www.cjfoodville.co.kr/footer/userpolicy.asp" class="foundation" target="_blank" title="새창 열림"><img src="../common/images/footer_menu_03.png" alt="이용약관"></a></li>
						<li><a href="https://www.cjfoodville.co.kr/footer/location.asp" class="location" target="_blank" title="새창 열림"><img src="../common/images/footer_menu_10.png" alt="위치기반서비스 이용약관"></a></li>
						<li><a href="javascript:showMenuInfo('060000','U');" class="clause"><img src="../common/images/footer_menu_04.png" alt="창업안내"></a></li>
						<li><a href="https://www.cjfoodville.co.kr/footer/privacy.asp" class="privacy" target="_blank" title="새창 열림"><img src="../common/images/footer_menu_05.png" alt="개인정보처리방침"></a></li>
						<li><a href="https://www.cjfoodville.co.kr/footer/media_policy.asp" class="media" target="_blank" title="새창 열림"><img src="../common/images/footer_menu_11.png" alt="영상정보처리기기 운영관리방침"></a></li><!-- 2023-07-13 추가 -->
						<li><a href="javascript:showMenuInfo('140000','U');" class="email"><img src="../common/images/footer_menu_06.png" alt="이메일무단수집거부"></a></li>
						<li><a href="http://www.cjfoodville.co.kr/footer/ethic_center.asp" class="ethic" target="_blank" title="새창 열림"><img src="../common/images/footer_menu_07.png" alt="윤리신고센터"></a></li>
						<li><a href="javascript:showMenuInfo('130000','U');" class="legal"><img src="../common/images/footer_menu_08.png" alt="법적고지"></a></li>
						<li><a href="javascript:showMenuInfo('150000','U');" class="sitemap2"><img src="../common/images/footer_menu_09.png" alt="사이트맵"></a></li>
					</ul>
					<!-- //Footer Menu -->
				</li>
				<li>
					<div class="info">
						<span class="business-name"><img src="../common/images/footer_info_business_name.png" alt="상호명:CJ푸드빌(주)"></span>
						<address><img src="../common/images/footer_info_address.png?v20210120" alt="주소:(우)04555 서울시 중구 마른내로34(초동 106-9번지)KT&G을지로타워 3, 9-11층 CJ푸드빌㈜"></address>
						<span class="cs-center"><img src="../common/images/footer_info_cs_center.png" alt="고객센터:1577-0700"></span>
						<span class="certificate">
							<img src="../common/images/footer_info_certificate.png" alt="통신판매업종신고증 제 2011-서울중구-0771호"><a href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=3128142519" target="_blank" title="새창열림"><img src="../common/images/footer_info_information.png" alt="사업자정보확인"></a>
						</span>
						<span class="hosting"><img src="../common/images/hosting.png" alt="호스팅제공자 : CJ올리브네트웍스(주)" /></span>
						<span class="business-num"><img src="../common/images/footer_info_business_num.png" alt="사업자등록번호:312-81-42519"></span>
						<span class="ceo"><img src="../common/images/footer_info_ceo.png?v20210120" alt="대표이사:김찬호"></span>
						<span class="manager"><img src="../common/images/footer_info_manager.png?v2211" alt="개인정보보호책임자:김재완"></span>
						<span class="email"><a href="mailto:help_master@cj.net"><img src="../common/images/footer_info_email.png" alt="대표 이메일:help_master@cj.net"></a></span>
					</div>
					<p class="copyright">COPYRIGHT 2024&copy;CJ Foodville ALL RIGHT RESERVED.</p>
				</li>
			</ul>
		</div>
	</div>
	<!-- //footer -->
</div>
<!-- //wrap -->
<div class="dim" id="modalOverlay" tabindex="-1"></div>
<script type="text/javascript">
// 모바일로 접근할경우
if ( (navigator.userAgent.match(/iPhone/i)) || ( navigator.userAgent.match(/Android/i) && navigator.userAgent.indexOf("Mobile") > -1 ) || (navigator.userAgent.match(/BlackBerry/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/Windows CE/i)) || (navigator.userAgent.match(/Symbian/i)))
{
	document.write("<div style='position:absolute;width:100%;height:130px;margin-top:322px;background-color:#fff; vertical-align:middle; font-size:70px; font-weight:bold; color:#000; text-align:center; padding-top:70px; border:2px solid #000;'><a href='http://m.tlj.co.kr'>모바일 버젼으로 보기</a></div>");
}
</script>
<script type="text/javascript" src="/static/js/common.js?V20220414"></script>
<script type="text/javascript" src="/static/js/modal-window.js"></script>
<script type="text/javascript" src="/static/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/static/js/bread.js"></script>
<script type="text/javascript">
	//딤드 이미지 공통
	function dimOpen() {
		var wfh = $('#wrap').height() + $('#footer').height();
		$('.dim').css('height', wfh).show();
	}

	function layerCenter(obj) {
		var layerTop = 0;
		layerTop = $(window).scrollTop() + (($(window).height() - obj.height()) / 2);
		obj.css('top', layerTop).show();
	}
</script>


	<Script>
	<!--
	//ssoLoginCheckNoJquery
	function GO_RELOAD()
	{
		var frm = document.ssologinfrm;
		//var url = "/product/list.asp?SSO=OK";

		
		var url = "/product/list.asp?ref=2";

		frm.action = url;
		//frm.submit();
		location.href = url;
	}

	function CJSSOQ_CEHCK()
	{
		var frm = document.ssologinfrm;

		var dataString = $("form[name='ssologinfrm']").serialize();
		$.ajax({
			url:"/CJFVInclude/SSO_V2/SSO_CHECK_V2.asp",
			type:"get",
			timeout:5000,
			data:dataString,
			error:function(xhr, status, e)
			{
				//alert(xhr.status + " : 에러가 발생했습니다.");
			},
			success:function(html)
			{
				var result = html

				if(result == "OK") {
					GO_RELOAD();
					return;
				}

				if(result == "RULE_GO") {
					var url = parent.location.href.toLowerCase();

					if(url.indexOf('mem_subscrib')<0) {
						parent.location.href='/CJFVSite/mem_subscrib.html';
					}

					return;
				}
				
				//14세 경우
				if(result == "RULE_GO_14") {
					var url = parent.location.href.toLowerCase();

					if(url.indexOf('mem_lra')<0){
						parent.location.href='/CJFVSite/mem_lra.html';
					}
					return;
				}

				//if(result == "RECOVER") {
					//top.location.href='/CJFVmember/LOGIN/dormancy/recoverDormant.html';
					//return;
				//}

				if(result == "RULE_XX") {
					//alert("복호화 NO !");
					return;
				}

				if(result == "NO") {
				//	alert("복호화 NO !");
					return;
				}

				/* else {
				//3.	alert("ETC !");
				//	alert(result);
					GO_RELOAD();
					return;
				}*/
			}
		});
	}
	-->
	</Script>
	<form name="ssologinfrm">
	<input  type="hidden"  id="cjssoq" name="cjssoq" />
	</form>

	
		<script type="text/javascript" src="https://nsso.cjone.com/findCookieSecured.jsp?cjssoq=lNS%2BkPF%2FpbLsaAFmc2qR7VHcvo8SBdz8VYI1Yelxpjso2%2BI%2BhGIijfr0SmwZNqzW9VbJBISGnzbh846lfWmCf1c0YlM4OFBGQ0pkN3pNVFMxbTkyaGIzY3ZBUS9MQmdZV3BYbTFHbHNFd1Nsam15MVpjRUduenBlTnd4SkJUTmk%3D"></script>
			<Script type="text/javascript">
			<!--
		function logout()
		{
			document.lgoForm.submit();
		}

		window.onload = function ()
		{
			var userId = "";
			//세션 정보가 없을경우
			if (userId == "null" || userId == "")
			{
				//SSO 쿠키가 있고 정상적으로 토큰을 발급받았을 경우
				if ((typeof _cjssoEncData) != "undefined" && _cjssoEncData != "")
				{
					//ajax를 사용해서 _cjssoEncData 를 복호화 하여 사용하셔도 무방합니다.
					//샘플을 경량화 시키기 위해 일반 페이지를 활용했습니다.

					document.getElementById("cjssoq").value = _cjssoEncData;

				//4.	alert("쿠키를 조사해보니 있어서 복호화 하러 갑니다.");
				CJSSOQ_CEHCK();
				} else {
					//alert("세션도 없고 쿠키도 없어서 로그인 페이지로 갑니다.")
					//self.location.href = "loginForm.asp";
				}
			}
		}
			-->
			</Script>


<!-- 구글 아날리틱스 추가 (2013-12-03) ↓ -->
<script type="text/javascript">
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46083485-1', 'www.tlj.co.kr');
  ga('send', 'pageview');
</script>
<!-- 구글 아날리틱스 추가 (2013-12-03) ↑ -->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-HPR8ZX3YQB"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-HPR8ZX3YQB');
</script>

<!--↓ 로그인 되어 있을 경우만 홈페이지 로그 저장!(2014-06-10)↓ -->

<!--↑ 로그인 되어 있을 경우만 홈페이지 로그 저장!(2014-06-10)↑ -->

</body>
</html>
