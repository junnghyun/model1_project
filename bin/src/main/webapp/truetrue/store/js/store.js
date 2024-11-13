/**
 * 
 */

function loadCities() {
    const provinceSelect = document.getElementById('province');
    const citySelect = document.getElementById('city');
    
    // 현재 선택된 광역시/도
    const selectedProvince = provinceSelect.value;

    // 이전에 추가된 시/군/구 옵션 제거
    citySelect.innerHTML = '<option value="">시/군/구</option>';

    // 선택된 광역시/도에 따른 시/군/구 목록
    let cities = [];
    
    switch (selectedProvince) {
        case '서울':
            cities = ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'];
            break;
        case '부산':
            cities = ['강서구', '금정구', '기장군', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구'];
            break;
        case '대구':
            cities = ['남구', '달서구', '달성군', '동구', '북구', '서구', '수성구', '중구'];
            break;
        case '인천':
            cities = ['강화군', '계양구', '남동구', '동구', '미추홀구', '부평구', '서구', '연수구', '옹진군', '중구'];
            break;
        case '광주':
            cities = ['광산구', '남구', '동구', '북구', '서구'];
            break;
        case '대전':
            cities = ['대덕구', '동구', '서구', '유성구', '중구'];
            break;
        case '울산':
            cities = ['남구', '동구', '북구', '울주군', '중구'];
            break;
        case '경기':
            cities = ['고양시', '구리시', '군포시', '김포시', '남양주시', '동두천시', '부천시', '성남시', '수원시', '안산시', '안양시', '양주시', '오산시', '시흥시', '파주시', '평택시', '하남시', '화성시'];
            break;
        case '강원':
            cities = ['강릉시', '고성군', '동해시', '양구군', '양양군', '원주시', '철원군', '춘천시', '태백시', '횡성군'];
            break;
        case '충북':
            cities = ['괴산군', '단양군', '보은군', '영동군', '옥천군', '청주시', '충주시'];
            break;
        case '충남':
            cities = ['공주시', '보령시', '서산시', '아산시', '천안시', '청양군', '태안군', '홍성군'];
            break;
        case '전북':
            cities = ['고창군', '군산시', '김제시', '남원시', '익산시', '전주시', '정읍시'];
            break;
        case '전남':
            cities = ['광양시', '나주시', '목포시', '순천시', '여수시', '진도군', '해남군'];
            break;
        case '경북':
            cities = ['경산시', '경주시', '구미시', '문경시', '상주시', '안동시', '영주군', '포항시'];
            break;
        case '경남':
            cities = ['거제시', '김해시', '마산시', '밀양시', '사천시', '양산시', '창원시', '진주'];
            break;
        case '제주':
            cities = ['서귀포시', '제주시'];
            break;
    }

    // 시/군/구 옵션 추가
    for (let city of cities) {
        const option = document.createElement('option');
        option.value = city;
        option.textContent = city;
        citySelect.appendChild(option);
    }
}

function resetFilters() {
    $("#store-name").val('');
    const baseUrl = window.location.pathname;
    window.location.href = baseUrl;
}

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

        // 모달 업데이트
        updateModal(storeName, storeAddress, storePhone, lat, lng);
    }

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

    function updateModal(storeName, storeAddress, storePhone, lat, lng) {
        $('#modal-store-name').text(storeName);
        $('#modal-store-address').text(storeAddress);
        $('#modal-store-phone').text(storePhone);

        // 모달 내부 지도 업데이트
        updateModalMap(lat, lng);
    }

    function updateModalMap(lat, lng) {
        const modalMapContainer = document.getElementById('modal-map');
        const modalMapOption = {
            center: new kakao.maps.LatLng(lat, lng), // 매장 위치로 중심좌표 설정
            level: 3 // 확대 수준
        };

        const modalMap = new kakao.maps.Map(modalMapContainer, modalMapOption);
        const modalMarkerPosition = new kakao.maps.LatLng(lat, lng);

        const modalMarker = new kakao.maps.Marker({
            position: modalMarkerPosition
        });

        modalMarker.setMap(modalMap);
    }

    // +버튼 클릭 시 모달 열기
    $('#add-store-btn').on('click', function() {
        $('#modal').css('display', 'block');
    });

    // 모달 닫기
    $('.close').on('click', function() {
        $('#modal').css('display', 'none');
    });

    // 창 밖을 클릭하면 모달 닫기
    window.onclick = function(event) {
        if (event.target == document.getElementById('modal')) {
            $('#modal').css('display', 'none');
        }
    };

    // 기존 코드...
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
});