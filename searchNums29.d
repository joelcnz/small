void main() {
	int nc; // number candidate
	int[] arr;
	immutable length = 10;
	arr.length = length;
	void rand() {
		import std.random;
		nc = cast(int)uniform!"[]"(1, length);
	}
	bool isUnique() {
		import std.stdio: writeln; 
		foreach(immutable n; arr) {
			if (n == nc)
				return false;
		}
		
		return true;
	}
	
	import std.stdio: writeln;
	foreach(i; 0 .. length) {
		do {
			rand;
		} while(! isUnique); //here! I had it without the '!' (not isUnique)
		arr[i] = nc;
	}
	writeln(arr);
}
