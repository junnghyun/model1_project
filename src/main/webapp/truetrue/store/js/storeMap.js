window.onload = function() {
    // 지도 표시할 div 요소
    var mapContainer = document.getElementById('map'); 

    // 지도 옵션 설정
    var mapOption = { 
        center: new kakao.maps.LatLng(37.5665, 126.9780), // 지도 중심좌표 (서울 시청 좌표)
        level: 3 // 확대 수준
    };

    // 지도 생성
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커를 표시할 위치 설정
    var markerPosition  = new kakao.maps.LatLng(37.5665, 126.9780); 

    // 마커 생성
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 지도에 마커 표시
    marker.setMap(map);
};


$(document).ready(function() {
        // map-info의 높이를 제외한 나머지 map-section의 높이를 구하여 map의 height 설정
        function adjustMapHeight() {
            var mapSectionHeight = $('.map-section').height();
            var mapInfoHeight = $('.map-info').outerHeight(true); // map-info의 전체 높이 (padding, margin 포함)
            var mapHeight = mapSectionHeight - mapInfoHeight;
            
            $('#map').css('height', mapHeight + 'px'); // map의 높이를 조정
        }

        adjustMapHeight(); // 페이지가 로드될 때 높이 조정

        $(window).resize(function() {
            adjustMapHeight(); // 창 크기가 변경될 때 높이 조정
        });
    });