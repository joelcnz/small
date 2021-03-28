string echo(in string str) {
	return `writeln("` ~ str ~ `"); ` ~ str;
}

void main() {
	import std.container; //: redBlackTree, removeKey;
	import std.algorithm: equal;
	import std.stdio;
	
	mixin(echo(q{ auto rbt = redBlackTree!true(0, 1, 1, 1, 4, 5, 7); }));

	void print() {
		foreach(e; rbt) {
			write(e, ' ');
		}
		writeln;
	}

	print;
	mixin(echo(q{ rbt.removeKey(1, 4, 7); }));
	print;
	mixin(echo(q{ assert(equal(rbt[], [0, 1, 1, 5])); }));
	mixin(echo(q{ rbt.removeKey(1, 1, 0); }));
	print;
	mixin(echo(q{ assert(equal(rbt[], [5])); }));
}