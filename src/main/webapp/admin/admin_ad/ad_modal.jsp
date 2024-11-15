<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" 
 info="광고 추가" %>


<%-- <%
    String advertiser = request.getParameter("advertiser");
    out.println("광고주: " + advertiser); // 값을 출력하여 확인
%> --%>
<div class="modal-overlay">
    <div class="modal-content shadow-xl">
        <div class="bg-green-600 text-white px-6 py-4 flex justify-between items-center">
            <h2 class="text-xl font-semibold">광고 추가</h2>
            <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeAdModal()">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
        <!-- 광고 추가 폼 -->
        <form class="p-6 space-y-6" action="ad_modal_process.jsp" id="addAdForm" name="addAdForm" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="input-group">
                    <label for="ad_number" class="block text-sm font-medium text-gray-700 mb-1">광고 번호</label>
                    <input type="text" id="ad_Id" name="ad_Id" class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="${ AdVO.ad_id}" readonly="readonly"/>
                </div>
                <div class="input-group">
                    <label for="advertiser" class="block text-sm font-medium text-gray-700 mb-1">광고주 이름</label>
                    <input type="text" id="advertiser" name="advertiser" maxlength="20" class="form-control" required />
                </div>
                <div class="input-group">
                    <label for="ad_Start_Date" class="block text-sm font-medium text-gray-700 mb-1">광고 시작일</label>
                    <input type="date" id="ad_Start_Date" name="ad_Start_Date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required>
                </div>
                <div class="input-group">
                    <label for="ad_End_Date" class="block text-sm font-medium text-gray-700 mb-1">광고 종료일</label>
                    <input type="date" id="ad_End_Date" name="ad_End_Date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required>
                </div>
                <div class="input-group">
                    <label for="ad_Phone" class="block text-sm font-medium text-gray-700 mb-1">광고주 연락처</label>
                    <input type="tel" id="ad_Phone" name="ad_Phone" pattern="[0-9]{11}" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required>
                </div>
                <div class="input-group">
                    <label for="ad_Price" class="block text-sm font-medium text-gray-700 mb-1">광고 비용</label>
                    <input type="number" id="ad_Price" name="ad_Price" max="999999" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required>
                </div>
            </div>
            <div class="input-group">
                <label for="ad_Detail" class="block text-sm font-medium text-gray-700 mb-1">광고 내용</label>
                <textarea id="ad_Detail" name="ad_Detail" rows="4" maxlength="300" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required></textarea>
            </div>
            <div class="input-group">
                <label for="ad_Img" class="block text-sm font-medium text-gray-700 mb-1">광고 이미지</label>
                <input type="file" id="ad_Img" name="ad_Img" accept="image/*" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="history.back()">취소</button>
                <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition duration-150">저장</button>
            </div>
        </form>
    </div>
</div>

<script>
    function validateForm() {
        const price = document.getElementById('ad_Price').value;
        const phone = document.getElementById('ad_Phone').value;
        const detail = document.getElementById('ad_Detail').value;

        if (price.length > 6) {
            alert("가격은 6자리 이내여야 합니다.");
            return false;
        }
        if (phone.length !== 11) {
            alert("휴대폰 번호는 11자리여야 합니다.");
            return false;
        }
        if (detail.length > 300) {
            alert("광고 내용은 300자 이내여야 합니다.");
            return false;
        }

        return true;
    }
</script>
