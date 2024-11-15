package kr.co.truetrue.user.card;

public class CardVO {
	private int card_id,order_id,month,installment_type;
    private String card_num1,card_num2,card_num3,card_num4,year,card_type;
    
	public CardVO() {
		super();
	}
	public int getCard_id() {
		return card_id;
	}
	public void setCard_id(int card_id) {
		this.card_id = card_id;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getInstallment_type() {
		return installment_type;
	}
	public void setInstallment_type(int installment_type) {
		this.installment_type = installment_type;
	}
	public String getCard_num1() {
		return card_num1;
	}
	public void setCard_num1(String card_num1) {
		this.card_num1 = card_num1;
	}
	public String getCard_num2() {
		return card_num2;
	}
	public void setCard_num2(String card_num2) {
		this.card_num2 = card_num2;
	}
	public String getCard_num3() {
		return card_num3;
	}
	public void setCard_num3(String card_num3) {
		this.card_num3 = card_num3;
	}
	public String getCard_num4() {
		return card_num4;
	}
	public void setCard_num4(String card_num4) {
		this.card_num4 = card_num4;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getCard_type() {
		return card_type;
	}
	public void setCard_type(String card_type) {
		this.card_type = card_type;
	}
    
}
