package kr.co.truetrue.ad;

import java.sql.Date;

public class AdVO {

    private int ad_Id;                  	// ad_id
    private String ad_Start_Date;         // ad_start_date(시작) 광고기간
    private String ad_End_Date;           // ad_end_date(종료) 광고기간 
    private String advertiser;          // advertiser
    private String ad_Detail;            // ad_detail(광고 제목)
    private String ad_Phone;             // ad_phone
    private String ad_Img;               // ad_img
    private int ad_Price;                // ad_price
    private int clicks;                 // clicks
    private java.sql.Date input_Date;    // input_date(입력일)
    private int ad_Active;            // ad_active(몇 번째 광고인지 )
    private String delete_Flag;          // delete_flag(기본 y)
	
    public AdVO(){
    	
    	
    }
    
    public AdVO(int ad_Id, String ad_Start_Date, String ad_End_Date, String advertiser, String ad_Detail,
			String ad_Phone, String ad_Img, int ad_Price, int clicks, Date input_Date, int ad_Active,
			String delete_Flag) {
		this.ad_Id = ad_Id;
		this.ad_Start_Date = ad_Start_Date;
		this.ad_End_Date = ad_End_Date;
		this.advertiser = advertiser;
		this.ad_Detail = ad_Detail;
		this.ad_Phone = ad_Phone;
		this.ad_Img = ad_Img;
		this.ad_Price = ad_Price;
		this.clicks = clicks;
		this.input_Date = input_Date;
		this.ad_Active = ad_Active;
		this.delete_Flag = delete_Flag;
	}

	public int getAd_Id() {
		return ad_Id;
	}

	public void setAd_Id(int ad_Id) {
		this.ad_Id = ad_Id;
	}

	public String getAd_Start_Date() {
		return ad_Start_Date;
	}

	public void setAd_Start_Date(String ad_Start_Date) {
		this.ad_Start_Date = ad_Start_Date;
	}

	public String getAd_End_Date() {
		return ad_End_Date;
	}

	public void setAd_End_Date(String ad_End_Date) {
		this.ad_End_Date = ad_End_Date;
	}

	public String getAdvertiser() {
		return advertiser;
	}

	public void setAdvertiser(String advertiser) {
		this.advertiser = advertiser;
	}

	public String getAd_Detail() {
		return ad_Detail;
	}

	public void setAd_Detail(String ad_Detail) {
		this.ad_Detail = ad_Detail;
	}

	public String getAd_Phone() {
		return ad_Phone;
	}

	public void setAd_Phone(String ad_Phone) {
		this.ad_Phone = ad_Phone;
	}

	public String getAd_Img() {
		return ad_Img;
	}

	public void setAd_Img(String ad_Img) {
		this.ad_Img = ad_Img;
	}

	public int getAd_Price() {
		return ad_Price;
	}

	public void setAd_Price(int ad_Price) {
		this.ad_Price = ad_Price;
	}

	public int getClicks() {
		return clicks;
	}

	public void setClicks(int clicks) {
		this.clicks = clicks;
	}

	public java.sql.Date getInput_Date() {
		return input_Date;
	}

	public void setInput_Date(java.sql.Date input_Date) {
		this.input_Date = input_Date;
	}

	public int getAd_Active() {
		return ad_Active;
	}

	public void setAd_Active(int ad_Active) {
		this.ad_Active = ad_Active;
	}

	public String getDelete_Flag() {
		return delete_Flag;
	}

	public void setDelete_Flag(String delete_Flag) {
		this.delete_Flag = delete_Flag;
	}

	@Override
	public String toString() {
		return "AdVO [ad_Id=" + ad_Id + ", ad_Start_Date=" + ad_Start_Date + ", ad_End_Date=" + ad_End_Date
				+ ", advertiser=" + advertiser + ", ad_Detail=" + ad_Detail + ", ad_Phone=" + ad_Phone + ", ad_Img="
				+ ad_Img + ", ad_Price=" + ad_Price + ", clicks=" + clicks + ", input_Date=" + input_Date
				+ ", ad_Active=" + ad_Active + ", delete_Flag=" + delete_Flag + "]";
	}
	
    
 
   
}//class
