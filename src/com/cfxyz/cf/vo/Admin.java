package com.cfxyz.cf.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Admin implements Serializable {
	private String aid;
	private String password;
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
