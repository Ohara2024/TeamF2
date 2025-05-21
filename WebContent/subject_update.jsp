<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目情報の編集</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h2>科目情報の編集</h2>
<%
    int subjectId = Integer.parseInt(request.getParameter("id"));
    String url = "jdbc:mysql://localhost:8080/school_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    String user = "root";
    String password = "password123";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM subjects WHERE id = ?");
    pstmt.setInt(1, subjectId);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
%>
<form action="updateStudent" method="post">
    <input type="hidden" name="id" value="${student.id}">
    名前: <input type="text" name="name" value="${student.name}"><br>
    年齢: <input type="number" name="age" value="${student.age}"><br>
    学科: <input type="text" name="department" value="${student.department}"><br>
    <input type="submit" value="更新">
</form>

<%
    } else {
%>
    <p>該当する科目が見つかりませんでした。</p>
<%
    }
    rs.close();
    pstmt.close();
    conn.close();
%>
</body>
</html>
