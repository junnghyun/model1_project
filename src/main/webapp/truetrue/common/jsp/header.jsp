<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="header_project_1"%>
    <style type="text/css">
	
.gnb_brand > li {
  align-content: center;
  width: 20%; /*20*5=100%*/
  float: left;
  text-align: center;
  line-height: 40px;
  font-family:'Nanum Barun Gothic';
}

.gnb_brand a {
  color: #fff;
}

.submenu > li {
  line-height: 50px;
}

.store_find > h2 {
font-family:'Nanum Barun Gothic';

}

.submenu {
  height: 0; /*ul의 높이를 안보이게 처리*/
  overflow: hidden;
}
.gnb_brand > li:hover {
  background-color: #0D4633;
  transition-duration: 0.5s;
}
.gnb_brand > li:hover .submenu {
  height: 100px;
  transition-duration: 0.4s;
}
.search_img_tr {
  z-index: -1;
}
.srch_form{
 z-index: 1;
}
#store_find{
 background-image: "truetrue/common/images/trz.png";
}
.store_find{
 background-image: "truetrue/common/images/trz.png";
}

	</style>
<body class="main reform">
	<div id="header" >
		<div class="gnb_dim"></div>
		<div class="gnb_dim2"></div>
		<div class="headerWrap">
			<h1 class="logo"><a href="링크넣어야됨"><img src="truetrue/common/images/logo.png" alt="뚜레쥬르 로고" /></a></h1><!-- 201607 -->
			<ul class="top_search">
				<li>

					<fieldset>
						<legend>제품검색</legend>
						<form name="srch" method="get" action="/product/result.asp" onsubmit="return srchCheck(srch);" style="margin-left: -120px;">
							<label for="prod_name">
								<input type="text" id="prod_name" name="prod_name" value="" style="width:100;" class="ipt02" autocomplete="off" title="제품명 입력" placeholder="제품명을 입력해 주세요."  />
							</label>
							<a href="#prod_name" id="btnSearch" class="btn_search" onclick="prodSrch(srch); return false"><img src="truetrue/common/images/btn_search1.png" title="검색" alt="검색" /></a>
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
			<ul class="tnb">
				<li style="/*display:none;*/">
					<a href="매장안내링크넣어주세요" class="tnb_store"><img src="truetrue/common/images/info_market.png"></a>
					<a href="고객센터링크넣어주세요" class="tnb_customer"><img src="truetrue/common/images/faq.png"></a>
					<a href="로그인링크넣어주세요" class="tnb_login"><img src="truetrue/common/images/login_btn.png"></a>
				</li>
			</ul>
			<!-- //TopNavigationBar -->
			<!-- GNB -->
						<div class="gnb">
				<ul class="gnb_brand">
	  <li>
        <a style="font-size: 15px" >&nbsp;</a>
      </li>
	  <li>
        <a href="매장안내링크" style="font-size: 15px" >매장안내</a>
      </li>
      <li>
        <a href="제품링크" style="font-size: 15px">제품</a>
        <ul class="submenu">
          <li><a href="빵링크" style="font-size: 15px">빵</a></li>
          <li><a href="케이크링크" style="font-size: 15px">케이크</a></li>
        </ul>
      </li>
      <li>
        <a href="장바구니링크" style="font-size: 15px;" >장바구니</a>
      </li>
				</ul>
			</div>
			
			<script type="text/javascript">
			$(document).ready(function() {
				var $gnb = $(".gnb ");
				
				$gnb.find("a[MENU_CODE]").each(function() {
					$(this).attr("href", "javascript:showMenuInfo('" + $(this).attr('MENU_CODE') + "', 'U');");
				});
				
				var	MENU_CODE = "000000";
				var sMCode1 = MENU_CODE.substr(0, 2);//대메뉴코드(0~> 2자리)
				var sMCode2 = MENU_CODE.substr(2, 2);//중메뉴코드(2~> 2자리)
				var sMCode3 = MENU_CODE.substr(4, 2);//중메뉴코드(4~> 2자리) - GNB에서는 2depth까지만 표시되므로, 실제로 여기서 쓸일은 없지만
				$gnb.find("a[MENU_CODE='" + sMCode1 + "0000'][depth=1]").addClass("on");//대메뉴 on
				$gnb.find("a[MENU_CODE='" + sMCode1 + sMCode2 + "00'][depth=2]").addClass("on");//중메뉴 on
			});
			</script>
		</div>


</div>
	<p id="back-top">
		<a href="#top"><img src="truetrue/common/images/top.png" style="opacity: 50%; outline: none; border: none; display: block;"><span></span></a>
	</p>