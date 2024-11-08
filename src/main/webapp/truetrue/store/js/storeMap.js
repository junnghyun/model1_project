$(document).ready(function() {
    // 페이지 로드 시 첫 번째 매장 정보를 표시
    const firstStore = $('.store-item').first();
    if (firstStore.length) {
        updateMapInfo(firstStore);
    }

    // 매장 리스트에서 클릭 시 매장 정보 업데이트
    $('.store-item').on('click', function() {
        updateMapInfo($(this));
    });

    function updateMapInfo(storeElement) {
        const storeName = storeElement.find('h3').text();
        const storeAddress = storeElement.find('p:nth-child(2)').text();
        const storePhone = storeElement.find('p:nth-child(3)').text();
        const lat = storeElement.data('lat');
        const lng = storeElement.data('lng');

        $('#map-store-name').text(storeName);
        $('#map-store-address').text(storeAddress);
        $('#map-store-phone').text(storePhone);

        // 지도 업데이트
        updateMap(lat, lng);
    }

    // 지도를 업데이트하는 함수
    function updateMap(lat, lng) {
        const mapContainer = document.getElementById('map');
        const mapOption = {
            center: new kakao.maps.LatLng(lat, lng), // 매장 위치로 중심좌표 설정
            level: 3 // 확대 수준
        };

        const map = new kakao.maps.Map(mapContainer, mapOption);
        const markerPosition = new kakao.maps.LatLng(lat, lng);

        const marker = new kakao.maps.Marker({
            position: markerPosition
        });

        marker.setMap(map);
    }
});

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