package com.cfxyz.cf.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.cfxyz.cf.dao.IDeptDAO;
import com.cfxyz.cf.dao.util.AbstractDAOImpl;
import com.cfxyz.cf.vo.Dept;

public class DeptDAOImpl extends AbstractDAOImpl implements IDeptDAO {
	private PreparedStatement pstmt ;

	/**
	 * 如果想要使用数据层进行原子性的功能操作实现，必须要提供有Connection接口对象
	 * 另外，由于开发之中业务层要调用数据层，所以数据层的打开与关闭交由业务层处理
	 * @param conn 表示数据库的连接对象
	 */
	public DeptDAOImpl(Connection conn) {
		super(conn);
	}

	@Override
	public boolean doCreate(Dept vo) throws Exception {
		String sql = "INSERT INTO dept(deptno,dname,loc) VALUES(?,?,?)" ;
		this.pstmt = this.conn.prepareStatement(sql) ;
		this.pstmt.setInt(1, vo.getDeptno());
		this.pstmt.setString(2, vo.getDname());
		this.pstmt.setString(3, vo.getLoc());
		return this.pstmt.executeUpdate() > 0;
	}

	@Override
	public boolean doUpdate(Dept vo) throws Exception {
		String sql = "UPDATE dept SET dname=?,loc=? WHERE deptno =?" ;
		this.pstmt = this.conn.prepareStatement(sql) ;
		this.pstmt.setString(1, vo.getDname());
		this.pstmt.setString(2, vo.getLoc());
		this.pstmt.setInt(3, vo.getDeptno());
		return this.pstmt.executeUpdate() > 0;
	}

	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws Exception {
		return super.removeHandle(ids, "dept", "deptno");
	}
	
	@Override
	public Dept findById(Integer id) throws Exception {
		Dept vo = null;
		String sql = "SELECT deptno,dname,loc FROM dept WHERE deptno = ?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, id);
		ResultSet rs = this.pstmt.executeQuery();
		if(rs.next()) {
			vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
		}
		return vo;
	}

	@Override
	public List<Dept> findAll() throws Exception {
		List<Dept> all = new ArrayList<Dept>();
		String sql = "SELECT deptno,dname,loc FROM dept";
		this.pstmt = this.conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			Dept vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
			all.add(vo);
		}
		return all;
	}

	@Override
	public List<Dept> findAllSplit(Integer currentPage, Integer lineSize, String column, String keyWord)
			throws Exception {
		throw new Exception("此方法未实现！");
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws Exception {
		throw new Exception("此方法未实现！");
	}

}
