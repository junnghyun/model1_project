package kr.co.truetrue.user.cart;

public class ProductVO {
	   private int product_id;
	   private String category_id,product_img,delete_flag,input_date,detail,
	   	product_type,product_name;
	   private int total_weight,calories,sugar,protein,saturated_fat,sodium
	   	,price,recom_product;

	   public ProductVO() {
	   }

	   public int getProduct_id() {
	       return product_id;
	   }

	   public void setProduct_id(int product_id) {
	       this.product_id = product_id;
	   }

	   public String getCategory_id() {
	       return category_id;
	   }

	   public void setCategory_id(String category_id) {
	       this.category_id = category_id;
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

	   public String getDetail() {
	       return detail;
	   }

	   public void setDetail(String detail) {
	       this.detail = detail;
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

	   public String getInput_date() {
	       return input_date;
	   }

	   public void setInput_date(String input_date) {
	       this.input_date = input_date;
	   }

	   public int getPrice() {
	       return price;
	   }

	   public void setPrice(int price) {
	       this.price = price;
	   }

	   public String getDelete_flag() {
	       return delete_flag;
	   }

	   public void setDelete_flag(String delete_flag) {
	       this.delete_flag = delete_flag;
	   }

	   public int getRecom_product() {
	       return recom_product;
	   }

	   public void setRecom_product(int recom_product) {
	       this.recom_product = recom_product;
	   }
	   
	   public String getProduct_img() {
	       return product_img;
	   }

	   public void setProduct_img(String product_img) {
	       this.product_img = product_img;
	   }
	}
