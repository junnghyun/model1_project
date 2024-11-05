package kr.co.truetrue.user.store;

public class StoreUtil {
    private static String[] columnName = {"storeName", "location", "category"};

    public static String numToField(String fieldNum) {
        return columnName[Integer.parseInt(fieldNum)];
    }

    public String pagination(StoreSearchVO sVO) {
        StringBuilder pagination = new StringBuilder();

        if (sVO.getTotalCount() > 0) { // 데이터가 존재할 경우
            int pageNumber = 5; // 한 화면에 보여줄 페이지 수
            int startPage = ((sVO.getCurrentStorePage() - 1) / pageNumber) * pageNumber + 1;
            int endPage = startPage + pageNumber - 1;

            if (sVO.getTotalPage() < endPage) {
                endPage = sVO.getTotalPage();
            }

            // 이전 페이지 버튼
            if (sVO.getCurrentStorePage() > 1) {
                pagination.append("<button onclick=\"location.href='")
                        .append(sVO.getUrl()).append("?currentPage=1'\">&lt;&lt;</button>"); // 첫 페이지
                pagination.append("<button onclick=\"location.href='")
                        .append(sVO.getUrl()).append("?currentPage=")
                        .append(sVO.getCurrentStorePage() - 1).append("'\">&lt;</button>"); // 이전 페이지
            }

            // 페이지 번호 링크
            for (int movePage = startPage; movePage <= endPage; movePage++) {
                if (movePage == sVO.getCurrentStorePage()) {
                    pagination.append("<button style=\"font-weight: bold;\">")
                            .append(movePage).append("</button>"); // 현재 페이지
                } else {
                    pagination.append("<button onclick=\"location.href='")
                            .append(sVO.getUrl()).append("?currentPage=")
                            .append(movePage).append("'\">")
                            .append(movePage).append("</button>"); // 페이지 링크
                }
            }

            // 다음 페이지 버튼
            if (sVO.getCurrentStorePage() < sVO.getTotalPage()) {
                pagination.append("<button onclick=\"location.href='")
                        .append(sVO.getUrl()).append("?currentPage=")
                        .append(sVO.getCurrentStorePage() + 1).append("'\">&gt;</button>"); // 다음 페이지
                pagination.append("<button onclick=\"location.href='")
                        .append(sVO.getUrl()).append("?currentPage=")
                        .append(sVO.getTotalPage()).append("'\">&gt;&gt;</button>"); // 마지막 페이지
            }
        }

        return pagination.toString();
    }
}
