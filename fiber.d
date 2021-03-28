import std.stdio;
import std.range;
import std.concurrency;

/* Resolve the name conflict with std.range.Generator. */
alias FiberRange = std.concurrency.Generator;

void fibonacciSeries()
{
	int
	current = 0;
	// <-- Not a parameter anymore
	int
	next = 1;
	while(true) {
		yield(current);
		const nextNext = current + next;
		current = next;
		next = nextNext;
	}
}

void main()
{
	auto
	series = new FiberRange!int(&fibonacciSeries);
	writefln("%(%s %)", series.take(10));
}
