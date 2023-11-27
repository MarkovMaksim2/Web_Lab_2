package prod.beans;

import jakarta.ejb.Stateful;
import jakarta.ejb.StatefulTimeout;
import prod.models.Point;

import java.io.Serializable;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Stateful
@StatefulTimeout(unit = TimeUnit.HOURS, value = 1)
public class PointBean implements Serializable {
    private final List<Point> points = new ArrayList<>();

    public void add(Point p) {
        points.add(p);
    }

    public List<Point> getPoints() {
        return points;
    }

    @Override
    public String toString() {
        return points.toString();
    }

    @Override
    public int hashCode() {
        return points.hashCode() * 15;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        PointBean point = (PointBean) obj;

        boolean eq = points.size() == point.getPoints().size();
        int i;
        for (i = 0; eq && i < points.size(); i++) {
            if (points.get(i) != point.getPoints().get(i)) eq = false;
        }
        return eq;
    }
}
