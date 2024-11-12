package kr.co.truetrue.crawler;

import kr.co.truetrue.kakao.GeoCodingService;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.time.Duration;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class MapCrawlerService {

    private WebDriver driver;
    private GeoCodingService geoCodingService;

    // 생성자에서 크롬 드라이버 및 GeoCodingService 초기화
    public MapCrawlerService() {
        String os = System.getProperty("os.name").toLowerCase();
        String driverPath = "";

        if (os.contains("win")) {
            driverPath = "C:\\Users\\user\\git\\model1_project\\src\\main\\webapp\\truetrue\\common\\chromedriver\\win64_130.0.6723.116\\chromedriver.exe";  // Windows
        } else if (os.contains("mac")) {
            driverPath = "/Users/anjeonghyeon/git/model1_project/src/main/webapp/truetrue/common/chromedriver/mac_130.0.6723.116/chromedriver";  // MacOS
        } else {
            System.out.println("지원되지 않는 운영체제입니다.");
            return;
        }

        // 크롬 드라이버 설정
        System.setProperty("webdriver.chrome.driver", driverPath);
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");  // 브라우저 창 숨기기
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        this.driver = new ChromeDriver(options);
        this.geoCodingService = new GeoCodingService();  // GeoCodingService 초기화
    }

    // 크롤링 및 중복 확인을 포함한 매장 데이터 수집 메서드
    public JSONArray crawlStores(String keyword) {
        JSONArray storeList = new JSONArray();  // 최종 매장 리스트를 담을 배열
        String url = "https://map.kakao.com/";

        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
        driver.get(url);

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

            int page = 1;
            int pageIndex = 0;

            // 페이지 순회하며 크롤링
            while (true) {
                pageIndex++;
                System.out.println("페이지: " + page);

                // 페이지 번호 클릭
                driver.findElement(By.xpath("//*[@id='info.search.page.no" + pageIndex + "']")).sendKeys(Keys.ENTER);
                TimeUnit.SECONDS.sleep(1);

                // 매장 리스트 크롤링
                List<WebElement> storeElements = driver.findElements(By.cssSelector(".placelist > .PlaceItem"));
                for (WebElement storeElement : storeElements) {
                    WebElement nameElement = storeElement.findElement(By.cssSelector(".head_item > .tit_name > .link_name"));
                    WebElement addressElement = storeElement.findElement(By.cssSelector(".info_item > .addr > p"));
                    WebElement phoneElement = storeElement.findElement(By.cssSelector(".info_item > .contact > .phone"));

                    String name = nameElement.getText();
                    String address = addressElement.getText();
                    String phone = phoneElement.getText();

                    System.out.println("매장명: " + name);
                    System.out.println("주소: " + address);
                    System.out.println("연락처: " + phone);

                    // 주소로 위도와 경도 정보를 받아옴
                    JSONObject location = geoCodingService.getGeoLocation(address);

                    // 중복 여부 확인을 위한 DAO 호출
                    CrawlerDAO cDAO = new CrawlerDAO();
                    CrawlerVO existingStore = cDAO.selectDetailStore(address);
                    String flag = (existingStore == null) ? "true" : "false";  // 중복 데이터 여부 확인

                    System.out.println("중복 여부 (flag): " + flag);

                    // 매장 정보 저장
                    JSONObject storeInfo = new JSONObject();
                    storeInfo.put("flag", flag);
                    storeInfo.put("name", name);
                    storeInfo.put("address", address);
                    storeInfo.put("phone", phone);
                    storeInfo.put("latitude", location != null ? location.get("latitude") : "0.000000");
                    storeInfo.put("longitude", location != null ? location.get("longitude") : "0.000000");

                    storeList.add(storeInfo);  // 매장 정보를 리스트에 추가
                }

                // 더 이상 페이지가 없을 경우 반복 종료
                if (storeElements.size() < 15) break;
                if (!driver.findElement(By.xpath("//*[@id='info.search.page.next']")).isEnabled()) break;

                // 5페이지씩 묶어 넘어가기
                if (pageIndex % 5 == 0) {
                    driver.findElement(By.xpath("//*[@id='info.search.page.next']")).sendKeys(Keys.ENTER);
                    pageIndex = 0;
                }

                page++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();  // 크롤링 완료 후 드라이버 종료
        }

        return storeList;  // 수집된 매장 리스트 반환
    }
}
