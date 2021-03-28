void main() {
	int[] arr;
	
	arr.length = 10;
	
	arr.getUniqueNumbersRange;
	import std.stdio;
	writeln(arr);
}

void getUniqueNumbersRange(ref int[] arr) {
	int nc;

	void rand() {
		import std.random;
		nc = cast(int)uniform!"[]"(0, arr.length);
	}

	bool isUnique() {
		foreach(n; arr)
			if (nc == n)
				return false;
		return true;
	}
	
	foreach(ref n; arr) {
		do {
			rand;
		} while(isUnique == false);
		n = nc;
	}
}
