import std.algorithm.iteration : map, each;
import std.array : array;
import std.conv : to;
import std.range : takeExactly, tee;
import std.stdio;

version=Idiomatic;
//version=MoreLikeC;

version(Idiomatic)
void main()
{
    double mean = 0;
    auto sample = File("10numbers.txt")
        .byLine
        .takeExactly(10)
        .map!(to!double)
        .tee!((x){mean += x;})
        .array;
    mean /= sample.length;
    // prints one element per line
    sample.map!(x => x - mean).each!writeln;
}

version(MoreLikeC)
void main()
{
    File fin = File("10numbers.txt");
    double[] sample;
    sample.length = 10;
    double mean = 0;
    for(int i = 0; i < sample.length; i++)
    {
        fin.readf("%s", &sample[i]);
        if(!fin.eof)
            fin.readln();
        mean += sample[i];
    }
    mean /= sample.length;
    // prints one element per line
    for(int i = 0; i < sample.length; i++)
    {
        writeln(sample[i] - mean);
    }
}