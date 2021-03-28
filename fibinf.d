/// Not work
module yieldnotranges;

import std.stdio;

struct Foo {
    int current = 0;
	int next = 1;

    int front() @property {
        return current;
    }

    void popFront() {
        const nextNext = current + next;
        current = next;
        next = nextNext;
    }

    // This range is infinite, i.e. never empty.
    enum empty = false;

//    typeof(this) save() @property { return this; }
}

void main()
{
	import std.range;
	Foo foo;
	print(foo.take(7));
}

import std.range;
void print(T)(T range) 
	if (isInputRange!T)
{
	writeln(range);
}