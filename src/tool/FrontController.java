package tool;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import scoremanager.LogOutAction;
import scoremanager.LoginAction;
import scoremanager.MenuAction;

@WebServlet("/FrontController")
public class FrontController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        processRequest(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("login".equals(action)) {
            req.getRequestDispatcher("/scoremanager/login.jsp").forward(req, resp);
        } else if ("menu".equals(action)) {
            new MenuAction().execute(req, resp);
        } else if ("logout".equals(action)) {
            new LogOutAction().execute(req, resp);
        } else if ("executeLogin".equals(action)) {
            new LoginAction().execute(req, resp); // LoginActionを経由
        } else {
            req.getRequestDispatcher("/scoremanager/login.jsp").forward(req, resp); // デフォルトはログイン画面
        }
    }
}