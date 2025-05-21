package dao;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Dao {
    static DataSource ds;

    public Connection getConnection() throws Exception {
        if (ds == null) {
            InitialContext ic = new InitialContext();
            String jndiName = "java:comp/env/jdbc/yajima"; // 修正
            System.out.println("Attempting to lookup: " + jndiName); // デバッグログ追加
            try {
                ds = (DataSource) ic.lookup(jndiName);
                System.out.println("DataSource lookup succeeded for: " + jndiName);
            } catch (Exception e) {
                System.err.println("DataSource lookup failed for: " + jndiName + " - " + e.getMessage());
                throw e;
            }
        }
        try {
            Connection conn = ds.getConnection();
            System.out.println("Connection established successfully via JNDI");
            return conn;
        } catch (Exception e) {
            System.err.println("Connection failed: " + e.getMessage());
            throw e;
        }
    }
}