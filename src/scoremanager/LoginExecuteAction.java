package scoremanager;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;

public class LoginExecuteAction {
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        try {
            TeacherDao teacherDao = new TeacherDao();
            Teacher teacher = teacherDao.login(id, password);

            HttpSession session = req.getSession();
            if (teacher != null) {
                teacher.setAuthenticated(true); // 認証済みフラグを設定
                session.setAttribute("teacherName", teacher.getName());
                session.setAttribute("teacher", teacher);
                req.getRequestDispatcher("/scoremanager/main/menu.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "IDまたはパスワードが正しくありません。");
                req.getRequestDispatcher("scoremanager/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "ログイン処理中にエラーが発生しました: " + e.getMessage());
            req.getRequestDispatcher("scoremanager/login.jsp").forward(req, resp);
        }
    }
}