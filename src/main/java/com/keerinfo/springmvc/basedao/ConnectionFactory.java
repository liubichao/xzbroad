package com.keerinfo.springmvc.basedao;

import com.keerinfo.springmvc.utils.MyUtils;
import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

public final class ConnectionFactory {

	private ConnectionFactory() {
	}
	private static ComboPooledDataSource ds = null;

	static {
		try {
			ds = new ComboPooledDataSource();
			ds.setDriverClass(MyUtils.getProperty("jdbc.driverClassName"));
			ds.setJdbcUrl(MyUtils.getProperty("jdbc.url"));
			ds.setUser(MyUtils.getProperty("jdbc.username"));
			ds.setPassword(MyUtils.getProperty("jdbc.password"));
			ds.setMaxPoolSize(500);
			ds.setMinPoolSize(3);
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
	}

	public static synchronized Connection getConnection() {
		Connection con = null;
		try {
			con = ds.getConnection();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return con;
	}
}
