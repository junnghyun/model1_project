<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.user.card.CardDAO" %>
<%@ page import="kr.co.truetrue.user.card.CardVO" %>
<%@ page import="kr.co.truetrue.admin.order.OrderDAO" %>

<%
/* 카드 정보를 저장하는 프로세스 */

// 카드 정보 받기
String userId = (String)session.getAttribute("user_id");
String cardNum1 = request.getParameter("cardNum1");
String cardNum2 = request.getParameter("cardNum2");
String cardNum3 = request.getParameter("cardNum3");
String cardNum4 = request.getParameter("cardNum4");
String expMonth = request.getParameter("expMonth");
String expYear = request.getParameter("expYear");
String cardType = request.getParameter("cardType");
String installment = request.getParameter("installment");

// cart_product_ids와 requests 파라미터 추가
String cartProductIds = request.getParameter("cartProductIds");
String requests = request.getParameter("requests");

JSONObject jsonObj = new JSONObject();

try {
    // 새로운 주문 ID 생성
    OrderDAO orderDAO = OrderDAO.getInstance();
    int orderId = orderDAO.getNextOrderId();  

    // 카드 정보 객체 생성 및 설정
    CardVO cardVO = new CardVO();
    cardVO.setOrder_id(orderId);  
    cardVO.setCard_num1(cardNum1);
    cardVO.setCard_num2(cardNum2);
    cardVO.setCard_num3(cardNum3);
    cardVO.setCard_num4(cardNum4);
    cardVO.setMonth(Integer.parseInt(expMonth));
    cardVO.setYear(expYear);
    cardVO.setCard_type(cardType);
    // 할부 개월 수 설정 (숫자만 추출)
    cardVO.setInstallment_type(Integer.parseInt(installment.replaceAll("[^0-9]", "")));

    CardDAO cardDAO = CardDAO.getInstance();
    
    // 기존 카드 정보 확인 (order_id 기준으로 조회)
    CardVO existingCard = cardDAO.getCardInfoByOrderId(orderId);
    
    if(existingCard != null) {
        // 기존 카드가 있으면 업데이트
        cardVO.setCard_id(existingCard.getCard_id());
        cardDAO.updateCardInfo(cardVO);
    } else {
        // 기존 카드가 없으면 새로 저장
        cardDAO.insertCardInfo(cardVO);
    }
    
    jsonObj.put("status", "success");
    jsonObj.put("order_id", orderId);  
    
} catch(Exception e) {
    jsonObj.put("status", "error");
    jsonObj.put("message", e.getMessage());
    e.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>