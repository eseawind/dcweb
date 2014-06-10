package com.jstrd.asdc.test;

public class ClassLoaderTest {

	public static void main(String[] args) {
		ClassLoader c1 = ClassLoaderTest.class.getClassLoader();
		System.out.println(c1);
		ClassLoader c2 = c1.getParent();
		System.out.println(c2);
		ClassLoader c3 = c2.getParent();
		System.out.println(c3);
	
		System.out.println(System.getProperties());
	}
}
