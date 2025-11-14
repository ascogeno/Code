/* CSE 381 - RSA 
*  (c) BYU-Idaho - It is an honor code violation to post this
*  file completed in a public file sharing site. F5.
*
*  Instructions: Refer to W09 Prove: Assignment in Canvas for detailed instructions.
*/

using System.Numerics;
using System.Threading.Tasks.Dataflow;

namespace AlgorithmLib;

public class RSA
{
    /* Recursively use Euclid to find the Greatest Common Divisor between
     * two numbers as well as the linear combination form.
     *
     *  Inputs:
     *     a - First number
     *     b - Second number
     *  Outputs:
     *     (gcd, i, j) where gcd = i*a + j*b
     */
    public static (BigInteger, BigInteger, BigInteger) Euclid(BigInteger a, BigInteger b)
    {
        //base case
        if (b == 0)
        {
            return (a, 1, 0);
        }

        //recursive call
        var (gcd, i1, j1) = Euclid(b, a % b);

        //im not totally sure, im just following what the book said and then Chat corrected
        BigInteger i = j1;
        BigInteger j = i1 - (a / b) * j1;

        return (gcd, i, j);
    }

    /* Recursively calculates x^y mod n
     *
     *  Inputs:
     *     x - base
     *     y - exponent
     *     n - modulo
     *  Outputs:
     *     Result of x^y mod n
     */
    public static BigInteger ModularExponentiation(BigInteger x, BigInteger y, BigInteger n)
    {
        //base case. should always have one
        if (y == 0)
        {
            return 1;
        }

        // if y is even
        if (y % 2 == 0)
        {
            var z = ModularExponentiation(x, y / 2, n);
            return (z * z) % n;
        }
        else
        {
            var z = ModularExponentiation(x, (y - 1) / 2, n);
            return (z * z * x) % n;
        }
    }

    /* Generate the RSA private key given the two prime numbers p and q and
     * the public key e which was selected to be co-prime with
     * phi = (p-1) * (q-1).
     * 
     *  Inputs:
     *     p - First prime
     *     q - Second prime
     *     e - Public Key 
     *  Outputs:
     *     Private Key - Must be positive
     */
    public static BigInteger GeneratePrivateKey(BigInteger p, BigInteger q, BigInteger e)
    {
        var phi = (p - 1) * (q - 1); //stole from class
        var (_, d, _) = Euclid(e, phi); //idk, i had i in here but chat said to do d instead

        //make sure key is positive. i guess. idk, another chat suggestion. might remove
        d %= phi;
        if (d < 0)
        {
            d += phi;
        }

        return d;
    }

    /* Encrypt a value using the public keys e and n
     *
     *  Inputs:
     *     value - Value to encrypt
     *     e - Public Key whose value was co-prime with phi
     *     n - Public Key whose Value is equal to p*q
     *  Outputs:
     *     encrypted value
     */
    public static BigInteger Encrypt(BigInteger value, BigInteger e, BigInteger n)
    {
        return ModularExponentiation(value, e, n);
    }

    /* Decrypt a value using the public key n and private key d
     *
     *  Inputs:
     *     value - Value to decrypt
     *     d - Private Key whose value was the multiplicative inverse of e mod phi
     *     n - Public Key whose Value is equal to p*q
     *  Outputs:
     *     encrypted value
     */
    public static BigInteger Decrypt(BigInteger value, BigInteger d, BigInteger n)
    {
        return ModularExponentiation(value, d, n);
    }


}