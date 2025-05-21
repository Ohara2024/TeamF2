package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDao extends Dao {
    // ... (get メソッドは変更なし)

    private String baseSql = "SELECT SJ.cd as sj_cd, SJ.name as sj_name, ST.no as st_no, ST.name as st_name, "
            + "ST.ent_year as st_ent_year, ST.class_num as st_class_num, ST.is_attend as st_is_attend, "
            + "T.no as t_no, coalesce(T.point, -1) as t_point "
            + "FROM student ST left outer join (test T inner join subject SJ on T.subject_cd=SJ.cd) "
            + "on ST.no=T.student_no ";

    private List<Test> postFilter(ResultSet rSet, School school) throws Exception {
        List<Test> list = new ArrayList<>();
        while (rSet.next()) {
            Subject subject = new Subject();
            subject.setCd(rSet.getString("sj_cd"));
            subject.setName(rSet.getString("sj_name"));
            subject.setSchool(school);

            Student student = new Student();
            student.setNo(rSet.getString("st_no"));
            student.setName(rSet.getString("st_name"));
            student.setEntYear(rSet.getInt("st_ent_year"));
            student.setClassNum(rSet.getString("st_class_num"));
            student.setAttend(rSet.getBoolean("st_is_attend"));
            student.setSchool(school); // エラー箇所、修正済み

            Test test = new Test();
            test.setStudent(student);
            test.setClassNum(rSet.getString("st_class_num")); // 注意: classNum は Test クラスに存在するか確認
            test.setSubject(subject);
            test.setSchool(school);
            test.setNo(rSet.getInt("t_no"));
            test.setPoint(rSet.getInt("t_point"));

            list.add(test);
        }
        return list;
    }

    // ... (filter, save, delete メソッドは変更なし)
}