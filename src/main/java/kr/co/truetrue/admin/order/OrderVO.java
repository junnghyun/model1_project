package kr.co.truetrue.admin.order;

public class OrderVO {
	private int order_id, cart_product_id, total_price,quantity;
    private String user_id, payment_date, delivery_date, 
                   zip_code, address, address_detail, 
                   delivery_status, product_info, order_id_list,
                   recipient, recipient_phone, request,
                   product_name, product_img;
    
    
    public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
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


	public int getOrder_id() {
		return order_id;
	}


	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}


	public int getCart_product_id() {
		return cart_product_id;
	}


	public void setCart_product_id(int cart_product_id) {
		this.cart_product_id = cart_product_id;
	}


	public int getTotal_price() {
		return total_price;
	}


	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getPayment_date() {
		return payment_date;
	}


	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}


	public String getDelivery_date() {
		return delivery_date;
	}


	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
	}


	public String getZip_code() {
		return zip_code;
	}


	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getAddress_detail() {
		return address_detail;
	}


	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}


	public String getDelivery_status() {
		return delivery_status;
	}


	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}


	public String getProduct_info() {
		return product_info;
	}


	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}


	public String getOrder_id_list() {
		return order_id_list;
	}


	public void setOrder_id_list(String order_id_list) {
		this.order_id_list = order_id_list;
	}


	public String getRecipient() {
		return recipient;
	}


	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}


	public String getRecipient_phone() {
		return recipient_phone;
	}


	public void setRecipient_phone(String recipient_phone) {
		this.recipient_phone = recipient_phone;
	}


	public String getRequest() {
		return request;
	}


	public void setRequest(String request) {
		this.request = request;
	}


	@Override
	public String toString() {
		return "OrderVO [order_id=" + order_id + ", cart_product_id=" + cart_product_id + ", total_price=" + total_price
				+ ", quantity=" + quantity + ", user_id=" + user_id + ", payment_date=" + payment_date
				+ ", delivery_date=" + delivery_date + ", zip_code=" + zip_code + ", address=" + address
				+ ", address_detail=" + address_detail + ", delivery_status=" + delivery_status + ", product_info="
				+ product_info + ", order_id_list=" + order_id_list + ", recipient=" + recipient + ", recipient_phone="
				+ recipient_phone + ", request=" + request + ", product_name=" + product_name + ", product_img="
				+ product_img + "]";
	}


}
