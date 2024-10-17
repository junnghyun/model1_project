/**
 * 
 */

function openAddProductModal() {
	 // Tailwind CSS를 동적으로 로드
    const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
    tailwindLink.id = 'tailwindCSS'; // ID를 추가하여 나중에 쉽게 찾을 수 있게 함
    document.head.appendChild(tailwindLink);
	
    document.getElementById('addProductModal').style.display = 'block';
}

function openEditProductModal() {
	const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
    tailwindLink.id = 'tailwindCSS'; // ID를 추가하여 나중에 쉽게 찾을 수 있게 함
    document.head.appendChild(tailwindLink);
	 
    document.getElementById('editProductModal').style.display = 'block';
}

function closeProductModal() {
    document.getElementById('addProductModal').style.display = 'none';
    document.getElementById('editProductModal').style.display = 'none';
    
    // Tailwind CSS 제거
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) {
        document.head.removeChild(tailwindLink);
    }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    const modal = document.getElementById('.modal-overlay');
    if (event.target === modal) {
        closeProductModal();
    }
};

// 폼 제출 시 데이터 처리 (예시)
document.getElementById('editAdModal').onsubmit = function(event) {
    event.preventDefault(); // 기본 제출 방지
    // 추가 로직 (예: 데이터 전송)
    closeModal(); // 모달 닫기
};