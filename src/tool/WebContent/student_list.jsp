<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ページタイトル</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

<title>学生一覧</title></head>
<body>
<h2>学生一覧</h2>
<table border="1">
    <tr><th>ID</th><th>名前</th><th>年齢</th><th>学科</th><th>操作</th></tr>
<%
String url = "jdbc:mysql://localhost:8080/your_db"; // ← これが正しい場合が多い

    String user = "your_user";
    String password = "your_password";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM students");

    while (rs.next()) {
        int id = rs.getInt("id");
%>
    <tr>
        <td><%= id %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getInt("age") %></td>
        <td><%= rs.getString("department") %></td>
        <td>
            <form action="student_update.jsp" method="get">
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
