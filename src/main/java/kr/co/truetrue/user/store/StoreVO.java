package kr.co.truetrue.user.store;

import java.sql.Date;

public class StoreVO {
	int store_id;
	String store_address, store_name, store_phone;
	char store_status;
	double lat, lng;
	Date date;
	
	public StoreVO() {
		super();
	}

	public StoreVO(int store_id, String store_address, String store_name, String store_phone, char store_status,
			double lat, double lng, Date date) {
		super();
		this.store_id = store_id;
		this.store_address = store_address;
		this.store_name = store_name;
		this.store_phone = store_phone;
		this.store_status = store_status;
		this.lat = lat;
		this.lng = lng;
		this.date = date;
	}

	public int getStore_id() {
		return store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public String getStore_address() {
		return store_address;
	}

	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_phone() {
		return store_phone;
	}

	public void setStore_phone(String store_phone) {
		this.store_phone = store_phone;
	}

	public char getStore_status() {
		return store_status;
	}

	public void setStore_status(char store_status) {
		this.store_status = store_status;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "StoreVO [store_id=" + store_id + ", store_address=" + store_address + ", store_name=" + store_name
				+ ", store_phone=" + store_phone + ", store_status=" + store_status + ", lat=" + lat + ", lng=" + lng
				+ ", date=" + date + "]";
	}

	
	
	
}
