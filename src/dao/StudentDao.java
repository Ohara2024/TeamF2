package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;

public class StudentDao {
    private Connection getConnection() throws Exception {
        Class.forName("org.h2.Driver");
        String url = "jdbc:h2:tcp://localhost/~/exam";
        String user = "sa";
        String password = "";
        return DriverManager.getConnection(url, user, password);
    }

    public List<Student> findAll() throws Exception {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM Student";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Student student = new Student();
                student.setNo(rs.getString("NO"));
                student.setName(rs.getString("NAME"));
                student.setEntYear(rs.getInt("ENT_YEAR"));
                student.setClassNum(rs.getString("CLASS_NUM"));
                student.setAttend(rs.getBoolean("IS_ATTEND"));
                student.setSchoolCd(rs.getString("SCHOOL_CD"));
                students.add(student);
            }
        }
        return students;
    }

    public void save(Student student) throws Exception {
        String sql = "INSERT INTO Student (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getNo());
            pstmt.setString(2, student.getName());
            pstmt.setInt(3, student.getEntYear());
            pstmt.setString(4, student.getClassNum());
            pstmt.setBoolean(5, student.isAttend());
            String schoolCd = student.getSchoolCd();
            if (schoolCd == null) {
                schoolCd = "";
            }
            pstmt.setString(6, schoolCd);
            pstmt.executeUpdate();9
        }
    }
}