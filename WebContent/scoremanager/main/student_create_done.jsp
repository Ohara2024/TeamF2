<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登録完了</title>
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
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(255, 182, 193, 0.3);
            text-align: center;
            width: 100%;
            max-width: 500px;
        }
        h1 {
            color: #ff6b81;
            font-size: 24px;
            margin-bottom: 20px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 30px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #d1c4e9;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
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
            h1 {
                font-size: 20px;
            }
            p {
                font-size: 14px;
            }
            a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>登録完了</h1>
        <p>学生登録が完了しました。</p>
        <a href="<%=request.getContextPath()%>/scoremanager/main/student_list.jsp">学生一覧に戻る</a>
    </div>
</body>
</html>