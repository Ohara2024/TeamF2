package scoremanager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import dao.StudentDao;
import tool.Action;

public class StudentListAction implements Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        StudentDao studentDao = new StudentDao();
        List<Student> students = studentDao.findAll();
        System.out.println("Students: " + students); // デバッグ用ログ
        req.setAttribute("students", students);
        req.getRequestDispatcher("/scoremanager/main/student_list.jsp").forward(req, res);
    }
}