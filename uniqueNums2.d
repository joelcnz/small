void main() {
	import std.stdio;
	int[] arr;
	arr.length = 10;
	arr.uniqueNumbers.writeln;
}

auto uniqueNumbers(int[] arr) {
	int nc;
	
	void rand() {
		import std.random;
		nc = cast(int)uniform!"[]"(1, arr.length);
	}
	
	bool isUnique() {
		foreach(a; arr)
			if (a == nc)
				return false;
		return true;
	}
	
	foreach(ref a; arr) {
		do {
			rand;
		} while(! isUnique);
		a = nc;
	}
	
	return arr;
}
