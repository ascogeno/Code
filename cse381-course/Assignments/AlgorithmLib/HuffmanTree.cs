/* CSE 381 - Huffman Tree
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W10 Prove: Assignment in Canvas for detailed instructions.
*/
using System.Text;

namespace AlgorithmLib;

public static class HuffmanTree
{
    /* Represent the nodes in the Huffman Tree */
    public class Node
    {
        // Letter represented by the node.  Can be blank.
        public char Letter { get; set; }

        // Frequency of letters in the sub-tree beginning with this node
        public int Count { get; set; }

        // Left and Right sub-trees (can be Null)
        public Node? Left;
        public Node? Right;
    }

    /* Create a profile showing the frequency of all letters
     * from a string of text.
     *
     *  Inputs:
     *     text - Source for the profile
     *  Outputs:
     *     List of (letter,count) pairs that represent the profile
     *     of the text.  This list must be sorted by letter to ensure
     *     consistent huffman tree creation.
     */
    public static List<(char, int)> Profile(string text)
    {
        var freq = new Dictionary<char, int>();

        foreach (char c in text)
        {
            if (!freq.ContainsKey(c))
                freq[c] = 0;

            freq[c]++;
        }

        // supposed to be alphabetized or the tree isn't "consistent"
        return freq.OrderBy(x => x.Key)
                   .Select(x => (x.Key, x.Value))
                   .ToList();
    }

    /* Create a huffman tree for all letters in the profile.  Use a PQueue object
     * (code already provided for you) in your implementation for the 
     * priority queue.
     *
     *  Inputs:
     *     profile - Previously generated profile list of (letter,count) pairs
     *  Outputs:
     *     The root node of a huffman tree
     */
    public static Node BuildTree(List<(char, int)> profile)
    {
        // using the class they gave us
        var pq = new PQueue<Node>();

        // each (letter,count) pair becomes a leaf node
        foreach (var pair in profile)
        {
            char letter = pair.Item1;
            int count = pair.Item2;

            pq.Enqueue(new Node
            {
                Letter = letter,
                Count = count,
                Left = null,
                Right = null
            }, count);

        }

        // oddball case: only one letter in entire text
        if (pq.Size() == 1)
            return pq.Dequeue();

        // keep merging smallest two until one remains
        while (pq.Size() > 1)
        {
            Node a = pq.Dequeue();
            Node b = pq.Dequeue();

            // internal node doesn't store actual letter
            var parent = new Node
            {
                Letter = '\0',
                Count = a.Count + b.Count,
                Left = a,
                Right = b
            };

            pq.Enqueue(parent, parent.Count);

        }

        return pq.Dequeue();
    }

    /* Create an encoding map from the huffman tree
     *
     *  Inputs:
     *     tree - Root node of the Huffman Tree
     *  Outputs:
     *     A dictionary where key is the letter and value is the
     *     huffman code.
     */
    public static Dictionary<char, string> CreateEncodingMap(Node? tree)
    {
        var map = new Dictionary<char, string>();
        _CreateEncodingMap(tree, "", map);
        return map;
    }

    /* Recursively visit each node in the Huffman Tree
     * looking for leaf nodes which contain letters.  Keep
     * track of the huffman code by adding 0 when going left
     * and 1 when going right.  If the tree has only one node
     * (which can be determined by node being a leaf but the
     * bit string is currently empty), then the one letter in 
     * the tree should be encoded as "1".
     *
     *  Inputs:
     *     node - Current node we are on
     *     code - Current bit string code created
     *     map - Encoding Map being populated
     *  Outputs:
     *     none
     */
    public static void _CreateEncodingMap(Node? node, string code, Dictionary<char, string> map)
    {
        if (node == null)
            return;

        bool leaf = node.Left == null && node.Right == null;

        if (leaf)
        {
            // assignment mentions that "empty" code isn't allowed
            if (code == "")
                map[node.Letter] = "1";
            else
                map[node.Letter] = code;

            return;
        }

        // left = 0, right = 1
        if (node.Left != null)
            _CreateEncodingMap(node.Left, code + "0", map);

        if (node.Right != null)
            _CreateEncodingMap(node.Right, code + "1", map);
    }

    /* Encode a string with the encoding map.
     *
     *  Inputs:
     *     text - String to encode
     *     map - Encoding Map previously created
     *  Outputs:
     *     A string of huffman codes (1's and 0's) representing the
     *     encoding of the text.
     */
    public static string Encode(string text, Dictionary<char, string> map)
    {
        var sb = new StringBuilder();

        foreach (char c in text)
        {
            // just glue the bitstrings together
            sb.Append(map[c]);
        }

        return sb.ToString();
    }

    /* Decode a string with the huffman tree
     *
     *  Inputs:
     *     text - String to decode
     *     tree - Root node of the previously created huffman tree
     *  Outputs:
     *     decoded text
     */
    public static string Decode(string text, Node? tree)
    {
        if (tree == null)
            return "";

        // if there is only one character total, the whole thing is trivial
        bool single = tree.Left == null && tree.Right == null;

        if (single)
        {
            return new string(tree.Letter, text.Length);
        }

        var output = new StringBuilder();
        Node? curr = tree;

        foreach (char bit in text)
        {
            // walk one step
            curr = (bit == '0') ? curr!.Left : curr!.Right;

            // reached a leaf → output a letter
            if (curr!.Left == null && curr.Right == null)
            {
                output.Append(curr.Letter);
                curr = tree; // restart from the top again
            }
        }

        return output.ToString();
    }
}