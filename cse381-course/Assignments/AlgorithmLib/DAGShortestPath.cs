/* CSE 381 - DAG Shortest Path
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W05 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;

public static class DAGShortestPath
{
    /* Topologically sort all vertices in a graph and return the sorted
     * list of vertex ID's.  Use a Stack object (available in C#).
     *
     *  Inputs:
     *     g - Graph
     *  Outputs:
     *     Return a sorted list of vertex ID's
     */
    public static List<int> Sort(Graph g)
    {
        Stack<int> s = new Stack<int>(); // need this for later
        List<int> in_degree = Enumerable.Repeat(0, g.Size()).ToList(); // the in-degree that the book mentions

        for (int i = 0; i < g.Size(); i++) // allows us to loop through all the vertices in the graph (g.Size())
        {
            foreach (var edge in g.Edges(i)) // looks through each edge in the graph
            {
                in_degree[edge.DestId]++; // At this point, we're supposed to be incrementing the in-degree for each adjacent vertex.
            }
        }

        for (int i = 0; i < g.Size(); i++) // once all in-degrees are computed, we can now gather all vertices with 0 in-degree
        {
            if (in_degree[i] == 0)
            {
                s.Push(i); // this is what I needed the stack for
            }
        }

        List<int> sorted = new List<int>(); // now we make the sorted list, finally
        while (s.Count > 0)
        {
            int y = s.Pop();
            sorted.Add(y); // adding these last few vertices, in order of when we got them earlier.

            foreach (var edge in g.Edges(y)) // this part adjusts the in-degrees for all adjacent vertices
            {
                in_degree[edge.DestId]--;
                if (in_degree[edge.DestId] == 0)
                {
                    s.Push(edge.DestId); // push the next vertex onto the stack if ready
                }
            }
        }

    // we return the sorted list!
    return sorted; //btw, this function had to be rewritten when I used a queue first. stacks are cool tho, didn't mind too much
}

    /* Find the shortest path from a starting vertex to all
     * vertices in a DAG.  This function will need to
     * call the Sort function to obtain the topologically
     * sorted list of vertices from the graph.
     *
     *  Inputs:
     *     g - Directed Acyclic Graph
     *     startVertex - Starting vertex ID
     *  Outputs:
     *     (distance list, predecessor list) 
     *     NOTE: The above two output lists should contain Graph.INF as needed
     */
    public static (List<int>, List<int>) ShortestPath(Graph g, int startVertex)
{
    List<int> l = Sort(g); // first, get the topologically sorted list of vertices from the graph

    List<int> distance = Enumerable.Repeat(Graph.INF, g.Size()).ToList(); // distance table, starts as infinity
    List<int> predecessor = Enumerable.Repeat(Graph.INF, g.Size()).ToList(); // predecessor table, also starts as infinity
    distance[startVertex] = 0; // distance from start to itself is 0

    for (int i = 0; i < l.Count; i++) // loop through vertices in topological order
    {
        int u = l[i];

        if (distance[u] != Graph.INF) // only process if this vertex is reachable
        {
            foreach (var edge in g.Edges(u)) // look through all edges from this vertex
            {
                int v = edge.DestId;
                int w = edge.Weight;

                // relax the edge directly here, it deserves a break
                if (distance[v] > distance[u] + w)
                {
                    distance[v] = distance[u] + w;
                    predecessor[v] = u;
                }
            }
        }
    }

    // return both lists together
    return (distance, predecessor);
}

    
}