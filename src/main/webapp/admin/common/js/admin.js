/**
 * 
 */

function showSection(sectionId) {
    document.querySelectorAll('.section').forEach(section => {
        section.style.display = 'none';
    });
    document.getElementById(sectionId).style.display = 'block';
}

function toggleSidebar() {
	const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('toggle-btn');
    
    // 사이드바를 토글
    sidebar.classList.toggle('hidden');
    
    // 사이드바가 숨겨진 경우 ≡를 보여줌
    if (sidebar.classList.contains('hidden')) {
        toggleBtn.innerHTML = '&#9776;'; // 햄버거 메뉴
    } else {
        toggleBtn.innerHTML = '&times;'; // X 버튼
    }
}