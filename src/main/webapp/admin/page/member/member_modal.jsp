<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <div class="modal-overlay">
        <div class="modal-content shadow-xl">
            <div class="bg-blue-600 text-white px-6 py-4 flex justify-between items-center">
                <h2 class="text-xl font-semibold">회원 상세 정보 수정</h2>
                <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeMemverModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <form class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group">
                        <label for="id" class="block text-sm font-medium text-gray-700 mb-1">회원 ID</label>
                        <input type="text" id="id" name="id" class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.id}" readonly>
                    </div>
                    <div class="input-group">
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">이름</label>
                        <input type="text" id="name" name="name" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.name}">
                    </div> 
                    <div class="input-group">
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
                        <input type="password" id="password" name="password" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="********">
                    </div>
                    <div class="input-group">
                        <label for="birthdate" class="block text-sm font-medium text-gray-700 mb-1">생년월일</label>
                        <input type="date" id="birthdate" name="birthdate" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.birthDate}">
                    </div>
                    <div class="input-group">
                        <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">연락처</label>
                        <input type="tel" id="phone" name="phone" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.phone}">
                    </div>
                    <div class="input-group">
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">이메일</label>
                        <input type="email" id="email" name="email" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.email}">
                    </div>
                    <div class="input-group">
                        <label for="zipcode" class="block text-sm font-medium text-gray-700 mb-1">우편번호</label>
                        <input type="text" id="zipcode" name="zipcode" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.getZipcode}">
                    </div>
                </div>
                <div class="input-group">
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-1">주소</label>
                    <input type="text" id="address" name="address" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.getAddress}">
                </div>
                <div class="input-group">
                    <label for="detail_address" class="block text-sm font-medium text-gray-700 mb-1">상세주소</label>
                    <input type="text" id="detail_address" name="detail_address" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" value="${member.getDetailAddress}">
                </div>
                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeMemverModal()">취소</button>
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition duration-150">저장</button>
                </div>
            </form>
        </div>
    </div>
