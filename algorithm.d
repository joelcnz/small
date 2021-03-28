// This is a small file, see the much larger one, some where

//#a start
//#mine ^-^ (used, see above - remove test)
//#fail
import std.algorithm: equal, minCount, minPos, reverse, remove, SwapStrategy, multiSort, makeIndex, isSorted,
	bringToFront, map, balancedParens, canFind, findSkip, reduce;
import std.container: SList;
import std.range: empty, popFrontN;
import std.array: array;
import std.stdio: writeln, stdout, write;
import std.conv: to;
import std.math: approxEqual;
import std.typecons: Tuple;
import core.thread: Thread, dur;

@safe:
void main(string[] args) {
	equalApproxEqualTest();
	minCountTest();
	minPosTest();
	reverseTest();
	bringToFrontTest();
	removeTest();
	multiSortTest();
	makeIndexTest();
	mapTest();
//	sleepTest(); // this is slow
	banancedTest();
	canFindTest();
	findSkipTest();
}

void equalApproxEqualTest() @trusted {
	double[] b = [ 1.0, 2, 4, 3];
	double[] c = [ 1.005, 2, 4, 3];

	assert(equal!(approxEqual)(b, c));
}

void minCountTest() @trusted {
	int[] a = [ 2, 3, 4, 1, 2, 4, 1, 1, 2 ];
	//assert(minCount(a) == tuple(1, 3)); //#fail
	writeln("minCount: ", typeid(minCount(a)));
	writeln(minCount(a).array());
}

void minPosTest() @safe {
	int[] a = [ 2, 3, 4, 1, 2, 4, 1, 1, 2 ];
	
	// Minimum is 1 and first occurs in position 3
	assert(minPos(a) == [ 1, 2, 4, 1, 1, 2 ]);
	// Maximum is 4 and first occurs in position 2
	assert((a = minPos!("a > b")(a)) == [ 4, 1, 2, 4, 1, 1, 2 ]); // crop left size
	
	assert(minPos!"a > b"(a.reverse).reverse == [4, 1, 2, 4] ); // Finished the cropping from the other end
}

void reverseTest() @safe {
	int[] arr = [ 1, 2, 3 ];
	reverse(arr);
	assert(arr == [ 3, 2, 1 ]);
}

void bringToFrontTest() @trusted {
	auto list = SList!(int)(4, 5, 6, 7, 1, 2, 3);
	auto r1 = list[];
	auto r2 = list[];
	
	popFrontN(r2, 4);
	assert(equal(r2, [ 1, 2, 3 ]));
	bringToFront(r1, r2);
	assert(equal(list[], [ 1, 2, 3, 4, 5, 6, 7 ]));
}

//#removeTest
void removeTest() @trusted {
	writeln("removeTest:");
	int[] a = [ 1, 2, 3, 2, 3, 4, 5, 2, 5, 6 ];
	assert(remove!("a == 2")(a) == [ 1, 3, 3, 4, 5, 5, 6 ]);

	class B {
		int i;
		this(int i0) {
			i = i0;
		}
		
		override string toString() const {
			return i.to!string();
		}
	}
	B[] arr;
	foreach(b; [1, 2, 3, 2, 3, 4, 5, 2, 5, 6 ])
		arr ~= new B(b);
	arr = remove!"a.i == 2"(arr);
	foreach(i, b; [ 1, 3, 3, 4, 5, 5, 6 ])
		if (arr[i].i != b)
			writeln("fail!");
	int t;
	every!((a) { writeln(a); t += a.i; a.i *= -1; })(arr);
	writeln("Total: ", t);
	every!((a) { writeln(a); })(arr);
	every!((a) { a.i *= -10; writeln(a); })(arr);
}

//#mine ^-^ (used, see above - remove test)
// could just use foreach, but this is practise(sp)
void every(alias pred, R)(R r) @trusted {
	foreach(e; r)
		pred(e);
}

void multiSortTest() @trusted {
	static struct Point { int x, y, z; }
	auto pts1 = [ Point(0, 0, 0), Point(5, 5, 5), Point(0, 1, 3), Point(0, 2, 2) ];
	auto pts2 = [ Point(0, 0, 0), Point(0, 1, 3), Point(0, 2, 2), Point(5, 5, 5) ];
	multiSort!("a.x < b.x", "a.y < b.y", "a.z < b.z", SwapStrategy.unstable)(pts1);
	assert(pts1 == pts2);
}

void makeIndexTest() @trusted {
	immutable(int[]) arr = [ 2, 3, 1, 5, 0 ]; // index using pointers
	auto index1 = new immutable(int)*[arr.length];
	makeIndex!("a < b")(arr, index1);
	assert(isSorted!("*a < *b")(index1));
}

void mapTest() @trusted {
	auto arr = [5,3,7,8,7,6,6,2,3];
	
	writeln(arr);
	writeln(map!"a.to!string"(arr));
	
	alias map!(to!string) stringize;
	assert(equal(stringize([ 1, 2, 3, 4 ]), [ "1", "2", "3", "4" ]));
}

void sleepTest() @trusted {
	for(int i=0; i<3; i++) {
		Thread.sleep(dur!"seconds"(1));
		write("#");	stdout.flush();
	}
	writeln();
}

void banancedTest() {
	auto s = "1 + (2 * (3 + 1 / 2)";
	assert(!balancedParens(s, '(', ')'));
	s = "1 + (2 * (3 + 1) / 2)";
	assert(balancedParens(s, '(', ')'));
	
	s = "1 + (2 * (3 + 1) / 2)";
	// note 0 for nesting levels, so having more than 0 nesting levels is not allowed
	assert(!balancedParens(s, '(', ')', 0));

	s = "1 + (2 * 3 + 1) / (2 - 5)";
	assert(balancedParens(s, '(', ')', 1));
	assert(balancedParens(`t--j`, 't', 'j', 1));
	assert(!balancedParens(`t--jj`, 't', 'j', 1));
}

void canFindTest() @trusted {
	assert("gun bullit".canFind("it"));
	class A { char c; this(char c0) { c=c0; } }
	auto a = [new A('a'), new A('b')];
	assert(canFind(a, a[1]));
	assert(!canFind(a, new A('b')));

	//#a start
	bool canFindMine(char h) @safe {
		foreach(e; a)
			if (e.c == h)
				return true;
		return false;
	}
	assert(canFindMine('b'));
	assert(!canFindMine('f'));
}


void findSkipTest() @trusted {
	string s = "abcdef";
	assert(findSkip(s, "cd") && s == "ef");
	s = "abcdef";
	assert(!findSkip(s, "cxd") && s == "abcdef");
	assert(findSkip(s, "def") && s.empty);
}
