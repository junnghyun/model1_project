
function deleteMember() {
    const userConfirmed = confirm("삭제하시겠습니까?");
    if (userConfirmed) {
        deleteItem(); // 삭제 기능 실행
    }
}

/**
 * 
 */

function openMemberModal(memberId) {
	// Tailwind CSS를 동적으로 로드
    const tailwindLink = document.createElement('link');
    tailwindLink.rel = 'stylesheet';
    tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
    tailwindLink.id = 'tailwindCSS'; // ID를 추가하여 나중에 쉽게 찾을 수 있게 함
    document.head.appendChild(tailwindLink);
    
    window.location.href = 'memberDetails.jsp?id=' + memberId;
}

function closeMemverModal() {
    document.getElementById('memberModal').style.display = 'none';
    
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
        closeMemverModal();
    }
};

function deleteMember(memberId) {
    if (confirm(memberId + '를 삭제하시겠습니까?')) {
        // AJAX를 사용하여 삭제 요청
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'deleteMember.jsp', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function() {
            if (xhr.status === 200) {
                alert('회원이 삭제되었습니다.');
                location.reload();
            } else {
                alert('회원 삭제에 실패했습니다.');
            }
        };
        xhr.send('id=' + memberId);
    }
}