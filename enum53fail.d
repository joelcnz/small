import std.stdio;

void main() {
	//auto nums = [3, 4];
	//immutable nums = [ 3, 4 ];
	const nums = [3, 4];

	enum last = nums[ $ - 1 ]; // cann't read at compile time (with out nums being 'immutable', or 'const')
}
