<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>ページタイトル</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

<title>更新完了</title></head>
<body>
<h2>更新完了</h2>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    String department = request.getParameter("department");

    String url = "jdbc:mysql://localhost:8080/your_db";
    String user = "your_user";
    String password = "your_password";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    PreparedStatement pstmt = conn.prepareStatement("UPDATE students SET name = ?, age = ?, department = ? WHERE id = ?");
    pstmt.setString(1, name);
    pstmt.setInt(2, age);
    pstmt.setString(3, department);
    pstmt.setInt(4, id);
    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("学生情報を更新しました。<br>");
    } else {
        out.println("更新に失敗しました。<br>");
    }

    pstmt.close();
    conn.close();
%>
<a href="student_list.jsp">学生一覧に戻る</a>
</body>
</html>
