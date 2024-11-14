<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="headerAndFooter"%>
<!DOCTYPE html>
<html>
<head></head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="truetrue/common/css/common.css" />
<link rel="stylesheet" type="text/css" href="truetrue/common/css/main.css" />
<script type="text/javascript" src="truetrue/common/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="truetrue/common/js/menu.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta property="og:image" content="truetrue/common/images/sns_tlj_logo.jpg" />
<meta name="keywords" content="뚜레쥬르, 신선함, 갓구운, 베이커리, 빵, 케이크, 커피, 샌드위치, 케익, 뚜레쥬르매장, 이벤트, 할인혜택, 쇼핑몰, 배송, 뚜레쥬르 창업" />
<meta name="description" content="건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내" />
<title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
<link rel="alternate" href="http://m.tlj.co.kr/">
<link rel="canonical" href="http://www.tlj.co.kr/">
<link rel="SHORTCUT ICON" href="/favicon.ico" />
<meta name="viewport" content="width=1400" />
    <script type="text/javascript">
		$(document).ready(function(){
			showMenuInfo("000000", "L"); // 라인맵
		});
	</script>
    <script type="text/javascript">
		$(document).ready(function(){
			showMenuInfo("000000", "L"); // 라인맵
		});
	</script>

	<body bgcolor="#F7F0DA"></body>
<title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
	<div>
	<jsp:include page="truetrue/common/jsp/header.jsp"/>
	</div>
	<div class="main-slider4">
		<ul>
			<li class="img_main2"><img src="truetrue/common/images/img_main2.jpg" width="1400px" height="606px" alt="건강한 데일리 베이커리 - 건강하지만, 맛있어야, 맛있지만, 건강해야, 매일 먹을 수 있다는 평범한 원칙으로부터 뚜레쥬르의 오늘은 시작됩니다."/></li>
		</ul>
	</div>
	<div align="center">
		
			<jsp:include page="truetrue/common/jsp/coin_slider.jsp"/>
			<jsp:include page="truetrue/common/jsp/product_bread.jsp"/>
		<ul>
			<li>
				<a href="장바구니">
				<img alt="" src="truetrue/common/images/img_banner4.png" >
				</a>
				<a href="제품">
				<img alt="" src="truetrue/common/images/img_banner5.jpg">
				</a>
			</li>
		</ul>
<div class="section2" style="position: relative; width: 100%; max-width: 600px; margin-left: -395px; margin-top: 20px">
<ul>
<li>
    <img src="truetrue/common/images/trz.png" style="width: 100%; display: block; filter: brightness(0.5);">
    <div class="store_find" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 10; text-align: center;">
        <h2 class="hidden">매장찾기</h2>
        <p class="hidden">뚜레쥬르 매장을 찾아보세요.</p>
        <h2 style="margin: 0; padding: 0; line-height: 1.5; position: relative; top: 80px; color: #FFFFFF; font-size: 30px;">매장 찾기</h2>
        <h2 style="margin: 0; padding: 0; line-height: 1.5; position: relative; top: 80px; color: #FFFFFF; font-size: 15px;">가까운 뚜뚜뚜뚜 매장을 찾아보세요</h2>
        <fieldset class="srch_form" style="display: inline-block;">
            <legend>매장검색</legend>
            <form name="store" action="/store/search.asp" onsubmit="return goStore(store);" style="margin-right: 195px; margin-top: -60px">
                <label >
                    <input type="text" name="keyword" style="width: 150px;" class="ipt02" title="매장명 입력" placeholder="매장명이나 시/군/구 명 입력" onfocus="if(this.value == '매장명이나 시/군/구 명 입력') this.value=''" onblur="if(this.value == '') this.value='매장명이나 시/군/구 명 입력'" />
                </label>
                <input type="image" src="truetrue/common/images/btn_search.gif" class="btn_search" title="검색" alt="검색" />
            </form>

        </fieldset>
        	 <div class="new_div" style="text-align: center; margin-left:602px; margin-top: -226.7px; width: 390px; height: 270px; background-color: #333333">
  					<a href="매장안내"><img src="truetrue/common/images/market_info.png" width="390px" height="270px" style="display: block; filter: brightness(0.8);"></a>
        			<h2 style="margin: 0; padding: 0; line-height: 1.5; position: relative; top: -170px; color: #FFFFFF; font-size: 30px; font-family:'Nanum Barun Gothic';">매장 안내</h2>
        			<h2 style="margin: 0; padding: 0; line-height: 1.5; position: relative; top: -170px; color: #FFFFFF; font-size: 15px; font-family:'Nanum Barun Gothic';">매장에 대하여 알아보세요</h2>
   			</div>
	</div>
</li>

        
</ul>
   	 </div>

	</div>
	
<script type="text/javascript">
    function goStore(frm) {
        if (frm.keyword.value == '') {
            frm.keyword.focus(); return false;
        }
    }
</script>
			
	<jsp:include page="truetrue/common/jsp/footer.jsp"/>
	
</html>