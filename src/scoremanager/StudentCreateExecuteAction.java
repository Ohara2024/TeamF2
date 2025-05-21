package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction implements Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        int entYear = Integer.parseInt(req.getParameter("entYear"));
        String classNum = req.getParameter("classNum");
        boolean isAttend = Boolean.parseBoolean(req.getParameter("isAttend"));
        String schoolCd = req.getParameter("schoolCd");

        // デバッグ用ログ
        System.out.println("no: " + no);
        System.out.println("name: " + name);
        System.out.println("entYear: " + entYear);
        System.out.println("classNum: " + classNum);
        System.out.println("isAttend: " + isAttend);
        System.out.println("schoolCd: " + schoolCd);

        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchoolCd(schoolCd);

        StudentDao studentDao = new StudentDao();
        studentDao.save(student);

        res.sendRedirect(req.getContextPath() + "scoremanager/main/student_create_done.jsp");
    }
}