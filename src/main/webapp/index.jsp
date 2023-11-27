<%@ page import="prod.beans.PointBean" %>
<%@ page import="prod.models.Point" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <link href="stylesheets/main.css" rel="stylesheet">
    <title>Лабораторная работа 2</title>
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
        <!-- <a href="https://soundcloud.com/m2magnida">Soundcloud</a> -->
    </nav>
</header>
<% PointBean bean = (PointBean) request.getSession().getAttribute("points"); %>
<div id="page">
    <div class="graph" id="central">
        <svg width="400" height="400" id="blueGraph" radius="150">
            <polygon points="200,200 125,200 200,125" fill="#05A1FF" />
            <rect x="200" y="125" width="150" height="75" fill="#05A1FF"/>
            <path d="M200 275 A75 75 0 0 0 275 200 L200 200 L200 275 Z" fill="#05A1FF" />

            <line x1="0" y1="200" x2="400" y2="200" stroke="black" />
            <line x1="200" y1="0" x2="200" y2="400" stroke="black" />

            <line x1="400" y1="200" x2="390" y2="195" stroke="black" />
            <line x1="400" y1="200" x2="390" y2="205" stroke="black" />
            <line x1="200" y1="0" x2="205" y2="10" stroke="black" />
            <line x1="200" y1="0" x2="195" y2="10" stroke="black" />

            <text x="385" y="215">x</text>
            <text x="215" y="15">y</text>

            <text x="40" y="185">-R</text>
            <line x1="50" y1="195" x2="50" y2="205" stroke="black" />
            <text x="115" y="185">-R/2</text>
            <line x1="125" y1="195" x2="125" y2="205" stroke="black" />
            <text x="270" y="185">R/2</text>
            <line x1="275" y1="195" x2="275" y2="205" stroke="black" />
            <text x="345" y="185">R</text>
            <line x1="350" y1="195" x2="350" y2="205" stroke="black" />

            <text x="215" y="50">R</text>
            <line x1="195" y1="50" x2="205" y2="50" stroke="black" />
            <text x="215" y="125">R/2</text>
            <line x1="195" y1="125" x2="205" y2="125" stroke="black" />
            <text x="215" y="275">-R/2</text>
            <line x1="195" y1="275" x2="205" y2="275" stroke="black" />
            <text x="215" y="350">-R</text>
            <line x1="195" y1="350" x2="205" y2="350" stroke="black" />

            <% if (bean != null) {
                for (Point p : bean.getPoints()) {
            %>
            <circle cx="<%= (int)(p.getX() / (double)p.getRadius() * 150.0) + 200 %>" cy="<%= (int)(-p.getY() / (double)p.getRadius() * 150.0) + 200 %>" r="5" fill="black" />
            <% }
            } %>
        </svg>
    </div>
    <div id="formDiv">
        <form class="graphForm" id="form" method="GET">
            <div>
                <label>X:</label>
                <input type="checkbox" name="xCheckbox" value="-5" /> -5
                <input type="checkbox" name="xCheckbox" value="-4" /> -4
                <input type="checkbox" name="xCheckbox" value="-3" /> -3
                <input type="checkbox" name="xCheckbox" value="-2" /> -2
                <input type="checkbox" name="xCheckbox" value="-1" /> -1
                <input type="checkbox" name="xCheckbox" value="1" /> 1
                <input type="checkbox" name="xCheckbox" value="2" /> 2
                <input type="checkbox" name="xCheckbox" value="3" /> 3
            </div>
            <br>
            <div>
                <label for="yCoordinate" class="y_label">Y:</label>
                <input name="yCoordinate" id="yCoordinate" class="yCoordinate" value="0" />
            </div>
            <br>
            <div>
                <label class="radius">R:</label>
                <button type="button" onclick="chooseR(1, this)" class="glow-on-hover" name="radius">1</button>
                <button type="button" onclick="chooseR(2, this)" class="glow-on-hover" name="radius">2</button>
                <button type="button" onclick="chooseR(3, this)" class="glow-on-hover" name="radius">3</button>
                <button type="button" onclick="chooseR(4, this)" class="glow-on-hover" name="radius">4</button>
                <button type="button" onclick="chooseR(5, this)" class="glow-on-hover" name="radius">5</button>
            </div>
            <br>
            <div>
                <button type="submit" class="glow-on-hover">Send</button>
                <button type="reset" onclick="removeRadius()" class="glow-on-hover">Refresh</button>
                <button type="button" onclick="refreshCircles()" class="glow-on-hover">Clear graph</button>
            </div>
        </form>
    </div>
    <div>
        <table>
            <thead>
                <tr>
                    <th>X</th>
                    <th>Y</th>
                    <th>R</th>
                    <th>Result</th>
                </tr>
            </thead>
            <tbody id="results">
            <% if (bean != null) {
                for (Point p : bean.getPoints()) { %>
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
            <% }
            } %>
            </tbody>
        </table>
    </div>
</div>
<script src="tools.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    $("input").change(function(){
        $(this).siblings("input").prop('checked', false);
    });
</script>
</body>
</html>