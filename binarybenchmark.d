import core.simd;
import core.bitop;

import std.algorithm;

immutable size_t ArraySize = 16;

int simdIndexOf(ubyte niddle, ref const ubyte[ArraySize] haystack)
{
    ubyte16 arr;
    arr.array = haystack[];
    ubyte16 niddles;
    niddles.array[] = niddle;
    ubyte16 result;
    result = __simd_sto(XMM.PCMPEQB, arr, niddles);
    alias Mask = ulong;
	static assert(2 * Mask.sizeof == result.sizeof);
	immutable BitsInByte = 8;

    if (Mask mask = *cast(Mask*)(result.array.ptr))
    {
        return bsf(mask) / BitsInByte;
    }
    else if (Mask mask = *cast(Mask*)(result.array.ptr + Mask.sizeof))
    {
        return bsf(mask) / BitsInByte + cast(int)Mask.sizeof;
    }
    else
    {
        return -1;
    }

}

int naiveIndexOf(ubyte niddle, ref const ubyte[ArraySize] haystack)
{
    for (int i = 0; i < ArraySize; ++i)
    {
        if (haystack[i] == niddle)
        {
            return i;
        }
    }

    return -1;
}

int binaryIndexOf(ubyte niddle, ref const ubyte[ArraySize] haystack)
{
    /// https://en.wikipedia.org/wiki/Binary_search_algorithm
    int imin = 0;
    int imax = ArraySize - 1;

    while(true)
    {
        if (imax < imin)
        {
            return -1;
        }
        else
        {
            int imid = (imin + imax) / 2;

            if (haystack[imid] > niddle)
            {
                imax = imid - 1;
                continue;
            }
            else if (haystack[imid] < niddle)
            {
                imin = imid + 1;
                continue;
            }
            else
            {
                return imid;
            }
        }
    }
}

immutable ubyte[ArraySize] arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

void runSIMD()
{
    static int i = 0;
    simdIndexOf(cast(ubyte)(i++/ArraySize + 1), arr);
}

void runNaive()
{
    static int i = 0;
    naiveIndexOf(cast(ubyte)(i++/ArraySize + 1), arr);
}

void runBinary()
{
    static int i = 0;
    binaryIndexOf(cast(ubyte)(i++/ArraySize + 1), arr);
}


void runBenchmark()
{
    import std.stdio;
    import std.datetime.stopwatch;
	enum {sim, bin, nav}
    auto t = benchmark!(
            runSIMD
            , runBinary
            , runNaive
            )(10_000);
    writeln("-----");
    writeln("SIMD:    ", t[sim]);
    writeln("Binary:  ", t[bin]);
    writeln("Naive:   ", t[nav]);
}

void main()
{
	runBenchmark();
	runBenchmark();
}

