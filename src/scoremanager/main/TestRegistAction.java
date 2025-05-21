package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ClassNum;
import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;
import dao.StudentDao;
import dao.TestDao;

public class TestRegistAction implements tool.Action {
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // パラメータの取得
        String entYearStr = req.getParameter("entYear");
        String classNumStr = req.getParameter("classNum");
        String subjectCd = req.getParameter("subjectCd");
        String noStr = req.getParameter("no");

        int entYear = Integer.parseInt(entYearStr);
        int no = Integer.parseInt(noStr);

        // 必要なBeanの構築
        School school = (School) req.getSession().getAttribute("school");
        ClassNum classNum = new ClassNum();
        classNum.setClass_num(classNumStr);
        classNum.setSchool(school);

        Subject subject = new Subject();
        subject.setCd(subjectCd);
        subject.setSchool(school);

        // StudentDaoから該当クラスの生徒一覧を取得
        StudentDao stuDao = new StudentDao();
        List<Student> students = stuDao.filter(school, entYear, classNumStr, true); // 在籍中のみに絞る

        // 成績入力された内容を取得してTestインスタンスに詰める
        List<Test> testList = new ArrayList<>();
        boolean hasError = false;

        for (Student stu : students) {
            String pointStr = req.getParameter("point_" + stu.getNo());

            if (pointStr == null || pointStr.trim().isEmpty()) {
                continue; // 空欄ならスキップ
            }

            int point;
            try {
                point = Integer.parseInt(pointStr);
                if (point < 0 || point > 100) {
                    req.setAttribute("error_" + stu.getNo(), "0～100の範囲で入力してください");
                    hasError = true;
                    continue;
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error_" + stu.getNo(), "数値で入力してください");
                hasError = true;
                continue;
            }

            Test test = new Test();
            test.setStudent(stu);
            test.setSubject(subject);
            test.setClassNum(classNumStr);
            test.setSchool(school);
            test.setNo(no);
            test.setPoint(point);

            testList.add(test);
        }

        if (hasError) {
            // エラーがあるので再表示用データも一緒に設定
            req.setAttribute("students", students);
            req.setAttribute("subject", subject);
            req.setAttribute("classNum", classNum);
            req.setAttribute("entYear", entYear);
            req.setAttribute("no", no);
            req.getRequestDispatcher("/jsp/test_Regist.jsp").forward(req, res);
            return;
        }

        // 成績の保存
        TestDao testDao = new TestDao();
        boolean result = testDao.save(testList);

        if (result) {
            req.setAttribute("message", "登録が完了しました");
        } else {
            req.setAttribute("message", "登録に失敗しました");
        }

        // 完了画面 or 再表示
        req.getRequestDispatcher("/jsp/test_Regist_done.jsp").forward(req, res);
    }
}
