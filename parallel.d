// See - Org: http://davesdprogramming.wordpress.com/2011/04/07/7/
import std.parallelism;
import std.stdio;
import std.math;
import std.datetime;

void main()
{
    auto logs = new double[20_000_000];

    writeln("CPUs : ",totalCPUs );

	StopWatch stopWatch;

    {
		scope(exit) writeln(stopWatch.peek().msecs);
        stopWatch.start();

        foreach(i, ref elem; logs)
            elem = log(i + 1.0);
    }

    {
		scope(exit) writeln(stopWatch.peek().msecs);
        stopWatch.start();

        foreach(i, ref elem; parallel(logs))
            elem = log(i + 1.0);
    }
}
