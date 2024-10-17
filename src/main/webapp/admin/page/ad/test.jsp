<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>광고 정보 수정 모달</title>
    <style>
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
        }
        .modal-content {
            background-color: white;
            margin: auto;
            padding: 20px;
            width: 600px; /* 가로 600px */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            overflow-y: auto; /* 스크롤 가능 */
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 15px; /* 각 필드 간의 간격 */
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: 500;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .submit-btn {
            padding: 10px 15px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
        .cancel-btn {
            padding: 10px 15px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .cancel-btn:hover {
            background-color: #e53935;
        }
        .inline-fields {
            display: flex;
            justify-content: space-between; /* 필드 간 간격 설정 */
        }
        .inline-fields > div {
            flex: 1;
            margin-right: 10px;
        }
        .inline-fields > div:last-child {
            margin-right: 0;
        }
    </style>
</head>
<body class="bg-gray-100">

    <!-- 광고 정보 수정 버튼 -->
    <button class="add-product-btn" onclick="openModal()">광고 정보 수정</button>

    <!-- 광고 정보 수정 모달 -->
    <div class="modal" id="adEditModal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2 class="font-semibold text-lg mb-4">광고 정보 수정</h2>
            <form id="adEditForm">
                <div class="form-group inline-fields">
                    <div>
                        <label for="ad_number">광고 번호:</label>
                        <input type="text" id="ad_number" name="ad_number" value="AD12345" readonly class="bg-gray-200">
                    </div>
                    <div>
                        <label for="advertiser_name">광고주 이름:</label>
                        <input type="text" id="advertiser_name" name="advertiser_name" value="(주)행복한 광고" required>
                    </div>
                </div>
                <div class="form-group inline-fields">
                    <div>
                        <label for="ad_start_date">광고 시작일:</label>
                        <input type="date" id="ad_start_date" name="ad_start_date" value="2023-05-01" required>
                    </div>
                    <div>
                        <label for="ad_end_date">광고 종료일:</label>
                        <input type="date" id="ad_end_date" name="ad_end_date" value="2023-05-31" required>
                    </div>
                </div>
                <div class="form-group inline-fields">
                    <div>
                        <label for="advertiser_contact">광고주 연락처:</label>
                        <input type="tel" id="advertiser_contact" name="advertiser_contact" value="02-1234-5678" required>
                    </div>
                    <div>
                        <label for="ad_cost">광고 비용:</label>
                        <input type="number" id="ad_cost" name="ad_cost" value="1000000" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="ad_content">광고 내용:</label>
                    <textarea id="ad_content" name="ad_content" rows="4" required>신제품 출시 기념 특별 할인 이벤트! 지금 바로 확인하세요.</textarea>
                </div>
                <div class="form-group">
                    <label for="ad_image">광고 이미지:</label>
                    <div class="inline-fields">
                        <div>
                            <img src="/api/placeholder/200/150" alt="현재 광고 이미지" class="w-40 h-auto object-cover rounded-md">
                        </div>
                        <div>
                            <input type="file" id="ad_image" name="ad_image" accept="image/*" class="border rounded-md py-2 px-3">
                        </div>
                    </div>
                </div>
                <div class="flex justify-between mt-4">
                    <button type="button" class="cancel-btn" onclick="closeModal()">취소</button>
                    <button type="submit" class="submit-btn">저장</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal() {
        	const tailwindLink = document.createElement('link');
            tailwindLink.rel = 'stylesheet';
            tailwindLink.href = 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css'; // Tailwind CSS CDN
            document.head.appendChild(tailwindLink);
        	
            document.getElementById('adEditModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('adEditModal').style.display = 'none';
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const modal = document.getElementById('adEditModal');
            if (event.target === modal) {
                closeModal();
            }
        };

        // 폼 제출 시 데이터 처리 (예시)
        document.getElementById('adEditForm').onsubmit = function(event) {
            event.preventDefault(); // 기본 제출 방지
            // 추가 로직 (예: 데이터 전송)
            closeModal(); // 모달 닫기
        };
    </script>
</body>
</html>
