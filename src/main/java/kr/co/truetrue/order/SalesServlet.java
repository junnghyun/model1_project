package kr.co.truetrue.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/getMonthlySales")
public class SalesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 월별 매출 데이터를 Map<String, Double>로 가져옴
        OrderDAO orderDAO = OrderDAO.getInstance();
        Map<String, Double> monthlySales = orderDAO.getMonthlySales();
        
        // JSON 형식으로 데이터를 변환
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("monthlySales", monthlySales);
        
        // JSON 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // 응답으로 JSON 데이터 전송
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
