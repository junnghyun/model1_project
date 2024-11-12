function submitRegion() {
    const region = document.getElementById("region").value;

    if (!region) {
        alert("지역을 선택하세요.");
        return;
    }
    
    // 버튼 활성화
    fetchButton.disabled = true;
    
    // 로딩 오버레이 표시
    showLoadingOverlay();

    fetch('/model1_project/crawlStores', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8', // UTF-8 인코딩 추가
        },
        body: new URLSearchParams({
            'region': region
        })
    })
    .then(response => {
        // 응답을 텍스트로 받아서 JSON으로 파싱
        return response.text().then(text => {
            console.log("서버 응답:", text); // 응답 내용 출력
            return JSON.parse(text); // 응답이 JSON일 경우 파싱
        });
    })
    .then(data => {
        setTimeout(() => {
            // 크롤링 데이터 표시
            displayStoreData(data);

            // 크롤링 작업 완료 후 로딩 오버레이 숨기기
            hideLoadingOverlay();
            
            // 버튼 활성화
            fetchButton.disabled = true;	
        }, 5000); // 5초 지연
    })
    .catch(error => {
        console.error('Error:', error);
        
        const storeTable = document.getElementById("storeTable");
        storeTable.innerHTML = `
            <tr>
                <td colspan="6" class="error-message">오류가 발생했습니다. 다시 시도해주세요.</td>
            </tr>
        `;
        
        // 에러 발생 시에도 로딩 오버레이 숨기기
        hideLoadingOverlay();
        
        // 버튼 활성화
        fetchButton.disabled = true;
    });
}

function displayStoreData(data) {
    const storeTable = document.getElementById("storeTable");
    storeTable.innerHTML = '';  // 테이블 초기화

    if (data.length === 0) {
        storeTable.innerHTML = `
            <tr>
                <td colspan="6" class="empty-message">해당 지역에 매장 정보가 없습니다.</td>
            </tr>
        `;
        return;
    }

    // 크롤링 데이터를 테이블 형태로 표시
    data.forEach(store => {
        const isChecked = store.flag === 'true' ? 'checked' : '';
        const isDisabled = store.flag === 'false' ? 'disabled' : '';

        storeTable.innerHTML += `
            <tr>
                <td><input type="checkbox" ${isChecked} ${isDisabled}></td>
                <td>${store.name}</td>
                <td>${store.address}</td>
                <td>${store.phone}</td>
                <td>${store.latitude}</td>
                <td>${store.longitude}</td>
            </tr>`;
    });
}

function saveSelectedStores() {
    const rows = document.querySelectorAll("#storeTable tr");
    const selectedStores = [];

    rows.forEach(row => {
        const checkbox = row.querySelector("input[type='checkbox']");
        if (checkbox && checkbox.checked && !checkbox.disabled) {
            const store = {
                store_name: row.cells[1].innerText,
                store_address: row.cells[2].innerText,
                store_phone: row.cells[3].innerText,
                lat: row.cells[4].innerText,
                lng: row.cells[5].innerText
            };
            selectedStores.push(store);
        }
    });
    
    console.log(JSON.stringify(selectedStores));
    fetch('/model1_project/saveStores', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(selectedStores)
    })
    .then(response => response.text())
    .then(data => {
    alert("저장 완료!");
    window.location.href = '/model1_project/admin/admin_store/admin_store.jsp';  // 이동할 페이지 경로로 수정
	})
	.catch(error => console.error('Error:', error));
}

// 로딩 오버레이 표시 함수
function showLoadingOverlay() {
    const overlay = document.getElementById("loadingOverlay");
    overlay.style.display = "flex"; // 오버레이를 보이게 설정
}

// 로딩 오버레이 숨기기 함수
function hideLoadingOverlay() {
    const overlay = document.getElementById("loadingOverlay");
    overlay.style.display = "none"; // 오버레이를 숨기도록 설정
}
