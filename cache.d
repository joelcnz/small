import std.functional;

int count;

int factorial(int x) {
	import std.stdio;
	writeln(++count);
    alias fact = memoize!(factorial);
    return (x < 2) ? 1:x*fact (x-1);
}


void main() {
    factorial(5); // 5 steps
    import std.stdio;
    writeln;
	count = 0;
    factorial(10); // 5 steps, (or 6)
}
