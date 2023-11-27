const form = document.querySelector('.graphForm');
const resultsTable = document.getElementById('results');
const graph = document.getElementById("blueGraph");


function chooseR(r, button) {
    document.getElementsByClassName('radius').item(0).setAttribute('rvalue', r);

    const buttons = document.getElementsByClassName("glow-on-hover");

    if (buttons) {
        let el;
        for (el of buttons) {
            el.removeAttribute("disabled")
        }
    }

    button.setAttribute("disabled", "disabled");
}

async function sendAndReceive(x, y, r) {
    const data = formData(x, y, r);

    data.append("action", "checkArea");

    const url = "controller?" + new URLSearchParams(data).toString();

    const response = await fetch(url, {method: "get"});

    if (!response.ok) {
        alert("Unable to set response");
    }

    const responseJson = await response.json();

    if (responseJson.error) alert(responseJson.error);

    return responseJson;
}


graph.addEventListener('click', async function () {
    const radius = document.getElementsByClassName('radius').item(0).getAttribute('rvalue');

    if (!radius) {
        alert("Input radius");
        return;
    }

    const rect = graph.getBoundingClientRect();

    const mouseX = event.clientX - rect.x;
    const mouseY = event.clientY - rect.y;

    console.log(mouseX + ", " + mouseY);

    const centerX = graph.getAttribute("width") / 2;
    const centerY = graph.getAttribute("height") / 2;
    const graphRadius = graph.getAttribute("radius");

    const x = (mouseX - centerX) / graphRadius;
    const y = (centerY - mouseY) / graphRadius;

    const jsonData = await sendAndReceive(x * radius, y * radius, radius);

    drawTableLine(jsonData);
    drawPoint(mouseX, mouseY);
});


form.addEventListener('submit', function () {
    event.preventDefault();
    const ycoord = document.getElementById('yCoordinate').value;
    const radius = document.getElementsByClassName('radius').item(0).getAttribute('rvalue');

    const xValues = [];
    const checkboxes = document.querySelectorAll('input[name="xCheckbox"]:checked');
    checkboxes.forEach(function (checkbox) {
        xValues.push(checkbox.value);
    });

    if (xValues.length === 0) {
        alert("Select X");
        return;
    }
    const xcoord = xValues[0];
    if (!ycoord || !radius) {
        alert("Input all values");
        return;
    }

    if (isNaN(ycoord) || ycoord > 3 || ycoord < -5) {
        alert("Y value might be in range [-5; 3]");
        return;
    }

    const data = formData(xcoord, ycoord, radius);

    data.append("action", "goToTable");

    window.location.href = "controller?" + new URLSearchParams(data).toString();
});

function formData(x, y, r) {
    const data = new FormData();

    data.append("X", x);
    data.append("Y", y);
    data.append("R", r);

    return data
}

function drawTableLine(jsonData) {
    if (jsonData) {
        if (jsonData.from === "AreaCheckServlet") {
            const newRow = document.createElement('tr');
            newRow.innerHTML = `<td>${jsonData.x}</td><td>${jsonData.y}</td><td>${jsonData.radius}</td><td>${jsonData.inArea ? 'Inside' : 'Outside'}</td>`;
            resultsTable.appendChild(newRow);
        }
    }
}

function drawPoint(x, y) {
    const newPoint = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
    newPoint.setAttribute('cx', x);
    newPoint.setAttribute('cy', y);
    newPoint.setAttribute('fill', randomHexColor());
    newPoint.setAttribute('r', "5");

    graph.appendChild(newPoint);
}

function randomHexColor() {
    const hex = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]

    return "#" + hex[getRandomInt(15)] + hex[getRandomInt(15)]
        + hex[getRandomInt(15)] + hex[getRandomInt(15)]
        + hex[getRandomInt(15)] + hex[getRandomInt(15)];
}

function getRandomInt(max) {
    return Math.floor(Math.random() * max);
}

function refreshCircles() {
    const circles = graph.querySelectorAll('circle');
    circles.forEach(circle => {
        graph.removeChild(circle);
    });
}

function removeRadius() {
    const r = document.getElementsByClassName('radius').item(0)

    if (r) {
        r.removeAttribute('rvalue');
    }

    const buttons = document.getElementsByClassName("glow-on-hover");

    if (buttons) {
        let el;
        for (el of buttons) {
            el.removeAttribute("disabled")
        }
    }
}