package prod.servlets;

import java.io.*;

import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonObjectBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import prod.beans.PointBean;
import prod.models.Point;

@WebServlet("/areaCheck")
public class AreaCheckServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Point p = new Point(Double.parseDouble(request.getParameter("X")),
                Double.parseDouble(request.getParameter("Y")),
                Integer.parseInt(request.getParameter("R")));

        HttpSession session = request.getSession();
        PointBean bean = (PointBean) session.getAttribute("points");

        if (bean == null) {
            bean = new PointBean();

            session.setAttribute("points", bean);
        }

        bean.add(p);

        if (request.getParameter("action").equals("checkArea")) {
            JsonObjectBuilder builder = Json.createObjectBuilder()
                    .add("x", p.getX())
                    .add("y", p.getY())
                    .add("radius", p.getRadius())
                    .add("inArea", p.getInArea())
                    .add("from", "AreaCheckServlet");

            JsonObject jsonObject = builder.build();
            String jsonString;
            try(Writer writer = new StringWriter()) {
                Json.createWriter(writer).write(jsonObject);
                jsonString = writer.toString();
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(200);
            PrintWriter writer = response.getWriter();
            writer.write(jsonString);
            writer.flush();
        }
        else if (request.getParameter("action").equals("goToTable")) {
            request.getRequestDispatcher("./points.jsp").forward(request, response);
        }
    }
}
