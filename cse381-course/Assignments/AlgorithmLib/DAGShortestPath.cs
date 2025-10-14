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
        Queue<int> q = new Queue<int>(); //need this for later
        List<int> in_degree = new List<int>(); //the in-degree that the book mentions
        for (int i = 0; i < g.Size(); i++) //allows us to loop through all the vertices in the graph (g.Size())
        {
            foreach (var edge in g.Edges(i))//looks through each edge in the graph
            {
                in_degree[edge.DestId]++;//idk this was an optimization AI suggestion
                                         //At this point, we're supposed to be incrementing the in-degree for each adjacent vertex.
                                         //It's hard for me to tell if that's what this does
            }
            if (in_degree[i] == 0) // While we're looping through, we need to gather all the vertices that connect to nothing. Or, got through the last loop with 0
            {
                q.Enqueue(i);//this is what I needed the queue for
            }
        }
        
        List<int> sorted = new List<int>(); //now we make the sorted list, finally
        while (q.Count>0)
        {
            int y = q.Dequeue();
            sorted.Add(y); //adding these last few vertices, in order of when we got them earlier.

            foreach(var edge in g.Edges(y)) //idk,  this parts a bit technical. another suggestion from Chat to get this working
            {
                in_degree[edge.DestId]--;
                if (in_degree[edge.DestId] == 0)
                {
                    q.Enqueue(edge.DestId);
                }
            }
        }
        //we return the sorted list!
        return sorted;
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
        List<int> l = Sort(g);
        
        return (new List<int>(), new List<int>());
    } 
    
}