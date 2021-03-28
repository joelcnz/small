//#a.display; - not work
//#Horrible, sick, error! I thinks is a compiler bug! (found a odd charactor, and I think, removing that, fixed it!)
// cant make out this program, of course.
import std.stdio,std.conv;
import std.algorithm;

void main() {
	int[] a = [4,8,5,2,0,5,4];
	
	static bool greater(int a, int b)
	{
	    return a > b;
	}
	sort!(greater)(a);  // predicate as alias
	sort!("a > b")(a);  // predicate as string
	                    // (no ambiguity with array name)
	void display(T)(T[] arr) {
		foreach(e;arr) {
			write(e," ");
		}
		writeln();
	}
	display(a); //#a.display; - not work
	
	a.sort;            // no predicate, "a < b" is implicit

	display(a);

	writeln("Also:");
	a.length=0;
	a = [2, 5, 7, 9, 11];
	sort!("a > b")(a);
	display(a);
	

	int[] arr = [ 1, 2, 3, 4 ]; //#Horrible, sick, error! I thinks is a compiler bug! (found a odd charactor, and I think, removing that, fixed it!)
	// sort in descending order
	arr.sort!("a > b");
	assert(arr == [ 4, 3, 2, 1 ]);
	// sort in ascending order
	arr.sort;
	assert(arr == [ 1, 2, 3, 4 ]);
	//sort with a delegate
	bool myComp(int x, int y) { return x > y; }
	arr.sort!(myComp);

	assert(arr == [ 4, 3, 2, 1 ]);
	
	arr.sort!( (int x, int y) { return x < y; } );

	assert(arr == [ 1, 2, 3, 4 ]);
	
	sort!((a, b) => a > b)(arr);
	
	assert(arr == [4,3,2,1]);
	
	// Showcase stable sorting
	string[] words = [ "aBc", "a", "abc", "b", "ABC", "c" ];
	words.sort!("a.toUpper < b.toUpper", SwapStrategy.stable);
	assert(words == [ "a", "aBc", "abc", "ABC", "b", "c" ]);
	writeln(words);
}
