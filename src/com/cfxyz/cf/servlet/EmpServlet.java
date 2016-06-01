package com.cfxyz.cf.servlet;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cfxyz.cf.factory.ServiceFactory;
import com.cfxyz.cf.util.BasePath;
import com.cfxyz.cf.vo.Dept;
import com.cfxyz.cf.vo.Emp;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

@SuppressWarnings("serial")
public class EmpServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path = "pages/errors.jsp";
		String status = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/") + 1) ;
		if (status != null) { //表示现在有了status操作
			if("insertPre".equals(status)) {
				path = this.insertPre(request);
			} else if("insert".equals(status)) {
				path = this.insert(request,response);
			} else if ("list".equals(status)) {
				path = this.list(request);
			} else if ("listSplit".equals(status)) {
				path = this.listSplit(request);
			} else if ("listDetails".equals(status)) {
				path = this.listDetails(request);
			} else if ("updatePre".equals(status)) {
				path = this.updatePre(request);
			} else if ("update".equals(status)) {
				path = this.update(request,response);
			} else if ("delete".equals(status)) {
				path = this.delete(request);
			} else if ("show".equals(status)) {
				path = this.show(request);
			}
			
		}
		request.getRequestDispatcher(path).forward(request, response);
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
	
	public String insertPre(HttpServletRequest request) throws ServletException, IOException{
		try {
			Map<String, Object> map = ServiceFactory.getIEmpServiceInstance().insertPre();
			request.setAttribute("allEmps", map.get("allEmps"));
			request.setAttribute("allDepts", map.get("allDepts"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/emp/emp_insert.jsp" ;
	}
	
	public String insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		SmartUpload smart = new SmartUpload();
		smart.initialize(super.getServletConfig(), request, response);
		try {
			smart.upload();
		} catch (SmartUploadException e1) {
			e1.printStackTrace();
		}
		Emp vo = new Emp() ;
		vo.setEmpno(Integer.parseInt(smart.getRequest().getParameter("empno"))) ;
		vo.setEname(smart.getRequest().getParameter("ename")) ;
		vo.setJob(smart.getRequest().getParameter("job")) ;
		try {
			vo.setHiredate(new SimpleDateFormat("yyyy-MM-dd").parse(smart.getRequest().getParameter("hiredate"))) ;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		vo.setSal(Double.parseDouble(smart.getRequest().getParameter("sal"))) ;
		vo.setComm(Double.parseDouble(smart.getRequest().getParameter("comm"))) ;
		int tempMgr = Integer.parseInt(smart.getRequest().getParameter("mgr")) ;
		if(tempMgr != 0) { //表示现在有领导
			Emp mgr = new Emp();
			mgr.setEmpno(tempMgr); //保存领导编号
			vo.setMgr(mgr);
		}
		int tempDept = Integer.parseInt(smart.getRequest().getParameter("deptno")) ;
		if(tempDept != 0) { //表示现在有部门
			Dept dept = new Dept(); //保存部门编号
			dept.setDeptno(tempDept);
			vo.setDept(dept);
		}
		String fileName = "nophoto.jsp"; //上传的图片名称
		if(smart.getFiles().getFile(0).getSize() > 0) {
			if(smart.getFiles().getFile(0).getContentType()
				.contains("image")) { //判断文件类型
				fileName = java.util.UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
			}
		}
		vo.setPhoto(fileName);
		vo.setNote(smart.getRequest().getParameter("note"));
		String msg = "雇员信息增加失败！";
		try {
			if(ServiceFactory.getIEmpServiceInstance().insert(vo)) {
				if(smart.getFiles().getFile(0).getSize() > 0) {
					if(smart.getFiles().getFile(0).getContentType()
						.contains("image")) { //判断文件类型
						String filePath = getServletContext().getRealPath("/upload/") + fileName;
						smart.getFiles().getFile(0).saveAs(filePath);
					}
				}
				msg = "雇员信息增加成功！";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", "/pages/back/admin/emp/EmpServlet/insertPre");
		return "/pages/forward.jsp" ;
	}
	
	public String list(HttpServletRequest request) throws ServletException, IOException{
		try {
			request.setAttribute("allEmps", ServiceFactory.getIEmpServiceInstance().list());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/emp/emp_list.jsp" ;
	}
	
	public String listSplit(HttpServletRequest request) throws ServletException, IOException{
		String url = "/pages/back/admin/emp/EmpServlet/listSplit" ;
		int currentPage = 1 ;
	    String keyWord = "" ; //默认的关键字
	    int lineSize = 5 ;
	    String column = "ename"; //默认查询列
	    String columnData = "雇员编号:empno|雇员姓名:ename|雇员职位:job" ;
	    try {
	        //如果没有输入参数那么就会是null，null无法变为数字
	        currentPage = Integer.parseInt(request.getParameter("cp"));
	    } catch (Exception e) {}
	    try {
	        //如果没有输入参数那么就会是null，null无法变为数字
	        lineSize = Integer.parseInt(request.getParameter("ls"));
	    } catch (Exception e) {}
	    if(request.getParameter("col") != null) { //表示有查询列
	        column = request.getParameter("col") ;
	    }
	    if(request.getParameter("kw") != null) { //表示有查询关键字
	        keyWord = request.getParameter("kw") ;
	    }
	    try {
			Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().list(column, keyWord, currentPage, lineSize);
			request.setAttribute("allEmps", map.get("allEmps"));
			request.setAttribute("allRecorders", map.get("empCount"));
	    } catch (Exception e) {
			e.printStackTrace();
		}
	    request.setAttribute("columnData", columnData);
	    request.setAttribute("keyWord", keyWord);
	    request.setAttribute("column", column);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("lineSize", lineSize);
	    request.setAttribute("url", url);
		return "/pages/back/admin/emp/emp_list_split.jsp" ;
	}
	
	public String listDetails(HttpServletRequest request) throws ServletException, IOException{
		String url = "/pages/back/admin/emp/EmpServlet/listDetails" ;
		int currentPage = 1 ;
	    String keyWord = "" ; //默认的关键字
	    int lineSize = 5 ;
	    String column = "ename"; //默认查询列
	    String columnData = "雇员编号:empno|雇员姓名:ename|雇员职位:job" ;
	    try {
	        //如果没有输入参数那么就会是null，null无法变为数字
	        currentPage = Integer.parseInt(request.getParameter("cp"));
	    } catch (Exception e) {}
	    try {
	        //如果没有输入参数那么就会是null，null无法变为数字
	        lineSize = Integer.parseInt(request.getParameter("ls"));
	    } catch (Exception e) {}
	    if(request.getParameter("col") != null) { //表示有查询列
	        column = request.getParameter("col") ;
	    }
	    if(request.getParameter("kw") != null) { //表示有查询关键字
	        keyWord = request.getParameter("kw") ;
	    }
	    try {
			Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().listDetails(column, keyWord, currentPage, lineSize);
			request.setAttribute("allEmps", map.get("allEmps"));
			request.setAttribute("allRecorders", map.get("empCount"));
	    } catch (Exception e) {
			e.printStackTrace();
		}
	    request.setAttribute("columnData", columnData);
	    request.setAttribute("keyWord", keyWord);
	    request.setAttribute("column", column);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("lineSize", lineSize);
	    request.setAttribute("url", url);
		return "/pages/back/admin/emp/emp_list_details.jsp" ;
	}
	
	public String updatePre(HttpServletRequest request) throws ServletException, IOException{
		int empno = Integer.parseInt(request.getParameter("empno")) ;
		try {
			Map<String,Object> map = ServiceFactory.getIEmpServiceInstance().updatePre(empno) ;
			request.setAttribute("emp", map.get("emp"));
			request.setAttribute("allEmps", map.get("allEmps"));
			request.setAttribute("allDepts", map.get("allDepts"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/emp/emp_update.jsp" ;
	}
	
	public String update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		SmartUpload smart = new SmartUpload();
		smart.initialize(super.getServletConfig(), request, response);
		try {
			smart.upload();
		} catch (SmartUploadException e) {
			e.printStackTrace();
		}
		Emp vo = new Emp() ;
		vo.setEmpno(Integer.parseInt(smart.getRequest().getParameter("empno"))) ;
		vo.setEname(smart.getRequest().getParameter("ename")) ;
		vo.setJob(smart.getRequest().getParameter("job")) ;
		try {
			vo.setHiredate(new SimpleDateFormat("yyyy-MM-dd").parse(smart.getRequest().getParameter("hiredate"))) ;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		vo.setSal(Double.parseDouble(smart.getRequest().getParameter("sal"))) ;
		vo.setComm(Double.parseDouble(smart.getRequest().getParameter("comm"))) ;
		int tempMgr = Integer.parseInt(smart.getRequest().getParameter("mgr")) ;
		if(tempMgr != 0) { //表示现在有领导
			Emp mgr = new Emp();
			mgr.setEmpno(tempMgr); //保存领导编号
			vo.setMgr(mgr);
		}
		int tempDept = Integer.parseInt(smart.getRequest().getParameter("deptno")) ;
		if(tempDept != 0) { //表示现在有部门
			Dept dept = new Dept(); //保存部门编号
			dept.setDeptno(tempDept);
			vo.setDept(dept);
		}
		vo.setNote(smart.getRequest().getParameter("note"));
		String fileName = smart.getRequest().getParameter("oldpic");
		if(smart.getFiles().getSize() > 0) { //有文件上传
			if(smart.getFiles().getFile(0).getContentType().contains("image")) {
				fileName = java.util.UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
			}
		}
		vo.setPhoto(fileName) ;
		String msg = "雇员信息修改失败！";
		try {
			if(ServiceFactory.getIEmpServiceInstance().update(vo)) {
				if(smart.getFiles().getFile(0).getSize() > 0) {
					if(smart.getFiles().getFile(0).getContentType()
						.contains("image")) { //判断文件类型
						if(!"nophoto.jpg".equals(fileName)) {
							String filePath = getServletContext().getRealPath("/upload/") + fileName;
							smart.getFiles().getFile(0).saveAs(filePath);
						}
					}
				}
				msg = "雇员信息修改成功！";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		StringBuffer buf = new StringBuffer() ;
		buf.append(smart.getRequest().getParameter("backurl")).append("?") ;
		buf.append("cp=").append(smart.getRequest().getParameter("cp")) ;
		buf.append("&ls=").append(smart.getRequest().getParameter("ls")) ;
		buf.append("&col=").append(smart.getRequest().getParameter("col")) ;
		buf.append("&kw=").append(smart.getRequest().getParameter("kw")) ;
		buf.append("&deptno=").append(smart.getRequest().getParameter("deptno")) ;
		request.setAttribute("msg", msg);
		request.setAttribute("url", buf.toString());
		return "/pages/forward.jsp" ;
	}
	
	public String delete(HttpServletRequest request) throws ServletException, IOException{
		String eno = request.getParameter("eno"); //数据之间使用'|'分割
		String msg = "雇员信息删除失败！";
		Set<String> photos = new HashSet<String>(); //保存雇员图片
		if(!(eno == null || "".equals(eno))) { //eno确定有数据
			String result[] = eno.split("\\|");
			Set<Integer> ids = new HashSet<Integer>();
			for(int x = 0; x < result.length; x++) {
				String temp[] = result[x].split(":");
				ids.add(Integer.parseInt(temp[0]));
				if(!"nophoto.jpg".equals(temp[1])) {
					photos.add(temp[1]);
				}
			}
			try {
				if(ServiceFactory.getIEmpServiceInstance().delete(ids)) {
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
					msg = "雇员信息删除成功！";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		StringBuffer buf = new StringBuffer() ;
		buf.append(request.getParameter("backurl")).append("?") ;
		buf.append("cp=").append(request.getParameter("cp")) ;
		buf.append("&ls=").append(request.getParameter("ls")) ;
		buf.append("&col=").append(request.getParameter("col")) ;
		buf.append("&kw=").append(request.getParameter("kw")) ;
		request.setAttribute("msg", msg);
		request.setAttribute("url", buf.toString());
		return "/pages/forward.jsp" ;
	}
	
	public String show(HttpServletRequest request) throws ServletException, IOException{
		int empno = Integer.parseInt(request.getParameter("empno")) ;
		try {
			request.setAttribute("emp",ServiceFactory.getIEmpServiceInstance().show(empno)) ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pages/back/admin/emp/emp_show.jsp" ;
	}
}
