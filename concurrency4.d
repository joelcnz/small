import std.stdio;
import std.concurrency;
import std.conv;

void main()
{
    Tid worker = spawn(&workerFunc);

    foreach (value; 1 .. 5) {
        worker.send(value);
        double result = receiveOnly!double();
        writefln("sent: %s, received: %s", value, result);
    }

    /* Sending a negative value to the worker so that it
     * terminates.  */
    worker.send(-1);
}

void workerFunc()
{
    int value = 0;

    while (value >= 0) {
        value = receiveOnly!int();
        double result = to!double(value) / 5;
        ownerTid.send(result);
    }
}
