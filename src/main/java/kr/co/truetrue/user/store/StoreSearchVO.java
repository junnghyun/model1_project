package kr.co.truetrue.user.store;

public class StoreSearchVO {
	private int startNum, endNum, currentStorePage, totalPage, totalCount;
	private String field="0";
	private String keyword;
	
	public StoreSearchVO() {
		super();
	}

	public StoreSearchVO(int startNum, int endNum, int currentStorePage, int totalPage, int totalCount, String field,
			String keyword) {
		super();
		this.startNum = startNum;
		this.endNum = endNum;
		this.currentStorePage = currentStorePage;
		this.totalPage = totalPage;
		this.totalCount = totalCount;
		this.field = field;
		this.keyword = keyword;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public int getCurrentStorePage() {
		return currentStorePage;
	}

	public void setCurrentStorePage(int currentStorePage) {
		this.currentStorePage = currentStorePage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "StoreSearchVO [startNum=" + startNum + ", endNum=" + endNum + ", currentStorePage=" + currentStorePage
				+ ", totalPage=" + totalPage + ", totalCount=" + totalCount + ", field=" + field + ", keyword="
				+ keyword + "]";
	}

	
	
}
