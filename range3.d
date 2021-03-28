import std.stdio;

class Range(T) {
	T[] arr;

	auto total() {
		static if (is(T == int)) {
			import std.algorithm;

			return arr.sum;
		}
	}

	bool empty() { return arr.length == 0; }
	@property T front() { return arr[0]; }
	void popFront() { arr = arr[1 .. $]; }
	@property auto save() {
		writeln("Save!");
		return arr;
	}
}

void main() {
	auto ints = new Range!int;
	ints.arr = [1,2,4,8,12,34,30,1979];
	foreach(element; ints.save)
		write(element, ' ');
	writeln("\ntake two:");
	foreach(i; ints.save)
		write(i, ' ');
	writeln;
	writeln("Total: ", ints.total);
}

