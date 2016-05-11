package com.cfxyz.cf.test.junit;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import junit.framework.TestCase;

import org.junit.Test;

import com.cfxyz.cf.factory.ServiceFactory;
import com.cfxyz.cf.vo.Emp;

public class IEmpServiceTest {

	@Test
	public void testInsert() {
		Emp vo = new Emp();
		vo.setEmpno(9999);
		vo.setEname("测试");
		vo.setJob("测试岗");
		vo.setHiredate(new Date());
		vo.setSal(8333.0);
		vo.setComm(5324.0);
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().insert(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdate() {
		Emp vo = new Emp();
		vo.setEmpno(9999);
		vo.setEname("测测");
		vo.setJob("不要测");
		vo.setHiredate(new Date());
		vo.setSal(8333.0);
		vo.setComm(234.0);
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().update(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdatePre() {
		try {
			TestCase.assertNotNull(ServiceFactory.getIEmpServiceInstance().updatePre(9999));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testDelete() {
		Set<Integer> ids = new HashSet<Integer>();
		ids.add(9999);
		try {
			TestCase.assertNotNull(ServiceFactory.getIEmpServiceInstance().delete(ids));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testList() {
		try {
			TestCase.assertTrue(ServiceFactory.getIEmpServiceInstance().list().size() > 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testListStringStringIntInt() {
		fail("Not yet implemented");
	}

}
