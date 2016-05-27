package com.cfxyz.cf.servlet;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cfxyz.cf.factory.ServiceFactory;
import com.cfxyz.cf.vo.Dept;

@SuppressWarnings("serial")
public class DeptServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path = "pages/errors.jsp";
		String status = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/") + 1) ;
		if (status != null) { //表示现在有了status操作
			if("insert".equals(status)) { //执行insert操作
				path = this.insert(request);
			} else if ("list".equals(status)) {
				path = this.list(request);
			} else if ("updatePre".equals(status)) {
				path = this.updatePre(request);
			} else if ("update".equals(status)) {
				path = this.update(request);
			} else if ("delete".equals(status)) {
				path = this.delete(request);
			} else if ("listDetails".equals(status)) {
				path = this.listDetails(request);
			}
			
		}
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
	
	public String insert(HttpServletRequest request) {
		Dept vo = new Dept() ;
		vo.setDeptno(Integer.parseInt(request.getParameter("deptno"))) ;
		vo.setDname(request.getParameter("dname")) ;
		vo.setLoc(request.getParameter("loc")) ;
		String msg = "部门信息增加失败！";
		try {
			if(ServiceFactory.getIDeptServiceInstance().insert(vo)) {
				msg = "部门信息增加成功！";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg); //forward.jsp要进行信息提示
		request.setAttribute("url", "/pages/back/admin/dept/dept_insert.jsp");
		return "/pages/forward.jsp";
	}
	
	public String list(HttpServletRequest request) {
		try {
			request.setAttribute("allDepts", ServiceFactory
					.getIDeptServiceInstance().list());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/dept/dept_list.jsp";
	}
	
	public String listDetails(HttpServletRequest request) {
		try {
			request.setAttribute("allDepts", ServiceFactory
					.getIDeptServiceInstance().listDetails());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/dept/dept_list_details.jsp";
	}
	
	public String updatePre(HttpServletRequest request) {
		int deptno = Integer.parseInt(request.getParameter("deptno")) ;
		try {
			request.setAttribute("dept", ServiceFactory
					.getIDeptServiceInstance().updatePre(deptno)) ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/dept/dept_update.jsp";
	}
	
	public String update(HttpServletRequest request) {
		Dept vo = new Dept() ;
		vo.setDeptno(Integer.parseInt(request.getParameter("deptno"))) ;
		vo.setDname(request.getParameter("dname")) ;
		vo.setLoc(request.getParameter("loc")) ;
		String msg = "部门信息修改失败！";
		try {
			if(ServiceFactory.getIDeptServiceInstance().update(vo)) {
				msg = "部门信息修改成功！";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg); //forward.jsp要进行信息提示
		request.setAttribute("url", "/pages/back/admin/dept/DeptServlet/list");
		return "/pages/forward.jsp";
	}
	
	public String delete(HttpServletRequest request) {
		String dno = request.getParameter("dno"); //数据之间使用'|'分割
		String msg = "部门信息删除失败！";
		if(!(dno == null || "".equals(dno))) { //dno确定有数据
			String result[] = dno.split("\\|");
			Set<Integer> ids = new HashSet<Integer>();
			for(int x = 0; x < result.length; x++) {
				ids.add(Integer.parseInt(result[x]));
			}
			Map<String, Object> map;
			try {
				map = ServiceFactory.getIDeptServiceInstance().delete(ids);
				boolean flag = (boolean) map.get("flag");
				if(flag) {
					msg = "部门信息删除成功！";
					//部门信息删除之后一定要删除对应的雇员照片
					Set<String> photos = (Set<String>) map.get("allPhotos");
					Iterator<String> iter = photos.iterator();
					while(iter.hasNext()) {
						String photo = iter.next();
						if(!"nophoto.jpg".equals(photo)) { //不是nophoto，可以删除
							String filePath = getServletContext().getRealPath("/upload/") + photo ;
							File file = new File(filePath);
							if(file.exists()) {
								file.delete();
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("msg", msg); //forward.jsp要进行信息提示
		request.setAttribute("url", "/pages/back/admin/dept/DeptServlet/list");
		return "/pages/forward.jsp";
	}
}
