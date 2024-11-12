package kr.co.truetrue.crawler;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.truetrue.dao.DbConnection;

@WebServlet("/saveStores")
public class SaveStoresController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSON으로 받은 데이터를 파싱하여 DB에 저장
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        CrawlerVO[] stores = gson.fromJson(reader, CrawlerVO[].class);

        // 받은 데이터 확인 (디버깅용)
        System.out.println("받은 매장 데이터:");
        for (CrawlerVO store : stores) {
            System.out.println("Name: " + store.getStore_name() +
                               ", Phone: " + store.getStore_phone() +
                               ", Address: " + store.getStore_address() +
                               ", Lat: " + store.getLat() +
                               ", Lng: " + store.getLng());
        }

        CrawlerDAO cDAO = new CrawlerDAO();
        Connection con = null;

        try {
            // Connection 가져오기
            DbConnection dbCon = DbConnection.getInstance();
            con = dbCon.getConn();
            con.setAutoCommit(false);
            
            // 매장 데이터를 DB에 삽입
            for (CrawlerVO cVO : stores) {
                cDAO.insertStore(con, cVO); // 트랜잭션 처리를 위해 Connection을 전달
            }

            con.commit(); // 성공 시 커밋
            response.getWriter().write("성공적으로 저장되었습니다.");
        } catch (SQLException e) {
            try {
                if (con != null) {
                    con.rollback(); // 오류 발생 시 롤백
                }
            } catch (SQLException rollbackEx) {
                System.err.println("롤백 중 오류 발생: " + rollbackEx.getMessage());
            }
            System.err.println("SQL 오류 발생: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("저장 중 오류가 발생했습니다.");
        } finally {
            if (con != null) {
                try {
                    con.close(); // Connection 자원 해제
                } catch (SQLException closeEx) {
                    System.err.println("Connection 종료 중 오류 발생: " + closeEx.getMessage());
                }
            }
        }
    }
}
