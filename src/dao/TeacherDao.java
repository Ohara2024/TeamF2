package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.Teacher;

public class TeacherDao extends Dao {

    /**

     * getメソッド 教員IDを指定して教員インスタンスを1件取得する

     *

     * @param id:String

     *            教員ID

     * @return 教員クラスのインスタンス 存在しない場合はnull

     * @throws Exception

     */

    public Teacher get(String id) throws Exception {

        // 教員インスタンスを初期化

        Teacher teacher = new Teacher();

        // コネクションを確立

        Connection connection = getConnection();

        // プリペアードステートメント

        PreparedStatement statement = null;

        try {

            // プリペアードステートメントにSQL文をセット（大文字に修正）

            System.out.println("Executing query: select * from TEACHER where id=" + id);

            statement = connection.prepareStatement("select * from TEACHER where id=?");

            // プリペアードステートメントに教員IDをバインド

            statement.setString(1, id);

            // プリペアードステートメントを実行

            ResultSet rSet = statement.executeQuery();

            // 学校Daoを初期化

            SchoolDao schoolDao = new SchoolDao();

            if (rSet.next()) {

                // リザルトセットが存在する場合

                // 教員インスタンスに検索結果をセット

                teacher.setId(rSet.getString("id"));

                teacher.setPassword(rSet.getString("password"));

                teacher.setName(rSet.getString("name"));

                // 学校フィールドには学校コードで検索した学校インスタンスをセット

                teacher.setSchool(schoolDao.get(rSet.getString("school_cd")));

            } else {

                // リザルトセットが存在しない場合

                // 教員インスタンスにnullをセット

                teacher = null;

            }

        } catch (Exception e) {

            System.err.println("Error in TeacherDao.get: " + e.getMessage());

            throw e;

        } finally {

            // プリペアードステートメントを閉じる

            if (statement != null) {

                try {

                    statement.close();

                } catch (SQLException sqle) {

                    System.err.println("Failed to close statement: " + sqle.getMessage());

                    throw sqle;

                }

            }

            // コネクションを閉じる

            if (connection != null) {

                try {

                    connection.close();

                } catch (SQLException sqle) {

                    System.err.println("Failed to close connection: " + sqle.getMessage());

                    throw sqle;

                }

            }

        }

        return teacher;

    }

    /**

     * loginメソッド 教員IDとパスワードで認証する

     *

     * @param id:String

     *            教員ID

     * @param password:String

     *            パスワード

     * @return 認証成功:教員クラスのインスタンス, 認証失敗:null

     * @throws Exception

     */

    public Teacher login(String id, String password) throws Exception {

        // 教員クラスのインスタンスを取得

        Teacher teacher = get(id);

        // 教員がnullまたはパスワードが一致しない場合

        if (teacher == null || !teacher.getPassword().equals(password)) {

            return null;

        }

        return teacher;

    }

}
