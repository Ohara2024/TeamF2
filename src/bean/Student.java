package bean;

public class Student {
    private String no;
    private String name;
    private int entYear;
    private String classNum;
    private boolean isAttend;
    private String schoolCd;
    private School school;

    public String getNo() { return no; }
    public void setNo(String no) { this.no = no; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getEntYear() { return entYear; }
    public void setEntYear(int entYear) { this.entYear = entYear; }
    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }
    public boolean isAttend() { return isAttend; }
    public void setAttend(boolean attend) { this.isAttend = attend; }
    public String getSchoolCd() { return schoolCd; }
    public void setSchoolCd(String schoolCd) { this.schoolCd = schoolCd; }
    public School getSchool() { return school; }
    public void setSchool(School school) { this.school = school; }
}8