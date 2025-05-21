package scoremanager;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginAction {
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        new LoginExecuteAction().execute(req, resp); // LoginExecuteActionに委譲
    }
}