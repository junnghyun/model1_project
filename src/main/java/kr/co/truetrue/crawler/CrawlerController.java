package kr.co.truetrue.crawler;

import kr.co.truetrue.crawler.MapCrawlerService;
import org.json.simple.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/crawlStores")
public class CrawlerController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CrawlerController.class.getName());
    private MapCrawlerService crawlerService;

    @Override
    public void init() throws ServletException {
        // 서비스 객체를 서블릿 초기화 시 생성하여 재사용
        crawlerService = new MapCrawlerService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String region = request.getParameter("region");

        // 지역명이 제공되지 않으면 클라이언트에 오류 응답
        if (region == null || region.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "지역명이 제공되지 않았습니다.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"지역명이 필요합니다.\"}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            // 크롤링 서비스 호출 (키워드: "뚜레쥬르 + 지역명")
            JSONArray storeList = crawlerService.crawlStores("뚜레쥬르"+region);

            // 응답을 JSON 형식으로 설정
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();
            out.write(storeList.toJSONString());

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "크롤링 중 오류 발생", e);
            // 예외 발생 시 클라이언트에 오류 응답
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"크롤링 중 오류가 발생했습니다.\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
