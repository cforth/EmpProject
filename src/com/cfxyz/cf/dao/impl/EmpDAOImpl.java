package com.cfxyz.cf.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.cfxyz.cf.dao.IEmpDAO;
import com.cfxyz.cf.dao.util.AbstractDAOImpl;
import com.cfxyz.cf.vo.Dept;
import com.cfxyz.cf.vo.Emp;

public class EmpDAOImpl extends AbstractDAOImpl implements IEmpDAO {
	private PreparedStatement pstmt ;
	
	public EmpDAOImpl(Connection conn) {
		super(conn);
	}

	@Override
	public boolean doCreate(Emp vo) throws Exception {
		String sql = "INSERT INTO emp(empno,ename,job,hiredate,sal,comm,mgr,deptno,photo,note) VALUES(?,?,?,?,?,?,?,?,?,?)" ;
		this.pstmt = this.conn.prepareStatement(sql) ;
		this.pstmt.setInt(1, vo.getEmpno());
		this.pstmt.setString(2, vo.getEname());
		this.pstmt.setString(3, vo.getJob());
		this.pstmt.setDate(4, new java.sql.Date(vo.getHiredate().getTime()));
		this.pstmt.setDouble(5, vo.getSal());
		this.pstmt.setDouble(6, vo.getComm());
		if(vo.getMgr() == null) { //领导不存在
			this.pstmt.setNull(7, Types.NULL) ;
		} else {
			this.pstmt.setInt(7, vo.getMgr().getEmpno()) ;
		}
		if(vo.getDept() == null) {
			this.pstmt.setNull(8, Types.NULL) ;
		} else {
			this.pstmt.setInt(8, vo.getDept().getDeptno());
		}
		this.pstmt.setString(9, vo.getPhoto());
		this.pstmt.setString(10, vo.getNote());
		return this.pstmt.executeUpdate() > 0;
	}

	@Override
	public boolean doUpdate(Emp vo) throws Exception {
		String sql = "UPDATE emp SET ename=?,job=?,hiredate=?,sal=?,comm=?,mgr=?,deptno=?,photo=?,note=? WHERE empno=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, vo.getEname());
		this.pstmt.setString(2, vo.getJob());
		this.pstmt.setDate(3, new java.sql.Date(vo.getHiredate().getTime()));
		this.pstmt.setDouble(4, vo.getSal());
		this.pstmt.setDouble(5, vo.getComm());
		if(vo.getMgr() == null) { //领导不存在
			this.pstmt.setNull(6, Types.NULL) ;
		} else {
			this.pstmt.setInt(6, vo.getMgr().getEmpno()) ;
		}
		if(vo.getDept() == null) {
			this.pstmt.setNull(7, Types.NULL) ;
		} else {
			this.pstmt.setInt(7, vo.getDept().getDeptno());
		}
		this.pstmt.setString(8, vo.getPhoto());
		this.pstmt.setString(9, vo.getNote());
		this.pstmt.setInt(10, vo.getEmpno());
		return this.pstmt.executeUpdate() > 0;
	}

	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws Exception {
		return super.removeHandle(ids, "emp", "empno");
	}

	@Override
	public Emp findById(Integer id) throws Exception {
		Emp vo = null ;
		String sql = "SELECT empno,ename,job,hiredate,sal,comm FROM emp WHERE empno = ?" ;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, id);
		ResultSet rs = this.pstmt.executeQuery();
		if(rs.next()) {
			vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
		}
		return vo ;
	}

	@Override
	public List<Emp> findAll() throws Exception {
		List<Emp> all = new ArrayList<Emp>();
		String sql = "SELECT empno,ename,job,hiredate,sal,comm,photo,note FROM emp" ;
		this.pstmt = this.conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			Emp vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
			vo.setPhoto(rs.getString(7));
			vo.setNote(rs.getString(8));
			all.add(vo);
		}
		return all ;
	}

	@Override
	public List<Emp> findAllSplit(Integer currentPage, Integer lineSize,
			String column, String keyWord) throws Exception {
		List<Emp> all = new ArrayList<Emp>();
		String sql = "SELECT * FROM ( "
				+ " SELECT empno,ename,job,hiredate,sal,comm,photo,note,ROWNUM rn FROM emp WHERE " + column + " LIKE ? AND ROWNUM <=?) temp "
				+ " WHERE temp.rn > ?" ;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, "%" + keyWord + "%");
		this.pstmt.setInt(2, currentPage * lineSize);
		this.pstmt.setInt(3, (currentPage - 1) * lineSize);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			Emp vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
			vo.setPhoto(rs.getString(7));
			vo.setNote(rs.getString(8));
			all.add(vo);
		}
		return all ;
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws Exception {
		return super.countHandle("emp", column, keyWord);
	}

	@Override
	public void doRemoveByDeptno(Integer deptno) throws Exception {
		String sql = "DELETE FROM emp WHERE deptno = ?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, deptno);
		this.pstmt.executeUpdate() ;
	}

	@Override
	public Emp findByIdDetails(Integer id) throws Exception {
		Emp vo = null ;
		String sql = "SELECT e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, "
				+ " m.empno mno,m.ename mname,d.deptno dno,d.dname dna,e.photo,e.note "
				+ " FROM emp e, emp m, dept d "
				+ " WHERE e.empno = ? AND e.mgr=m.empno(+) AND e.deptno=d.deptno(+)" ;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, id);
		ResultSet rs = this.pstmt.executeQuery();
		if(rs.next()) {
			vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
			Emp mgr = new Emp();
			mgr.setEmpno(rs.getInt(7));
			mgr.setEname(rs.getString(8));
			vo.setMgr(mgr);
			Dept dept = new Dept();
			dept.setDeptno(rs.getInt(9));
			dept.setDname(rs.getString(10));
			vo.setDept(dept);
			vo.setPhoto(rs.getString(11));
			vo.setNote(rs.getString(12));
		}
		return vo ;
	}

	@Override
	public List<Emp> findAllSplitDetails(String column, String keyWord,
			Integer currentPage, Integer lineSize) throws Exception {
		List<Emp> all = new ArrayList<Emp>();
		String sql = "SELECT * FROM ( "
				+ " SELECT e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, "
				+ " m.empno mno,m.ename mname,d.deptno dno,d.dname dna,e.photo,e.note,ROWNUM rn "
				+ " FROM emp e,emp m, dept d "
				+ " WHERE e. " 
				+ column + " LIKE ? AND e.mgr=m.empno(+) AND e.deptno=d.deptno(+) AND ROWNUM <=?) temp "
				+ " WHERE temp.rn > ?" ;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, "%" + keyWord + "%");
		this.pstmt.setInt(2, currentPage * lineSize);
		this.pstmt.setInt(3, (currentPage - 1) * lineSize);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			Emp vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
			Emp mgr = new Emp();
			mgr.setEmpno(rs.getInt(7));
			mgr.setEname(rs.getString(8));
			vo.setMgr(mgr);
			Dept dept = new Dept();
			dept.setDeptno(rs.getInt(9));
			dept.setDname(rs.getString(10));
			vo.setDept(dept);
			vo.setPhoto(rs.getString(11));
			vo.setNote(rs.getString(12));
			all.add(vo);
		}
		return all ;
	}

	@Override
	public List<Emp> findAllByDeptno(Integer deptno, String column,
			String keyWord, Integer currentPage, Integer lineSize)
			throws Exception {
		List<Emp> all = new ArrayList<Emp>();
		String sql = "SELECT * FROM ( "
				+ " SELECT e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, "
				+ " m.empno mno,m.ename mname,d.deptno dno,d.dname dna,e.photo,e.note,ROWNUM rn "
				+ " FROM emp e,emp m, dept d "
				+ " WHERE e. " 
				+ column + " LIKE ? AND d.deptno=? AND e.mgr=m.empno(+) AND e.deptno=d.deptno(+) AND ROWNUM <=?) temp "
				+ " WHERE temp.rn > ?" ;
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, "%" + keyWord + "%");
		this.pstmt.setInt(2, deptno);
		this.pstmt.setInt(3, currentPage * lineSize);
		this.pstmt.setInt(4, (currentPage - 1) * lineSize);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			Emp vo = new Emp();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getDouble(5));
			vo.setComm(rs.getDouble(6));
			Emp mgr = new Emp();
			mgr.setEmpno(rs.getInt(7));
			mgr.setEname(rs.getString(8));
			vo.setMgr(mgr);
			Dept dept = new Dept();
			dept.setDeptno(rs.getInt(9));
			dept.setDname(rs.getString(10));
			vo.setDept(dept);
			vo.setPhoto(rs.getString(11));
			vo.setNote(rs.getString(12));
			all.add(vo);
		}
		return all ;
	}

	@Override
	public Set<String> findAllPhotoByDeptno(Set<Integer> deptno)
			throws Exception {
		Set<String> allPhotos = new HashSet<String>();
		if(deptno.size() == 0) {
			return allPhotos ;
		}
		StringBuffer buf = new StringBuffer();
		buf.append("SELECT photo FROM emp WHERE deptno IN ");
		Iterator<Integer> iter = deptno.iterator();
		while(iter.hasNext()) {
			buf.append(iter.next()).append(",");
		}
		buf.delete(buf.length()-1, buf.length()).append(")");
		this.pstmt = this.conn.prepareStatement(buf.toString());
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()) {
			allPhotos.add(rs.getString(1));
		}
		return allPhotos;
	}

}
