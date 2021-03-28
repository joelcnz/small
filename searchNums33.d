struct UniqueArray(T, T LOWER, T UPPER) {
	T _rc;
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
	alias ArrayInt10 = UniqueArray!(int, 1, 10);
	ArrayInt10 unique;
	foreach(arr; 0 .. 7) {
		with(unique) {
			doUniqueNums;
			print;
		}
	}
	
	alias ArrayChar10 = UniqueArray!(char, 'A','J');
	ArrayChar10 unique2;
	foreach(arr; 0 .. 7) {
		with(unique2) {
			doUniqueNums;
			print;
		}
	}
}
