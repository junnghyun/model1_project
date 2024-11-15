<%@page import="kr.co.truetrue.admin.prd.AdminPrdDAO"%>
<%
    String productIdParam = request.getParameter("productId");

    if (productIdParam != null && !productIdParam.isEmpty()) {
        int productId = Integer.parseInt(productIdParam);
        
        AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();
        
        // 데이터베이스에서 해당 제품 삭제 처리
        boolean isDeleted = adminPrdDAO.updateProductDeleteFlag(productId);
		System.out.println(isDeleted);
        if (isDeleted) {
            out.print("success");
        } else {
            out.print("failure");
        }
    } else {
        out.print("failure");
    }
%>