void main() {
	import std.stdio;
	int[] nums;
	nums.length = 10;
	nums.uniqueNums.writeln;
}

auto uniqueNums(ref int[] arr) {
	int nc;
	void rand() {
		import std.random;
		nc = cast(int)uniform!"[]"(1, arr.length);
	}
	
	bool notUnique() {
		foreach(const n; arr)
			if (nc == n)
				return true;
		return false;
	}
	
	foreach(ref n; arr) {
		do {
			rand;
		} while(notUnique);
		n = nc;
	}
	
	return arr;
}