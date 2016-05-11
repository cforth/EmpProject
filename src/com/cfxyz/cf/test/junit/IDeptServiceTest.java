package com.cfxyz.cf.test.junit;

import java.util.HashSet;
import java.util.Set;

import org.junit.Test;

import com.cfxyz.cf.factory.ServiceFactory;
import com.cfxyz.cf.vo.Dept;

import junit.framework.TestCase;

public class IDeptServiceTest {

	@Test
	public void testInsert() {
		Dept vo = new Dept();
		vo.setDeptno(11);
		vo.setDname("哈哈");
		vo.setLoc("呵呵");
		try {
			TestCase.assertTrue(ServiceFactory.getIDeptServiceInstance().insert(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdate() {
		Dept vo = new Dept();
		vo.setDeptno(11);
		vo.setDname("发展部");
		vo.setLoc("北京");
		try {
			TestCase.assertTrue(ServiceFactory.getIDeptServiceInstance().update(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testDelete() {
		Set<Integer> ids = new HashSet<Integer>();
		ids.add(11);
		try {
			TestCase.assertTrue(ServiceFactory.getIDeptServiceInstance().delete(ids));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpatePre() {
		try {
			TestCase.assertNotNull(ServiceFactory.getIDeptServiceInstance().updatePre(20));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testList() {
		try {
			TestCase.assertTrue(ServiceFactory.getIDeptServiceInstance().list().size() > 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
