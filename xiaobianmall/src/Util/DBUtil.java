package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {//这里是云服务器对应的数据库密码
    static String ip = "47.103.218.127";
    static int port = 3306;
    static String database = "xiaobianmall";
    static String encoding = "UTF-8";//idea 你来打包
    static String loginName = "root";
    static String password = "2017Bian!";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {

        String url = String.format("jdbc:mysql://%s:%d/%s?characterEncoding=%s", ip, port, database, encoding);
        return DriverManager.getConnection(url, loginName, password);
    }

    public static void main(String[] args) throws SQLException {
        System.out.println(getConnection());

    }
}
