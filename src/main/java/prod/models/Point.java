package prod.models;

import java.util.Objects;

public class Point {
    private final double x;
    private final double y;
    private final int radius;
    private final boolean inArea;

    public Point(double x, double y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;

        this.inArea = checkArea();
    }

    private boolean checkArea() {
        if (x >= 0 && y >= 0 && x <= radius && y <= radius / 2.0) return true;
        else if (x >= 0 && y < 0 && x * x + y * y <= radius * radius / 4.0) return true;
        else return x <= 0 && y > 0 && radius / 2.0 - y + x >= 0;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public int getRadius() {
        return radius;
    }

    public boolean getInArea() {
        return inArea;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Point point = (Point) o;
        return x == point.x && y == point.y && radius == point.radius && inArea == point.inArea;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, radius, inArea);
    }

    @Override
    public String toString() {
        return "X: " + x + " Y: " + y + " Radius: " + radius + " Is point in area: " + inArea;
    }
}
