package com.cfxyz.cf.test.junit;

import static org.junit.Assert.fail;

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
		fail("Not yet implemented");
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
