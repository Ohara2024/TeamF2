<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生情報の編集</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h2>学生情報の編集</h2>
<%
    int id = Integer.parseInt(request.getParameter("id"));
String url = "jdbc:mysql://localhost:8080/your_db";

    String user = "root";
    String password = "password123";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM students WHERE id = ?");
    pstmt.setInt(1, id);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
%>
    <form action="student_update_done.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        名前: <input type="text" name="name" value="<%= rs.getString("name") %>"><br>
        年齢: <input type="text" name="age" value="<%= rs.getInt("age") %>"><br>
        学科: <input type="text" name="department" value="<%= rs.getString("department") %>"><br>
        <input type="submit" value="更新">
    </form>
<%
    } else {
%>
    <p>該当する学生が見つかりませんでした。</p>
<%
    }
    rs.close();
    pstmt.close();
    conn.close();
%>
</body>
</html>
