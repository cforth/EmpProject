package com.cfxyz.cf.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cfxyz.cf.factory.ServiceFactory;
import com.cfxyz.cf.util.MD5Code;
import com.cfxyz.cf.vo.Admin;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//首先定义一个公共的表示错误路径的页面，一般设置为errors.jsp
		String path = "/pages/errors.jsp";
		String msg = null ;
		String url = null ; //表示的forward.jsp提示信息后的跳转路径
		//Servlet的主要功能是可以接收用户的请求数据
		String code = request.getParameter("code");
		//如果要取得session对象依靠request.getSession()完成
		String rand = (String) request.getSession().getAttribute("rand");
		//需要进行验证，因为Servlet可以直接通过路径访问,所以必须对数据验证
		if(code != null && rand != null) { //通过login.jsp访问的LoginServlet
			if(rand.equalsIgnoreCase(code)) { //验证码通过
				Admin vo = new Admin();
				vo.setAid(request.getParameter("aid"));
				vo.setPassword(new MD5Code().getMD5ofStr(request.getParameter("password")));
				try {
					if(ServiceFactory.getIAdminServiceInstance().login(vo)) {
						request.getSession().setAttribute("aid", vo.getAid()); //保存session属性
						msg = "登陆成功，欢迎您的光临";
						url = "/pages/back/index.jsp";
					} else {
						msg = "登陆失败，错误的用户名或密码";
						url = "/pages/back/login.jsp";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				msg = "验证码输入错误，请重新输入！" ;
			}
			path = "/pages/forward.jsp";
		}
		//必须将msg与url的属性保存过去
		request.setAttribute("msg",msg);
		request.setAttribute("url",url);
		//不管中间如何操作，最终的结果如果要想显示出来必须跳转到JSP页面上
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
}
