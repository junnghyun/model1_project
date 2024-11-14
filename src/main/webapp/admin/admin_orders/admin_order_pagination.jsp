<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
    <c:if test="${currentPage > 1}">
        <a href="admin_orders.jsp?currentPage=${currentPage-1}" class="prev-page">◀</a>
    </c:if>
    
    <c:forEach var="i" begin="1" end="${totalPage}">
        <a href="admin_orders.jsp?currentPage=${i}" 
           class="page-num ${currentPage == i ? 'active' : ''}">
            ${i}
        </a>
    </c:forEach>
    
    <c:if test="${currentPage < totalPage}">
        <a href="admin_orders.jsp?currentPage=${currentPage+1}" class="next-page">▶</a>
    </c:if>
    
</div>