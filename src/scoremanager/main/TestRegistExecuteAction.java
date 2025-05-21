package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;
import dao.StudentDao;
import dao.TestDao;
import tool.Action;

public class TestRegistExecuteAction implements Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // パラメータ取得
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String subjectCd = req.getParameter("subjectCd");
        String noStr = req.getParameter("no");

        int entYear = Integer.parseInt(entYearStr);
        int no = Integer.parseInt(noStr);

        // セッションからSchool取得
        School school = (School) req.getSession().getAttribute("school");

        // Subjectインスタンス作成
        Subject subject = new Subject();
        subject.setCd(subjectCd);
        subject.setSchool(school);

        // 生徒取得
        StudentDao studentDao = new StudentDao();
        List<Student> students = studentDao.filter(school, entYear, classNum, true); // 在籍中

        // 点数のバリデーションと保存準備
        List<Test> testList = new ArrayList<>();
        boolean hasError = false;

        for (Student student : students) {
            String pointStr = req.getParameter("point_" + student.getNo());
            if (pointStr == null || pointStr.trim().isEmpty()) {
                continue;
            }

            try {
                int point = Integer.parseInt(pointStr);
                if (point < 0 || point > 100) {
                    req.setAttribute("error_" + student.getNo(), "0～100で入力してください");
                    hasError = true;
                    continue;
                }

                Test test = new Test();
                test.setStudent(student);
                test.setSubject(subject);
                test.setClassNum(classNum);
                test.setSchool(school);
                test.setNo(no);
                test.setPoint(point);

                testList.add(test);

            } catch (NumberFormatException e) {
                req.setAttribute("error_" + student.getNo(), "数値で入力してください");
                hasError = true;
            }
        }

        if (hasError) {
            // エラーがある場合は入力画面に戻す
            req.setAttribute("students", students);
            req.setAttribute("subject", subject);
            req.setAttribute("classNum", classNum);
            req.setAttribute("entYear", entYear);
            req.setAttribute("no", no);
            req.getRequestDispatcher("/jsp/test_Regist.jsp").forward(req, res);
            return;
        }

        // 保存処理
        TestDao testDao = new TestDao();
        boolean result = testDao.save(testList);

        if (result) {
            req.setAttribute("message", "登録が完了しました");
        } else {
            req.setAttribute("message", "登録に失敗しました");
        }

        // 完了画面へ遷移
        req.getRequestDispatcher("/jsp/testRegist_done.jsp").forward(req, res);
    }
}
