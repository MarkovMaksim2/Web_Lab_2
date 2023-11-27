<%@ page import="prod.beans.PointBean" %>
<%@ page import="prod.models.Point" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="stylesheets/main.css" rel="stylesheet">
    <title>Points table</title>
</head>
<body>
<header>
    <div class="logo" id="main">
        <img src="resources/photo.jpg">
    </div>
    <div class="title">
        <i>Markov Maksim Aleksandrovich P3233 1408</i>
    </div>
    <nav>
        <a href="https://github.com/MarkovMaksim2">GitHub</a>
        <a href="https://soundcloud.com/m2magnida">Soundcloud</a>
    </nav>
</header>
<div>
    <% PointBean bean = (PointBean) request.getSession().getAttribute("points");
    if (bean == null) {
    %>
    <h2>No results</h2>
    <% } else { %>
    <table>
        <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Result</th>
            </tr>
        </thead>
        <tbody>
            <% for (Point p : bean.getPoints()) { %>
            <tr>
                <td>
                    <%= p.getX() %>
                </td>
                <td>
                    <%= p.getY() %>
                </td>
                <td>
                    <%= p.getRadius() %>
                </td>
                <td>
                    <%= p.getInArea() ? "<span class=\"success\">Inside</span>"
                            : "<span class=\"fail\">Outside</span>" %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>
</div>
<div>
    <a href="index.jsp" class="back_link">Go back</a>
</div>
</body>
</html>
