/* CSE 381 - String Matcher
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W08 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;

public static class StringMatcher
{
    /* Find all matches of the pattern in the string of text given a list
     * of all valid input characters.  This function needs to build Finite
     * State Machine table by calling BuildFSM.
     *
     *  Inputs:
     *     text - string to search for pattern
     *     pattern - substring to search in the text
     *     inputs - valid characters using in the text and pattern
     *  Outputs:
     *     list of indices where the pattern matched (last char of pattern match)
     */
    public static List<int> MatchPattern(string text, string pattern, List<char> inputs)
    {
        List<Dictionary<char, int>> fsm = BuildFSM(pattern, inputs);
        List<int> results = new List<int>();
        int state = 0;

        // Walk through each character in the text
        for (int i = 0; i < text.Length; i++)
        {
            char c = text[i];

            // If the FSM does not define a transition for this input, reset
            if (!fsm[state].ContainsKey(c))
                state = 0;
            else
                state = fsm[state][c];

            // If we reached the full pattern length, record a match
            if (state == pattern.Length)
                results.Add(i);
        }

        return results;
    }

    /* Build the Finite State Machine table for the pattern and list of valid
     * inputs provided.
     *
     *  Inputs:
     *     pattern - string to match
     *     inputs - valid list of characters that could be seen
     *  Outputs:
     *     Finite State Machine defined by a list of dictionaries.  Each index
     *     in the list represents a state in the FSM (index 0 is first).  The
     *     dictionary shows the next state to goto for each of the valid
     *     inputs that can occur.
     */
    public static List<Dictionary<char, int>> BuildFSM(string pattern, List<char> inputs)
    {
        int m = pattern.Length;
        List<Dictionary<char, int>> fsm = new List<Dictionary<char, int>>(m + 1);

        // Initialize each state with an empty transition table
        for (int i = 0; i <= m; i++)
            fsm.Add(new Dictionary<char, int>());

        // Build transitions for each state q
        for (int q = 0; q <= m; q++)
        {
            // Try all possible input characters
            foreach (char a in inputs)
            {
                int nextState = 0;

                // Try largest possible prefix length down to nada
                for (int k = Math.Min(m, q + 1); k >= 0; k--)
                {
                    bool ok = true;

                    // Check last character of prefix vs input char
                    if (k > 0 && pattern[k - 1] != a)
                        ok = false;

                    // Check previous characters if prefix length is greater than 1
                    if (ok && k > 1)
                    {
                        if (q < k - 1)
                            ok = false;
                        else
                        {
                            // Compare prefix with suffix of pattern
                            for (int j = 0; j < k - 1; j++)
                            {
                                if (pattern[j] != pattern[q - (k - 1) + j])
                                {
                                    ok = false;
                                    break;
                                }
                            }
                        }
                    }

                    // Use the first (longest) valid k
                    if (ok)
                    {
                        nextState = k;
                        break;
                    }
                }

                // Store computed transition
                fsm[q][a] = nextState;
            }
        }

        return fsm;
    }
}