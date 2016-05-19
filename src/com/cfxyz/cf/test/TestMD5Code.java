package com.cfxyz.cf.test;

import com.cfxyz.cf.util.MD5Code;

public class TestMD5Code {
	public static void main(String[] args) {
		String str = "java";
		String sec = new MD5Code().getMD5ofStr(str); //加密
		System.out.println(sec);
		System.out.println(sec.length());
	}
}
