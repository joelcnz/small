import std.algorithm, std.range, std.stdio;

void main() {
	auto answer1 = recurrence!"a[n-1] + a[n-2]"(1, 1)
	              .until!"a > 4_000_000"()
	              .filter!"a % 2 == 0"()
	              .reduce!"a + b"();

	writeln(answer1);

/*
	auto answer2 = recurrence!(a => a[n-1] + a[n-2])(1, 1)
	              .until!(a => a > 4_000_000)()
	              .filter!(a => a % 2 == 0)()
	              .reduce!(a => a + b)();
*/

	auto e1 = [1, 2, 3].map!"a * 3"();
	auto e2 = [1, 2, 3].map!(a => a * 3)();
	auto e3 = [1, 2, 3].map!((a) { return a * 3; })();
	auto e4 = [1, 2, 3].map!(delegate (int a) { return a * 3; })();
}
