package bean;

public class Test {
    private Student student;
    private Subject subject;
    private School school;
    private int no;
    private int point;
    private String classNum; // 追加

    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }
    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }
    public School getSchool() { return school; }
    public void setSchool(School school) { this.school = school; }
    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
    public String getClassNum() { return classNum; } // 追加
    public void setClassNum(String classNum) { this.classNum = classNum; } // 追加
}