package kr.co.truetrue.dao;

import java.sql.Date;

public class userVO {
	
	private String user_id,name,birth,address,address_detail,phone,email,zip_code,pass,withdrawn_flag;
	private int alluser ;
//	private char withdrawn_flag;
	private Date join_date;
public userVO() {
	super();
}
public userVO(String user_id, String name, String birth, String address, String address_detail, String phone,
		String email, String zip_code, String pass, String withdrawn_flag, int alluser, Date join_date) {
	super();
	this.user_id = user_id;
	this.name = name;
	this.birth = birth;
	this.address = address;
	this.address_detail = address_detail;
	this.phone = phone;
	this.email = email;
	this.zip_code = zip_code;
	this.pass = pass;
	this.withdrawn_flag = withdrawn_flag;
	this.alluser = alluser;
	this.join_date = join_date;
}
public String getUser_id() {
	return user_id;
}
public void setUser_id(String user_id) {
	this.user_id = user_id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getBirth() {
	return birth;
}
public void setBirth(String birth) {
	this.birth = birth;
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
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getZip_code() {
	return zip_code;
}
public void setZip_code(String zip_code) {
	this.zip_code = zip_code;
}
public String getPass() {
	return pass;
}
public void setPass(String pass) {
	this.pass = pass;
}
public String getWithdrawn_flag() {
	return withdrawn_flag;
}
public void setWithdrawn_flag(String withdrawn_flag) {
	this.withdrawn_flag = withdrawn_flag;
}
public int getAlluser() {
	return alluser;
}
public void setAlluser(int alluser) {
	this.alluser = alluser;
}
public Date getJoin_date() {
	return join_date;
}
public void setJoin_date(Date join_date) {
	this.join_date = join_date;
}
@Override
public String toString() {
	return "userVO [user_id=" + user_id + ", name=" + name + ", birth=" + birth + ", address=" + address
			+ ", address_detail=" + address_detail + ", phone=" + phone + ", email=" + email + ", zip_code=" + zip_code
			+ ", pass=" + pass + ", withdrawn_flag=" + withdrawn_flag + ", alluser=" + alluser + ", join_date="
			+ join_date + "]";
}
	
	
	
	
}
