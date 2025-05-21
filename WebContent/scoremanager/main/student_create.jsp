<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生登録</title>
    <style>
        body {
            font-family: 'Noto Sans JP', 'Comic Sans MS', Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(to bottom, #fce2e6, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(255, 182, 193, 0.3);
            width: 100%;
            max-width: 500px;
        }
        h1 {
            text-align: center;
            color: #ff6b81;
            font-size: 24px;
            margin-bottom: 20px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        label {
            width: 120px;
            font-weight: bold;
            color: #ff6b81;
            font-size: 14px;
        }
        input[type="text"], input[type="number"] {
            flex: 1;
            padding: 10px;
            border: 1px solid #ffb6c1;
            border-radius: 8px;
            font-size: 14px;
            background-color: #fff0f5;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #ff6b81;
            box-shadow: 0 0 8px rgba(255, 107, 129, 0.3);
            outline: none;
        }
        input[type="checkbox"] {
            margin-left: 120px;
        }
        button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #d1c4e9;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        button:hover {
            background-color: #ffb6c1;
            transform: scale(1.05);
        }
        .error {
            color: #d32f2f;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
        a {
            display: block;
            text-align: center;
            padding: 10px;
            background-color: #d1c4e9;
            color: #fff;
            font-size: 14px;
            margin-top: 20px;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s, transform 0.2s;
        }
        a:hover {
            background-color: #ffb6c1;
            transform: scale(1.05);
        }
        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }
            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }
            label {
                width: 100%;
                margin-bottom: 5px;
            }
            input[type="checkbox"] {
                margin-left: 0;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>学生登録</h1>

        <%-- フォーム送信の処理 --%>
        <%
            String error = null;
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                request.setCharacterEncoding("UTF-8");
                String no = request.getParameter("no");
                String name = request.getParameter("name");
                String entYearStr = request.getParameter("entYear");
                String classNum = request.getParameter("classNum");
                boolean isAttend = "true".equals(request.getParameter("isAttend"));
                String schoolCd = request.getParameter("schoolCd");

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // 入力値のバリデーション
                    if (no == null || no.trim().isEmpty() || no.length() > 10) {
                        throw new SQLException("学生番号が無効です。");
                    }
                    if (name == null) {
                        throw new SQLException("名前が入力されていません。");
                    }
                    String trimmedName = name.trim();
                    if (trimmedName.isEmpty()) {
                        throw new SQLException("名前が空です。");
                    }
                    if (trimmedName.length() > 10) {
                        throw new SQLException("名前は10文字以内で入力してください。");
                    }
                    int entYear;
                    try {
                        entYear = Integer.parseInt(entYearStr);
                        if (entYear < 2000 || entYear > 2100) {
                            throw new SQLException("入学年は2000年から2100年の範囲で入力してください。");
                        }
                    } catch (NumberFormatException e) {
                        throw new SQLException("入学年が無効です。");
                    }
                    if (classNum == null || classNum.trim().isEmpty() || classNum.length() > 5) {
                        throw new SQLException("クラス番号が無効です。");
                    }
                    if (schoolCd == null || schoolCd.trim().isEmpty() || schoolCd.length() > 6) {
                        throw new SQLException("学校コードが無効です。");
                    }

                    // H2ドライバの読み込み
                    Class.forName("org.h2.Driver");
                    conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/exam", "sa", "");

                    // 学生番号の重複チェック
                    String checkSql = "SELECT COUNT(*) FROM STUDENT WHERE NO = ?";
                    stmt = conn.prepareStatement(checkSql);
                    stmt.setString(1, no);
                    rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        throw new SQLException("学生番号 " + no + " は既に登録されています。");
                    }
                    rs.close();
                    stmt.close();

                    // 学校コードの存在チェック
                    checkSql = "SELECT COUNT(*) FROM SCHOOL WHERE CD = ?";
                    stmt = conn.prepareStatement(checkSql);
                    stmt.setString(1, schoolCd);
                    rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        throw new SQLException("学校コード " + schoolCd + " は存在しません。");
                    }
                    rs.close();
                    stmt.close();

                    // クラス番号の存在チェック
                    checkSql = "SELECT COUNT(*) FROM CLASS_NUM WHERE CLASS_NUM = ? AND SCHOOL_CD = ?";
                    stmt = conn.prepareStatement(checkSql);
                    stmt.setString(1, classNum);
                    stmt.setString(2, schoolCd);
                    rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        throw new SQLException("クラス番号 " + classNum + " は学校コード " + schoolCd + " に存在しません。");
                    }
                    rs.close();
                    stmt.close();

                    // STUDENTテーブルに挿入
                    String sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, no);
                    stmt.setString(2, trimmedName);
                    stmt.setInt(3, entYear);
                    stmt.setString(4, classNum);
                    stmt.setBoolean(5, isAttend);
                    stmt.setString(6, schoolCd);
                    stmt.executeUpdate();

                    // 成功したら完了画面にリダイレクト
                    response.sendRedirect(request.getContextPath() + "/main/student_create_done.jsp");
                    return;
                } catch (ClassNotFoundException | SQLException e) {
                    error = "登録エラー: " + e.getMessage();
                } catch (Exception e) {
                    error = "予期しないエラー: " + e.getMessage();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            }
        %>

        <form action="<%=request.getContextPath()%>/scoremanager/main/student_create.jsp" method="post">
            <div class="form-group">
                <label for="no">学生番号:</label>
                <input type="text" id="no" name="no" maxlength="10" required>
            </div>
            <div class="form-group">
                <label for="name">名前:</label>
                <input type="text" id="name" name="name" maxlength="10" required>
            </div>
            <div class="form-group">
                <label for="entYear">入学年:</label>
                <input type="number" id="entYear" name="entYear" min="2000" max="2100" required>
            </div>
            <div class="form-group">
                <label for="classNum">クラス番号:</label>
                <input type="text" id="classNum" name="classNum" maxlength="5" required>
            </div>
            <div class="form-group">
                <label for="isAttend">在籍状況:</label>
                <input type="checkbox" id="isAttend" name="isAttend" value="true"> 在籍中
            </div>
            <div class="form-group">
                <label for="schoolCd">学校コード:</label>
                <input type="text" id="schoolCd" name="schoolCd" maxlength="6" required>
            </div>
            <button type="submit">登録する</button>
        </form>
        <p><a href="<%=request.getContextPath()%>scoremanager/main/student_list.jsp">学生一覧に戻る</a></p>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
    </div>
</body>
</html>