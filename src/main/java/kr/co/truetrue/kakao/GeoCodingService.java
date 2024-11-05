package kr.co.truetrue.kakao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class GeoCodingService {
	
	private static final String KAKAO_API_KEY = "a5ff8121253901a6bd5fea3e7a138290";
    private static final String KAKAO_API_URL = "https://dapi.kakao.com/v2/local/search/address.json";
    
    public JSONObject getGeoLocation(String address) throws Exception {
        String encodedAddress = URLEncoder.encode(address, "UTF-8");
        URL url = new URL(KAKAO_API_URL + "?query=" + encodedAddress);
        
        HttpURLConnection conn = null;
        BufferedReader br = null;
        
        try {
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "KakaoAK " + KAKAO_API_KEY);
            
            if (conn.getResponseCode() != 200) {
                throw new Exception("Failed to get response from Kakao API: " + conn.getResponseCode());
            }
            
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder result = new StringBuilder();
            String line;
            
            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            
            JSONParser parser = new JSONParser();
            JSONObject jsonObj = (JSONObject) parser.parse(result.toString());
            JSONArray documents = (JSONArray) jsonObj.get("documents");
            
            if (!documents.isEmpty()) {
                JSONObject firstResult = (JSONObject) documents.get(0);
                JSONObject location = new JSONObject();
                
                // 위도와 경도를 소수점 6자리로 제한
                double latitude = Double.parseDouble(firstResult.get("y").toString());
                double longitude = Double.parseDouble(firstResult.get("x").toString());
                
                location.put("latitude", round(latitude, 6));
                location.put("longitude", round(longitude, 6));
                return location;
            }
            
            return null;
            
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    // 소수점 n자리로 반올림하는 메소드
    private double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();
        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }
}
