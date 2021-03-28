// http://ddili.org/ders/d.en/concurrency.html

import std.stdio;
import std.concurrency;
import core.thread;

void worker()
{
    foreach (i; 0 .. 5) {
        Thread.sleep(500.msecs);
        writeln(i, " (worker)");
    }
}

void main()
{
    spawn(&worker);

    foreach (i; 0 .. 5) {
        Thread.sleep(300.msecs);
        writeln(i, " (main)");
    }

    writeln("main is done.");
}
