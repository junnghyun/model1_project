/**
 * 광고 관리 스크립트
 */

$(document).ready(function () {
    // 광고 추가 모달 열기
    $('#openAddAdButton').on('click', openAddAdModal);

    // 광고 삭제
    $('.delete-btn').on('click', function () {
        const adId = $(this).data('id');
        deleteAd(adId);
    });

    // 광고 편집
    $('.edit-btn').on('click', function () {
        const adId = $(this).data('id');
        openEditAdModal(adId);
    });
});

// 광고 삭제 함수
function deleteAd(adId) {
    if (confirm("이 광고를 삭제하시겠습니까?")) {
        $.ajax({
            url: 'ad_delete.jsp',
            type: 'POST',
            data: { ad_Id: adId },
            success: function (response) {
                alert("광고가 삭제되었습니다.");
                location.reload();
            },
            error: function () {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });
    }
}

// 광고 추가 모달 열기
function openAddAdModal() {
    loadTailwindCSS();
    $('#adModal').show();
}

// 광고 편집 모달 열기
function openEditAdModal(adId) {
    loadTailwindCSS();

    $.ajax({
        url: 'ad_update.jsp',
        type: 'GET',
        data: { ad_Id: adId },
        success: function (response) {
            const adData = JSON.parse(response);
            $('#ad_Id').val(adData.ad_Id);
            $('#advertiser').val(adData.advertiser);
            $('#ad_Start_Date').val(adData.ad_Start_Date);
            $('#ad_End_Date').val(adData.ad_End_Date);
            $('#ad_Phone').val(adData.ad_Phone);
            $('#ad_Price').val(adData.ad_Price);
            $('#ad_Detail').val(adData.ad_Detail);
            $('#editAdModal').show();
        },
        error: function () {
          alert("광고 데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// 광고 편집 저장
function editAd() {
    const formData = {
        ad_Id: $('#ad_Id').val(),
        advertiser: $('#advertiser').val(),
        ad_Start_Date: $('#ad_Start_Date').val(),
        ad_End_Date: $('#ad_End_Date').val(),
        ad_Phone: $('#ad_Phone').val(),
        ad_Price: $('#ad_Price').val(),
        ad_Detail: $('#ad_Detail').val()
    };

    $.ajax({
        url: 'ad_update.jsp',
        type: 'POST',
        data: formData,
        success: function (response) {
            alert(response.includes("업데이트 성공") ? "광고가 성공적으로 업데이트되었습니다." : "업데이트 실패: " + response);
            location.reload();
        },
        error: function () {
            alert("업데이트 중 오류가 발생했습니다.");
        }
    });
}

// Tailwind CSS 로드
function loadTailwindCSS() {
    if (!document.getElementById('tailwindCSS')) {
        const tailwindLink = document.createElement('link');
        tailwindLink.rel = 'stylesheet';
        tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css';
        tailwindLink.id = 'tailwindCSS';
        document.head.appendChild(tailwindLink);
    }
}

// 광고 추가 및 편집 모달 닫기
function closeAdModal() {
    $('#adModal, #editAdModal').hide();
    removeTailwindCSS();
}

// Tailwind CSS 제거
function removeTailwindCSS() {
    const tailwindLink = document.getElementById('tailwindCSS');
    if (tailwindLink) document.head.removeChild(tailwindLink);
}


// 편집 폼 제출 처리
$('#editAdForm').on('submit', function (event) {
    event.preventDefault();
    editAd();
});


  
    // 이미지 미리보기 함수
    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                $('#image_preview').attr('src', e.target.result).css({ width: '100px', height: '100px' });
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 업데이트 함수
    function editAd(event) {
        event.preventDefault();  // 폼 기본 동작 중단

        const formData = {
            ad_Id: $('#ad_number').val(),
            ad_Start_Date: $('#ad_Start_Date').val().replace(/-/g, ''),
            ad_End_Date: $('#ad_End_Date').val().replace(/-/g, ''),
            advertiser: $('#advertiser').val(),
            ad_Phone: $('#ad_Phone').val(),
            ad_Price: $('#ad_Price').val(),
            ad_Detail: $('#ad_content').val(),
            ad_Img: $('#ad_image').val().split('\\').pop()
        };

        $.ajax({
            url: 'ad_update.jsp',
            type: 'POST',
            data: formData,
            success: function(response) {
                const result = JSON.parse(response); // JSON 응답 파싱
                if (result.status === "성공") {
                    alert("업데이트에 성공하셨습니다.");  // 성공 메시지
                    window.location.href = "admin_ad.jsp";  // 페이지 이동
                } else {
                    alert(result.message);  // 실패 메시지
                }
            },
            error: function() {
                alert("업데이트 중 오류가 발생했습니다.");  // 일반 오류 메시지
            }
        });
    }

    // 모달 닫기 함수 (취소 버튼 기능)
    function closeAdModal() {
        history.back(); // 취소 시 이전 페이지로 이동
    }
