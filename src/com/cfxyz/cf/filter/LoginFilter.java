package com.cfxyz.cf.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		//如果要想在过滤器中取得HTTPSession对象，必须强制转换
		HttpServletRequest req = (HttpServletRequest) request ;
		HttpSession ses = req.getSession() ;
		if(ses.getAttribute("aid") != null) { //属性存在了
			chain.doFilter(request, response) ; //放行
		} else {
			request.setAttribute("msg", "您还未登陆，请先登录！");
			request.setAttribute("url", "/pages/back/login.jsp");
			request.getRequestDispatcher("/pages/forward.jsp").forward(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
