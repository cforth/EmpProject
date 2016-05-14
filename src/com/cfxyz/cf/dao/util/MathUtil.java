package com.cfxyz.cf.dao.util;

import java.math.BigDecimal;

public class MathUtil {
	public static double round(double num, int scale) {
		return new BigDecimal(num).divide(new BigDecimal(1), scale, 
				BigDecimal.ROUND_HALF_UP).doubleValue();
	}
}
