<%@page import="kr.co.truetrue.user.store.StoreVO"%>
<%@page import="kr.co.truetrue.user.store.StoreDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 폼이 POST로 제출된 경우
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        StoreVO sVO = new StoreVO();
        sVO.setStore_name(new String(request.getParameter("store_name").getBytes("ISO-8859-1"), "UTF-8"));
        sVO.setStore_phone(request.getParameter("store_contact"));

        // 주소와 상세주소를 결합하여 저장
        String address = new String(request.getParameter("address").getBytes("ISO-8859-1"), "UTF-8");
		String addressDetail = new String(request.getParameter("address_detail").getBytes("ISO-8859-1"), "UTF-8");
        String fullAddress = address + " " + addressDetail; // 예: 주소 상세주소
        sVO.setStore_address(fullAddress.trim()); // trim()으로 공백 제거

        String status = request.getParameter("store_status");
        sVO.setStore_status(status != null && !status.isEmpty() ? status.charAt(0) : ' ');

        sVO.setLat(Double.parseDouble(request.getParameter("latitude")));
        sVO.setLng(Double.parseDouble(request.getParameter("longitude")));

        StoreDAO sDAO = StoreDAO.getInstance();
        boolean insertFlag = false;

        try {
            sDAO.insertStore(sVO);
            insertFlag = true; // 성공적으로 삽입됨
        } catch (SQLException e) {
            e.printStackTrace();
        }
%>
        <div>
            <c:choose>
                <c:when test="${insertFlag}">
                    <p>매장 정보가 성공적으로 추가되었습니다.</p>
                </c:when>
                <c:otherwise>
                    <p>매장 정보 추가에 실패했습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
<%
    }
%>
<div id="storeAddModal" style="display: none;">
    <div class="modal-overlay">
        <div class="modal-content shadow-xl">
            <div class="bg-green-600 text-white px-6 py-4 flex justify-between items-center">
                <h2 class="text-xl font-semibold" style="font-color: black;">매장 정보 추가</h2>
                <button class="text-white hover:text-gray-200 transition duration-150" onclick="closeStoreModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <form action="${pageContext.request.requestURI}" method="post" class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group md:col-span-2">
                        <label for="store_name" class="block text-sm font-medium text-gray-700 mb-1">매장명</label>
                        <input type="text" id="store_name" name="store_name" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="매장명을 입력해주세요">
                    </div>
                    <div class="input-group md:col-span-2">
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">주소</label>
                        <div class="relative">
						    <input type="text" id="address" name="address" class="w-full px-3 py-2 pr-24 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="주소 검색을 통해 주소를 입력해주세요." readonly>
						    <div class="absolute inset-y-0 right-0 flex items-center">
						        <button type="button" id="findZipcode" onclick="searchZipcode('add')" class="h-7 px-3 mx-2 text-sm bg-green-600 text-white rounded hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 transition duration-150">
								    주소 검색
								</button>
						    </div>
						</div>
                    </div>
                    <div class="input-group md:col-span-2">
                        <label for="address_detail" class="block text-sm font-medium text-gray-700 mb-1">상세주소</label>
                        <input type="text" id="address_detail" name="address_detail" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="상세주소를 입력해주세요">
                    </div>
                    <div class="input-group">
                        <label for="store_contact" class="block text-sm font-medium text-gray-700 mb-1">매장 연락처</label>
                        <input type="tel" id="store_contact" name="store_contact" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="연락처를 입력해주세요">
                    </div>
                    <div class="input-group">
                        <label for="store_status" class="block text-sm font-medium text-gray-700 mb-1">매장 상태</label>
                        <select id="store_status" name="store_status" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                            <option value="Y">영업 중</option>
                            <option value="D">폐업</option>
                            <option value="T">임시 휴업</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label for="latitude" class="block text-sm font-medium text-gray-700 mb-1">위도</label>
                        <input type="number" id="latitude" name="latitude" step="0.000001" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="위도">
                    </div>
                    <div class="input-group">
                        <label for="longitude" class="block text-sm font-medium text-gray-700 mb-1">경도</label>
                        <input type="number" id="longitude" name="longitude" step="0.000001" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" placeholder="경도">
                    </div>
                </div> 
                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeStoreModal()">취소</button>
                    <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-orange-700 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition duration-150">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>
