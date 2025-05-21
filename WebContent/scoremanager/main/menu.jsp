<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>メニュー</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        .header {
            background-color: #fff;
            padding: 10px 20px;
            border-bottom: 1px solid #ccc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        .header .user-info {
            display: flex;
            align-items: center;
            gap: 40px; /* 間隔を20pxから40pxに拡大 */
        }
        .header .user-info span {
            font-size: 14px;
            color: #666;
        }
        .header .logout-link {
            text-decoration: none;
            color: #007bff;
            font-size: 14px;
        }
        .header .logout-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .container {
            display: flex;
            flex-grow: 1;
        }
        .sidebar {
            width: 200px;
            background-color: #fff;
            padding: 20px;
            border-right: 1px solid #ccc;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            margin-bottom: 10px;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #007bff;
            display: block;
            padding: 10px;
            background-color: #f8d7da;
            border-radius: 5px;
            text-align: center;
        }
        .sidebar ul li a:hover {
            background-color: #f1aeb5;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            text-align: center;
        }
        .main-content h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .main-content p {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }
        .card {
            display: inline-block;
            width: 150px;
            padding: 15px;
            margin: 10px;
            background-color: #d1e7dd;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card a {
            text-decoration: none;
            color: #007bff;
            display: block;
            text-align: center;
        }
        .card a:hover {
            color: #0056b3;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background-color: #e9ecef;
            color: #666;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>大原学園 成績管理システム</h1>
        <div class="user-info">
            <span><%= session.getAttribute("teacherName") %> さん</span>
            <form action="/TeamF/FrontController" method="post" style="margin: 0;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="logout-link" style="background: none; border: none; padding: 0; cursor: pointer;">ログアウト</button>
            </form>
        </div>
    </div>
    <div class="container">
        <div class="sidebar">
            <ul>
                <li><a href="/TeamF/scoremanager/main/student_list.jsp">学生管理</a></li>
                <li><a href="#">成績管理</a></li>
                <li><a href="#">成績登録</a></li>
                <li><a href="#">成績参照</a></li>
            </ul>
        </div>
        <div class="main-content">
            <h2>メニュー</h2>
            <p>ようこそ、<%= session.getAttribute("teacherName") %> さん！</p>
            <div class="card">
                <a href="/TeamF/scoremanager/main/student_list.jsp">学生管理</a>
            </div>
            <div class="card">
                <a href="#">成績管理</a>
            </div>
            <div class="card">
                <a href="#">成績登録</a>
            </div>
            <div class="card">
                <a href="#">成績参照</a>
            </div>
        </div>
    </div>
    <div class="footer">
        © 2025 TIC 大原学園
    </div>
</body>
</html>