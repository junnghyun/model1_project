<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.store.StoreVO"%>
<%@page import="kr.co.truetrue.user.store.StoreDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="sVO" class="kr.co.truetrue.user.store.StoreVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

int store_id = 0;
String storeId = request.getParameter("store_id");

// store_id를 정수형으로 변환
try {
    store_id = Integer.parseInt(storeId);
} catch (NumberFormatException nfe) {
    response.sendRedirect("admin_store.jsp");
    return;
}

// StoreDAO 및 StoreVO 인스턴스 생성
StoreDAO sDAO = StoreDAO.getInstance();

try {
    sVO = sDAO.selectDetailStore(store_id);
    pageContext.setAttribute("sVO", sVO);
} catch (SQLException se) {
    se.printStackTrace();
    response.sendRedirect("admin_store.jsp");
    return;
}



double latitude = sVO.getLat(); // StoreVO에서 위도 가져오기
double longitude = sVO.getLng(); // StoreVO에서 경도 가져오기

// 매장 수정 폼 HTML 생성
if ("POST".equalsIgnoreCase(request.getMethod())) {
    // StoreVO 객체 생성 및 데이터 설정
    sVO = new StoreVO();
    sVO.setStore_id(Integer.parseInt(request.getParameter("store_id")));
    sVO.setStore_name(new String(request.getParameter("store_name").getBytes("ISO-8859-1"), "UTF-8"));
    sVO.setStore_phone(request.getParameter("store_contact"));
    
    String address = new String(request.getParameter("address").getBytes("ISO-8859-1"), "UTF-8");
	String addressDetail = new String(request.getParameter("address_detail").getBytes("ISO-8859-1"), "UTF-8");
    String fullAddress = address + " " + addressDetail; // 예: 주소 상세주소
    sVO.setStore_address(fullAddress.trim()); // trim()으로 공백 제거
    
    String status = request.getParameter("store_status");
    sVO.setStore_status(status != null && !status.isEmpty() ? status.charAt(0) : ' ');
    
    String latitudeStr = request.getParameter("latitude");
    String longitudeStr = request.getParameter("longitude");
    sVO.setLat(Double.parseDouble(latitudeStr));
    sVO.setLng(Double.parseDouble(longitudeStr));

    // StoreDAO 인스턴스 생성 및 업데이트 수행
    sDAO = StoreDAO.getInstance();
    try {
        sDAO.updateStore(sVO);
        // 성공적인 업데이트 후 리다이렉트
        response.sendRedirect("admin_store.jsp");
        return;
    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().write("error"); // 클라이언트에게 오류 메시지 전송
    }
}
%>

<!-- 매장 정보 수정 모달 -->
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg w-full max-w-3xl mx-4">
        <!-- Modal Header -->
        <div class="bg-green-600 text-white px-6 py-4 rounded-t-lg flex justify-between items-center">
            <h2 class="text-xl font-semibold">매장 정보 수정</h2>
            <button type="button" onclick="closeStoreModal()" class="text-white hover:text-gray-200">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>

            <!-- 수정 폼 -->
            <form class="p-6 space-y-6" method="post" action="store_edit_modal.jsp?store_id=${sVO.store_id}">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group md:col-span-2">
                        <label for="store_name" class="block text-sm font-medium text-gray-700 mb-1">매장명</label>
                        <input type="text" id="store_name" name="store_name" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" value="${sVO.store_name}" placeholder="매장명을 입력해주세요" required>
                    </div>

                    <div class="input-group md:col-span-2">
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">주소</label>
                        <input type="text" id="address" name="address" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" 
                        		value="${sVO.store_address.replaceAll('^(.*?\\s\\d+)(\\s.*)', '$1').trim()}" placeholder="기본 주소를 입력해주세요" required>
                    </div>

                    <div class="input-group md:col-span-2">
                        <label for="address_detail" class="block text-sm font-medium text-gray-700 mb-1">상세주소</label>
                        <input type="text" id="address_detail" name="address_detail" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" 
                        		value="${sVO.store_address.replaceAll('^(.*?\\s\\d+)(\\s.*)', '$2').trim()}" placeholder="상세주소를 입력해주세요">
                    </div>

                    <div class="input-group">
                        <label for="store_contact" class="block text-sm font-medium text-gray-700 mb-1">매장 연락처</label>
                        <input type="tel" id="store_contact" name="store_contact" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" value="${sVO.store_phone}" placeholder="연락처를 입력해주세요" required>
                    </div>

                    <div class="input-group">
                        <label for="store_status" class="block text-sm font-medium text-gray-700 mb-1">매장 상태</label>
                        <select id="store_status" name="store_status" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
						    <option value="Y" ${sVO.getStoreStatusString() == 'Y' ? 'selected' : ''}>영업 중</option>
						    <option value="D" ${sVO.getStoreStatusString() == 'D' ? 'selected' : ''}>폐업</option>
						    <option value="T" ${sVO.getStoreStatusString() == 'T' ? 'selected' : ''}>임시 휴업</option>
						</select>
                    </div>

                    <div class="input-group">
                        <label for="latitude" class="block text-sm font-medium text-gray-700 mb-1">위도</label>
                      	<input type="number" id="latitude" name="latitude" step="0.000001" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" value="${sVO.lat != null ? sVO.lat : ''}" required>
                    </div>

                    <div class="input-group">
                        <label for="longitude" class="block text-sm font-medium text-gray-700 mb-1">경도</label>
                        <input type="number" id="longitude" name="longitude" step="0.000001" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" value="${sVO.lng != null ? sVO.lng : ''}" required>
                    </div>
                </div>

                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 transition duration-150" onclick="closeStoreModal()">취소</button>
                    <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-orange-700 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition duration-150">저장</button>
                </div>
            </form>
        </div>
    </div>
