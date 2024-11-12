$(function() {
    // 페이지 로드시 검색창 초기화
    initializeSearchInput();
    
    // Enter key event handler for search input
    $("#store-name").keyup(function(evt) {
        if (evt.which == 13) {
            searchStores();
        }
    });
});	

document.getElementById("store").onclick = function() {
    window.location.href = "admin_store.jsp";
};

/**
 * 검색창 초기값 설정 및 null 처리
 */
function initializeSearchInput() {
    const searchInput = $("#store-name");
    const currentValue = searchInput.val();
    
    // null, undefined, "null" 문자열 처리
    if (!currentValue || currentValue === "null" || currentValue === "undefined") {
        searchInput.val("");
    }
}

/**
 * 검색어 유효성 검사
 */
function validateSearchInput() {
    const keyword = $("#store-name").val();
    
    // null, 빈 문자열 처리
    if (!keyword || keyword.trim() === "") {
        resetFilters();
        return false;
    }
    
    // 공백 제거 후 길이 체크
    if (keyword.trim().length < 2) {
        alert("검색어는 2글자 이상 입력해주세요.");
        $("#store-name").focus();
        return false;
    }
    
    // 특수문자 체크
    if (/[<>%]/.test(keyword)) {
        alert("특수문자는 검색할 수 없습니다.");
        $("#store-name").focus();
        return false;
    }
    
    return true;
}

/**
 * 매장 검색 실행
 */
function searchStores() {
    const searchInput = $("#store-name");
    const keyword = searchInput.val();
    
    // null이거나 빈 문자열인 경우 초기화
    if (!keyword || keyword.trim() === "") {
        resetFilters();
        return;
    }
    
    if (!validateSearchInput()) {
        return;
    }
    
    const currentUrl = new URL(window.location.href);
    
    // 검색 파라미터 설정
    currentUrl.searchParams.set('currentPage', '1');
    currentUrl.searchParams.set('keyword', keyword.trim());
    currentUrl.searchParams.set('field', 'store_name');
    
    window.location.href = currentUrl.toString();
}

/**
 * 검색 필터 초기화
 */
function resetFilters() {
    $("#store-name").val('');
    const baseUrl = window.location.pathname;
    window.location.href = baseUrl;
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
    // JSP로 이동하여 삭제 처리
    location.href = 'delete_store.jsp?store_id=' + storeId;
  }
}

function confirmSave() {
    if (confirm("저장하시겠습니까?")) {
        return true; // 저장 진행
    } else {
        alert("저장이 취소되었습니다.");
        return false; // 저장 취소
    }
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

// 매장 수정 모달 열기 함수 수정
function openStoreEditModal(store_id) {
    if (!store_id) {
        alert("매장 ID가 없습니다. 확인해 주세요.");
        return;
    }
    
    // 기존 모달이 있다면 제거
    let existingModal = document.getElementById('storeEditModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    // 새로운 모달 컨테이너 생성
    const modalContainer = document.createElement('div');
    modalContainer.id = 'storeEditModal';
    modalContainer.style.display = 'none';
    document.body.appendChild(modalContainer);

    // TailwindCSS 로드
    loadTailwindCSS();
    
    // Fetch API를 사용하여 매장 수정 폼을 가져오기
    fetch(`store_edit_modal.jsp?store_id=${store_id}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(html => {
            modalContainer.innerHTML = html;
            modalContainer.style.display = 'block';
            
            // 주소 검색 이벤트 리스너 다시 설정
            const addressInput = modalContainer.querySelector('#address');
            if (addressInput) {
                addressInput.addEventListener('click', () => searchZipcode('edit'));
            }
            
            // 취소 버튼 이벤트 리스너
            const cancelBtn = modalContainer.querySelector('button[type="button"]');
            if (cancelBtn) {
                cancelBtn.addEventListener('click', closeStoreModal);
            }
            
            // 폼 제출 이벤트 처리
            /**const form = modalContainer.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    submitEditForm(this, store_id);
                });
            }
            */
        })
        .catch(error => {
            console.error('모달 로드 중 오류 발생:', error);
            alert('모달을 로드하는 중 오류가 발생했습니다.');
        });
}

// 수정 폼 제출 처리 함수
/**function submitEditForm(form, store_id) {
    const formData = new FormData(form);
    fetch(`store_edit_modal.jsp?store_id=${store_id}`, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.text(); // 응답을 텍스트로 변환
    })
    .then(responseText => {
	    console.log('서버 응답:', responseText); // 서버 응답 로그
	    if (responseText === "success") {
	        alert('매장 정보가 성공적으로 수정되었습니다.');
	        closeStoreModal();
	    } else {
	        alert('정보 수정 중 오류가 발생했습니다.');
	    }
	})
    .catch(error => {
        console.error('폼 제출 중 오류 발생:', error);
        alert('매장 정보 수정 중 오류가 발생했습니다.');
    });
}
*/

// 모달 닫기 함수 개선
function closeStoreModal() {
    const modals = ['storeAddModal', 'storeEditModal'];
    modals.forEach(modalId => {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.style.display = 'none';
            if (modalId === 'storeEditModal') {
                modal.remove(); // 완전히 제거
            }
        }
    });

    // TailwindCSS 제거
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) {
        tailwindLink.remove();
    }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    const storeAddModal = document.getElementById('storeAddModal');
    const storeEditModal = document.getElementById('storeEditModal');
    
    if (event.target === storeAddModal) {
        storeAddModal.style.display = 'none';
    }
    if (event.target === storeEditModal) {
        storeEditModal.style.display = 'none';
    }
    if (event.target.classList.contains('modal-overlay')) {
        closeStoreModal();
    }
};

// 다음 우편번호 API로 주소 검색
function searchZipcode(modalType) {
    new daum.Postcode({
        oncomplete: function(data) {
            const modalId = modalType === 'add' ? '#storeAddModal' : '#storeEditModal';
            const modal = document.querySelector(modalId);
            const addressInput = modal.querySelector('#address');
            const addressDetail = modal.querySelector('#address_detail');
            const latitudeInput = modal.querySelector('#latitude');
            const longitudeInput = modal.querySelector('#longitude');

            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            // 법정동명이 있을 경우 추가
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만듦
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 주소 정보 입력
            if (addressInput) {
                addressInput.value = roadAddr;
                
                // 주소가 입력되면 위도/경도 가져오기
                getGeoLocation(roadAddr)
                    .then(location => {
                        if (location && location.latitude && location.longitude) {
                            latitudeInput.value = location.latitude;
                            longitudeInput.value = location.longitude;
                        } else {
                            console.warn('위도/경도 정보를 찾을 수 없습니다.');
                            clearGeoLocation(latitudeInput, longitudeInput);
                        }
                    })
                    .catch(error => {
                        console.error('위도/경도 조회 중 오류:', error);
                        clearGeoLocation(latitudeInput, longitudeInput);
                        showError('주소의 위도/경도를 가져오는데 실패했습니다.');
                    });

                // input 이벤트 발생
                const event = new Event('input', { bubbles: true });
                addressInput.dispatchEvent(event);
            }

            // 상세주소 필드로 포커스 이동
            if (addressDetail) {
                addressDetail.focus();
            }
        }
    }).open();
}

// 위도/경도 가져오는 함수
function getGeoLocation(address) {
    return new Promise(function(resolve, reject) {
        fetch("/model1_project/api/geocode?address=" + encodeURIComponent(address), {
            method: "GET",
            headers: {
                'Accept': "application/json",
                'Content-Type': "application/json"
            }
        })
        .then(function(response) {
            if (!response.ok) {
                throw new Error("HTTP error! status: " + response.status);
            }
            return response.json();
        })
        .then(function(data) {
            if (data.error) {
                throw new Error(data.error);
            }

            resolve({
                latitude: parseFloat(data.latitude),
                longitude: parseFloat(data.longitude)
            });
        })
        .catch(function(error) {
            console.error("Error in getGeoLocation:", error);
            reject(error);
        });
    });
}

// 위도/경도 입력 필드 초기화
function clearGeoLocation(latitudeInput, longitudeInput) {
    if (latitudeInput) latitudeInput.value = '';
    if (longitudeInput) longitudeInput.value = '';
}

// 에러 메시지 표시
function showError(message) {
    alert(message);
}