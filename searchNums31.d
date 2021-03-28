class UniqueNums(T) {
public:	
	this(in int nums) {
		_length = nums;
		_nums.length = _length;
	}
	
	void doNumArray() {
		foreach(i; 0 .. _length) {
			do {
				rand;
			} while(! unique);
			_nums[i] = _numCan;
		}
	}
	
	void print() {
		import std.stdio: writeln;
		writeln("Count to ", _length);
		writeln(_nums);
	}

private:
	T _numCan; // number cadidate
	T[] _nums;
	T _length;
	
	void rand() {
		import std.random: uniform;
		_numCan = cast(T)uniform!"[]"(1, _length);
	}

	auto unique() {
		foreach(num; _nums)
			if (_numCan == num)
				return false;
		return true;
	}
}

void main(string[] args) {
	import std.conv: to;
	auto uniqueNums = new UniqueNums!int(args[1].to!int);
	with(uniqueNums) {
		doNumArray;
		print;
	}
}
