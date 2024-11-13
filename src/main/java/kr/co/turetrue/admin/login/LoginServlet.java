package kr.co.turetrue.admin.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminId = request.getParameter("admin_id");
        String pass = request.getParameter("pass");

        AdminVO aVO = new AdminVO();
        aVO.setAdmin_id(adminId);
        aVO.setPass(pass);

        AdminDAO aDAO = AdminDAO.getInstance();
        try {
            boolean isValid = aDAO.selectLogin(aVO);
            if (isValid) {
                HttpSession session = request.getSession();
                session.setAttribute("adminData", aVO);
                response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard/admin_dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/admin_login/admin_login.jsp?error=invalid");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
