<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績登録完了</title>
    <style>
        body {
            font-family: sans-serif;
            padding: 2em;
            background-color: #f5f5f5;
        }
        .container {
            background-color: #fff;
            padding: 2em;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: auto;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .message {
            margin: 1em 0;
            font-size: 1.2em;
            color: #006400;
        }
        .button {
            display: inline-block;
            margin-top: 1em;
            padding: 0.5em 1.5em;
            font-size: 1em;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>成績登録</h1>

        <div class="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "処理が完了しました。" %>
        </div>

        <a class="button" href="<%= request.getContextPath() %>/menu.jsp">メニューに戻る</a>
    </div>
</body>
</html>
