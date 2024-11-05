<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    <div class="modal-overlay">
        <div class="modal-content shadow-xl">
            <div class="bg-green-600 text-white px-6 py-4 flex justify-between items-center">
                <h2 class="text-xl font-semibold">광고 정보 추가</h2>
                <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeAdModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <form class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group">
                        <label for="ad_number" class="block text-sm font-medium text-gray-700 mb-1">광고 번호</label>
                        <input type="text" id="ad_number" name="ad_number" class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="AD12345" readonly>
                    </div>
                    <div class="input-group">
                        <label for="advertiser_name" class="block text-sm font-medium text-gray-700 mb-1">광고주 이름</label>
                        <input type="text" id="advertiser_name" name="advertiser_name" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="">
                    </div> 
                    <div class="input-group">
                        <label for="ad_start_date" class="block text-sm font-medium text-gray-700 mb-1">광고 시작일</label>
                        <input type="date" id="ad_start_date" name="ad_start_date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="">
                    </div>
                    <div class="input-group">
                        <label for="ad_end_date" class="block text-sm font-medium text-gray-700 mb-1">광고 종료일</label>
                        <input type="date" id="ad_end_date" name="ad_end_date" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="">
                    </div>
                    
                    <div class="input-group">
                        <label for="advertiser_contact" class="block text-sm font-medium text-gray-700 mb-1">광고주 연락처</label>
                        <input type="tel" id="advertiser_contact" name="advertiser_contact" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="">
                    </div>
                    <div class="input-group">
                        <label for="ad_cost" class="block text-sm font-medium text-gray-700 mb-1">광고 비용</label>
                        <input type="number" id="ad_cost" name="ad_cost" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" value="">
                    </div>
                </div>
                <div class="input-group">
                    <label for="ad_content" class="block text-sm font-medium text-gray-700 mb-1">광고 내용</label>
                    <textarea id="ad_content" name="ad_content" rows="4" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"></textarea>
                </div>
                <div class="input-group">
                    <label for="ad_image" class="block text-sm font-medium text-gray-700 mb-1">광고 이미지</label>
                    <div class="flex items-center space-x-4">
                        <img id="image_preview" src="/api/placeholder/160/160" alt="현재 광고 이미지" class="w-40 h-auto object-cover rounded-md">
                        <input type="file" id="ad_image" name="ad_image" accept="image/*" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500" onchange="previewImage(this);">
                    </div>
                </div>
                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeAdModal()">취소</button>
                    <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 transition duration-150">저장</button>
                </div>
            </form>
        </div>
    </div>