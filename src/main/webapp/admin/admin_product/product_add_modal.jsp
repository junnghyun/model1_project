<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal-overlay">
    <div class="modal-content shadow-xl max-w-3xl mx-auto">
        <div class="bg-indigo-600 text-white px-4 py-3 flex justify-between items-center">
            <h2 class="text-lg font-semibold">제품 정보 추가</h2>
            <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeProductModal()">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
        <form class="p-4 space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="input-group">
                    <label for="product_id" class="block text-sm font-medium text-gray-700 mb-1">제품 ID</label>
                    <input type="text" id="product_id" name="product_id" class="w-full px-2 py-1 text-sm bg-gray-100 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="P12345" readonly>
                </div>
                <div class="input-group">
                    <label for="category_number" class="block text-sm font-medium text-gray-700 mb-1">카테고리</label>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="radio" name="category" value="bread" class="form-radio text-indigo-600 focus:ring-indigo-500" checked onchange="updateProductType(this.value)">
                            <span class="ml-2 text-sm">빵</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="category" value="cake" class="form-radio text-indigo-600 focus:ring-indigo-500" onchange="updateProductType(this.value)">
                            <span class="ml-2 text-sm">케이크</span>
                        </label>
                    </div>
                </div>
                <div class="input-group">
                    <label for="product_name" class="block text-sm font-medium text-gray-700 mb-1">제품명</label>
                    <input type="text" id="product_name" name="product_name" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="맛있는 과자">
                </div>
                <div class="input-group">
                    <label for="bread_type" class="block text-sm font-medium text-gray-700 mb-1">종류</label>
                    <select id="product_type" name="product_type" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                        <option value="">선택하세요</option>
                    </select>
                </div>
                <div class="input-group md:col-span-2">
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-1">설명</label>
                    <textarea id="description" name="description" rows="2" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">바삭바삭하고 달콤한 과자입니다.</textarea>
                </div>
                <div class="input-group">
                    <label for="total_weight" class="block text-sm font-medium text-gray-700 mb-1">총중량 (g)</label>
                    <input type="number" id="total_weight" name="total_weight" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="100">
                </div>
                <div class="input-group">
                    <label for="calories" class="block text-sm font-medium text-gray-700 mb-1">열량 (kcal)</label>
                    <input type="number" id="calories" name="calories" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="500">
                </div>
                <div class="input-group">
                    <label for="sugar" class="block text-sm font-medium text-gray-700 mb-1">당류 (g)</label>
                    <input type="number" id="sugar" name="sugar" step="0.1" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="10.5">
                </div>
                <div class="input-group">
                    <label for="protein" class="block text-sm font-medium text-gray-700 mb-1">단백질 (g)</label>
                    <input type="number" id="protein" name="protein" step="0.1" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="5.2">
                </div>
                <div class="input-group">
                    <label for="sodium" class="block text-sm font-medium text-gray-700 mb-1">나트륨 (mg)</label>
                    <input type="number" id="sodium" name="sodium" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="200">
                </div>
                <div class="input-group">
                    <label for="price" class="block text-sm font-medium text-gray-700 mb-1">가격 (원)</label>
                    <input type="number" id="price" name="price" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" value="1500">
                </div>
                <div class="input-group md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-1">알레르기 정보</label>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="allergy_info" value="milk" class="form-checkbox text-indigo-600 focus:ring-indigo-500">
                            <span class="ml-2 text-sm">우유</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="allergy_info" value="wheat" class="form-checkbox text-indigo-600 focus:ring-indigo-500">
                            <span class="ml-2 text-sm">밀</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="allergy_info" value="soy" class="form-checkbox text-indigo-600 focus:ring-indigo-500">
                            <span class="ml-2 text-sm">대두</span>
                        </label>
                    </div>
                </div>
                <div class="input-group md:col-span-2">
                    <label for="product_image" class="block text-sm font-medium text-gray-700 mb-1">제품 이미지</label>
                    <div class="flex items-center space-x-4">
                        <img src="" alt="현재 제품 이미지" class="w-20 h-20 object-cover rounded-md">
                        <input type="file" id="product_image" name="product_image" accept="image/*" class="w-full px-2 py-1 text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                    </div>
                </div>
            </div>
            <div class="flex justify-end space-x-3 mt-4">
                <button type="button" class="px-3 py-1 text-sm bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeProductModal()">취소</button>
                <button type="submit" class="px-3 py-1 text-sm bg-indigo-600 text-white rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition duration-150">저장</button>
            </div>
        </form>
    </div>
</div>