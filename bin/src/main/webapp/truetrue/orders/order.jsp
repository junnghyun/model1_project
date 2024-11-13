<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="매장 안내 "%>
<!DOCTYPE html>
<html>
<head>
    <title>매장 검색</title>
    <style>
    <style>

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
	z-index: 110; /* 헤더의 z-index를 높여 상단 요소들이 잘 보이게 함 */
}

#btn_more {
	
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

.store_search input[type="date"] {
	padding: 10px;
	font-size: 14px;
	color: #555;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-right: 10px;
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
	min-height: 600px; /* content와 동일한 최소 높이 */
	box-sizing: border-box;
	border: 1px solid #E1DDDD;
}

.store_list {
	flex: 1;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	height: 100%; /* 부모 요소에 맞춰 높이 조정 */
	overflow-y: auto;
	box-shadow: 10px 10px 20px black;
}

.store_map {
	flex: 1;
	margin-left: 10px;
	padding: 20px;
	background-images: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
		url("/jsp_prj/day1011/images/brandstore.jpg");
	background-repeat: no repeat;
	background-position: center;
	color: white;
	border: 1px solid #ddd;
	height: 100%; /* 부모 요소에 맞춰 높이 조정 */
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
	color: #F0F0F0;
}

.store_search button[type="submit"] {
	background-color: #2E5A27;
		color: #FFFFFF;
	pointer: cursor;
}

/* 버튼 위치 스타일 수정 */
#button {
	position: absolute;
	left: 20px;
	top: 15px;
	z-index: 120; /* 버튼이 다른 요소 위에 위치하도록 z-index 추가 */
}

#button input {
	padding: 10px;
	font-size: 14px;
}

#button input::placeholder {
	color: #666;
}
/* 상단 메뉴 스타일 수정 */
.top-menu {
	position: absolute;
	right: 20px;
	top: 15px;
	z-index: 120; /* top-menu가 다른 요소 위에 위치하도록 z-index 추가 */
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

#btn_more {
	background-position: right-bottom;
}

.order_breakdown {
	width: 100%;
	margin-top: 20px;
}

.order_breakdown table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

.order_breakdown table th, .order_breakdown table td {
	border: 1px solid #ddd;
	padding: 10px;
}

.order_breakdown table th {
	background-color: #ECEFE4;
	font-weight: bold;
}

    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
        $(function () {
            // 검색 버튼 클릭 시 실행될 함수
            $('#searchBtn').click(function () {
                // 입력된 조회기간의 시작일과 종료일을 가져옴
                const startDate = $('#start_date').val();
                const endDate = $('#end_date').val();

                // 날짜 범위에 따라 주문 목록을 필터링
                $('.order_row').each(function () {
                    const orderDate = $(this).data('order-date'); // 주문일 가져오기
                    if (orderDate >= startDate && orderDate <= endDate) {
                        $(this).show();  // 날짜가 범위에 속하면 보여줌
                    } else {
                        $(this).hide();  // 날짜가 범위에 속하지 않으면 숨김
                    }
                });
            });

            // 상품명 키워드 검색 기능
            $('#submit').click(function () {
                const keyword = $('#keyword').val().toLowerCase();

                $('.order_row').each(function () {
                    const productName = $(this).find('td:eq(1)').text().toLowerCase();
                    if (productName.includes(keyword)) {
                        $(this).show();  // 키워드가 포함된 행은 보여줌
                    } else {
                        $(this).hide();  // 키워드가 없는 행은 숨김
                    }
                });
            });

            // 실시간 상품명 검색 기능
            $('#keyword').on('keyup', function () {
                const keyword = $(this).val().toLowerCase();

                $('.order_row').each(function () {
                    const productName = $(this).find('td:eq(1)').text().toLowerCase();
                    if (productName.includes(keyword)) {
                        $(this).show();  // 검색 키워드가 포함된 행은 보여줌
                    } else {
                        $(this).hide();  // 키워드가 없는 행은 숨김
                    }
                });
            });
        });
    </script>
</head>
<body>
    <div id="wrap">
        <!-- 헤더 -->
        <div id="header">
			<div id="button">
			<input type="text" placeholder="제품명을 입력해주세요.">
		</div>
			<h1 class="logo">
				<img src="../common/images/logo.png" alt="뚜레쥬르 로고">
			</h1>
			<div class="top-menu">
				<ul>
					<li><a href="#">매장안내</a></li>
					<li><a href="#">고객센터</a></li>
					<li><a href="#">login</a></li>
				</ul>
			</div>
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
			<h2 class="page_title">
				<span class="tit_store_info">주문배송조회</span>
			</h2>
			<div id="extwaiokist" style="display: none" v="nipgg" q="8d0e5b69" c="258.6" i="308" u="28.36" s="10102403" sg="svr_07312409-ga_10102403-bai_09032406" d="1" w="false" e="}" a="3" m="BMe=" vn="9adfy">
				<div id="extwaigglbit" style="display: none" v="nipgg" q="8d0e5b69" c="258.6" i="308" u="28.36" s="10102403" sg="svr_07312409-ga_10102403-bai_09032406" d="1" w="false" e="}" a="3" m="BMe="></div>
			</div>
		</div>

        <!-- 페이지 컨텐츠 -->
        <div class="container">
            <div id="content">
                <!-- 조회기간 검색 부분 -->
                <div class="store_search">
                    <label for="start_date">조회기간</label>
                    <input type="date" id="start_date" name="start_date">
                    <label for="end_date">~</label>
                    <input type="date" id="end_date" name="end_date">
                    <button type="button" id="searchBtn">검색</button>
                    <input type="text" id="keyword" name="keyword" placeholder="주문하신 상품을 검색해주세요.">
                	<button type="button" id="submit">검색</button>
                </div>

                <!-- 주문 목록 테이블 -->
                <div class="store_result_area">
                    <div class="order_breakdown">
                        <table>
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>상품명</th>
                                    <th>주문일</th>
                                    <th>결제금액</th>
                                    <th>배송완료일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="order_row" data-order-date="2024-10-17">
                                    <td>010203</td>
                                    <td>크림가득 메론빵</td>
                                    <td>2024.10.17</td>
                                    <td>3000</td>
                                    <td></td>
                                    <td>배송중</td>
                                </tr>
                                <tr class="order_row" data-order-date="2024-10-13">
                                    <td>040506</td>
                                    <td>기분 좋은 올리브 베이글</td>
                                    <td>2024.10.13</td>
                                    <td>4000</td>
                                    <td>2024.10.14</td>
                                    <td>배송완료</td>
                                </tr>
                                 <tr class="order_row" data-order-date="2024-10-15">
                                    <td>070589</td>
                                    <td>카스테라 우유크림볼</td>
                                    <td>2024.10.15</td>
                                    <td>5000</td>
                                    <td>2024.10.17</td>
                                    <td>배송완료</td>
                                </tr>
                                 <tr class="order_row" data-order-date="2024-10-20">
                                    <td>071563</td>
                                    <td>2배 더 진해진 순진우유 식빵</td>
                                    <td>2024.10.20</td>
                                    <td>6000</td>
                                    <td></td>
                                    <td>결제완료</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
