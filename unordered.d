struct UniqueArray(T ARRAY, int LOWER = 1, int UPPER = 10) {
	int _rc;
	T[] _arr;
	
	void rand() {
		import std.random: uniform;
		_rc = uniform!"[]"(LOWER, UPPER);
	}
	
	bool isUnique() {
		foreach(const e; _arr) {
			if (e == _rc)
				return false;
		}
		return true;	
	}
	
	void doUniqueNums() {
		if (_arr.length == UPPER - LOWER + 1) {
			reset;
		}
		foreach(e; LOWER .. UPPER + 1) {
			do {
				rand;
			} while(! isUnique);
			_arr ~= _rc;
		}
	}
	
	void print() {
		import std.stdio: writeln;
		writeln(_arr);
	}
	
	void reset() {
		_arr.length = 0;
	}
}

void main() {
	import std.string: split;
	UniqueArray!("I went for a walk and fell down hole".split, 1, 10);
	foreach(arr; 0 .. 7) {
		with(unique) {
			doUniqueNums;
			print;
		}
	}
}
