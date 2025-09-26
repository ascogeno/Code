/* CSE 381 - BetterLinearSerach
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W01 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;

public static class BetterLinearSearch
{

    /* Search for an item in a list.  Ignore duplicates by exiting
    *  as soon as the first match is found.
    *
    *  Inputs:
    *     data - list to search
    *     target - value to search for
    *  Outputs:
    *     Index where target was found
    *
    *  Note: Return -1 if target not found
    */
    public static int Search<T>(List<T> data, T target) where T : IComparable<T>
    {
        //edge case for an empty list. added this later, all the tests passed without it though
        if (data.Count == 0)
        {
            return -1;
        }
        
        //loops through the data. "i" is an index that increments by one every loop, until it reaches the size of the list
        for (int i = 0; i < data.Count; i++)
        {
            //checks if the current index, when used to look at the list, returns the target
            if (data[i].Equals(target))
            {
                //returns i, which if the "if" statement works, should only return correct indices
                return i;
            }
        }
        // returns -1, like the assingment said to. This code only executes if the whole list was looked through,
        // thus meaning that no match was found
        return -1;
    }
}