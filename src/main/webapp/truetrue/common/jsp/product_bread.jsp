<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
    body {
        display: flex;
    }
    .product-slider {
        position: relative;
        width: 600px; /* 슬라이더의 총 너비 */
        height: 500px; /* 높이를 500px로 변경 */
        overflow: hidden;
    }
    .product-slides {
        display: flex;
        transition: transform 0.5s ease-in-out;
        width: 1800px; /* 3개씩 3페이지로 설정 (600px * 3) */
    }
    .product-group {
        display: flex; /* 세 개의 제품을 가로로 정렬 */
        width: 600px; /* 각 그룹의 너비 */
    }
    .featured-product {
        position: relative;
        width: 350px;
        height: 350px;
        margin-right: 10px; /* 간격 */
    }
    .small-products {
        display: flex;
        flex-direction: column; /* 세로 방향 정렬 */
        justify-content: space-between; /* 간격 조정 */
        height: 350px; /* 전체 높이 맞추기 */
    }
    .small-product {
        position: relative;
        width: 200px;
        height: 175px;
        margin-top: 10px; /* 간격 */
    }
    .product-image, .small-product-image {
        width: 100%;
        height: 100%;
    }
    .product-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        color: white;
        display: none;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        text-align: center;
    }
    .featured-product:hover .product-overlay,
    .small-product:hover .product-overlay {
        display: flex;
    }
    .nav-button {
        border: none;
        background-color: transparent;
        cursor: pointer;
        font-size: 24px; /* 화살표 크기 */
        position: absolute;
        top: 35%;
        transform: translateY(-50%);
    }
    .prev-nav {
        left: 5px; /* 왼쪽 화살표 위치 */
    }
    .next-nav {
        right: 5px; /* 오른쪽 화살표 위치 */
    }
    .more-btn {
        background-color: white;
        border: none;
        border-radius: 5px;
        padding: 5px 10px;
        cursor: pointer;
        margin-top: 10px;
    }
</style>
</head>
<body>

<div class="product-slider">
    <div class="product-slides" id="productSlides">
        <div class="product-group">
            <div class="featured-product">
                <img class="product-image" src="product1.jpg" alt="Product 1">
                <div class="product-overlay">
                    <div>제품 1 설명</div>
                    <a href="https://example.com/product1" target="_blank">
                        <button class="more-btn">More</button>
                    </a>
                </div>
            </div>
            <div class="small-products">
                <div class="small-product">
                    <img class="small-product-image" src="product2.jpg" alt="Product 2">
                    <div class="product-overlay">
                        <div>제품 2 설명</div>
                        <a href="https://example.com/product2" target="_blank">
                            <button class="more-btn">More</button>
                        </a>
                    </div>
                </div>
                <div class="small-product">
                    <img class="small-product-image" src="product3.jpg" alt="Product 3">
                    <div class="product-overlay">
                        <div>제품 3 설명</div>
                        <a href="https://example.com/product3" target="_blank">
                            <button class="more-btn">More</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="product-group">
            <div class="featured-product">
                <img class="product-image" src="product4.jpg" alt="Product 4">
                <div class="product-overlay">
                    <div>제품 4 설명</div>
                    <a href="https://example.com/product4" target="_blank">
                        <button class="more-btn">More</button>
                    </a>
                </div>
            </div>
            <div class="small-products">
                <div class="small-product">
                    <img class="small-product-image" src="product5.jpg" alt="Product 5">
                    <div class="product-overlay">
                        <div>제품 5 설명</div>
                        <a href="https://example.com/product5" target="_blank">
                            <button class="more-btn">More</button>
                        </a>
                    </div>
                </div>
                <div class="small-product">
                    <img class="small-product-image" src="product6.jpg" alt="Product 6">
                    <div class="product-overlay">
                        <div>제품 6 설명</div>
                        <a href="https://example.com/product6" target="_blank">
                            <button class="more-btn">More</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- 필요한 만큼 product-group 추가 -->
    </div>
    <button class="nav-button prev-nav" onclick="prevProductSlide()">&#10094;</button>
    <button class="nav-button next-nav" onclick="nextProductSlide()">&#10095;</button>
</div>

<script>
    // 제품 슬라이더 관련 변수 및 함수
    let currentProductSlide = 0;
    const totalProductSlides = 1; // 페이지 수를 설정 (각 페이지에 3개 제품을 보여주기 위해)

    function showProductSlide(index) {
        const productSlides = document.getElementById('productSlides');
        currentProductSlide = index;

        productSlides.style.transform = 'translateX(' + (-600 * currentProductSlide) + 'px)';
    }

    function nextProductSlide() {
        if (currentProductSlide < totalProductSlides) {
            currentProductSlide++;
            showProductSlide(currentProductSlide);
        }
    }

    function prevProductSlide() {
        if (currentProductSlide > 0) {
            currentProductSlide--;
            showProductSlide(currentProductSlide);
        }
    }
</script>

</body>
</html>