// a repeated line ?!
import std.stdio;
import std.concurrency;

void printTid(string tag)
{
    writefln("%s: %s, address: %s", tag, thisTid, &thisTid);
}

void worker()
{
    printTid("Worker");
}

void main()
{
    spawn(&worker);
    printTid("Owner ");
}
