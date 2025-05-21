package tool;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import scoremanager.StudentCreateAction;
import scoremanager.StudentCreateExecuteAction;
import scoremanager.StudentListAction;

public class FrontController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        processRequest(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        processRequest(req, res);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String path = req.getServletPath();
        Action action = null;

        if (path.equals("/student/list.action")) {
            action = new StudentListAction();
        } else if (path.equals("/student/create.action")) {
            action = new StudentCreateAction();
        } else if (path.equals("/student/create/execute.action")) {
            action = new StudentCreateExecuteAction();
        }

        try {
            if (action != null) {
                action.execute(req, res);
            } else {
                res.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(); // ログ出力に置き換え推奨
        }
    }
}