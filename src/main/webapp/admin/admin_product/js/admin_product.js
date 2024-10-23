// 제품 종류 옵션 정의
const productTypes = {
    bread: [
        { value: "식빵", label: "식빵" },
        { value: "건강빵", label: "건강빵" },
        { value: "간식빵", label: "간식빵" },
        { value: "파이/패스트리", label: "파이/패스트리"},
        { value: "도넛/고르케", label: "도넛/고르케"}
    ],
    cake: [
        { value: "생크림케이크", label: "생크림케이크" },
        { value: "스페셜케이크", label: "스페셜케이크" },
        { value: "무스케이크", label: "무스케이크" },
        { value: "케릭터케이크", label: "케릭터케이크" },
        { value: "조각케이크", label: "조각케이크" },
        { value: "대형케이크", label: "대형케이크" }
    ]
};

// 종류 선택 업데이트 함수
function updateProductType(category) {
    // 모든 product_type select 요소를 찾습니다
    const typeSelects = document.querySelectorAll('#product_type');
    
    typeSelects.forEach(typeSelect => {
        // 기존 옵션 제거
        typeSelect.innerHTML = '<option value="">선택하세요</option>';
        
        // 선택된 카테고리에 따라 새로운 옵션 추가
        productTypes[category].forEach(option => {
            const optionElement = document.createElement('option');
            optionElement.value = option.value;
            optionElement.textContent = option.label;
            typeSelect.appendChild(optionElement);
        });
    });
}

// 모달 관리 함수들
function openAddProductModal() {
    loadTailwindCSS();
    const modal = document.getElementById('addProductModal');
    if (modal) {
        modal.style.display = 'block';
        initializeModal(modal);
    }
}

function openEditProductModal() {
    loadTailwindCSS();
    const modal = document.getElementById('editProductModal');
    if (modal) {
        modal.style.display = 'block';
        initializeModal(modal);
    }
}

function closeProductModal() {
    const modals = document.querySelectorAll('#addProductModal, #editProductModal');
    modals.forEach(modal => {
        if (modal) {
            modal.style.display = 'none';
        }
    });
    removeTailwindCSS();
}

// 모달 초기화 함수
function initializeModal(modal) {
    // 해당 모달 내의 라디오 버튼 초기값으로 종류 옵션 설정
    const initialCategory = modal.querySelector('input[name="category"]:checked');
    if (initialCategory) {
        updateProductType(initialCategory.value);
    }
    
    // 카테고리 변경 이벤트 리스너 설정
    const categoryInputs = modal.querySelectorAll('input[name="category"]');
    categoryInputs.forEach(input => {
        input.addEventListener('change', (e) => updateProductType(e.target.value));
    });
}

// Tailwind CSS 관리 함수들
function loadTailwindCSS() {
    if (!document.getElementById('tailwindCSS')) {
        const tailwindLink = document.createElement('link');
        tailwindLink.rel = 'stylesheet';
        tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css';
        tailwindLink.id = 'tailwindCSS';
        document.head.appendChild(tailwindLink);
    }
}

function removeTailwindCSS() {
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) {
        document.head.removeChild(tailwindLink);
    }
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    if (event.target.matches('.modal-overlay')) {
        closeProductModal();
    }
};

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    // 모든 모달에 대해 초기화 수행
    const modals = document.querySelectorAll('#addProductModal, #editProductModal');
    modals.forEach(modal => {
        if (modal.style.display === 'block') {
            initializeModal(modal);
        }
    });
});

// 제품 삭제 함수
function deleteProduct() {
    const userConfirmed = confirm("삭제하시겠습니까?");
    if (userConfirmed) {
        // 실제 삭제 로직 구현
        console.log("제품이 삭제되었습니다.");
    }
}

// 폼 제출 처리
document.addEventListener('DOMContentLoaded', function() {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            // 폼 데이터 수집 및 처리 로직
            const formData = new FormData(this);
            console.log("폼 데이터가 제출되었습니다.");
            closeProductModal();
        });
    });
});