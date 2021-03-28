//#whoops
//#tuple with split not work
//#Date patterns
//#mixin fail
//#heats up the CPU
//#total bomb 2
//#total bomb
//#I don't get moveFront etc
//#ELS testing
//#script part
//#more script stuff
//#this looks better
//#main
//#ELS - equal distance letter sequences
//#lets let me down
//#tap looking
//#why did I have to put this here, it would say about undefined otherwise
//#this is dumb, it just straitaway converts my range to an array
//#What about this then, see above
//#foreach(i, u; ju.save) -> cannot infer argument types
//#no toString defined in sent's struct it's a inputRange at lessed
//#maybe shouldn't use 'save'
//#containers using Ranges
//#not work
//#what about join?
//#mine ^-^ (used, see above - remove test)

import std.algorithm: equal, minCount, minPos, reverse, remove, SwapStrategy, multiSort, makeIndex, isSorted,
	bringToFront, map, balancedParens, canFind, findSkip, mismatch, joiner, setIntersection,
		levenshteinDistance, findAdjacent, uniq, fill, until, OpenRight, sort, count, filter, find;
import std.algorithm.searching : findSplitBefore;
import std.stdio: writefln, writeln, stdout, write, writef, stdin, readln;
import std.range: empty, take, drop, repeat, retro, join, assumeSorted, put, chunks, cycle, chain, roundRobin, stride, radial,
	zip, lockstep, recurrence, sequence, frontTransversal, transversal, only, moveFront, iota;
import std.range.primitives : popFrontN;
import std.algorithm.iteration : reduce;
import std.container: SList;
import std.ascii: toUpper, isUpper, toLower, lowercase, uppercase, letters, digits;
import std.array: array, front, popFront, replace;
import std.string: split, format, inPattern, removechars, chomp;
import std.conv: to, text, roundTo;
import std.math: approxEqual;
import std.typecons: Tuple, tuple;
import core.thread: Thread, dur;
import std.functional: unaryFun, binaryFun;
import std.file;
import std.datetime: Duration, seconds, hours, msecs, days, Clock, SysTime;
import std.container: DList;
import std.bigint;

bool g_doNewLine;

// use at the start of each testing function
static void showTitle(in string message) {
	writeln((g_doNewLine ? "\n" : ""), "=== ", message, " ===");
	g_doNewLine = true;
}

//#main
void main(string[] args) {
	version(none) {
		dateTimeStuff();
	}

//	filterTest();

//	getInTheShowerI();
	//rangeStuff_1();
	//rangeStuff_3();
	//zipTest();
	//lockstepTest();
	//compilerStuff();
//	durTest();
//	other();
	//testBigint();
	//tupleTest2();
	durTest;

	version(none) {
	tupleTest();
	testBigint();
	durTest();
	onlyTest();
	moveFrontTest();
	DListTest();
	version(none) byChunkTest();
	version(none) scan(""d.dup);
	durTest();
	unaryFunTest();
	radialTest();
	Script(args);
	filterTest();
	CTErandom();
	Euclid();
	roundToTest();
	recurrenceTest();
	sequenceTest();
	frontTransversalTest();
	transversalTest();
	compilerStuff();
	arrayStuff();
	zipTest();
	lockstepTest();
	rangeStuff_3();
	rangeStuff_2();
	rangeStuff_1();
	roundRobinTest();
	strideTest();
	removeTest();
	binaryStuff();
	binarySearchStuff();
	getInTheShowerI();
	putTest();
	tupleTest();
	jTest();
	takeDropTest(); // std.range
	minPosTest();
	minCountTest();
	findAdjacentTest();
	sleepTest(); // slow uses dur! ;-)
	untilTest();
	fillTest();
	returnTypeOS();
	equalApproxEqualTest();
	reverseTest();
	bringToFrontTest();
	multiSortTest();
	makeIndexTest();
	mapTest();
	banancedTest();
	canFindTest();
	findSkipTest();
	mismatchTest();
	joinerTest();
	setIntersectionTest();
	setUnionTest();
	levenshteinDistanceTest();
	uniqTest();
	reduceTest();
	}
}

template Tupleq(T...)
{
		alias T Tupleq;
}

void tupleTest2() {
	showTitle("tupleTest2();");
	 
	mixin(jecho(`auto rhyme = Tupleq!("Mary", "had", "a", "little", "lamb");`));
	//mixin(jecho(`auto rhyme = Tupleq!("Mary had a little lamb".split);`)); //#tuple with split not work
	mixin(jecho(`assert(format("%s %s %s %s %s.", rhyme) == "Mary had a little lamb.");`));
}

void testBigint() {
	showTitle("testBigint();");

	BigInt a = "9588669891916142";
	BigInt b = "7452469135154800";
	auto c = a * b;
	assert(c == BigInt("71459266416693160362545788781600"));
	auto d = b * a;
	assert(d == BigInt("71459266416693160362545788781600"));
	assert(d == c);
	d = c * BigInt("794628672112");
	assert(d == BigInt("56783581982794522489042432639320434378739200"));
	auto e = c + d;
	assert(e == BigInt("56783581982865981755459125799682980167520800"));
	auto f = d + c;
	assert(f == e);
	auto g = f - c;
	assert(g == d);
	g = f - d;
	assert(g == c);
	e = 12345678;
	g = c + e;
	auto h = g / b;
	auto i = g % b;
	assert(h == a);
	assert(i == e);
	BigInt j = "-0x9A56_57f4_7B83_AB78";
	j ^^= 11;
}

void durTest() {
	showTitle("durTest();");

	mixin(jecho("
	Duration a,b;

	a = 9_900.seconds;
	b = 22.hours;

	assert(a < b);"));

	mixin(jecho(`
	writeln(a + b, "\nMin: ", Duration.min, "\nzero: ", Duration.zero, "\nMax: ", Duration.max);
	`));
	
	mixin(jecho("
		assert(a - seconds(9_900) == Duration.zero);
"));

	mixin(jecho("
	auto currentTime = Clock.currTime();
	auto timeString = currentTime.toISOExtString();
	auto restoredTime = SysTime.fromISOExtString(timeString);
	"));
	
	mixin(trace("currentTime timeString restoredTime".split));
	
	version(all) {
		mixin(jecho(`
		a = days(1);
		writeln("Enter speed of count down, from a day, in msecs (no more than 1_000): ");
		auto speed = readln.chomp.to!int;
		//#heats up the CPU
		bool done = false;
		while(! done) {
			write(a, ' '.repeat.take(20).array, "\r");
			Thread.sleep(msecs(1));
			a -= msecs(speed);
			done = (a == seconds(0));
		}
`));
	}
	writeln();
	
	//mixin(jecho("assert(hours(48).days == 2);"));
}

void dateTimeStuff() {
	showTitle("dateTimeStuff();");

	//mixin(jecho("auto appStartTick = Clock.currAppTick();
//writeln(appStartTick);"));
	
	//#mixin fail
	//mixin(jecho("
	SysTime currentTime;
	while(true) {
		currentTime = Clock.currTime();
		write(currentTime, ' '.repeat.take(10).array, '\r');
		Thread.sleep(msecs(1));
	}
	//"));
}

void binaryFunTest() {
	showTitle("binaryFunTest();");

	alias less = binaryFun!"a < b";
	alias greater = binaryFun!"a > b";
	assert(less(1, 2) != less(2, 1));
	assert(greater("2", "1") != greater("1", "2"));
	
	auto arr = [1,2,2,3,5,4,6];
	foreach(i, e; [0,1,2,3,4,5,6]) {
		if (less(e,arr[i])) {
			writeln(e, " less than ", arr[i]);
		} else {
			writeln(e, " is not less than ", arr[i]);
		}
	}
}

//#I don't get moveFront etc
void moveFrontTest() {
	showTitle("moveFrontTest();");

	string title = "The rain is back!";
	
	for(; !title.empty; title.popFront())
		write(title.moveFront);
	
	writeln();
}

void byChunkTest()
{
	showTitle("byChunkTest();");

	foreach (buffer; stdin.byChunk(4))
	{
		writeln(buffer.map!(a => a.to!(char)));
	}
}

void DListTest() {
	showTitle("DListTest();");

	auto dll = DList!int(only(0));
	dll.remove(dll[]);

	dll.insert(only(1));
	dll.insertFront(only(0));
	dll.insert(4);

	writeln(dll[]);


	auto a = DList!int([11,12]);
	auto b = a;

	void update() {
		writeln("a: ", a[], " b: ",b[]);
	}
	update();

	mixin(jecho("b.insertFront(1);"));
	mixin(jecho("b.insertBack(2);"));
	//mixin(jecho("b.Range.popFront();")); //#total bomb 2

	update();

//	a.insertAfter(1, [2,3]); //#total bomb

	mixin(jecho("a.remove(a[]);"));
	update();
}

version(none) {
	void dummy() {
		string s = "I went for a walk and fell down a hole.";
		s = s
			.uppercase
				.take(10)
				.map!(a => a.to!string~' ')
				.array;
	}
}

void CTErandom() {
	showTitle("CTErandom();");

	enum uint a0 = 210, c = 123, x0 = 1_780_588_661;
	auto x = x0;
	
	writeln("\nRandom:");
	//iota(100)
	0
	.repeat
	.take(100)
	.map!((a) {
	  	x = a0 * x + c;
	  	writeln(x);
	  	
	  	return a;
	  } )
	.array;
}

void Euclid() {
	showTitle("Euclid();");

	ulong gcd(ulong a, ulong b) {
		while(b) {
			auto t = b;
			b = a % b;
			a = t;
		}
		
		return a;
	}
	
	mixin(jecho(`writeln(gcd(10,20));`));
	mixin(jecho(`writeln(gcd(28,14));`));
	mixin(jecho(`writeln(gcd(123,456));`));
}

void roundToTest() {
	showTitle("roundToTest();");

	mixin(jecho("assert(roundTo!int(32.60) == 33);"));
}

void frontTransversalTest() {
	showTitle("frontTransversalTest();");

	auto x = new int[][3];
	
	x[0] = [1, 2];
	x[1] = [3, 4];
	x[2] = [5, 6];
	
	auto ror = frontTransversal(x);
	mixin(jecho("assert(equal(ror, [ 1, 3, 5 ][]));"));
}

void transversalTest() {
	showTitle("transversalTest();");

	auto x = new int[][3];
	
	x[0] = [1, 2];
	x[1] = [3, 4];
	x[2] = [5, 6];
	
	x[2][1] = 7;
	
	auto ror = transversal(x, 1);
	mixin(jecho("assert(equal(ror, [ 2, 4, 7 ][]));"));
}

void arrayStuff() {
	showTitle("arrayStuff();");

	auto array = new double[][5]; // Array of five arrays of double
	// 	each initially null (Joel: or is it nan)

	// Make a triangular matrix
	foreach( i, ref e; array ) {
		e = new double[ array.length - i ];
	}
	
	array[1] = new double[10]; // throw this in
	
	// ref is faster
	foreach( ref row; array ) {
		foreach( ref column; row )
			write( '#' );
		writeln();
	}
	
	foreach(y; iota(10)) {
		foreach(x; iota(10))
			if (y < array.length && x < array[y].length)
				write('*');
		if (y < array.length)
			writeln();
	}
	
	foreach(y; iota(10)) {
		if (y < array.length) {
			foreach(times; iota(2))
				`/\ \/`
				.split[times] // select up or down
				.repeat
				.take(array[y].length)
				.join // drop a dimention
				.writeln;
		}
	}
	
	foreach(y; iota(10)) {
		if (y < array.length) {
			foreach(times; iota(2)) {
				foreach(x; array[y]) {
					write([`/\`, `\/`][times]);
				}
				writeln;
			}
		}
	}
	//"0123456789".cycle.take(array[y].length).drop(x).write;
}

void onlyTest() {
	showTitle("onlyTest();");

	mixin(jecho(
`assert(equal(['V'], "V"));
assert([1, 2, 3, 4].findSplitBefore(only(3))[0] == [1, 2]);`));

	string title = "The D Programming Language";
	
	filter!isUpper(title)
	.map!only
	.join(".")
	.writeln; // "T.D.P.L"
}

void zipTest() {
	showTitle("zipTest();");

	int[] a = iota(10)
			  .drop(1)
			  .array ~ 10;
	string b = uppercase.take(10).to!string;
	float[] c = iota(0.5,10f, 1)
		.drop(1)
		.array
		.to!(float[]) ~ (10f + 0.5f);
	
	int index;
	foreach(e; zip(a, b, c)) {
		writefln("%s) %s-%s-(%s)", index, e[1], e[0], e[2]);
		++index;
	}
	writeln();
}

void lockstepTest() {
	showTitle("lockstepTest();");

	int[] a1 = iota(1,6).array;
	int[] a2 = iota(6,11).array;
	int[] a3 = iota(11,16).array;
	
	foreach(index, a,b,c; lockstep(a1,a2,a3)) {
		writefln("Index %s:  a = %s, b = %s, c = %s", index, a, b, c);
	}
}

void recurrenceTest() {
	showTitle("recurrenceTest();");

	// a[0] = 1, a[1] = 1, and compute a[n+1] = a[n-1] + a[n]
	auto fib = recurrence!("a[n-1] + a[n-2]")(1, 1);
	writeln(fib.take(10));
	
	// print the first 10 factorials
	foreach (e; recurrence!("a[n-1] * n")(1).take(10)) {
		writeln(e);
	}
	
	recurrence!("a[n-1] + a[n-2]")(1, 1)
	.take(10)
	.writeln;
}

void sequenceTest() {
	showTitle("sequenceTest();");

	writeln("sequenceTest:");
	
	// a[0] = 1, a[1] = 2, a[n] = a[0] + n * a[1]
	sequence!("a[0] + n * a[1]")(1, 2)
	.take(10)
	.writeln;
}

void roundRobinTest() {
	showTitle("roundRobinTest();");

	auto ABC = uppercase;
	auto abc = ABC.map!(a => a.toLower.to!char).array; // or just lowercase.dup;
	
	writeln(roundRobin(ABC, abc).array.chunks(2).join(", ")); // letter from the first array, then a letter from the second etc.
}

void strideTest() {
	showTitle("strideTest();");

	auto abc = "JJooeell";
	
	writeln(abc.stride(2)); // skip every second letter
}

void radialTest() {
	showTitle("radialTest();");

	//#lets let me down
	
	iota(10) // make a list of numbers from 0 to 9
	.drop(1) // get rid of 0
	.radial() // splice the numbers from the middle
	.map!(a => a.to!string) // convert the numbers to strings
	.join(" ->> ") // put the strings together with a devider
	.writeln(); // show the result
}

void filterTest() {
	showTitle("filterTest();");

	iota(1, 10)
	.msg("Oringal: ")
	.tap!(a => write(a, ' '))
	.filter!(a => a % 2 == 0)
	.msg("\nFiltered: ")
	.tap!(a => write(a, ' '))
	.msg("\nSquared: ")
	.map!(a => a * a)
	.tap!(a => write(a, ' '));
}

auto msgln(R)(R r, string s) {
	writeln(s);
	
	return r;
}

auto msg(R)(R r, string s) {
	write(s);
	
	return r;
}

void binaryStuff() {
	showTitle("binaryStuff();");

	foreach(n; 0 .. 0b11111111 + 0b1)
		writefln("%08b", n);
	writeln();

	char[][] sd =
			  [0b00111000,
			   0b01000100,
			   0b10111010,
			   0b01010100,
			   0b01010100,
			   0b00101000,
			   0b00101000,
			   0b00010000]
		.map!(a => format("%08b", a).dup )
		.array;

	foreach(i; iota(sd.length)) {
		sd[i] = sd[i]
		.replace("0", " ")
		.replace("1", "#")
		.dup;
	}

	version(flip) {
		sd = sd
			.retro
			.map!(a => a)
			.array;
	}

	sd // input data
	.retro // was wrong way up, any whoo
	.every!(a => writeln(a)); // Ah ha, my simple algrithm to the rescue, with the kitchen sink!
	.writeln("Done\n"); // now you can have stuff on the chain(?) after my every. But I don't think every can change its input
}

void binarySearchStuff() {
	showTitle("binarySearchStuff();");

	auto a = [ 1, 2, 3, 42, 52, 64 ];
	auto r = assumeSorted(a);
	assert(r.contains(3));
	assert(!r.contains(32));
}

void getInTheShowerI() {
	showTitle("getInTheShowerI();");

	dstring result;
	int count;
	/+
	"get in the shower! but before that do /some/ programming. ;-)"d
	.dup
	.map!(a => (write(a), a)) // before sentence //#whoops
	.array
	.split(" ")
	.map!((a) {
  		result ~= a[0].toUpper ~ a[1..$] ~ ' '; // building after sentence
      	count++;

		return a;
	} )
	.array;
+/
	writeln('\n', result, "\nsegments: ", count, "\n\n", "Do it!", '\n');
}

void putTest() {
	showTitle("putTest();");

	int[] slice = [ 1, 2, 3 ];
	int[] slice2 = slice;
	//slice = 0 ~ slice; // to avoid losing the orinal first element
	put(slice2, 100);
	writeln(slice); // get 100, 2, 3 I don't get /it/ though. //#but only prints '2, 3' what happened to the 1?
}

void compilerStuff() {
	showTitle("compilerStuff();");

	import compiler = std.compiler;
	writeln("'", compiler.name,"' ",
			compiler.vendor, ' ',
			compiler.version_major, '.', '0', compiler.version_minor);
}

void takeDropTest() {
	showTitle("takeDropTest();");

	int[] r;

	r ~= [0,0,1,2,3,4,3,2,1,0,0];
	writeln(r);
	writeln(r.take(r.length-2).drop(2));
}

//#silly jTest
void jTest() {
	showTitle("jTest();");

	int[] r = [1,2,3,4,5,6,7];
	int v;
	jprocess!( (a) { writeln("Start: ", a); },
			  (a) { v += a; writeln(a, ' ', v);  },
			  (a) { v = 0; writeln("End. ", a, ' ', reduce!"a + b"(v, r) ); } )(r);
}

void jprocess(alias start, alias pred, alias end, R)(R r) {
	string ev(string[] things...) {
		string result;
		
		foreach(thing; things)
			result ~= "every!"~thing~"(r);";
		
		return result;
	}
	
	mixin( ev("start pred end".split() ) );
	
	//	mixin(ev("start", "pred", "end"));
	//	every!start(r);
	//	every!pred(r);
	//	every!end(r);
}

void untilTest() {
	showTitle("untilTest();");

	auto r = "Orange black yellow red purple".split();

	writeln( until!`a == "red"`(r) );
	writeln( until!`a == "red"`(r, OpenRight.no) ); // includes "red"
}

void fillTest() {
	showTitle("fillTest();");

	int[] a = [1,2,3,4,5,6,7,8,9,0];
	fill(a, [3,4,0]);
	writeln(a);

	class A { char c; this(char c0) { c = c0; } }
	A[] b;
	foreach(e; "abc")
		b ~= new A(e);

	immutable doMap = `writeln(map!"a.c"(b));`;
	mixin(doMap);
	fill(b, new A('z'));
	mixin(doMap);
}

void reduceTest() {
	showTitle("reduceTest();");

	immutable add = "a + b", times = "a * b";
	writeln(reduce!(add)([1,2,3]), ' ', reduce!(times)([1,2,3]));
}

void uniqTest() {
	showTitle("uniqTest();");

	assert(equal(uniq([1,1,1,4,4,4,5,5,7,7,7,7,7,7,7,8]), [1,4,5,7,8]));
}


void findAdjacentTest() {
	showTitle("findAdjacentTest();");

	mixin(jecho(`
auto a = [20,1,3,4,4,5,7,10];
	assert(findAdjacent(a) == [4,4,5,7,10]);
	a = [1,2,3,4,3,2,1];
writeln(findAdjacent!"a > b"(a));`, 1));

}

void equalApproxEqualTest() @trusted {
	showTitle("equalApproxEqualTest();");

	double[] b = [1.0, 2, 4, 3];
	double[] c = [1.005, 2, 4, 3];

	assert(equal!(approxEqual)(b, c));
}

void minCountTest() @trusted {
	showTitle("minCountTest();");

	int[] a = [ 2, 3, 4, 1, 2, 4, 1,0,0,0,0,0, 1, 2, 8,3 ];
	assert(minCount(a) == tuple(0, 5)); // minimum number in a is 0 and it occurs 5 times
	assert(tuple(0,5)[1] == 5);
	writeln("minCount: ", typeid(minCount(a)));
	writeln(minCount(a).array());

	assert(minCount!"a > b"(a) == tuple(8, 1));
}

void minPosTest() @trusted {
	showTitle("minPosTest();");

	int[] a = [ 2, 3, 4, 1, 2, 4, 1, 1, 2 ];
	
	// Minimum is 1 and first occurs in position 3
	assert(minPos(a) == [ 1, 2, 4, 1, 1, 2 ]);
	// Maximum is 4 and first occurs in position 2
	assert((a = minPos!("a > b")(a)) == [ 4, 1, 2, 4, 1, 1, 2 ]); // crop left side
	
	assert(equal(minPos!"a > b"(a.reverse).reverse, [4,1,2,4]));
}

void reverseTest() @system {
	showTitle("reverseTest();");

	int[] arr = [ 1, 2, 3 ];
	reverse(arr);
	assert(arr == [ 3, 2, 1 ]);
}

void bringToFrontTest() @trusted {
	showTitle("bringToFrontTest();");

	auto list = SList!int(4, 5, 6, 7, 1, 2, 3);
	auto r1 = list[];
	auto r2 = list[];
	
	popFrontN(r2, 4);
	assert(equal(r2, [ 1, 2, 3 ]));
	bringToFront(r1, r2);
	assert(equal(list[], [ 1, 2, 3, 4, 5, 6, 7 ]));
}

//#removeTest
void removeTest() @trusted {
	showTitle("removeTest();");

	writeln("removeTest:");
	int[] a = [ 1, 2, 3, 2, 3, 4, 5, 2, 5, 6 ];
	assert(remove!("a == 2")(a) == [ 1, 3, 3, 4, 5, 5, 6 ]);

	class B {
		private int _num;
		@property {
			auto num() { return _num; }
			void num(int num0) { _num = num0; }
		}
		this(int num0) {
			_num = num0;
		}
		
		override string toString() const {
			return _num.to!string();
		}
	}
	B[] arr;
	foreach(b; [1, 2, 3, 2, 3, 4, 5, 2, 5, 6 ])
		arr ~= new B(b);
	arr = remove!"a.num == 2"(arr);
	foreach(i, b; [ 1, 3, 3, 4, 5, 5, 6 ])
		if (arr[i].num != b)
			writeln("fail!");
	int t;
	every!((a) { writeln(a); t += a.num; a.num(a.num * -1); })(arr[0..3]);
	writeln("Total: ", t);
	//every!((a) { writeln(a); })(arr);
	//every!((a) { a.num(a.num * -10); writeln(a); })(arr[0..3]);
	arr
	.every!((a) { writeln(a); })[0..3]
	.every!((a) { a.num(a.num * -10); writeln(a); });
}

//#mine ^-^ (used, see above - remove test)
// ... but this is practise(sp)
// Maybe I could make a tap function, this doesn't keep the change if any after it's finished
// You can have every!(..).writeln(..); since having it return a value
R every(alias pred, R)(R r) @trusted {
	foreach(e; r)
		pred(e);

	return r;
}

//#tap looking
alias tap = every;

void multiSortTest() @trusted {
	showTitle("multiSortTest();");

	static struct Point { int x, y, z; }
	auto pts1 = [ Point(0, 0, 0), Point(5, 5, 5), Point(0, 1, 3), Point(0, 2, 2) ];
	auto pts2 = [ Point(0, 0, 0), Point(0, 1, 3), Point(0, 2, 2), Point(5, 5, 5) ];
	multiSort!("a.x < b.x", "a.y < b.y", "a.z < b.z", SwapStrategy.unstable)(pts1);
	assert(pts1 == pts2);
}

void makeIndexTest() @trusted {
	mixin(jecho(`
	immutable(int[]) arr = [ 2, 3, 1, 5, 0 ]; // index using pointers
	auto index1 = new immutable(int)*[arr.length];
	makeIndex!("a < b")(arr, index1);
	assert(isSorted!("*a < *b")(index1));`));
}

void mapTest() @trusted {
	showTitle("mapTest();");

	auto arr = [5,3,7,8,7,6,6,2,3];
	
	writeln(arr);
	writeln(map!"a.to!string"(arr));
	
	alias stringize = map!(to!string);
	assert(equal(stringize([ 1, 2, 3, 4 ]), [ "1", "2", "3", "4" ]));
}

void sleepTest() @trusted {
	showTitle("sleepTest();");

	for(int i=0; i<3; i=i+1) {
		write("#");	stdout.flush();
		//Thread.sleep(dur!"msecs"(200)); // generic
		Thread.sleep(msecs(200)); // non generic
	}
	writeln();
}

void banancedTest() {
	showTitle("banancedTest();");

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
	showTitle("canFindTest();");

	assert("gun bullit".canFind("it"));
	class A { char c; this(char c0) { c=c0; } }
	auto a = [new A('a'), new A('b')];
	assert(canFind(a, a[1]));
	assert(!canFind(a, new A('b')));

	assert(canFindMine!A(a, (e) { return e.c == 'b'; }));
	assert(! canFindMine!A(a, (e) => e.c == 'z'));
}

bool canFindMine(T)(T[] a, bool delegate(T) dg) @trusted {
	foreach(e; a) {
		if (dg(e)) {
			return true;
		}
	}

	return false;
}


void findSkipTest() @trusted {
	showTitle("findSkipTest();");

	string s = "abcdef";
	assert(findSkip(s, "cd") && s == "ef");
	s = "abcdef";
	assert(!findSkip(s, "cxd") && s == "abcdef");
	assert(findSkip(s, "def") && s.empty);
}

void mismatchTest() @trusted {
	showTitle("mismatchTest();");

	int[] x = [ 1, 5, 2, 7, 4, 3 ];
	double[] y = [ 1.0, 5, 2, 7.3, 4, 8 ];
	//byte[] z = [1,5,2,4,6,8,4,6];
	auto m = mismatch(x, y);
	assert(m[0] == x[3 .. $]);
	assert(m[1] == y[3 .. $]);
	writeln(x, '\n', y, '\n', m);
}

//#what about join?
void joinerTest() @trusted {
	showTitle("joinerTest();");

	assert(("Mary has a little lamb.".split()).joiner("...").equal("Mary...has...a...little...lamb."));
}

void setIntersectionTest() @trusted {
	showTitle("setIntersectionTest();");

	int[] a = [1,2,4,5,7,9];
	int[] b = [0,1,2,4,7,8];
	int[] c = [0,1,4,5,7,8];
	assert(equal(setIntersection(a,a), a));
	assert(equal(setIntersection([1,2],[2,3]), [2]));
	assert(equal(setIntersection(a,b), [1,2,4,7])); // only two arguments
}

void setUnionTest() @trusted {
	showTitle("setUnionTest();");
	/+
	mixin(jecho("
	int[] a = [1,2,4,5,7,9];
	int[] b = [0,1,2,4,7,8];
	int[] c = [10];
	assert(equal(setUnion(a,b,c), [0,1,1,2,2,4,4,5,7,7,8,9,10][]));", 1) );
		+/
}

void levenshteinDistanceTest() {
	showTitle("levenshteinDistanceTest();");

	assert(levenshteinDistance("cat", "rat") == 1);
	mixin(jecho(`assert(levenshteinDistance("aaa", "abb") == 2);`));
	mixin(jecho2("assert(levenshteinDistance(`aaa`, `abb`) == 2);"));
}

template Erase(T, TL...) {
	static if (TL.length == 0) // 0 length tuple, return self
		alias Erase = TL;
	else static if (is(T == TL[0])) // match with first in tuple, return tail
		alias Erase = TL[1 .. $];
	else // no match, return head concatenated with recursive tail operation
		alias Erase = Tuple!(TL[0], Erase!(T, TL[1 .. $]));
}

void tupleTest() {
	showTitle("tupleTest();");

	Erase!(float, int,double,float,uint) er;
	mixin(jecho("writeln(typeid(er));"));
}

/// Save writing the symbol twice each time
	/// ---
	/// mixin( trace( "xpos", "ypos" ) );
	/// Output:
	/// xpos: 1979
	/// ypos: 30
	/// ---
string trace(in string[] strs...) {
	string result;
	foreach( str; strs )
		result ~= `writeln( "` ~ str ~ `: ", ` ~ str ~ ` );` ~ "\n";
	
	return result;
}

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

string jecho(in string str, in int on = 1) {
	return on ? "writeln(`" ~ str ~ "`);" ~ str : str;
}

string jecho2(in string str, in int on = 1) {
	return on ? `writeln("` ~ str ~ `"); ` ~ str : str;
}

//#containers using Ranges
struct Sentence {
	@property bool empty() { return data.length == 0; }
	@property ref char front() { return data[0]; }
	void popFront() { data = data[1..$]; }
	@property ref char back() { return data[$-1]; }
	void popBack() { data = data[0..$-1]; }

	this(string data0) {
		data = data0.dup;
	}
private:
	char[] data;
}

class Txt(T) {
	class Node {
		T c;
		@property T data() { return c; }
		this(T c0) {
			c = c0;
		}
		
		Node next, prev;
	}
	Node head, savedHead, tail, savedTail;

	/+
	void opOpAssign(T)(T[] s) {
		foreach(c; s) {
			//this ~= c;
			opOpAssign(c);
		}
	}
	+/
	
	void opOpAssign(T)(T c) {
		auto newUnit = new Node(c);

		if (tail is	null)
			head = tail = newUnit;
		else
			tail.next = newUnit,
			newUnit.prev = tail,
			tail = newUnit;
	}

	size_t length() {
		auto current = head;

		size_t total = 0;
		while (current !is null) {
			++total;
			current = current.next;
		}

		return total;
	}
	
	size_t opDollar() {
		return length();
	}

	void save() { savedHead = head; savedTail = tail; } //#maybe shouldn't use 'save'
	auto restore() { head = savedHead; tail = savedTail; return this; }
	@property bool empty() { return head is null || tail is null; }
	@property T front() { return head.data; }
	void popFront() { head = head.next; }

	@property T back() { return tail.data; }
	void popBack() { tail = tail.prev; }

	override string toString() {
		string result;
		
		save();
		scope(exit)
			restore();

		foreach(u; this)
			result ~= u.to!string()~(head.next !is null ? " " : "");
		
		return result;
	}
}

version(all)
/++
 + The Jrange using the Phobos type Range
 +/
class Jrange(T) {
	class Node {
		T c;
		@property T data() { return c; }
		this(T c0) {
			c = c0;
		}
		
		Node next, prev;
	}
	Node head, tail;

	this(T[] a...) {
		this ~= a;
	}

	void opOpAssign(string op)(T[] s...) {
		foreach(c; s) {
			this ~= c;
		}
	}
	
	void opOpAssign(string op)(T c) {
		auto newUnit = new Node(c);
		
		if (tail is	null)
			head = tail = newUnit;
		else
			tail.next = newUnit,
			newUnit.prev = tail,
			tail = newUnit;
	}
	
	size_t length() {
		auto current = head;
		
		size_t total = 0;
		while (current !is null) {
			++total;
			current = current.next;
		}
		
		return total;
	}
	
	size_t opDollar() {
		return length();
	}

	@property typeof(this) save() {
		auto newj = new Jrange!T();

		newj.head = head;
		newj.tail = tail;

		return newj;
	}
	@property bool empty() { return head is null || tail is null; }
	@property T front() { return head.data; }
	void popFront() { head = head.next; }
	
	@property T back() { return tail.data; }
	void popBack() { tail = tail.prev; }

	@property auto opIndex(size_t p) {
		auto cpy = save;
		for(int i;i<p && !cpy.empty; i++, cpy.popFront())
		{}

		return cpy.front;
	}

	@property typeof(this) opSlice(size_t s, size_t e) {
		auto cpy = save;
		auto slice = new Jrange!T;

		version(all) {
			size_t i;

			cpy
			.take(e)
			.map!((a) {
				if (i >= s)
					slice ~= cpy.front;
				++i;
				
				return a;
			} )
			.array;
		}

		version(none)
		for(size_t i;i<e && !cpy.empty; i++, cpy.popFront()) {
			if (i >= s )
				slice ~= cpy.front;
		}

		return slice;

	}

	override string toString() {

		return save.array.text;
	}
}

//#why did I have to put this here, it would say about undefined otherwise
static auto jreplace(T,T2)(T[] r, T2 from, T2 to) {
	return r.map!(a => a = (a == cast(dchar)from ? cast(dchar)to : a)).array;
}

void rangeStuff_1() {
	showTitle("rangeStuff_1();");

	version(all) {
	class IntString {
		int i;
		string s;

		this(int i0, string s0) {
			i = i0;
			s = s0;
		}

		override string toString() {
			return text(i, '-', s);
		}
	}

	auto r1 = new Jrange!IntString;

	r1 ~= [new IntString(1, "one"), new IntString(2, "two")];

	auto r2 = new Jrange!IntString;
	
	r2 ~= [new IntString(3, "three"), new IntString(4, "four")];

	writeln("chain:");
	typeof(r1) r1s, r2s;
	r1s = r1.save; r2s = r2.save;
	writeln(chain(r1s,r2s));
	r1s = r1.save; r2s = r2.save;
	writeln(chain(r1s,r2s));

	r1s = r1.save; r2s = r2.save;
	auto r3 =  chain(r1,r2);

	writeln(r3);

	auto rg = new Jrange!char;

//	rg ~= "0"~
//		"123456789"
	rg ~= digits
		.cycle
		.take(19)
		.to!string~"0"
		.dup;

	writeln(rg[3]);

	int sides;
	
	0 // dummy value
		.repeat
			.take(rg.length/2 + 1) // + 1 for the empty layer
			.map!((a) {
				  	writeln('.'.repeat.take(sides), rg[sides..$-sides], '.'.repeat.take(sides));
				  	sides++;
				  	
				  	return a;
				  } )
			.array;
	} // version
}

void rangeStuff_2() {
	showTitle("rangeStuff_2();");

	version(none) {
	auto ju = new Jrange!char();
	ju ~= "Hello, World!".dup;

	writeln(1, ' ', ju.save);
	writeln(2, ' ', ju.save);
	writeln(3, ' ', ju.save);

	foreach(u; ju.save) //#foreach(i, u; ju.save) -> cannot infer argument types
		write(u);

	writeln('\n', "foreach_reverse:");
	foreach_reverse(e; ju.save)
		write(e);
	writeln();

	foreach_reverse(i, u; ju.save.array)
		write(i, '-', u, ' ');

	writeln('\n', 4, ' ', ju.save, '\n');

	dchar upper(dchar c) {
		return c.toUpper;
	}

	writeln(map!upper(ju.save));

	string jactory(string[] s...) {
		string result;

		foreach(i, u; s) {
			result ~= (i != 0 ? "." : "")~u~'\n';
		}

		return "writeln(`"~result~"`);" ~ "write(`After: `);" ~ result ~ "writeln();";
	}

	static bool less(T)(T a, T b) {
		return a < b;
	}

	static bool more(T)(T a, T b) {
		return a > b;
	}

	writeln("Before: ", ju.save);
	alias jtext = ju;
	mixin(jactory("jtext<>map!(a => a.toUpper)<>retro<>array<>sort!more()<>writeln();".split("<>")));

	/+
	//map!((a) { return a.toUpper; } )(ju).
	map!(a => a.toUpper)(ju) // put all the letters into caps
	.retro // put in reverse - though redundant because of sort
	.array // to array for random access sort
	.sort!"a < b" // sort from the least to the greatest 123
	.writeln(); // output data (the sink)
	+/
	} // none
}

void rangeStuff_3() {
	showTitle("rangeStuff_3();");


	// setup
	auto mg = "#### ####".array.chunks(3);

	version(all) {
		showTitle("Long way");
		 //object definition
		struct Mg {
			dchar c;
		float x, y;
		}
	auto mgl = new Mg[][](3,3);
	auto data = "#### ####".dup; //.chunks(3);
	foreach(y; 0..3)
		foreach(x; 0..3) {
			ref auto m() { return mgl[y][x]; }

			m.x = x;
			m.y = y;
			m.c = data.front;
			data.popFront();
		}
		mgl.array.join.chunks(3).writeln();
	} // version

	showTitle("Print in 1D");
	//print in 1D
	mg // input data
	.join // make into a line
	.map!(r => r) // extract the characters
	.writeln(); // sink
	
	// count blocks
	mg // input data
	.join // make into one line
	.map!(r => r) // extract characters
	.count('#') // count the bricks
	.writeln(" bricks in block"); // display the number of bricks with useful message
	
	//print in 1D
	mg // input data
	.join("\n".dup) // make into a line of segments punchuated(sp) with newline characters
	.writeln("\n\\/"); // sink

	mg
	.join
	.jreplace('#', '@')
	.jreplace(' ', '+')
	.chunks(3)
	.join("\n".dup)
	.writeln();

	version(all) {
	//auto rocks = new Jrange!char(".oOo".dup);
	auto rocks = new Jrange!char('.','o','O','o');

	//#this is dumb, it just straitaway converts my range to an array
	rocks // input range, see above
	.array // I think this adds random access
	.repeat // use an infinite range
	.take(10) // select how many amounts of data
	.join // string all the data together
	.writeln('.'); // output data and including a pinch of salt
	} // none

	//#What about this then? see above
	foreach(n; 0..10)
		write(".oOo");
	writeln(".");

	//#Date patterns
	auto nums = new Txt!int();
	//nums ~= [1979,4,30];
	foreach(num; [1979,4,30])
		nums.opOpAssign(num);
	writeln(nums);

	foreach(dateType, n; [1946,5,28])
		writeln(n, " - ", "year month day".split[dateType]);
	immutable newLine = "\n";
	writeln(newLine, "First printed this year: 2013");

	immutable datesCode = `void dates(in int[3] nums, string title, string op = "+") {
		writefln("%4s %s %02s %s %02s > %4s - %s", nums[0], op, nums[1], op, nums[2],
			op == "*" ? nums.array.reduce!"a * b" : nums.array.reduce!"a + b",
		title);
	}`;

	mixin(datesCode);
	
	dates([1946,5,28], "Dad's birhdate");
	dates([1946,5,28], "Dad's birhdate", "*");
	dates([1979,4,30], "My's birhdate");
	dates([1982,7,25], "Timothy's birthdate");
	dates([1978,11,26], "Katherine's birhdate");
	dates([2005,5,5], "Ian 2nd birthdate");
	writeln();
	dates([1955,7,16], "Joy's birhdate");
	dates([1993,7,29], "Jeremy's birhdate", "*");
	dates([1940,8,5], "Mum's birhdate");
	dates([1976,11,6], "Alan's birhdate");
	dates([1973,3,11], "Ria's birhdate");

	version(none) {
	auto txt = new Txt!string();
	txt ~= "Hello, World!".split();
	txt.save();
	writeln(txt);

	txt.restore();
	txt.save();
	foreach(u; txt)
		write(u);

	writeln();
	txt.restore();
	writeln([txt]);
	
	auto chrs = new Txt!char();
	foreach(c; "This will be a nice place to sit down!") {
		chrs ~= c;
	}
	writeln(chrs);
	foreach(u; chrs)
		write(u), stdout.flush(), Thread.sleep(dur!"msecs"(5));

	// Sit down
	alias tchr = Txt!char;
	auto str = new Txt!tchr();
	
	foreach(s; 0..2)
		str ~= new tchr();
	
	str.save();
	
	foreach(word; "Sit down!".split()) {
		foreach(c; word)
			str.front ~= c;
		str.popFront();
	}
	
	str.save();
	foreach(word; str)
		writeln(word);
	
	str.restore();
	foreach(word; str)
		writeln(word);
	
	auto three = new Txt!(Txt!(Txt!char));
	foreach(a; 0..2) {
		three ~= new Txt!(Txt!char);
	}
	three.save();
	foreach(b; 0..2) {
		foreach(c; 0..2) {
			three.front ~= new Txt!char;
		}
		three.popFront();
	}
	three.restore();
	three.front.save();
	foreach(word; "Stand up!".split()) {
		foreach(c; word)
			three.front.front ~= c;
		three.front.popFront();
	}
	three.front.restore();
	foreach(word; three.front)
		writeln([word]);

	auto sent = Sentence("There was a cat the crossed my path. I called it to no avail, it rubbed it's cheack(sp) on a tree.");
	foreach_reverse(c; sent) {
		//auto c = sent.front.toUpper();
		write(c); stdout.flush();
		//Thread.sleep(dur!"msecs"(5));
	}
	
	write(" - ");
	foreach(c; sent) {
		write(c); stdout.flush();
		//Thread.sleep(dur!"msecs"(5));
	}

	writeln("\n\nEnter to win here >> ", sent); //#no toString defined in sent's struct it's a inputRange at lessed

	// reverse with doubley linked list data structure
	writeln();
	auto rev = new Txt!(char)();
	rev ~= cast(char[])"That is all.";
	rev.save();
	foreach_reverse(u; rev)
		write(u);

	rev.restore();
	writeln();

	alias mapa = map!("a");

	mapa(rev).writeln();
	rev.restore();
	string sms;
	sms ~= map!("a")(rev).array;
	writeln([sms]);
	rev.restore();
	rev.writeln();
	} // version
} // Ranges

void returnTypeOS() {
	showTitle("returnTypeOS();");

	import std.traits: ReturnType;
	
	import core.stdc.stdio;
	string s;
	s="testing";
//	printf("s = '%.*s'\n", s);               // 32 bit only
	printf("s = '%.*s'\n", s.length, s.ptr); // 32 and 64 bit
	
	string bitVer(string pnt, string bit) {
		return `version(X86`~(bit == "64" ? "_64" : "")~`) {`~
			pnt~`("`~bit~` bit"); } `;
	}
	mixin(bitVer("writeln", "32"));
	mixin(bitVer("writeln", "64"));
	
	mixin(jecho("
int one() { return 1; }
ReturnType!one x = one(); // x is declared as int
assert(x == 1);", 1));
}

//#more script stuff
version(none)
	void elsPro(dchar start = 'g', int spaces = 8, int number = 3,
				  dchar[] text = "In the beginning God created the heaven and the earth."d.dup ) {
		writeln(text);
		writeln("Start at first happening of '", start, "' skip ", spaces, " spaces, ", number, " times.");

		text = text.map!(a => a.toLower).array;
		text = removechars(text, digits.to!(dchar[])~" ");
		auto orgText = text.dup;

		int i, starti;

		text = text.find(start);
		starti = cast(int)(orgText.length - text.length);
		writeln(text);

		int[] ps;
		foreach(l; text.stride(spaces)) {
			ps ~= starti + i * spaces;
			write(l);
			++i;

			if (i == number)
				break;
		}
		ps ~= 0;
		writeln();

		int pPos;

		text = orgText;
		i = 0;
		foreach(l; text) {
			if (i == ps[pPos])
				write('(', l, ')'),
				++pPos;
			else
				write(l);
			++i;
		}

		writeln();
}

//#script part
void scriptPart() {
	auto gen = ""d;

	writeln("Printing how many of each letter.");
	
	dstring gen2;
	bool[dchar] unq;
	foreach(h; gen)
	if (h !in unq) {
		gen2 ~= h;
		unq[h] = true;
	}
	writeln(gen.length, '-', gen, '\n',
			gen2.length, '-', gen2);
	
	struct Lst {
		dstring tx;
		ulong cnt;
	}
	Lst[] lst;
	ulong[ulong] repeats;
	// numbers of each bunch of a kind
	foreach(h; gen2) {
		repeats[count(gen, h)]++;
		lst ~= Lst(text(h, " (", count(gen, h), ")  ").to!dstring, count(gen, h));
	}
	
	//sort!((a, b) => repeats[a] > repeats[b])(repeats);
	foreach(k, v; repeats) {
		writeln(v, " ", k, "'s");
	}
	
	sort!"a.cnt < b.cnt"(lst);
	foreach(p; lst)
		writeln(p.tx);
	
	foreach(c; iota(7, 127, 7)) {
		if (count(repeats.values, c) > 0) {
			write(c, "'s: ", count(repeats.values, c), '\n');
		}
	}
	
	version(none)
	foreach(h; gen2) {
		auto c = count(gen, h);
		
		if (c % 7 == 0)
			write(c, "'s (#): 7 x "); (c/7).writeln;
	}
	
	ulong[dstring] words;
	foreach(word; gen.split) {
		words[word]++;
		//writeln(word);
	}
	
	struct KeyVals {
		ulong value;
		dstring word;
	}
	KeyVals[] kvs;
	foreach(word, value; words) {
		kvs ~= KeyVals(value, word);
	}
	
	sort!"a.value < b.value"(kvs);
	ulong[ulong] num;
	foreach(kv; kvs) {
		num[kv.value]++;
		writeln(kv.value, ' ', kv.word);
	}
	
	struct Snum {
		ulong k;
		ulong v;
	}
	Snum[] snum;
	foreach(kv, value; num) {
		snum ~= Snum(kv, value);
	}
	sort!"a.v < b.v"(snum);
	foreach(sn; snum) {
		writeln("words: ", sn.k, " hits: ", sn.v);
	}
}

//#ELS testing
dchar[] g_word = "God"d.dup;

//#ELS - equal distance letter sequences
dchar[] scan(dchar[] text) {
	
	'-'.repeat.take(80).writeln;
	
	void elsPro(int letterHits, dchar[] word) {
		//mixin(traceLine("letterHits word".split));
		
		word = word.map!(a => a.toLower).to!dstring.dup;
		
		//writeln(text);
		
		int beginning;
		
		void findnth() {
			int start;
			for(; start < text.length && letterHits; start++) // find the nth count of the first letter of word
				if (text[start] == word[0])
					letterHits--;
			
			beginning = start - 1;
			//writeln(text);
		}
		
		if (beginning < 0)
			return;
		
		/+
          11111111112222222222333333333344444444445555555555666666
012345678901234567890123456789012345678901234567890123456789012345
inthebeginninggodcreatedtheheavenandtheearthandtheearthwaswithout
(g)inningg(o)dcreate(d)theheav
+/	
		findnth();
		
		//mixin(traceLine("text.length beginning text[beginning]".split));
		
		//writeln();
		// loop ends when either: success or 
		int pos = beginning, spaces;
		//const len = 1_000; //text.len;
		const len = text.length;
		//write(pos, ' ');
		
		spaces = 0;
		while(spaces < len / word.length && pos+1 < len &&
			  text[++pos] != word[1]) { // find second letter and the interval
			//mixin(trace("pos"));
			++spaces;
		}
		spaces++;
		
//		if (spaces < 3)
//			goto label2;
		//mixin(traceLine("text[beginning..beginning+spaces*word.length]"));
		
		//mixin(traceLine("pos text[pos] spaces".split));
		
		bool success = true;
		for(int p, stride = beginning; p < word.length /+ , stride + spaces < text.length +/ ; p++, stride += spaces) {
			//mixin(traceLine("beginning"));
			//mixin(traceLine("beginning", "p", "spaces", "stride", "text[stride]", "word[p]"));
			if (text[stride] != word[p]) {
				success = false;
				
				break;
			}
		}
		
		if (success) {
			int targ;
			auto str = ' '.repeat.take(spaces-1).to!(dchar[]);
			for(int n = beginning; n < beginning + word.length * spaces; ++n) {
				if (targ == spaces || n == beginning) {
					targ = 0;
					//write('(', text[n], ')');
					writeln(
						(n-spaces+1 >= 0 ? text[n-spaces+1..n] : str),
						'(', text[n], ')',
						text[n+1..n+spaces]);
				}
				//else
				//	write(text[n]);
				targ++;
			}
			
			writeln();
		}
		
	label2:{}
	} // ELS
	
	//elsPro(1, "God"d.dup);
	
	// loop through Bible verses
	
	
	//elsPro(args[0].to!int, args[1].to!(dchar[]));
	version(EndOfBlock)
		text = text[text.length - 1100..$];
	version(all)
		//text = "הִתְנַעֲרִי מֵעָפָר קוּמִי שְּׁבִי, יְרוּשָׁלִָם; התפתחו מוֹסְרֵי צַוָּארֵךְ, שְׁבִיָּה בַּת-צִיּוֹןכִּי-כֹה אָמַר יְהוָה, חִנָּם נִמְכַּרְתֶּם; וְלֹא בְכֶסֶף, תִּגָּאֵלוּכִּי כֹה אָמַר אֲדֹנָי יְהוִה, מִצְרַיִם יָרַד-עַמִּי בָרִאשֹׁנָה לָגוּר שָׁם; וְאַשּׁוּר, בְּאֶפֶס עֲשָׁקוֹ".to!(dchar[]);
		//text = "מִי הֶאֱמִין, לִשְׁמֻעָתֵנוּ; וּזְרוֹעַ יְהוָה, עַל-מִי נִגְלָתָהוַיַּעַל כַּיּוֹנֵק לְפָנָיו, וְכַשֹּׁרֶשׁ מֵאֶרֶץ צִיָּה--לֹא-תֹאַר לוֹ, וְלֹא הָדָר; וְנִרְאֵהוּ וְלֹא-מַרְאֶה, וְנֶחְמְדֵהוּנִבְזֶה וַחֲדַל אִישִׁים, אִישׁ מַכְאֹבוֹת וִידוּעַ חֹלִי; וּכְמַסְתֵּר פָּנִים מִמֶּנּוּ, נִבְזֶה וְלֹא חֲשַׁבְנֻהוּאָכֵן חֳלָיֵנוּ הוּא נָשָׂא, וּמַכְאֹבֵינוּ סְבָלָם; וַאֲנַחְנוּ חֲשַׁבְנֻהוּ, נָגוּעַ מֻכֵּה אֱלֹהִים וּמְעֻנֶּה"d.dup;
		//text = "אָכֵן חֳלָיֵנוּ הוּא נָשָׂא, וּמַכְאֹבֵינוּ סְבָלָם; וַאֲנַחְנוּ חֲשַׁבְנֻהוּ, נָגוּעַ מֻכֵּה אֱלֹהִים וּמְעֻנֶּה"d.dup;
		text = "נִבְזֶה וַחֲדַל אִישִׁים, אִישׁ מַכְאֹבוֹת וִידוּעַ חֹלִי; וּכְמַסְתֵּר פָּנִים מִמֶּנּוּ, נִבְזֶה וְלֹא חֲשַׁבְנֻהוּ"d.dup;
	text.length.writeln;
	//text = filter!(a => letters.canFind(a)); //removechars(text.to!(dchar[]), ";., "d.dup);
	writeln(text);
	text.length.writeln;

	version(none) {
		int start = 5;
		int skip = 14;
		int times = 3;

		text = text[times..$];
		foreach(p; iota(times)) {
			write(text[p]);
		}
	}
	
	version(all) {
		//int max = 1000; //cast(int)text.length / 3;
		int max = cast(int)text.length; // / 3;
		iota(1,max)
			.map!((n) { elsPro(n, /+ g_word +/ "הפָּכְ"d.dup); /+ write("\r", n, " of ", max, ' '); +/ return n; } )
				.array;
	}

	writeln();
	
	return text;
} // scan

void Script(string[] args) {
	args.popFront();
	
	dstring gen;
	version(none) {
		/+ //#this looks better Gen 1:1 -- 7 2's, 1 7's, 7 1's +/ gen = "ֶ בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ.";
		gen = "ְהָאָ֗רֶץ  הָיְתָ֥ה  תֹ֙הוּ֙  וָבֹ֔הוּ  וְחֹ֖שֶׁךְ  עַל־  פְּנֵ֣י  תְהֹ֑ום  וְר֣וּחַ  אֱלֹהִ֔ים  מְרַחֶ֖פֶת  עַל־  פְּנֵ֥י  הַמָּֽיִם׃ ";
		/+ John 3:1 -- 7's 1 +/ gen = "Ἦν δὲ ἄνθρωπος ἐκ τῶν Φαρισαίων Νικόδημος ὄνομα αὐτῷ ἄρχων τῶν Ἰουδαίων";
		/+ 1Tim 1:1 10 o's, 20 ' ''s +/ gen = "Paul an apostle of Jesus Christ by the commandment of God our Saviour and Lord Jesus Christ which is our hope";
		/+ 1Timothy 1:1 -- 14's: 1, 28's (#): 7 x 4, 7's (#): 7 x 1 +/ gen = "Παῦλος  ἀπόστολος  Χριστοῦ  Ἰησοῦ  κατ’  ἐπιταγὴν  θεοῦ  σωτῆρος  ἠμῶν  καὶ  Χριστοῦ  Ἰησοῦ  τῆς  ἐλπίδος  ἡμῶν";
		
		/+ John 3:16-17 -- 14 lone letters +/ gen = "Οὕτως γὰρ ἠγάπησεν ὁ θεὸς τὸν κόσμον ὥστε τὸν υἱὸν αὐτοῦ τὸν μονογενῆ ἔδωκεν ἵνα πᾶς ὁ πιστεύων εἰς αὐτὸν μὴ ἀπόληται ἀλλ' ἔχῃ ζωὴν αἰώνιον"; gen ~= "οὐ γὰρ ἀπέστειλεν ὁ θεὸς τὸν υἱὸν αὐτοῦ εἰς τὸν κόσμον ἵνα κρίνῃ τὸν κόσμον ἀλλ' ἵνα σωθῇ ὁ κόσμος δι' αὐτοῦ";
		/+ John 3:16-17 -- 7's 1. words: 2 - hits: 7. Words: 1 hits 28 +/ gen = "16 For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life. 17 For God sent not his Son into the world to condemn the world; but that the world through him might be saved.";
		/+ Ria + Alan or Joel = 7 letters. Timothy has 7 letters. And Alan and Joel both have an 'l' and the same number of letters and are closest in age. +/
		/+ ELS -- God +/ gen = "In the beginning God created the heaven and the earth.";
	}
	
	/+ ELS -- God +/ gen = "In the beginning God created the heaven and the earth.";
	
	version(none)
		gen = removechars(gen, digits.to!dstring~" ");
	
	//scriptPart();
}


void unaryFunTest() {
	showTitle("unaryFunTest();");

	alias isEven = unaryFun!"(a & 1) == 0";
	
	mixin(jecho("assert(isEven(16));"));
	mixin(jecho("assert(! isEven(17));"));
}

void other() {
	showTitle("other();");

	int x;
	foreach(a; 0 .. 10) {
		foreach(s; 0 .. x)
			write(' ');
		write("Car\r");
		stdout.flush;
		Thread.sleep(125.msecs);
		x++;
	}

	auto people = ["Joel", "Dad"];

	struct Set {
		int a, b;
	}
	auto sets = [Set(0,1), Set(1,0)];

	foreach(set; sets)
		with(set)
			writeln(people[a], " lives in the same house as ", people[b]);
}
