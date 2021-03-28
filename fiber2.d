import core.thread;

/* This is the fiber function that generates each element and
 * then sets the 'ref' parameter to that element. */
void fibonacciSeries(ref int current)                   // (1)
{
    current = 0;    // Note that 'current' is the parameter
    int next = 1;

    while (true) {
        Fiber.yield();                                  // (2)
        /* Next call() will continue from this point */ // (3)

        const nextNext = current + next;
        current = next;
        next = nextNext;
    }
}

void main()
{
    int current;                                        // (1)
                                                        // (4)
    Fiber fiber = new Fiber(() => fibonacciSeries(current));

    foreach (_; 0 .. 10) {
        fiber.call();                                   // (5)

        import std.stdio;
        writef("%s ", current);
    }
}
