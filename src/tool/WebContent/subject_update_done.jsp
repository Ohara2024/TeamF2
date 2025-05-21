<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><meta charset="UTF-8"><title>更新完了</title></head>
<body>
<h2>科目情報の更新</h2>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    int credit = Integer.parseInt(request.getParameter("credit"));
    String teacher = request.getParameter("teacher");
    String url = "jdbc:mysql://localhost:8080/your_db"; // ← これが正しい場合が多い

    String user = "root";
    String password = "password123";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    PreparedStatement pstmt = conn.prepareStatement("UPDATE subjects SET name = ?, credit = ?, teacher = ? WHERE id = ?");
    pstmt.setString(1, name);
    pstmt.setInt(2, credit);
    pstmt.setString(3, teacher);
    pstmt.setInt(4, id);
    int result = pstmt.executeUpdate();

    if (result > 0) {
%>
        <p>科目情報を更新しました。</p>
<%
    } else {
%>
        <p>更新に失敗しました。</p>
<%
    }
    pstmt.close();
    conn.close();
%>
<a href="subject_list.jsp">戻る</a>
</body>
</html>
