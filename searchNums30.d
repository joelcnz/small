import std.stdio;

/**
 * int a = 1; double b = 0.2; string c = "three";
 * 
 * eg. mixin( traceLine( "a b c".split ) );
 * 
 * Output:
 * 
 * (a: 1) (b: 0.2) (c: three)
 */
string traceLine(in string[] strs...) {
	string result;

	foreach( str; strs ) {
		result ~= `writef( "(` ~ str ~ `: %s) ", ` ~ str ~ ` );`;
	}
	result ~= `writeln();`;

	return result;
}

struct Number(T) {
	T nc;
	T[] arr;
	int len;
	
	void init(in int length) {
		len = length;
		arr.length = length;
	}
	
	void rand() {
		import std.random;
		nc = cast(T)uniform!"[]"(1, len);
		debug
			mixin(traceLine("nc"));
	}
	
	auto isUnique() {
		foreach(n; arr)
			if (n == nc)
				return false;
		return true;
	}
	
	void doUniqueNums() {
		foreach(i; 0 .. len) {
			do {
				rand;
			} while(! isUnique);
			arr[i] = nc;
		}
	}
	
	void print() {
		writeln(arr);
	}
}

void main(string[] args) {
	import std.conv: to;
	Number!(int) nums;

	with(nums) {
		nums.init(/* len */ args[1].to!int);

		nums.doUniqueNums;
		nums.print;
	}
}
