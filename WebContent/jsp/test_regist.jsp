<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, bean.Student, bean.Subject, bean.ClassNum" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    Subject subject = (Subject) request.getAttribute("subject");
    ClassNum classNum = (ClassNum) request.getAttribute("classNum");
    int entYear = (Integer) request.getAttribute("entYear");
    int no = (Integer) request.getAttribute("no");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成績登録</title>
    <style>
        .error {
            color: orange;
            font-size: 0.9em;
        }
        table {
            border-collapse: collapse;
            width: 60%;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <h2>成績登録</h2>

    <p>入学年度：<%= entYear %></p>
    <p>クラス：<%= classNum.getClass_num() %></p>
    <p>科目：<%= subject.getCd() %></p>
    <p>回数：<%= no %></p>

    <form action="TestRegist.action" method="post">
        <!-- hiddenパラメータ -->
        <input type="hidden" name="entYear" value="<%= entYear %>">
        <input type="hidden" name="classNum" value="<%= classNum.getClass_num() %>">
        <input type="hidden" name="subjectCd" value="<%= subject.getCd() %>">
        <input type="hidden" name="no" value="<%= no %>">

        <table>
            <tr>
                <th>出席番号</th>
                <th>氏名</th>
                <th>得点</th>
                <th>エラー</th>
            </tr>

            <%
                for (Student stu : students) {
                    String stuNo = stu.getNo();
                    String name = stu.getName();
                    String pointParam = "point_" + stuNo;
                    String error = (String) request.getAttribute("error_" + stuNo);
                    String value = request.getParameter(pointParam);
            %>
            <tr>
                <td><%= stuNo %></td>
                <td><%= name %></td>
                <td>
                    <input type="text" name="<%= pointParam %>" value="<%= value != null ? value : "" %>" size="5">
                </td>
                <td>
                    <% if (error != null) { %>
                        <span class="error"><%= error %></span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>

        <br>
        <input type="submit" value="登録">
    </form>
</body>
</html>
