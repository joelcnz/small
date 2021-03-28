import std.stdio;

struct Widget {
	private int[] array;
	this(uint length) {
		array = new int[length];
	}
	this(this) {
		writeln( "this(this) called" );
		array = array.dup;
	}
	int get(size_t offset) { return array[offset]; }
	void set(size_t offset, int value) { array[offset] = value; }
	auto getArray() {
		return array;
	}
}

void main() {
	auto w1 = Widget(10);
	auto w2 = Widget(10);
	w1.set(5, 100);
	w2.set(5, 42);
	assert(w1.get(5) == 100);
	
	auto wd1 = Widget(3);
	Widget wd2 = Widget(3);
	wd1.set(0, 1);
	wd1.set(1, 2);
	wd1.set(2, 3);
	assert( wd1.getArray == [1,2,3] );
	assert( wd2.getArray == [0,0,0] );
	void update(string message) {
		writeln(message, " wd1 = ", wd1, ", wd2 = ", wd2);
	}
	void delegate(string) print = &update;
	print("before");
	wd2 = wd1;
	print("after");

	assert( wd2.getArray == [1,2,3] );
}
