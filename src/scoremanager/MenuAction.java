package scoremanager;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MenuAction {
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("teacher") != null) {
            req.getRequestDispatcher("/TeamF2/scoremanager/menu.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "ログインしてください。");
            req.getRequestDispatcher("/scoremanager/login.jsp").forward(req, resp);
        }
    }
}