<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="../common/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="../common/css/main_20240911.css"/>
<!--  bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!--  jQuery CDN 시작-->
	<link rel="stylesheet" type="text/css" href="../common/css/brand.css" />


	<script type="text/javascript" src="../common/js/menu.js"></script>
	<script type="text/javascript" src="../common/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div id="wrap">
<!-- header -->
	<div id="header" >

	<div class="page_top">
		<div class="path">
		<ul>
			<li>
				<a href="/">Home</a>
				<a href="/">제품</a>
				<a>빵</a>
			</li>
		</ul>
		</div>
		<h2 class="page_title" style="padding:27px 0 0 17px;">
		<span class="tit_bread">빵</span>
		
		</h2>
	</div>
</div>
<!-- //header -->
<script type="text/javascript">
	$('#header').addClass('bread');
</script>

<!-- container -->
<div class="container">
	<div id="content">
		<!-- //path -->
		<div class="cnt_wrap product b_fff">
			<!-- 제품상세정보 -->
			<div class="product_detail box_type1">
				<ul>
					<li>
						<div class="left_area">
							<ul>
								<li class="item_wrap">
									<span class="img">
										<img src="../common/images/bread/2024-9-9_event(2).jpg" onerror='this.src="/static/images/common/img_none.png"' alt="기본좋은 소금버터식빵" width="350" height="350" />

									
										<span class="lb_best3">Best</span>
									

									</span>
									<div class="p_desc1">* 상기 이미지는 실제 제품과 다소 차이가 있을 수 있습니다.</div>
									
									<div class="p_desc2">
										<ul>
											<li class="tit">제품설명</li>
											<li>3개의 이즈니버터 홀로 깊어진 풍미와<BR>소금의 짭조름한 맛을 더 바삭하고 더 쫄깃하게<BR>즐길 수 있는 시그니처 식빵<BR><BR>*본 제품에 들어간 가루쌀은 물에 불리지 않고<BR>빻을 수 있는 국산 쌀 품종으로<BR>농가와 상생하는 착한 원료입니다.</li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
						<div class="right_area" style="margin:80px 80px 80px 80px; padding-left:0px;padding-right: 0px;">
							<div class="info">
								<span class="name">기본좋은 소금버터식빵</span>
								<span class="txt_shape">2500원</span>

							</div>
							<div class="table_nutrition">
								<table summary="1회 제공량(108g) 당 열량, 당류, 단백질, 포화지방, 나트륨 정보를 제공합니다.">
									<caption>영양성분</caption>
									<thead>
										<tr>
											<th scope="row" rowspan="4">영양성분</th>
										
											<td>총중량(g)  202</td>
										
										</tr>
										
										<tr>
											<td>총제공중량(회) 1</td>
										</tr>
										
										<tr>
											<td>1회 제공량(개) 1</td>
										</tr>
										
										<tr>
											<td>중량(g)  202</td>
										</tr>
										
									</thead>
									<tbody>
										
										<tr>
											<th scope="row" class="first">열량(kcal)</th>
											<td class="first">690</td>
										</tr>
										
										<tr>
											<th scope="row">당류(g/%)</th><!-- 2023-07-05 -->
											<td>8/8</td>
										</tr>
										
										<tr>
											<th scope="row">단백질(g/%)</th>
											<td>17/31</td>
										</tr>
										
										<tr>
											<th scope="row">포화지방(g/%)</th>
											<td>14/93</td>
										</tr>
										
										<tr>
											<th scope="row" class="last">나트륨(mg/%)</th>
											<td>1210/61</td>
										</tr>
										

										<!-- 2023-07-05 추가 S //-->
										<tr>
											<td colspan="2">* %영양소기준치 : 1일 영양성분 기준치에 대한 비율</td>
										</tr>
										<!-- 2023-07-05 E //-->

										
										<tr class="is-allergy">
											<th scope="row" class="last">알레르기 정보</th>
											<td class="last">우유, 밀 함유</td>
										</tr>
										
									</tbody>
								</table>
							</div>
							<!-- 201607 start -->
							<div class="btn-area">
								<a href="javascript:goList();" class="btn large st8">목록</a>
								<a href="javascript:goList();" class="btn large st8">장바구니 담기</a>
							</div>
						
							
							<!-- //201607 end -->
						</div>
					</li>
				</ul>
			</div>
			<!-- //제품상세정보 -->
		
		</div>
	</div>
</div>
</div>
</body>
</html>