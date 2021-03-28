//#not got working!
import std.stdio;
import std.string;

void main() {
	char[] s = "Hello IDEone@ D world!@".dup;
	void p(T)(T data) {
		writeln(data);
	}
	p(s);
	jremove(s, s.indexOf("@"));
	p(s);
	jremove(s, s.indexOf("@"));
	p(s);
	
	import std.algorithm;
	import std.range;
	writeln("i".replicate(7));
	writeln(`\|||||/`);
	writeln(` \|||/ `);
	"   |   \n".replicate(3).write;
	writeln(`  / \   `);
	import std.array;
	import std.algorithm : until, each;
	int[] ints = [1,22,2,33,3,4];
	p(ints);
	foreach(i; [22, 33]) {
//		writeln(ints.count(i));
		ints.jremove(ints.until(i).array.length);
	p(ints);
	}
	//[22, 33].ints.jremove(ints.until(i).array.length); //#not got working!
	writeln;
	
	import std.array : array;
	import std.algorithm : count, remove, find, filter;

	//string s2 = "Hello IDEone@ D world!@";
	//s2 = remove(s2, "IDE");
	//p;
	
	int[] arr = [1,2,44,3,7,4];
	writeln(arr);
//	writeln(arr.find(44));
	arr = arr.filter!((a) => a != 44 && a != 7).array;
//	arr = arr.remove(2,4);
	writeln(arr);

	//Copied out from Phobos documentation
	int[] a = [ 3, 5, 7, 8 ];
	assert(a.remove(1) == [ 3, 7, 8 ]);
	assert(a == [ 3, 7, 8, 8 ]);
}

void jremove(T)(ref T[] a, size_t i) {
	if (i != a.length-1)
		a = a[0 .. i] ~ a[i + 1 .. $];
	else
		a.length -= 1;
}
