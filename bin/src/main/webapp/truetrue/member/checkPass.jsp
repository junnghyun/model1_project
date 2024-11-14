<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="입력된 현재 비밀번호를 토대로 사용자를 파악하고 새로운 비밀번호로 업데이트 하는 일(현재 로그인되어있는 사용자의 회원코드나 아이디 정보를 받아야한다. 그렇지 않으면 비밀번호는 겹칠 수 있기 때문에 엉뚱한 사람의 번호가 바뀔 수 있음)"
%>
<%@ page import="kr.co.truetrue.member.MemberDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 사용자가 입력한 현재 비밀번호와 새 비밀번호 가져오기
    String bef_pwd = request.getParameter("bef_pwd");
    String new_pwd = request.getParameter("new_pwd");
    String new_pwd_check = request.getParameter("new_pwd_check");
    
    // 사용자를 식별하기 위해 로그인 되어있는 세션의 회원정보 중 아이디 가져오기 
    String userId = (String) session.getAttribute("user_id");
    
    // 입력값 검증
    if (bef_pwd == null || bef_pwd.isEmpty() || new_pwd == null || new_pwd.isEmpty() || new_pwd_check == null || new_pwd_check.isEmpty()) {
        out.println("<script>alert('모든 필드를 입력해 주세요.'); history.back();</script>");
    } else if (!new_pwd.equals(new_pwd_check)) {
        // 새 비밀번호와 확인 비밀번호가 일치하지 않는 경우
        out.println("<script>alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.'); history.back();</script>");
    } else {
        // MemberDAO 초기화
        MemberDAO mDAO = MemberDAO.getInstance();

        try {
            // verifyAndUpdatePassword 메서드를 사용하여 비밀번호를 확인하고 업데이트 수행
            boolean isUpdated = mDAO.verifyAndUpdatePassword(userId, bef_pwd, new_pwd);
            System.out.println("Password update result for user " + userId + ": " + isUpdated);
            if (isUpdated) {
                // 성공 메시지 - 비밀번호 변경 성공 후 메인 페이지로 이동
                out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); location.href='find_pw4.jsp';</script>");
            } else {
                // 실패 메시지 - 현재 비밀번호가 일치하는 사용자가 없거나 업데이트 실패
                out.println("<script>alert('비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인해주세요.'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('비밀번호 변경 중 오류가 발생했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    }
%>