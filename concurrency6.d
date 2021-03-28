import std.stdio;
import std.concurrency;
import core.thread;

void worker(int firstNumber)
{
    foreach (i; 0 .. 4) {
        Thread.sleep(500.msecs);
        writeln(firstNumber + i);
    }
}

void main()
{
    foreach (i; 1 .. 3) {
        spawn(&worker, i * 10);
    }
}
