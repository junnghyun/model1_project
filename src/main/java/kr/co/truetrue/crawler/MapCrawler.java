package kr.co.truetrue.crawler;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.FileWriter;
import java.io.IOException;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class MapCrawler {

    public static void main(String[] args) {
    	// 운영체제 확인 후 크롬 드라이버 경로 설정
        String os = System.getProperty("os.name").toLowerCase();
        String driverPath = "";

        if (os.contains("win")) {
            driverPath = /*경로 수정*/"c:/Users/user/git/model1_project/src/main/webapp/truetrue/common/chromedriver/win64_130.0.6723116/chromedriver.exe";  // Windows
        } else if (os.contains("mac")) {
            driverPath = "/Users/anjeonghyeon/git/model1_project/src/main/webapp/truetrue/common/chromedriver/mac_130.0.6723.116/chromedriver";  // MacOS
        } else {
            System.out.println("지원되지 않는 운영체제입니다.");
            return;
        }

        // 크롬 드라이버 설정
        System.setProperty("webdriver.chrome.driver", driverPath);

        // 옵션 설정 (창 숨기기)
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");  // 브라우저 창 숨기기
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        WebDriver driver = new ChromeDriver(options);
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));

        String url = "https://map.kakao.com/";
        driver.get(url);

        // 검색어 설정 (뚜레쥬르)
        String keyword = "뚜레쥬르";  
        JSONObject storeData = new JSONObject();
        JSONArray storeList = new JSONArray();

        try {
            // 검색창 대기 및 입력
        	WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            WebElement searchBox = wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.box_searchbar > input.query")));
            searchBox.sendKeys(keyword);
            searchBox.sendKeys(Keys.ENTER);
            TimeUnit.SECONDS.sleep(1);

            // 장소 탭 클릭
            WebElement placeTab = driver.findElement(By.cssSelector("#info\\.main\\.options > li.option1 > a"));
            placeTab.sendKeys(Keys.ENTER);
            TimeUnit.SECONDS.sleep(1);

            // 페이지 탐색 및 크롤링
            int page = 1;
            int page2 = 0;
            int errorCnt = 0;

            while (true) {
                page2++;
                System.out.println("페이지: " + page);

                // 페이지 번호 클릭
                driver.findElement(By.xpath("//*[@id='info.search.page.no" + page2 + "']")).sendKeys(Keys.ENTER);
                TimeUnit.SECONDS.sleep(1);

                // 매장 리스트 크롤링
                List<WebElement> storeElements = driver.findElements(By.cssSelector(".placelist > .PlaceItem"));
                for (int i = 0; i < storeElements.size(); i++) {
                    WebElement nameElement = driver.findElements(By.cssSelector(".head_item > .tit_name > .link_name")).get(i);
                    WebElement addressElement = driver.findElements(By.cssSelector(".info_item > .addr")).get(i);
                    WebElement phoneElement = driver.findElements(By.cssSelector(".info_item > .contact")).get(i);

                    String name = nameElement.getText();   // 매장명
                    String address = addressElement.findElements(By.cssSelector("p")).get(0).getText();  // 주소
                    String phone = phoneElement.getText(); // 연락처

                    System.out.println("매장명: " + name);
                    System.out.println("주소: " + address);
                    System.out.println("연락처: " + phone);

                    // 데이터 저장
                    JSONObject storeInfo = new JSONObject();
                    storeInfo.put("name", name);
                    storeInfo.put("address", address);
                    storeInfo.put("phone", phone);
                    storeList.add(storeInfo);
                }

                // 다음 페이지로 넘어가기
                if (storeElements.size() < 15) break;
                if (!driver.findElement(By.xpath("//*[@id='info.search.page.next']")).isEnabled()) break;
                if (page2 % 5 == 0) {
                    driver.findElement(By.xpath("//*[@id='info.search.page.next']")).sendKeys(Keys.ENTER);
                    page2 = 0;
                }

                page++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }

        // 수집된 데이터 저장
        storeData.put("매장정보", storeList);
        try (FileWriter file = new FileWriter("data/store_data.json")) {
            file.write(storeData.toJSONString());
            file.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("[데이터 수집 완료]");
    }
}
