<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>科目一覧</title></head>
<body>
<h2>科目一覧</h2>
<table border="1">
    <tr><th>ID</th><th>科目名</th><th>単位数</th><th>操作</th></tr>
<%
    String url = "jdbc:mysql://localhost:8080/your_db";
    String user = "your_user";
    String password = "your_password";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM subjects");

    while (rs.next()) {
        int id = rs.getInt("id");
%>
    <tr>
        <td><%= id %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getInt("credit") %></td>
        <td>
            <form action="subject_update.jsp" method="get">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="submit" value="編集">
            </form>
        </td>
    </tr>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
%>
</table>
</body>
</html>
