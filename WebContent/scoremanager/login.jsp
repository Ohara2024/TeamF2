<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ログイン</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 300px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .login-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .login-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .show-password {
            text-align: right;
            margin-top: 5px;
        }
        .error-message {
            color: #dc3545;
            margin-top: 10px;
            text-align: left;
        }
        .footer {
            margin-top: 20px;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>ログイン</h2>
        <form action="/TeamF/FrontController" method="post">
            <input type="hidden" name="action" value="executeLogin">
            <label>ID:</label>
            <input type="text" name="id"><br> <!-- value="admin" を削除 -->
            <label>パスワード:</label>
            <input type="password" name="password" value=""><br>
            <div class="show-password">
                <input type="checkbox" id="showPassword" onchange="document.getElementsByName('password')[0].type = this.checked ? 'text' : 'password'">
                <label for="showPassword">パスワードを表示</label>
            </div>
            <input type="submit" value="ログイン">
        </form>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
        <div class="footer">
            © 2025 TIC 大原学園
        </div>
    </div>
</body>
</html>