// I don't understand
import std.stdio;

auto factorial1(T)(T n) {
    if (n == 0)
        return 1;
    return n*factorial1(n-1);
}

auto factorial2(T)(T n) {
    T p = 1;
again :
    if (n == 0)
        return p;
    p *= n;
    n -= 1;
    goto again;
}

auto factorial3(T)(T n) {
    T p = 1;
    while (true) {
        if (n == 0) break;
        p *= n;
        n -= 1;
    }
    return p;
}

auto factorial4(T)(T n) {
    T p = 1;
    foreach (i; 0 .. n)
        p *= i+1;
    return p;
}

void main(string[] args) {
    auto n = 7;

	if (args.length == 2) {
		import std.conv;
		n = args[1].to!int;
	}

    n -= 1; // <- what is this for?
    auto f = factorial4(n);
    writeln("factorial(", n, ") = ", f);
}
