package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class StudentCreateAction implements Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        req.getRequestDispatcher("/scoremanager/main/student_create.jsp").forward(req, res);
    }
}