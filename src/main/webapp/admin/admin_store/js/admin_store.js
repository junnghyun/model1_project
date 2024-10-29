
// 매장 검색 기능
function searchStores() {
  const keyword = document.getElementById('store-name').value.trim();
  const url = new URL(window.location.href);
  url.searchParams.set('page', 1);
  url.searchParams.set('keyword', keyword);
  window.location.href = url.toString();
}

// 검색 필터 초기화
function resetFilters() {
  const url = new URL(window.location.href);
  url.searchParams.delete('keyword');
  url.searchParams.set('page', 1);
  window.location.href = url.toString();
}

// 페이지 변경 기능
function changePage(direction) {
    const url = new URL(window.location.href);
    let currentPage = parseInt(url.searchParams.get('currentPage') || '1'); // currentPage 파라미터 확인
    const totalPages = parseInt(document.querySelector('.pagination span').textContent.split('/')[1].trim());

    if (direction === 'prev' && currentPage > 1) {
        currentPage--;
    } else if (direction === 'next' && currentPage < totalPages) {
        currentPage++;
    }

    url.searchParams.set('currentPage', currentPage); // URL에 currentPage 업데이트
    window.location.href = url.toString();
}

// Excel 다운로드 기능
function downloadExcel() {
  const keyword = document.getElementById('store-name').value.trim();
  let url = 'store/excel';
  if (keyword) {
    url += `?keyword=${encodeURIComponent(keyword)}`;
  }
  window.location.href = url;
}

// 매장 삭제 기능
function deleteStore(storeId) {
  if (confirm('정말로 이 매장을 삭제하시겠습니까?')) {
    fetch(`/admin/store/${storeId}`, {
      method: 'DELETE'
    })
    .then(response => {
      if (response.ok) {
        alert('매장이 성공적으로 삭제되었습니다.');
        window.location.reload();
      } else {
        throw new Error('매장 삭제에 실패했습니다.');
      }
    })
    .catch(error => {
      alert(error.message);
      console.error('Error:', error);
    });
  }
} 

// 주소 검색 기능
function searchZipcode(modalType) {
  new daum.Postcode({
    oncomplete: function(data) {
      const modalId = modalType === 'add' ? '#storeAddModal' : '#storeEditModal';
      const modal = document.querySelector(modalId);
      const addressInput = modal.querySelector('#address');

      if (addressInput) {
        addressInput.value = data.roadAddress;

        const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(data.roadAddress, function(result, status) {
          if (status === kakao.maps.services.Status.OK) {
            const lat = result[0].y;
            const lng = result[0].x;

            modal.querySelector('#lat').value = lat;
            modal.querySelector('#lng').value = lng;
          }
        });
      }
    }
  }).open();
}

// TailwindCSS 로드
function loadTailwindCSS() {
  if (!document.getElementById('tailwindCSS')) {
    const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css';
    tailwindLink.id = 'tailwindCSS';
    document.head.appendChild(tailwindLink);
  }
}

// 매장 추가 모달 열기
function openStoreAddModal() {
  loadTailwindCSS();
  document.getElementById('storeAddModal').style.display = 'block';
}

// 매장 수정 모달 열기
function openStoreEditModal(storeId) {
  loadTailwindCSS();

  fetch(`/admin/store/${storeId}`)
    .then(response => response.json())
    .then(data => {
      const modal = document.getElementById('storeEditModal');
      modal.querySelector('#store_id').value = data.store_id;
      modal.querySelector('#store_name').value = data.store_name;
      modal.querySelector('#store_phone').value = data.store_phone;
      modal.querySelector('#address').value = data.store_address;
      modal.querySelector('#store_status').value = data.store_status;
      modal.querySelector('#lat').value = data.lat;
      modal.querySelector('#lng').value = data.lng;

      modal.style.display = 'block';
    })
    .catch(error => {
      console.error('Error:', error);
      alert('매장 정보를 불러오는데 실패했습니다.');
    });
}

// 모달 닫기
function closeStoreModal() {
  document.getElementById('storeAddModal').style.display = 'none';
  document.getElementById('storeEditModal').style.display = 'none';

  const tailwindLink = document.getElementById('tailwindCSS');
  if (tailwindLink) {
    document.head.removeChild(tailwindLink);
  }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
  const storeAddModal = document.getElementById('storeAddModal');
  const storeEditModal = document.getElementById('storeEditModal');

  if (event.target === storeAddModal || event.target === storeEditModal) {
    closeStoreModal();
  }
};

// 다음 우편번호 API로 주소 검색
function searchZipcode(modalType) {
    new daum.Postcode({
        oncomplete: function(data) {
            // 현재 활성화된 모달 찾기
            const modalId = modalType === 'add' ? '#storeAddModal' : '#storeEditModal';
            const modal = document.querySelector(modalId);
            const addressInput = modal.querySelector('#address');
            const addressDetail = modal.querySelector('#address_detail');

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 콘솔로그로 디버깅
            console.log('모달 타입:', modalType);
            console.log('모달 요소:', modal);
            console.log('주소 입력 필드:', addressInput);
            console.log('선택된 주소:', roadAddr);

            // 주소 정보 입력
            if (addressInput) {
                addressInput.value = roadAddr;
                // 값이 변경된 후 강제로 이벤트 발생시키기
                const event = new Event('input', { bubbles: true });
                addressInput.dispatchEvent(event);
                
                console.log('주소 입력 완료:', addressInput.value);
            } else {
                console.error('주소 입력 필드를 찾을 수 없습니다.');
            }

            // 상세주소 필드로 포커스 이동
            if (addressDetail) {
                addressDetail.focus();
            }
        }
    }).open();
}
