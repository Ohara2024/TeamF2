package tool;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        executeAction(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        executeAction(request, response);
    }

    private void executeAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 例: /test_regist.action → "test_regist"
            String path = request.getServletPath().replaceFirst("/", "").replaceFirst("\\.action$", "");

            // actionパッケージのクラス名を組み立てる
            String className = "scoremanager.main." +
                               path.substring(0, 1).toUpperCase() + path.substring(1) + "Action";

            // Actionインスタンスを生成して実行
            Action action = (Action) Class.forName(className).getDeclaredConstructor().newInstance();
            action.execute(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "アクションの実行に失敗しました: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}