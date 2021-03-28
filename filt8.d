//#not work (any function template, or what ever)
auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	
	for(; ! arr.empty; arr.popFront)
		if (dg(arr.front) == true)
			arr2 ~= arr.front;
	
	return arr2;
}

struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string: format;
		return format("%8s %s", name, age);
	}
}

void main(string[] args) {
	import std.range: popFront; 
	args.popFront;
	// rdmd filt8 Joel 35 Timothy 32 Ria 41 Alan 38 Mari 12 Lahtrell 4 Jeremy 21 Joy 59 Neville 68
	auto data = args;
	Person[] ppl, ppl2;
	import std.range: iota;
	foreach(i; iota(0, data.length, 2)) {
		import std.conv: to;
		ppl  ~= Person(data[i], data[i + 1].to!int);
		ppl2 ~= Person(data[i], data[i + 1].to!int);
	}
	void print(T)(string title, T[] arr) {
		import std.stdio: writeln;
		writeln(title);
		import std.range: empty, popFront, front;
		for(; ! arr.empty; arr.popFront)
			arr.front.writeln;
		writeln;
	}
	print!Person("Starts with:", ppl);
	import std.algorithm: sort, any;
	import std.range: array;
	ppl = filt!Person(a => a.age < 40, ppl).sort!"a.age < b.age".array;
	print!Person("less than 40 and sorted lesser to greater:", ppl);

//	ppl2 = filt!Person(a => any!"a"([41, 59, 12]), ppl2).sort!"a.name.length < b.name.length".array; //#not work (any function template, or what ever)
	ppl2 = filt!Person(a => 41 != a.age && 59 != a.age && 12 != a.age, ppl2).sort!"a.name.length < b.name.length".array;
	print!Person("By name length, ladies removed:", ppl2);
}

/+
bool any(T)(T[] arr, T[] minus) {
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront)
		foreach(m; minus)
			if (arr.front != m)
}
+/