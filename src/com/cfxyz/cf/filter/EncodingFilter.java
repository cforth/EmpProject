package com.cfxyz.cf.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class EncodingFilter implements Filter {
	private String charset = "UTF-8";
	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, 
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(this.charset);
		response.setCharacterEncoding(this.charset);
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		if(filterConfig.getInitParameter("charset") != null) {
			this.charset = filterConfig.getInitParameter("charset");
		}
	}

}
