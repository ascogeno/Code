/* CSE 381 - Dijkstra Shortest Path
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W06 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;

public static class DijkstraShortestPath
{

    /* Find the shortest path from a starting vertex to all
     * vertices in a graph using Dijkstra.  Use a PQueue object
     * (code already provided for you) in your implementation for the 
     * priority queue.
     *
     *  Inputs:
     *     g - Graph
     *     startVertex - Starting vertex ID
     *  Outputs:
     *     (distance list, predecessor list)
     *     NOTE: The above two output lists should contain Graph.INF as needed
     */
    public static (List<int>, List<int>) ShortestPath(Graph g, int startVertex)
    {
        List<int> dist = Enumerable.Repeat(Graph.INF, g.Size()).ToList();
        List<int> predecessor = Enumerable.Repeat(Graph.INF, g.Size()).ToList();
        //fix these to be ints intstead
        dist[startVertex] = 0;
        predecessor[startVertex] = Graph.INF;
        List<int> unvisited = Enumerable.Range(0, g.Size()).ToList();

        while (unvisited.Count() > 0)
        {
            int vertex = unvisited.OrderBy(v => dist[v]).First();
            if (dist[vertex] == Graph.INF)
            {
                break; 
            }
                

            unvisited.Remove(vertex);

            foreach (var edge in g.Edges(vertex))
            {
                if (dist[vertex] + edge.Weight < dist[edge.DestId])
                {
                    dist[edge.DestId] = dist[vertex] + edge.Weight;
                    predecessor[edge.DestId] = vertex;
                }
            }
        }
        return (dist, predecessor);
    } 
}