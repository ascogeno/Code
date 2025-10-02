/* CSE 381 - Merge Sort
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W03 Prove: Assignment in Canvas for detailed instructions.
*/

namespace AlgorithmLib;
 
public static class MergeSort
{
    /* Use Merge Sort to sort a list of values in place
     *
     *  Inputs:
     *     data - list of values
     *  Outputs:
     *     none
     */
    public static void Sort<T>(List<T> data) where T : IComparable<T> 
    {
        // Start the recursive process with the whole list
        _Sort(data, 0, data.Count-1);
    }

    /* Recursively use merge sort to sort a sublist
     * defined by first and last.
     * 
     *  Inputs:
     *     data - list of values
     *     first - the starting index of the sublist
     *     last - the ending index of the sublist
     *  Outputs:
     *     None
     */
    public static void _Sort<T>(List<T> data, int first, int last) where T : IComparable<T>
    {
        //base case, clears the rest of the code below to execute cleanly
        if (first >= last)
        {
            return;
        }
        //see what I mean? this would throw an exception if the list was empty. bad math
        //oh, it also finds the middle index
        int mid = (first + last) / 2;
        //sorts the left  half of the list
        _Sort(data, first, mid);
        //sorts the right half
        _Sort(data, mid + 1, last);
        //merges the two halves. not sure why this works, cause we're recursively calling a function that in itself doesn't sort, but whatever it works
        Merge(data, first, mid, last);
    }

    /* Merge two sorted list which are adjacent to each other back into
     * the same list.
     *
     *  Inputs:
     *     data - list of values
     *     first - the starting index of the first sorted sublist
     *     mid - the ending index of the first sorted sublist (second sublist starts after)
     *     last - the ending index of the second sorted sublist
     *  Outputs:
     *     None
     */
    public static void Merge<T>(List<T> data, int first, int mid, int last) where T : IComparable<T>
    {
        //self explanatory temp list to hold our stuff in
        List<T> temp = new List<T>();
        //for making the code not ugly, this is the index of the left side of the list
        int left = first;
        //similar purpose, though its more justified. now i dont have to type mid+1 to represent this elsewhere
        int right = mid + 1;

        //total number of elements between first and last (inclusive)
        int total = last - first + 1;

        //where the actual merge sorting happens
        //instead of 3 while loops, we’ll just run one for loop this many times,
        //checking which side still has elements left to grab from
        for (int i = 0; i < total; i++)
        {
            //Case 1: both halves still have elements left to compare
            if (left <= mid && right <= last)
            {
                //compare adjacent values, take whichever is smaller
                if (data[left].CompareTo(data[right]) <= 0)
                {
                    temp.Add(data[left]);
                    left++;
                }
                else
                {
                    temp.Add(data[right]);
                    right++;
                }
            }
            //Case 2: only the left side has stuff left
            else if (left <= mid)
            {
                temp.Add(data[left]);
                left++;
            }
            //Case 3: only the right side has stuff left
            else if (right <= last)
            {
                temp.Add(data[right]);
                right++;
            }
            //Case 4: both sides exhausted (shouldn’t really happen because of total count, but safe)
            else
            {
                break;
            }
        }

        //bring it all back into the og list
        for (int i = 0; i < temp.Count; i++)
        {
            data[first + i] = temp[i];
        }
    }
}

