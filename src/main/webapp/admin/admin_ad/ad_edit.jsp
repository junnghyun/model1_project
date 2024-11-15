<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.truetrue.ad.AdDAO, kr.co.truetrue.ad.AdVO" %>

<%
   String adId = request.getParameter("ad_Id");
   AdVO adVO = null;
   if (adId != null) {
       AdDAO adDAO = AdDAO.getInstance();  // 싱글턴 인스턴스 가져오기
       adVO = adDAO.selectOneAd(Integer.parseInt(adId)); // 광고 데이터 가져오기
   }

   // 기본값 설정
   String advertiser = adVO != null ? adVO.getAdvertiser() : "기본 광고주";
   String adStartDate = adVO != null ? adVO.getAd_Start_Date() : "";
   String adEndDate = adVO != null ? adVO.getAd_End_Date() : "";
   String adPhone = adVO != null ? adVO.getAd_Phone() : "";
   int adPrice = adVO != null ? adVO.getAd_Price() : 0;
   String adDetail = adVO != null ? adVO.getAd_Detail() : "";
   String adImg = adVO != null ? adVO.getAd_Img() : "default.jpg";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>광고 편집</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
  <!-- 광고 편집 모달 -->
    <div class="modal-overlay">
        <div class="modal-content shadow-xl">
            <div class="bg-green-600 text-white px-6 py-4 flex justify-between items-center">
                <h2 class="text-xl font-semibold">광고 편집</h2>
                <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeAdModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <form id="editAdForm" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group">
                        <!-- 광고 번호 필드 -->
                        <label for="ad_number" class="block text-sm font-medium text-gray-700 mb-1">광고 번호</label>
                        <input type="text" id="ad_number" name="ad_number" class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" 
                               value="<%= adId %>" readonly="readonly">
                    </div>
                   <!-- 광고주 이름 필드 -->
					<div class="input-group">
   				 <label for="advertiser" class="block text-sm font-medium text-gray-700 mb-1">광고주 이름</label>
   				<input type="text" id="advertiser" name="advertiser" maxlength="20" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" 
       			value="<%= advertiser %>" required>
                    <div class="input-group">
                        <label for="ad_Start_Date" class="block text-sm font-medium text-gray-700 mb-1">광고 시작일</label>
                        <input type="date" id="ad_Start_Date" name="ad_start_date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="<%= adStartDate %>" required>
                    </div>
                    <div class="input-group">
                        <label for="ad_End_Date" class="block text-sm font-medium text-gray-700 mb-1">광고 종료일</label>
                        <input type="date" id="ad_End_Date" name="ad_end_date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="<%= adEndDate %>" required>
                    </div>
                    <div class="input-group">
                        <label for="ad_Phone" class="block text-sm font-medium text-gray-700 mb-1">광고주 연락처</label>
                        <input type="tel" id="ad_Phone" name="ad_phone" pattern="[0-9]{11}" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="<%= adPhone %>" required>
                    </div>
                    <div class="input-group">
                        <label for="ad_Price" class="block text-sm font-medium text-gray-700 mb-1">광고 비용</label>
                        <input type="number" id="ad_Price" name="ad_price" max="999999" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="<%= adPrice %>" required>
                    </div>
                </div>
                <div class="input-group">
                    <label for="ad_Detail" class="block text-sm font-medium text-gray-700 mb-1">광고 내용</label>
                    <textarea id="ad_Detail" name="ad_detail" rows="4" maxlength="300" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" required><%= adDetail %></textarea>
                </div>
                <div class="input-group">
                    <label for="ad_Img" class="block text-sm font-medium text-gray-700 mb-1">광고 이미지</label>
                    <input type="file" id="ad_Img" name="ad_image" accept="image/*" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                </div>
                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeAdModal()">취소</button>
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

    function closeAdModal() {
        history.back(); // 이전 페이지로 이동
    }
</script>

</body>
</html>
