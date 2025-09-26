/* CSE 381 - Binary Search
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W02 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;
 
public static class BinarySearch
{
    /* Use Binary Search to search for an item in a list.
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
        // Start the recursion
        return _Search(data, target, 0, data.Count - 1);
    }

    /* Use Binary Search to recursively search for an item in a sublist.
    *
    *  Inputs:
    *     data - list to search
    *     target - value to search for
    *     first - starting index of sublist of data
    *     last - ending index of sublist of data
    *  Outputs:
    *     Index where target was found
    *
    *  Note: Return -1 if target not found
    */
    public static int _Search<T>(List<T> data, T target, int first, int last) where T : IComparable<T>
    {
        //CompareTo = -1 curr.lessthan(this)
        //CompareTo = 0 curr.equalto(this)
        //CompareTo = 1 curr.morethan(this)
        if (first > last)
        {
            return -1;
        }
        var mid = (first + last) / 2;
        if (data[mid].Equals(target))//data[mid] == target
        {
            return mid;
        }
        else if (target.CompareTo(data[mid]) > 0) //target > data[mid]
        {
            return _Search(data, target, mid + 1, last);
        }
        else // target < data[mid]
        {
           return _Search(data, target, first, mid - 1);
        }

        return -1;
    }

}