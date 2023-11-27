package prod.servlets;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.json.*;

@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            if (!request.getMethod().equals("GET")) {
                generateError(response, "Required method: GET", 405);
            } else {
                doGet(request, response);
            }
        } catch (Exception e) {
            generateError(response, e.toString(), 500);
        }
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (request.getParameter("action").equals("checkArea") || request.getParameter("action").equals("goToTable")) {
            if (request.getParameter("X") == null ||
                    request.getParameter("Y") == null ||
                    request.getParameter("R") == null ||
                    request.getParameter("action") == null ||
                    request.getParameter("X").isEmpty() ||
                    request.getParameter("Y").isEmpty() ||
                    request.getParameter("R").isEmpty() ||
                    request.getParameter("action").isEmpty()) {
                generateError(response, "Some of parameters are not registered :(", 406);
            }

            response.sendRedirect("./areaCheck?" + request.getQueryString());
        } else {
            generateError(response, "Nothing good at all", 406);
        }
    }

    private void generateError(HttpServletResponse response, String message, int errorCode) throws IOException {
        JsonObjectBuilder builder = Json.createObjectBuilder()
                .add("error", message)
                .add("from", "ControllerServlet");

        JsonObject jsonObject = builder.build();
        String jsonString;
        try(Writer writer = new StringWriter()) {
            Json.createWriter(writer).write(jsonObject);
            jsonString = writer.toString();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(errorCode);
        PrintWriter writer = response.getWriter();
        writer.write(jsonString);
        writer.flush();
    }

}
