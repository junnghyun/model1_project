package kr.co.truetrue.user.cart;

public class CartVO {
	private int cart_product_id,price,quantity,product_id;  
	private String product_img,product_name,user_id,order_flag,
					name,phone1,phone2,phone3;
	
	public CartVO() {
		super();
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public int getCart_product_id() {
        return cart_product_id;
    }
    public void setCart_product_id(int cart_product_id) {
        this.cart_product_id = cart_product_id;
    }
    public String getUser_id() {
        return user_id;
    }
    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
    public int getProduct_id() {
        return product_id;
    }
    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }
    public String getProduct_name() {
        return product_name;
    }
    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }
    public String getProduct_img() {
        return product_img;
    }
    public void setProduct_img(String product_img) {
        this.product_img = product_img;
    }
    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getOrder_flag() {
        return order_flag;
    }
    public void setOrder_flag(String order_flag) {
        this.order_flag = order_flag;
    }
	
}
