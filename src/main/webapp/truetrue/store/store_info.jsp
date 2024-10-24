<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="매장 안내 "%>
<!DOCTYPE html>

<html>
<head>
<title>매장 안내</title>
<style type="text/css">
<!DOCTYPE html> <html> <head> <title>매장 검색 </title> <style type ="text /css "> 

/* 전체 컨테이너 스타일 */ 
.container {
	padding: 50px 0;
}

/* 매장안내 home > 매장 안내 아래 스타일 */
#content {
	position: relative;
	width: 1000px;
	margin: 0 auto;
	padding-top: 20px;
	min-height: 600px;
}

/* 헤더 스타일 */
#header {
	background-color: #0d4633;
	padding: 20px 0;
	text-align: center;
	width: 100%;
	position: relative;
	z-index: 110;
}

/* 헤더 로고 스타일 */
.logo {
	width: 286px;
	height: 37px;
	margin: 0 auto;
}

/* 네비게이션 스타일 */
.gnb {
	position: relative;
	width: 100%;
	height: 43px;
	background: #0d4633;
	text-align: center;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

.gnb ul {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin: 0;
	width: 100%;
}

.gnb ul li {
	flex-grow: 1;
	text-align: center;
}

.gnb ul li a {
	text-decoration: none;
	color: white;
	font-size: 14px;
	display: block;
	padding: 10px;
	background-color: #0d4633;
	transition: background-color 0.3s;
}

.gnb ul li a:hover {
	background-color: #174e38;
	border-radius: 5px;
}

/* 페이지 상단 안내 섹션 */
.page_top {
	position: relative;
	background-color: #e1e8d1;
	padding: 10px;
	margin-bottom: 20px;
	border-radius: 5px;
}

.page_title {
	font-size: 20px;
	color: #0d4633;
}

.path {
	position: absolute;
	top: 34px;
	right: 0;
	padding: 14px 0 10px 0;
	text-align: right;
}

.path a {
	color: #0d4633;
	text-decoration: none;
}

.path a:first-child {
	padding-left: 0;
	background: none;
}

.path a:last-child {
	text-decoration: none;
}

/* 매장 검색 섹션 */
.store_search {
	position: relative;
	height: 80px;
	padding: 20px;
	background-color: #dadfcb;
	color: #fff;
	font-size: 14px;
	text-align: center;
	width: 100%;
	box-sizing: border-box;
}

.store_search label {
	font-weight: bold;
	margin-right: 10px;
	color: gray;
}

.store_search select, .store_search input {
	padding: 10px;
	margin-right: 10px;
	font-size: 14px;
	color: gray;
}

.store_search button {
	padding: 10px 20px;
	background-color: #2E5A27;
	color: white;
	border: none;
	cursor: pointer;
}

.store_search button[type="reset"] {
	background-color: #2E5A27;
	color: white;
	background-position: left center;
	cursor: pointer;
}

/* 매장 결과 영역 */
.store_result_area {
	display: flex;
	justify-content: space-between;
	width: 100%;
	padding: 20px;
	background-color: white;
	min-height: 600px;
	box-sizing: border-box;
}

.store_list {
	flex: 1;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	height: 100%;
	overflow-y: auto;
}

/* store_list 안의 테이블 너비 제한 */
.store_list table {
	width: 100%; /* 테이블이 부모 요소의 100% 크기에 맞도록 */
	table-layout: fixed; /* 고정된 테이블 레이아웃 */
	border-collapse: collapse; /* 테두리가 겹쳐지지 않도록 */
}

.store_list th, .store_list td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: center;
	color: gray;
	word-wrap: break-word; /* 긴 텍스트가 있을 경우 자동으로 줄바꿈 */
}

.store_map {
	flex: 1;
	margin-left: 10px;
	padding: 20px;
	background-images: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
		url("/common/images/brandstore.jpg");
	background-repeat: no-repeat;
	background-position: center;
	color: white;
	border: 1px solid #ddd;
	height: 100%;
}

.store_map strong {
	color: white;
	font-weight: bold;
}

/* 테이블 스타일 */
.store_list table {
	width: 100%;
	border-collapse: collapse;
}

.store_list table th {
	padding: 10px;
	border: 1px solid #ddd;
	font-size: 16px;
	text-align: center;
	color: gray;
}

.store_list table tbody td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: center;
	color: gray;
}

/* 페이징 */
.paging {
	text-align: center;
	margin-top: 20px;
}

.paging span {
	margin: 0 5px;
	font-size: 16px;
}

.paging a {
	text-decoration: none;
	color: #2E5A27;
}

.paging a:hover {
	text-decoration: underline;
}

.store_list .tab-area {
	position: relative;
	margin-bottom: 20px;
}

.store_list .tab-area ul {
	list-style: none;
	padding: 0;
}

.store_list .tab-area ul li a {
	display: block;
	padding: 10px;
	background-color: #2E5A27;
	color: white;
	border: 1px solid #2E5A27;
	text-align: center;
	text-decoration: none;
}

/* 초기화 및 검색 버튼 */
.store_search button {
	background-color: #2E5A27;
	color: white;
}

.store_search button[type="submit"] {
	background-color: #2E5A27;
	color: white;
}

.store_search button[type="reset"] {
	background-color: #2E5A27;
	color: white;
}

#button {
	position: absolute;
	left: 20px;
	top: 15px;
	z-index: 120;
}

#button input {
	padding: 10px;
	font-size: 14px;
}

#button input::placeholder {
	color: #666;
}

.top-menu {
	position: absolute;
	right: 20px;
	top: 15px;
	z-index: 120;
}

.top-menu ul {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.top-menu ul li {
	margin-left: 15px;
}

.top-menu ul li a {
	text-decoration: none;
	color: white;
	font-size: 14px;
	padding: 10px;
	background-color: #2E5A27;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.top-menu ul li a:hover {
	background-color: #174e38;
}

.storeList {
	overflow-y: auto;
	width: 364px;
	height: 417px;
	margin: 0 0 38px 0;
	border-top: 1px solid #d7d4d0;
	border-bottom: 1px solid #d7d4d0;
}

.btn_more img{ 

  float: right;
  margin-right: 2px;
  
}

.btn_more img {
    transition: filter 0.3s ease; 
}

/* 클릭 시 주황색 필터 적용 */
.btn_more img.clicked {
    filter: sepia(1) saturate(500%) hue-rotate(-50deg); 
}
</style>




<script type="text/javascript">
	$(document).ready(function() {
		// 매장 클릭 이벤트 핸들러
		$(".click_market").click(function(e) {
			e.preventDefault(); // 기본 링크 동작 막기

			// 클릭한 매장에 따라 정보를 설정
			var marketName = $(this).text();
			var marketInfo = {};

			if (marketName === "뚜레쥬르 강남역삼점") {
				marketInfo = {
					name : "뚜레쥬르 강남역삼점",
					roadAddr : "서울특별시 강남구 강남대로",
					jibunAddr : "서울특별시 강남구 역삼동 123-45",
					tel : "02-1234-5678"
				};
			} else if (marketName === "뚜레쥬르 서울역점") {
				marketInfo = {
					name : "뚜레쥬르 서울역점",
					roadAddr : "서울특별시 용산구 한강대로",
					jibunAddr : "서울특별시 용산구 동자동 456-78",
					tel : "02-9876-5432"
				};
			} else if (marketName === "뚜레쥬르 마곡점") {
				marketInfo = {
					name : "뚜레쥬르 마곡점",
					roadAddr : "서울특별시 강서구 마곡중앙로",
					jibunAddr : "서울특별시 강서구 마곡동 789-10",
					tel : "02-5678-1234"
				};
			}

			// 정보 업데이트
			$("#smallName").text(marketInfo.name);
			$("#smallAddrD").text(marketInfo.roadAddr);
			$("#smallAddrJ").text(marketInfo.jibunAddr);
			$("#smallTel").text(marketInfo.tel);
		});
		
		  $(document).ready(function() {
		        // 이미지 클릭 이벤트
		        $(".btn_more img").click(function() {
		            $(this).toggleClass("clicked"); // 클릭 시 'clicked' 클래스 추가/제거
		        });
		    });
		
		
</script>

</head>
<body>
	<div id="wrap">
		<!-- 헤더 -->
		<div id="header">
			<h1 class="logo">
				<img src="../common/images/logo.png" alt="뚜레쥬르 로고">
			</h1>
		</div>
		<div id="button">
			<input type="text" placeholder="제품명을 입력해주세요.">
		</div>
		<div class="top-menu">
			<ul>
				<li><a href="#">매장안내</a></li>
				<li><a href="#">고객센터</a></li>
				<li><a href="#">login</a></li>
			</ul>
		</div>
		<!-- 네비게이션 메뉴 -->
		<div class="gnb">
			<ul>
				<li class="brand_news"><a href="#">브랜드 소식</a></li>
				<li class="product"><a href="#">제품</a></li>
				<li class="shopping"><a href="#">장바구니</a></li>
			</ul>
		</div>

		<!-- 페이지 상단 -->
		<div class="page_top">
			<div class="path">
				<a href="#">Home</a> &gt; <a href="#">매장안내</a>
			</div>
			<h2 class="page_title">
				<span class="tit_store_info">매장안내</span>
			</h2>
		</div>

		<!-- 페이지 컨텐츠 -->
		<div class="container">
			<div id="content">
				<div class="store_search">
					<form>
						<label for="store_type">구분</label> <select name="store_type"
							id="store_type">
							<option value="" selected="">== 시 ==</option>
							<option value="서울">서울시</option>
						</select> <label for="keyword">매장명</label> <input type="text" id="keyword"
							name="keyword" placeholder="매장명을 입력해 주세요">
						<button type="reset">
							<img src="../common/images/reset.png">초기화
						</button>
						<button type="submit">
							<img src="../common/images/search.png">검색
						</button>
					</form>
				</div>


				<div class="store_result_area">

					<!-- 매장 리스트 테이블 -->
					<div class="store_list">
						<!-- 매장 검색 결과 테이블 -->
						<table>
							<thead>
								<tr>
									<th colspan="2">매장검색 결과</th>
								</tr>
							</thead>

						</table>

						<!-- 매장 리스트 테이블 -->
						<table>
							<thead>
								<tr>
									<th>매장명</th>
									<th>주소</th>
								</tr>
							</thead>
							<tbody class="storeList">
								<tr>
									<td><a href="#" class="click_market">뚜레쥬르 강남역삼점</a></td>
									<td>서울시 강남구 강남대로</td>
								</tr>
								<tr>
									<td><a href="#" class="click_market">뚜레쥬르 서울역점</a></td>
									<td>서울시 용산구 한강대로</td>
								</tr>
								<tr>
									<td><a href="#" class="click_market">뚜레쥬르 마곡점</a></td>
									<td>서울시 강서구 마곡중앙로</td>
								</tr>
							</tbody>
						</table>

						<!-- 페이징 영역 -->
						<div class="paging">
							<span><a href="#">[이전]</a></span> <span class="current">1</span>
							<span><a href="#">2</a></span> <span><a href="#">[다음]</a></span>
						</div>
					</div>
					<!-- 지도 -->
					<div class="store_map">
						<div class="in">
							<div class="store_table">
								<div class="store_info_bg"></div>
								<table summary="매장명, 매장주소, 매장전화번호 항목을 제공합니다">
									<caption></caption>
									<colgroup>
										<col style="width: 67px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<th class="first">매장명</th>
											<td class="first" id="smallName"></td>
										</tr>
										<tr>
											<th>도로명<br>주소
											</th>
											<td id="smallAddrD"></td>
										</tr>
										<tr>
											<th>지번주소</th>
											<td id="smallAddrJ"></td>
										</tr>
										<tr>
											<th class="last">전화번호</th>
											<td class="last" id="smallTel"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<span class="btn_more"><img
								src="../common/images/plus(2).png"><a href="#"
								id="smallLink"></a></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>