package tool;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
        // 初期化時にやることがあればここに
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        // リクエストのエンコーディングをUTF-8に設定
        request.setCharacterEncoding("UTF-8");

        // 次のフィルターまたはサーブレットへ処理を移す
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 終了時にやることがあればここに
    }
}