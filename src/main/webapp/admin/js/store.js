
function deleteStore() {
    const userConfirmed = confirm("삭제하시겠습니까?");
    if (userConfirmed) {
        deleteItem(); // 삭제 기능 실행
    }
}

/**
 * 모달 열기 함수
 */
function openStoreAddModal() {
    // Tailwind CSS를 동적으로 로드
    const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
    tailwindLink.id = 'tailwindCSS'; // ID를 추가하여 나중에 쉽게 찾을 수 있게 함
    document.head.appendChild(tailwindLink);
	
    document.getElementById('storeAddModal').style.display = 'block';
}

function openStoreEditModal() {
    // Tailwind CSS를 동적으로 로드
    const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
    tailwindLink.id = 'tailwindCSS'; // ID를 추가하여 나중에 쉽게 찾을 수 있게 함
    document.head.appendChild(tailwindLink);
	
    document.getElementById('storeEditModal').style.display = 'block';
}

/**
 * 모달 닫기 함수
 */
function closeStoreModal() {
    document.getElementById('storeAddModal').style.display = 'none';
    document.getElementById('storeEditModal').style.display = 'none';
    
    // Tailwind CSS 제거
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) {
        document.head.removeChild(tailwindLink);
    }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    const storeAddModal = document.getElementById('storeAddModal');
    const storeEditModal = document.getElementById('storeEditModal');
    
    // 클릭된 요소가 모달 창이라면 모달을 닫음
    if (event.target === storeAddModal || event.target === storeEditModal) {
        closeStoreModal();
    }
};
