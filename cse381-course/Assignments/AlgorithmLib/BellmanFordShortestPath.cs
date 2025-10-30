/* CSE 381 - Bellman Ford
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W07 Prove: Assignment in Canvas for detailed instructions.
*/

using System.ComponentModel;
using System.Runtime.InteropServices;

namespace AlgorithmLib;

public static class BellmanFordShortestPath
{
    /* Find the Shortest Path in a graph using the Bellman Ford Algorithm
    *  with the ability to detect a negative cycle.
    *
    *  Inputs:
    *     g - The Graph (using the Graph class provided)
    *     startVertex - The vertex ID to calculate shortest path from
    *  Outputs:
    *     (Distance List, Predecessor List)
    *     NOTE: The above two output lists should contain Graph.INF as needed
    *
    *  Note: If a negative cycle exists, then the function must return
    *  a tuple of two empty lists. 
    */
    public static (List<int>, List<int>) ShortestPath(Graph g, int startVertex)
    {
        //establishing and setting needed lists
        List<int> dist = Enumerable.Repeat(Graph.INF, g.Size()).ToList();
        List<int> predecessor = Enumerable.Repeat(Graph.INF, g.Size()).ToList();
        dist[startVertex] = 0;

        //begins looping inside code g.size()-1 times
        for (int i = 0; i < g.Size() - 1; i++)
        {
            //variable we make to check for changes
            bool changesMade = false;
            for (int vertex = 0; vertex < g.Size(); vertex++)
            {
                if (dist[vertex] != Graph.INF)
                {
                    foreach (var edge in g.Edges(vertex))
                    {
                        if (dist[vertex] + edge.Weight < dist[edge.DestId])
                        {
                            //we've found a negative cycle. log it, mark changes as being found
                            changesMade = true;
                            dist[edge.DestId] = dist[vertex] + edge.Weight;
                            predecessor[edge.DestId] = vertex;
                        }
                    }
                }
            }
            //executes if no changes are made. in other words, no negative loop
            if (!changesMade)
            {
                Console.Write($"Exiting at i = {i}");
                return (dist, predecessor);
            }
        }
        //only executes if a negative cycle exists. see above if statement
        return (new List<int>(), new List<int>());
    } 
}