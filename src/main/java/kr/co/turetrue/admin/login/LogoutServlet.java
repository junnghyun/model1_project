package kr.co.turetrue.admin.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

 // POST 요청으로 로그아웃 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 무효화
        HttpSession session = request.getSession();
        session.invalidate(); // 세션 무효화


        // 로그인 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/admin/admin_login/admin_login.jsp"); // 로그인 페이지로 리다이렉트
    }
}
