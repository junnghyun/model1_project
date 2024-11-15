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
        .slider {
            position: relative;
            width: 400px;
            height: 400px;
            overflow: hidden;
        }

        .slides {
            display: flex;
            transition: transform 0.5s ease-in-out;
            width: 1200px; /* 400px * 3 이미지 */
        }

        .slide {
            width: 400px;
            height: 400px;
        }

        .buttons {
            text-align: center;
            margin-top: 10px;
        }

        .button {
            border: none;
            background-color: gray;
            border-radius: 50%;
            width: 15px;
            height: 15px;
            margin: 0 5px;
            cursor: pointer;
        }

        .active {
            background-color: black;
        }
    </style>
</head>
<body>

<div class="slider">
    <div class="slides" id="slides">
    	<a href="https://example.com/link1" target="_blank">
        <img class="slide" src="${pageContext.request.contextPath}/truetrue/common/images/2024-9-25_event.jpg" alt="Image 1">
        </a>
        <a href="https://example.com/link2" target="_blank">
        <img class="slide" src="${pageContext.request.contextPath}/truetrue/common/images/2024-10-2_event(2).jpg" alt="Image 2">
        </a>
        <a href="https://example.com/link3" target="_blank">
        <img class="slide" src="${pageContext.request.contextPath}/truetrue/common/images/2024-10-10_event(2).jpg" alt="Image 3">
        </a>
    </div>
</div>

<div class="buttons" id="buttons">
    <button class="button active" onclick="goToSlide(0)"></button>
    <button class="button" onclick="goToSlide(1)"></button>
    <button class="button" onclick="goToSlide(2)"></button>
</div>

<script>
    let currentSlide = 0;
    const totalSlides = 3;

    function showSlide(index) {
        const slides = document.getElementById('slides');
        const buttons = document.querySelectorAll('.button');
        currentSlide = index;

        slides.style.transform = 'translateX(' + (-400 * currentSlide) + 'px)';
        
        buttons.forEach((button, idx) => {
            button.classList.toggle('active', idx === currentSlide);
        });
    }

    function goToSlide(index) {
        showSlide(index);
        resetTimer();
    }

    let timer = setInterval(() => {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
    }, 3000);

    function resetTimer() {
        clearInterval(timer);
        timer = setInterval(() => {
            currentSlide = (currentSlide + 1) % totalSlides;
            showSlide(currentSlide);
        }, 3000);
    }
</script>

</body>
</html>