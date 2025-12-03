/* CSE 381 - Convex Hull (Graham Scan)
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W11 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;

public static class ConvexHull
{
    /* Valid angle types to be used in the code */
    public enum Angle
    {
        Convex,
        Concave,
        Colinear
    }

    /* Representation of a 2D point with support
     * for comparing 2 points for equivalence.
    */
    public class Point
    {
        public readonly double X;
        public readonly double Y;

        // Used for comparison of doubles
        public static double TOLERANCE = 0.001;

        public Point(double x, double y)
        {
            X = x;
            Y = y;
        }

        /* This function supports testing */
        public bool Equals(Point point)
        {
            return Math.Abs(X - point.X) < TOLERANCE &&
                   Math.Abs(Y - point.Y) < TOLERANCE;
        }
    }

    /* Determine if 3 points form a convex, concave, or
     * co-linear angle.
     *
     *  Inputs:
     *     a - Point 1
     *     b - Point 2
     *     c - Point 3
     *  Outputs:
     *     Return Angle.Convex, Angle.Concave, or Angle.Colinear
     */
    public static Angle Orientation(Point a, Point b, Point c)
    {
        //cross product
        double cross = (b.X - a.X) * (c.Y - a.Y) - (b.Y - a.Y) * (c.X - a.X);

        if (Math.Abs(cross) < Point.TOLERANCE)
        {
            return Angle.Colinear;
        }

        //changes return based on positive or negative values
        return cross > 0 ? Angle.Convex : Angle.Concave;
    }

    /* Determine the angle of a point relative to an anchor point.
     *
     *  Inputs:
     *     anchor - Anchor point
     *     point - Other point
     *  Outputs:
     *     Return angle in radians
     */
    public static double GetAngle(Point anchor, Point point)
    {
        //slope
        return Math.Atan2(point.Y - anchor.Y, point.X - anchor.X);
    }

    /* Determine the distance from an anchor point to another point
     *
     *  Inputs:
     *     anchor - Anchor point
     *     point - Other point
     *  Outputs:
     *     Return distance
     */
    public static double GetDist(Point anchor, Point point)
    {
        double dx = point.X - anchor.X;
        double dy = point.Y - anchor.Y;
        return Math.Sqrt(dx * dx + dy * dy);
    }

    /* General a Convex Hull from a list of points.
     *
     *  Inputs:
     *     points - List of points to create hull around
     *  Outputs:
     *     Return list of points in the hull
     *
     * NOTE: If no hull exists, then return an empty list.
     */
    public static List<Point> GenerateHull(List<Point> points)
    {
        if (points == null || points.Count < 3)
        {
            return new List<Point>();
        }

        Point anchor = points[0];
        foreach (var p in points)
        {
            if (p.Y < anchor.Y || (Math.Abs(p.Y - anchor.Y) < Point.TOLERANCE && p.X < anchor.X))
            {
                anchor = p;
            }
        }

        points = points.OrderBy(p => GetAngle(anchor, p)).ThenBy(p => GetDist(anchor, p)).ToList();

        bool allColinear = true;
        for (int i = 2; i < points.Count; i++)
        {
            if (Orientation(points[0], points[1], points[i]) != Angle.Colinear)
            {
                allColinear = false;
                break;
            }
        }

        if (allColinear)
        {
            // return nothing if they all line up
            return new List<Point>();
        }

        List<Point> hull = new List<Point>();

        foreach (var p in points)
        {
            while (hull.Count >= 2 && Orientation(hull[hull.Count - 2], hull[hull.Count - 1], p) != Angle.Convex)
            {
                hull.RemoveAt(hull.Count - 1);
            }

            hull.Add(p);
        }
        if (hull.Count < 3)
        {
            return new List<Point>();
        }
        if (hull.Count >= 1)
        {
            hull.Add(hull[0]);
        }

        return hull;
    }
}
