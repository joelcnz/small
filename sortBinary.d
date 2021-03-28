struct Person {
	string name;
	int age;

	string toString() const {
		import std.string;
		return format("Name: %10s, Age: %02s", name, age);
	}

	auto nameLength() {
		return name.length;
	}
}

void main(string[] args) {
	import std.range;
	import std.array;
	args.popFront;
	// Joy 59 Dad 68
	Person[] ppl;
	import std.conv;
	foreach(i; iota(0, args.length, 2)) {
		ppl ~= Person(args[i], args[i+1].to!int);
	}

	import std.stdio;
	import std.algorithm;
	import std.range;
	foreach(psn; ppl.sort!"a.nameLength < b.nameLength".filter!q{a.name != "Ria" && a.name != "Joy"}.take(7))
		writeln(psn);

	long[] nums;
	nums.length = ppl.length;
	int i;
	foreach(psn; ppl.sort!q{a.age < b.age})
		nums[i++] = psn.age;

	assert(! binarySearch(nums, 99));
	assert(binarySearch(nums, 37));
}

auto binarySearch(T)(T[] arr, int value) {
	import std.array;
	if (arr.empty)
		return false;
	long i = arr.length/2;
	T mid = arr[i];
	if (mid > value)
		return binarySearch(arr[0 .. i], value);
	if (mid < value)
		return binarySearch(arr[i + 1 .. $], value);

	return true;
}
