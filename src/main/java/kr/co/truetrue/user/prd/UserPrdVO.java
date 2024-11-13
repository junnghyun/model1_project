package kr.co.truetrue.user.prd;

import java.sql.Date;
import java.util.List;

import kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO;

public class UserPrdVO {
	private int product_id;
	private int total_weight;
	private int calories;
	private int sugar;
	private int protein;
	private int saturated_fat;
	private int	sodium;
	private int price;
	private char category_id;
	private char delete_flag;
	private String product_name;
	private String product_type;
	private String product_img;
	private String detail;
	private Date input_date;
	
	private List<AllergyIngredientVO> allergyIngredients; 
	
	
	
	public UserPrdVO() {
	}


	public UserPrdVO(int product_id, int total_weight, int calories, int sugar, int protein, int saturated_fat,
			int sodium, int price,  char category_id, char delete_flag, String product_name,
			String product_type, String product_img, String detail, Date input_date,
			List<AllergyIngredientVO> allergyIngredients) {
		this.product_id = product_id;
		this.total_weight = total_weight;
		this.calories = calories;
		this.sugar = sugar;
		this.protein = protein;
		this.saturated_fat = saturated_fat;
		this.sodium = sodium;
		this.price = price;
		this.category_id = category_id;
		this.delete_flag = delete_flag;
		this.product_name = product_name;
		this.product_type = product_type;
		this.product_img = product_img;
		this.detail = detail;
		this.input_date = input_date;
		this.allergyIngredients = allergyIngredients;
	}
	
	
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getTotal_weight() {
		return total_weight;
	}
	public void setTotal_weight(int total_weight) {
		this.total_weight = total_weight;
	}
	public int getCalories() {
		return calories;
	}
	public void setCalories(int calories) {
		this.calories = calories;
	}
	public int getSugar() {
		return sugar;
	}
	public void setSugar(int sugar) {
		this.sugar = sugar;
	}
	public int getProtein() {
		return protein;
	}
	public void setProtein(int protein) {
		this.protein = protein;
	}
	public int getSaturated_fat() {
		return saturated_fat;
	}
	public void setSaturated_fat(int saturated_fat) {
		this.saturated_fat = saturated_fat;
	}
	public int getSodium() {
		return sodium;
	}
	public void setSodium(int sodium) {
		this.sodium = sodium;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public char getCategory_id() {
		return category_id;
	}
	public void setCategory_id(char category_id) {
		this.category_id = category_id;
	}
	public char getDelete_flag() {
		return delete_flag;
	}
	public void setDelete_flag(char delete_flag) {
		this.delete_flag = delete_flag;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_type() {
		return product_type;
	}
	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public Date getInput_date() {
		return input_date;
	}
	public void setInput_date(Date input_date) {
		this.input_date = input_date;
	}
	
	
	public List<AllergyIngredientVO> getAllergyIngredients() {
		return allergyIngredients;
	}
	public void setAllergyIngredients(List<AllergyIngredientVO> allergyIngredients) {
		this.allergyIngredients = allergyIngredients;
	}


	@Override
	public String toString() {
		return "UserPrdVO [product_id=" + product_id + ", total_weight=" + total_weight + ", calories=" + calories
				+ ", sugar=" + sugar + ", protein=" + protein + ", saturated_fat=" + saturated_fat + ", sodium="
				+ sodium + ", price=" + price + ", category_id=" + category_id + ", delete_flag=" + delete_flag
				+ ", product_name=" + product_name + ", product_type=" + product_type + ", product_img="
				+ product_img + ", detail=" + detail + ", input_date=" + input_date + ", allergyIngredients="
				+ allergyIngredients + "]";
	}
	

}
