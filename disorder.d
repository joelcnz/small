//#hack job
//#not work with char[]
//#I think some thing like isNuraml(sp)
/+
With this program, you can shuffle numbers as well as words and letters. Also the numbers can be any range (et 5,6,7), and any order (eg  5,8,10)
One minor progblem is it doesn't work with an array of 2 numbers.
+/
struct Disorder(T) {
	T[] _arr;
	
	void setData(T[] arr...) {
		_arr = arr;
	}
	
	void suffle() {
		foreach(e; _arr) {
			import std.random: uniform;
			int rand() {
				return cast(int)uniform!"[)"(0, _arr.length);
			}
			int i = rand, i2;
			do {
				i2 = rand;
			} while(i == i2);
			import std.algorithm: swap;
			swap(_arr[i], _arr[i2]);
		}
	}
	
	void order() {
		import std.algorithm: sort;
		static if (is(T == char)) {
			//sort!"a < b"(_arr); //#not work with char[]
			//_arr = _arr.sort.reverse;
			import std.algorithm: swap;
			
			//#hack job
			foreach(ref a; _arr) {
				foreach(ref b; _arr) {
					if (a < b)
						swap(a, b);
				}
			}
		} else static if (is(T == string)) {
			import std.string: toLower;
			sort!"a.toLower < b.toLower"(_arr);
		} else {
			sort!"a < b"(_arr);
		}
			
	}
	
	void print() {
		import std.stdio: writeln;
		writeln(_arr);
	}
}

void main() {
	Disorder!string disorderString;
	with(disorderString) {
		import std.string: split;
		setData("I went for a walk and fall down a hole".split);
		print;
		suffle;
		print;
		order;
		print;
	}
	
	Disorder!string disorderSelString;
	with(disorderString) {
		import std.string: split;
		setData("Timothy Joel Alan Ria Dad Mum".split);
		print;
		suffle;
		print;
		order;
		print;
	}

	Disorder!char disorderChar;
	with(disorderChar) {
		setData("I went for a walk and fall down a hole".dup);
		print;
		suffle;
		print;
		order;
		print;
	}
	
	Disorder!int disorderInt;
	with(disorderInt) {
		import std.range: iota, array;
		setData(iota(10,0, -1).array);
		print;
		suffle;
		print;
		order;
		print;
	}

	Disorder!int disorderSelInt;
	with(disorderSelInt) {
		import std.range: iota, array;
		setData(3,4,7,10,11,20,22,34,49,1979);
		print;
		suffle;
		print;
		order;
		print;
	}
}
